//
//  PostTableViewCell.swift
//  Makestagram
//
//  Created by Jananni Rathnagiri on 6/27/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import Bond

class PostTableViewCell: UITableViewCell {

   @IBOutlet weak var postImageView: UIImageView!

   var post: Post? {
      didSet {
         // 1
         if let post = post {
            //2
            // bind the image of the post to the 'postImage' view
            post.image.bindTo(postImageView.bnd_image)
         }
      }
   }

   override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
