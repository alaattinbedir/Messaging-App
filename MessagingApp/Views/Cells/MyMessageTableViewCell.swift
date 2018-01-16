//
//  MyMessageTableViewCell.swift
//  MessagingApp
//
//  Created by Alaattin Bedir on 16.01.2018.
//  Copyright © 2018 magiclampgames. All rights reserved.
//

import UIKit

class MyMessageTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    
    static let grayBubbleImage = UIImage(named: "bubble_gray")!.resizableImage(withCapInsets: UIEdgeInsetsMake(22, 26, 22, 26)).withRenderingMode(.alwaysTemplate)
    static let blueBubbleImage = UIImage(named: "bubble_blue")!.resizableImage(withCapInsets: UIEdgeInsetsMake(22, 26, 22, 26)).withRenderingMode(.alwaysTemplate)
    
    let bubbleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = MessageTableViewCell.grayBubbleImage
        imageView.tintColor = UIColor(white: 0.90, alpha: 1)
        return imageView
    }()
    
    let textBubbleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.avatarImageView.contentMode = UIViewContentMode.scaleAspectFit
        self.avatarImageView.layer.borderWidth = 1
        self.avatarImageView.layer.masksToBounds = false
        self.avatarImageView.layer.borderColor = UIColor.black.cgColor
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.height/2
        self.avatarImageView.clipsToBounds = true
        
        self.nameLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        self.nameLabel.textColor = UIColor(red: 0/255.0, green: 128/255.0, blue: 64/255.0, alpha: 1.0)
        
        self.bodyLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        self.bodyLabel.numberOfLines = 0
        
        self.containerView.clipsToBounds = true
        self.containerView.backgroundColor = UIColor.clear
        self.textBubbleView.addSubview(bubbleImageView)
        self.containerView.addSubview(textBubbleView)
        
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
