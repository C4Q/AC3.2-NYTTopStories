//
//  ViewController.swift
//  NYTTopStories
//
//  Created by Ana Ma on 11/19/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class NYTTopStoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationBarDelegate,UINavigationControllerDelegate {
    
    var storyObjectArr = [Story]()
    
    let screenSize: CGRect = UIScreen.main.bounds
    lazy private var tableView = UITableView()
    lazy var navBar = UINavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Top Stories"
        
        APIRequestManager.manager.getData(endpoint: Story.endpoint){(data:Data?) in
            if data != nil {
                dump(data!)
                if let validStory = Story.generateStory(from: data!) {
                    
                    self.storyObjectArr = validStory
                    
//                    let predicate = NSPredicate(format: "abstract[c] 'democrat'")
//                    self.storyObjectArrFiltered = validStory.filter{predicate.evaluate(with: $0)}
                    
                    dump(self.storyObjectArr)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        setUpTableView()
    }
    
    func setUpTableView() {
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        self.view.addSubview(navBar)
        self.view.addSubview(tableView)
        
        //http://stackoverflow.com/questions/33717698/create-navbar-programmatically-with-button-and-title-swift
        navBar.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 50)
        let navItem = UINavigationItem(title: "Top Stories")
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
        return storyObjectArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryCell.identifier, for: indexPath) as! StoryCell
        
        cell.storySelected = storyObjectArr[indexPath.row]
        self.tableView.rowHeight = screenSize.height * 0.28
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row) Selected" )
        let selectedStory = self.storyObjectArr[indexPath.row]
        guard let validURL = URL(string: selectedStory.url) else {return}
        UIApplication.shared.open(validURL, options: [:], completionHandler: nil)
    }
    
    //    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    //        return 72
    //    }
    
}

