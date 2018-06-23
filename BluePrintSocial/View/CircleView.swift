//
//  CircleView.swift
//  BluePrintSocial
//
//  Created by Shaun Tucker on 6/21/18.
//  Copyright © 2018 Shaun Tucker. All rights reserved.
//

import UIKit

class CircleView: UIImageView {
    
    override func awakeFromNib() {
        layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true 
        
    }

}
