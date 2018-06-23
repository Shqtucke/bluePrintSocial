//
//  PostCell.swift
//  BluePrintSocial
//
//  Created by Shaun Tucker on 6/21/18.
//  Copyright © 2018 Shaun Tucker. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet var profileImage: CircleView!
    @IBOutlet var usernameLbl: UILabel!
    @IBOutlet var postImage: UIImageView!
    @IBOutlet var caption: UITextView!
    @IBOutlet var likesLabel: UILabel!
    @IBOutlet var likeHeart: CircleView!
    
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(post: Post) {
        self.post = post
        self.caption.text = post.caption
        self.likesLabel.text = "\(post.likes)"
        
    }

}
