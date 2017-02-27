//
//  CircleView.swift
//  devSocial
//
//  Created by erterfed on 18/2/17.
//  Copyright © 2017 erterfed. All rights reserved.
//

import UIKit

class CircleView: UIImageView {
    
    override func layoutSubviews() {
        layer.cornerRadius = self.frame.width/2
        clipsToBounds = true
    }

}
