 //
 //  StoryTableViewCell.swift
 //  NYTTopStories
 //
 //  Created by Ana Ma on 11/20/16.
 //  Copyright © 2016 C4Q. All rights reserved.
 //
 
 import UIKit
 
 class StoryCell: UITableViewCell {
    
    static let identifier = "StoryCellIdentifier"
    var favButtonPressedCount = 0
    
    var storySelected: Story! {
        //get{}set{}willSet{}
        didSet{
            //after you set the value, what you want to happen
            guard let storyData = storySelected else {return}
            setup(story: storyData)
        }
    }
    
    func pressedAction(_ sender: UIButton) {
        // do your stuff here
        NSLog("you clicked on button %@", sender.tag)
    }
    //    override func layoutSubviews() {
    //        super.layoutSubviews()
    //        textLabel?.frame = CGRect(x: 64, y: textLabel!.frame.origin.y - 2, width: textLabel!.frame.width, height: textLabel!.frame.height)
    //        detailTextLabel?.frame = CGRect(x: 64, y: detailTextLabel!.frame.origin.y + 2, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
    //    }
    var storyImageView: UIImageView = {
        let image = UIImage(named: "default-placeholder")
        let iv = UIImageView(image:image)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 24
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .white
        tv.text = "Sample Text!!!"
        //tv.isSelectable = false
        tv.isEditable = false
        //http://stackoverflow.com/questions/10633955/select-the-uitableviewcell-over-the-uitextview-losing-ability-to-call-didselectr
        tv.isUserInteractionEnabled = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.frame = CGRect(x: 64, y: tv.frame.origin.y - 2, width: tv.frame.width, height: tv.frame.height)
        return tv
    }()
    
    let myButton = UIButton()
    
    func buttonAction(sender: UIButton!) {
        print("Button tapped")
        let userDefaults = UserDefaults.standard
        
        if let favoriteStories = userDefaults.object(forKey: "favoriteStories") as? [[String: String]]  {
            for story in favoriteStories {
                if story["url"] == storySelected?.url {
                    favButtonPressedCount = 1
                }
            }
        }
        
        if favButtonPressedCount == 0 {
            addToFavorites()
            myButton.setBackgroundImage(UIImage(named: "minus"), for: UIControlState.normal)
        } else {
            removeFromFavorites()
            myButton.setBackgroundImage(UIImage(named: "plus"), for: UIControlState.normal)
        }
        dump(UserDefaults.standard.dictionaryRepresentation())
    }
    
    func addToFavorites() {
        let userDefaults = UserDefaults.standard
        
        var favoriteStory = [String: String]()
        
        favoriteStory.updateValue(storySelected.section, forKey: "section")
        favoriteStory.updateValue(storySelected.subsection, forKey: "subsection")
        favoriteStory.updateValue(storySelected.title, forKey: "title")
        favoriteStory.updateValue(storySelected.abstract, forKey: "abstract")
        favoriteStory.updateValue(storySelected.url, forKey: "url")
        favoriteStory.updateValue(storySelected.byline, forKey: "byline")
        favoriteStory.updateValue(storySelected.item_type, forKey: "item_type")
        favoriteStory.updateValue(storySelected.updated_date, forKey: "updated_date")
        favoriteStory.updateValue(storySelected.created_date, forKey: "created_date")
        favoriteStory.updateValue(storySelected.published_date, forKey: "published_date")
        favoriteStory.updateValue(storySelected.material_type_facet, forKey: "material_type_facet")
        favoriteStory.updateValue(storySelected.kicker, forKey: "kicker")
        favoriteStory.updateValue(storySelected.short_url, forKey: "urlshort_url")
        
        if var favoriteStories = userDefaults.object(forKey: "favoriteStories") as? [[String: String]]  {
            favoriteStories.append(favoriteStory)
            userDefaults.set(favoriteStories, forKey: "favoriteStories")
        } else {
            userDefaults.set([favoriteStory], forKey: "favoriteStories")
        }
        favButtonPressedCount = 1
    }
    
    
    func removeFromFavorites() {
        let userDefaults = UserDefaults.standard
        if var favoriteStories = userDefaults.object(forKey: "favoriteStories") as? [[String: String]]  {
            for (index,story) in favoriteStories.enumerated() {
                if story["url"] == storySelected.url {
                    favoriteStories.remove(at: index)
                    userDefaults.set(favoriteStories, forKey: "favoriteStories")
                    favButtonPressedCount = 0
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        fatalError("init(Coder:) had not been implemented")
    }
    
    //http://stackoverflow.com/questions/40394314/wondering-how-i-subclass-uitableviewcell-in-swift-3-0-programmatically
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        //super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.clear
        
        addSubview(textView)
        addSubview(myButton)
        
        myButton.frame = CGRect(x:self.contentView.frame.width + 45 , y:self.contentView.frame.height / 2, width: 50, height: 50)
        myButton.setBackgroundImage(UIImage(named: "plus"), for: UIControlState.normal)
        myButton.setTitleColor(.blue, for: UIControlState.normal)
        myButton.backgroundColor = .clear
        myButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        textView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        textView.rightAnchor.constraint(equalTo: myButton.leftAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        myButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        myButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        myButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        myButton.leftAnchor.constraint(equalTo: textView.rightAnchor).isActive = true
        
        //        addSubview(storyImageView)
        //        storyImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        //        storyImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        //        storyImageView.widthAnchor.constraint(greaterThanOrEqualToConstant: 48).isActive = true
        //        storyImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 48).isActive = true
    }
    
    fileprivate func setup(story: Story){
        //You can format the text with attributedText, do manipulation
        //You can use command click to get some more of the library
        let attributedString = NSMutableAttributedString(string: story.title, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 18, weight: UIFontWeightMedium)])
        let attributedDescription = NSMutableAttributedString(string: "\n\n" + story.byline + "\n" + story.created_date + "\n" + story.abstract, attributes: [NSForegroundColorAttributeName:UIColor.lightGray, NSFontAttributeName:UIFont.systemFont(ofSize: 15, weight: UIFontWeightThin)])
        attributedString.append(attributedDescription)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        
        let textLength = attributedString.string.characters.count
        let range = NSRange(location: 0, length: textLength)
        
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: range)
        
        textView.attributedText = attributedString
    }
 }
