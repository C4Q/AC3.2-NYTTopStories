//
//  NYTViewController.swift
//  AC3.2-NYTTopStories
//
//  Created by Victor Zhong on 11/20/16.
//  Copyright © 2016 Victor Zhong. All rights reserved.
//

import UIKit

class NYTViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    var topStory = [TopStory]()
    @IBOutlet weak var topStoriesTableView: UITableView!
    @IBOutlet weak var sectionPicker: UIPickerView!
    
    let pickerData = ["Home",
                      "Opinion",
                      "World",
                      "National",
                      "Politics",
                      "Upshot",
                      "NY Region",
                      "Business",
                      "Technology",
                      "Science",
                      "Health",
                      "Sports",
                      "Arts",
                      "Books",
                      "Movies",
                      "Theater",
                      "Sunday Review",
                      "Fashion",
                      "T Magazine",
                      "Food",
                      "Travel",
                      "Magazine",
                      "Real Estate",
                      "Automobiles",
                      "Obituaries",
                      "Insider"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData(for: "home")
        topStoriesTableView.delegate = self
        topStoriesTableView.dataSource = self
        sectionPicker.delegate = self
        sectionPicker.dataSource = self
    }
    
    func loadData(for section: String) {
        let string = section.replacingOccurrences(of: " ", with: "").lowercased()
        APIRequestManager.manager.getData(endPoint: "https://api.nytimes.com/svc/topstories/v2/\(string).json?api-key=788f422f30424d219442b029449df041") { (data) in
            if data != nil {
                if let validData = TopStory.getStories(from: data!) {
                    print("We have \(validData.count) stories")
                    self.topStory = validData
                    DispatchQueue.main.async {
                        self.topStoriesTableView.reloadData()
                    }
                }
            }
        }
    }
    
    func selectSection() {
        let section = pickerData[sectionPicker.selectedRow(inComponent: 0)]
        loadData(for: section)
    }
    
    // MARK: - Picker view data source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectSection()
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topStory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "storyReuse", for: indexPath) as! NYTTableViewCell
        let story = topStory[indexPath.row]
        
        cell.titleLabel?.text = story.title
        cell.bylineLabel?.text = story.byline
        cell.dateLabel?.text = story.date
        cell.abstractLabel?.text = story.abstract
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: topStory[indexPath.row].url) else { return }
        UIApplication.shared.open(url)
    }
}
