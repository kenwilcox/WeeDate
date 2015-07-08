//
//  User.swift
//  WeeDate
//
//  Created by Kenneth Wilcox on 6/20/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import Foundation
import Parse

struct User {
  let id: String
  let name: String
  private let pfUser: PFUser
  
  func getPhoto(callback:(UIImage) -> ()) {
    let imageFile = pfUser.objectForKey("picture") as! PFFile
    imageFile.getDataInBackgroundWithBlock({
      data, error in
      if let data = data {
        callback(UIImage(data: data)!)
      }
    })
  }
}

private func pfUserToUser(user: PFUser)->User {
  return User(id: user.objectId!, name: user.objectForKey("firstName") as! String, pfUser: user)
}

func currentUser() -> User? {
  if let user = PFUser.currentUser() {
    return pfUserToUser(user)
  }
  return nil
}

func fetchUnviewedUsers(callback:([User]) -> ()) {
  var currentUserId = PFUser.currentUser()!.objectId!
  UIApplication.sharedApplication().networkActivityIndicatorVisible = true
  PFQuery(className: "Action")
    .whereKey("byUser", equalTo: currentUserId).findObjectsInBackgroundWithBlock({
      objects, error in
      let seenIds = map((objects as! [PFObject]), {$0.objectForKey("toUser")!})
      PFUser.query()!
        .whereKey("objectId", notEqualTo: currentUserId)
        .whereKey("objectId", notContainedIn: seenIds)
        .findObjectsInBackgroundWithBlock({
          objects, error in
          if let pfUsers = objects as? [PFUser] {
            let users = map(pfUsers, {pfUserToUser($0)})
            println("callback: \(users.count)")
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            callback(users)
          }
        })
    })
}

enum UserAction: String {
  case Like = "liked"
  case Skip = "skipped"
}

func saveSkip(user: User) {
  saveAction( user, UserAction.Skip)
}

func saveLike(user: User) {
  saveAction( user, UserAction.Like)
}

private func saveAction(user: User, action: UserAction) {
  let obj = PFObject(className: "Action")
  obj.setObject(PFUser.currentUser()!.objectId!, forKey: "byUser")
  obj.setObject(user.id, forKey: "toUser")
  obj.setObject(action.rawValue, forKey: "type")
  UIApplication.sharedApplication().networkActivityIndicatorVisible = true
  obj.saveInBackgroundWithBlock( { (success, error) in
    dispatch_async(dispatch_get_main_queue(), { () -> Void in
      UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    } )
  } )
}
