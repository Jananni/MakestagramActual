//
//  PostTableViewCell.swift
//  Makestagram
//
//  Created by Jananni Rathnagiri on 6/27/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import Bond
import Parse

class PostTableViewCell: UITableViewCell {

   @IBOutlet weak var postImageView: UIImageView!
   @IBOutlet weak var likesIconImageView: UIImageView!

   @IBOutlet weak var likesLabel: UILabel!
   @IBOutlet weak var likeButton: UIButton!
   @IBOutlet weak var moreButton: UIButton!

   var postDisposable: DisposableType?
   var likeDisposable: DisposableType?

   var post:Post? {
      didSet {

         postDisposable?.dispose()
         likeDisposable?.dispose()
         // free memory of image stored with post that is no longer displayed
         // 1
         if let oldValue = oldValue where oldValue != post {
            // 2
            oldValue.image.value = nil
         }

         if let post = post {
            postDisposable = post.image.bindTo(postImageView.bnd_image)

            likeDisposable = post.likes.observe { (value: [PFUser]?) -> () in
               if let value = value {
                  self.likesLabel.text = self.stringFromUserList(value)
                  self.likeButton.selected = value.contains(PFUser.currentUser()!)
                  self.likesIconImageView.hidden = (value.count == 0)
               } else {
                  self.likesLabel.text = ""
                  self.likeButton.selected = false
                  self.likesIconImageView.hidden = true
               }
            }
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

   @IBAction func moreButtonTapped(sender: AnyObject) {

   }

   @IBAction func likeButtonTapped(sender: AnyObject) {
      post?.toggleLikePost(PFUser.currentUser()!)
   }

   // Generates a comma separated list of usernames from an array (e.g. "User1, User2")
   func stringFromUserList(userList: [PFUser]) -> String {
      // 1
      let usernameList = userList.map { user in user.username! }
      // 2
      let commaSeparatedUserList = usernameList.joinWithSeparator(", ")

      return commaSeparatedUserList
   }


}
