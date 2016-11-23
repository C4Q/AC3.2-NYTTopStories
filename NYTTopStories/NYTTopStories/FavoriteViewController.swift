//
//  FilterViewController.swift
//  NYTTopStories
//
//  Created by Ana Ma on 11/20/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationBarDelegate,UINavigationControllerDelegate {
    
    var favoritesArray = [Story]()
    
    let screenSize: CGRect = UIScreen.main.bounds
    lazy private var tableView = UITableView()
    lazy var navBar = UINavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorites"
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let favoriteStrotiesDict = UserDefaults.standard.value(forKey: "favoriteStories") as? [[String : String]] {
            favoritesArray.removeAll()
            for dict in favoriteStrotiesDict {
                if let section = dict["section"],
                    let subsection = dict["subsection"],
                    let title = dict[ "title"],
                    let abstract = dict["abstract"],
                    let url = dict["url"],
                    let byline = dict["byline"],
                    let item_type = dict["item_type"],
                    let updated_date = dict["updated_date"],
                    let created_date = dict["created_date"],
                    let published_date = dict["published_date"],
                    let material_type_facet = dict["material_type_facet"],
                    let kicker = dict["kicker"],
                    let urlshort_url = dict["urlshort_url"]{
                    
                    let favoriteStories = Story(section: section, subsection: subsection, title: title, abstract: abstract, url: url, byline: byline, item_type: item_type, updated_date: updated_date, created_date: created_date, published_date: published_date, material_type_facet: material_type_facet, kicker: kicker, short_url: urlshort_url)
                    favoritesArray.append(favoriteStories)
                }
            }
            self.tableView.reloadData()
        }
    }

    func setUpTableView() {
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        self.view.addSubview(navBar)
        self.view.addSubview(tableView)
        
        //http://stackoverflow.com/questions/33717698/create-navbar-programmatically-with-button-and-title-swift
        navBar.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 50)
        let navItem = UINavigationItem(title: "Favorite Stories")
        let filterItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.edit, target: nil, action: #selector(getter: UIAccessibilityCustomAction.selector))
        navItem.rightBarButtonItem = filterItem
        navBar.setItems([navItem], animated: false)
        navBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        navBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        navBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.allowsSelection = true
        tableView.canCancelContentTouches = false
        tableView.isEditing = false
        
        tableView.frame = CGRect(origin: CGPoint(x: 0,y :screenHeight*0.12), size: CGSize(width: screenWidth, height: screenHeight*0.88))
        
        tableView.register(StoryCell.self, forCellReuseIdentifier: StoryCell.identifier)
        
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: navBar.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryCell.identifier, for: indexPath) as! StoryCell
        
        cell.storySelected = favoritesArray[indexPath.row]
        self.tableView.rowHeight = screenSize.height * 0.28
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row) Selected" )
        let selectedStory = self.favoritesArray[indexPath.row]
        guard let validURL = URL(string: selectedStory.url) else {return}
        UIApplication.shared.open(validURL, options: [:], completionHandler: nil)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
