//
//  PostCell.swift
//  devSocial
//
//  Created by erterfed on 19/2/17.
//  Copyright © 2017 erterfed. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //UIImage? = nil gives a default nil value if there's no image
    func configureCell(post: Post, img: UIImage? = nil) {
        self.post = post
        self.caption.text = post.caption
        self.likesLbl.text = "\(post.likes)"
        print("ert: imageUrl: \(post.imageUrl)")
        if img != nil {
            self.postImg.image = img
        } else {
            let ref = FIRStorage.storage().reference(forURL: post.imageUrl)
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("ert: Unable to download image from Firebase storage")
                } else {
                    print("ert: Image downloaded from Firebase storage")
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.postImg.image = img
                            FeedVC.imageCache.setObject(img, forKey: post.imageUrl as NSString)
                        }
                    }
                }
            })
        }
        /*
        if img != nil {
            //if there's an image in the cache already, use it instead of downloading the image
            self.postImg.image = img
        } else {
            //if image is not in cache, then download it and save into cache
            let ref = FIRStorage.storage().reference(forURL: post.imageUrl)
            //restrict the size uses for storage
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("ert: Unable to download image from Firebase storage")
                } else {
                    print("ert: Image downloaded from Firebase storage")
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.postImg.image = img
                            FeedVC.imageCache.setObject(img, forKey: post.imageUrl as NSString)
                        }
                    }
                }
            } )
                
        }
        */
        
    }

}
