//
//  MessageCell.swift
//  MessagingApp
//
//  Created by Alaattin Bedir on 14.01.2018.
//  Copyright © 2018 magiclampgames. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
   
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//        self.avatarImageView.contentMode = UIViewContentMode.scaleAspectFit
//        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.width / 2
//        self.avatarImageView.clipsToBounds = true
//        self.avatarImageView.layer.masksToBounds = false;
//        self.avatarImageView.layer.cornerRadius = 8;
//
//        self.nameLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
//        self.nameLabel.textColor = UIColor(red: 0/255.0, green: 128/255.0, blue: 64/255.0, alpha: 1.0)
//
//        self.bodyLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
//        self.bodyLabel.numberOfLines = 0
//
//        self.containerView.layer.cornerRadius = 8.0
//        self.containerView.clipsToBounds = true
//
//    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.avatarImageView.contentMode = UIViewContentMode.scaleAspectFit
//        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.width / 2
//        self.avatarImageView.clipsToBounds = true
//        self.avatarImageView.layer.masksToBounds = false;
//        self.avatarImageView.layer.cornerRadius = 8;

//        self.nameLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
//        self.nameLabel.textColor = UIColor(red: 0/255.0, green: 128/255.0, blue: 64/255.0, alpha: 1.0)
//
//        self.bodyLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
//        self.bodyLabel.numberOfLines = 0
//
//        self.containerView.layer.cornerRadius = 8.0
//        self.containerView.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
