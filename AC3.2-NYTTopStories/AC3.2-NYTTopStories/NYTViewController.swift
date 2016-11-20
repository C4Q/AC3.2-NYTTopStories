//
//  NYTViewController.swift
//  AC3.2-NYTTopStories
//
//  Created by Victor Zhong on 11/20/16.
//  Copyright © 2016 Victor Zhong. All rights reserved.
//

import UIKit

class NYTViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var topStoriesTableView: UITableView!
    @IBOutlet weak var sectionPicker: UIPickerView!
    @IBOutlet weak var sortButton: UIBarButtonItem!
    var topStory = [TopStory]()
    var sections = [String]()
    var sorted = false
    var cellIdentifer = "storyReuse"
    
    @IBAction func sortButtonTapped(_ sender: UIBarButtonItem) {
        sorted = !sorted
        if !sorted {
            sortButton.image = UIImage(named: "filter_empty")
            self.title = "NYT Top Stories By Date"
        }
        else {
            sortButton.image = UIImage(named: "filter_filled")
            self.title = "NYT Top Stories By Section"
        }
        self.topStoriesTableView.reloadData()
    }
    
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
                    self.configureSections(for: validData)
                    DispatchQueue.main.async {
                        self.topStoriesTableView.reloadData()
                    }
                }
            }
        }
    }
    
    func selectSection() {
        let section = pickerData[sectionPicker.selectedRow(inComponent: 0)]
        print("\n\(section) selected!")
        loadData(for: section)
        topStoriesTableView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    func configureSections(for stories: [TopStory]) {
        var sectionDict = [String : Int]()
        for story in stories {
            sectionDict[story.section] = 0
        }
        sections = Array(sectionDict.keys).sorted()
        print("\nWe have these sections: \(sections)")
    }
    
    func sortSections(at indexPath: IndexPath) -> TopStory {
        if sorted {
            return topStory.filter { $0.section == sections[indexPath.section] }.sorted { $0.date > $1.date }[indexPath.row]
        }
        else {
            return topStory.sorted { $0.date > $1.date } [indexPath.row]
        }
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
        if sorted {
            return sections.count
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if sorted {
            return "\(sections[section])"
        }
        else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sorted {
            return topStory.filter{$0.section == sections[section]}.count
        }
        else {
            return topStory.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath) as! NYTTableViewCell
        let story = sortSections(at: indexPath)
        
        cell.titleLabel?.text = story.title
        cell.bylineLabel?.text = story.byline
        cell.dateLabel?.text = story.date
        cell.abstractLabel?.text = story.abstract
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: sortSections(at: indexPath).url) else { return }
        UIApplication.shared.open(url)
    }
}
