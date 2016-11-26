//
//  TabBarViewController.swift
//  NYTTopStories
//
//  Created by Ana Ma on 11/20/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit
//
class TabBarViewController: UITabBarController, UITabBarControllerDelegate, UINavigationBarDelegate,UINavigationControllerDelegate {
    
    //http://swiftdeveloperblog.com/code-examples/create-uitabbarcontroller-programmatically/
    
    lazy var navBar = UINavigationBar()
    let screenSize: CGRect = UIScreen.main.bounds
    var screenWidth: CGFloat {
        return screenSize.width
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        self.view.addSubview(navBar)
        navBar.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 50)
        let navItem = UINavigationItem(title: "Favorite Stories")
        let filterItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.edit, target: nil, action: #selector(getter: UIAccessibilityCustomAction.selector))
        navItem.rightBarButtonItem = filterItem
        navBar.setItems([navItem], animated: false)
        navBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        navBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        navBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create Tab one
        let tabOne = NYTTopStoriesViewController()
        let tabOneBarItem1 = UITabBarItem(title: "Top Stories", image: nil, tag: 0)
        //        let tabOneBarItem = UITabBarItem(title: "Tab 1", image: UIImage(named: "defaultImage.png"), selectedImage: UIImage(named: "selectedImage.png"))
        
        tabOne.tabBarItem = tabOneBarItem1
        
        
        // Create Tab two
        let tabTwo = FavoriteViewController()
        let tabTwoBarItem2 = UITabBarItem(title: "Favorites", image: nil, tag: 1)
        //        let tabTwoBarItem2 = UITabBarItem(title: "Tab 2", image: UIImage(named: "defaultImage2.png"), selectedImage: UIImage(named: "selectedImage2.png"))
        
        tabTwo.tabBarItem = tabTwoBarItem2
        
        
        self.viewControllers = [tabOne, tabTwo]
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.title!)")
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
