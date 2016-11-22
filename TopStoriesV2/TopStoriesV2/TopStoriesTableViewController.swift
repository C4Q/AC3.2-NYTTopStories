//
//  TopStoriesTableViewController.swift
//  TopStoriesV2
//
//  Created by Cris on 11/20/16.
//  Copyright © 2016 Cris. All rights reserved.
//

import UIKit

class TopStoriesTableViewController: UITableViewController, UISearchBarDelegate {
    
    var objects = [Stories]()
     var articles = [Stories]()
    
    let APIURL = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=c895e9726a3e48229ef6321a4b0c532a"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "NYT Top Stories"
        setUpSearchBar()
        //        self.tableView.estimatedRowHeight = 200
        //        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        APIRequestManager.manager.getData(APIURlSring: APIURL) { (data: Data?) in
            if let validData = data,
                let validObjects = Stories.object(from: validData) {
                self.objects = validObjects
                self.articles = self.objects
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.delegate = self
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.placeholder = "Enter Pokemon Name or Type"
        return sb
    }()
    
    func setUpSearchBar() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        let searchbarView = UIView(frame: frame)
        searchbarView.addSubview(searchBar)
        searchBar.leftAnchor.constraint(equalTo: searchbarView.leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: searchbarView.rightAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: searchbarView.frame.height).isActive = true
        tableView.tableHeaderView = searchbarView
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            applyPredicate(search: text)
        }
    }
    
    func applyPredicate(search: String) {
        let predicate = NSPredicate(format:"storyAbstrct contains[c] %@ or storyTitle contains[c] %@", search, search)
        self.articles = objects.filter { predicate.evaluate(with: $0) }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = StoryCell(style: UITableViewCellStyle.default, reuseIdentifier: StoryCell.identifier)
        let story = articles[indexPath.row]
        cell.storyTitle.text = story.storyTitle
        cell.storyByLine.text = story.storyByLine
        cell.storyAbstract.text = story.storyAbstrct
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let story = articles[indexPath.row]
        
        guard let url = URL(string: story.storyURlString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        
    }
}
