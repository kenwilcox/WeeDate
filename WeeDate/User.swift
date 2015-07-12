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

func pfUserToUser(user: PFUser)->User {
  return User(id: user.objectId!, name: user.objectForKey("firstName") as! String, pfUser: user)
}

func currentUser() -> User? {
  if let user = PFUser.currentUser() {
    return pfUserToUser(user)
  }
  return nil
}

//func getUserAsync(userID: String, callback: (User) -> () ) {
//  PFUser.query()?
//    .whereKey("objectId", equalTo: userID)
//    .getFirstObjectInBackgroundWithBlock({
//      object, error -> Void in
//      if let pfUser = object as? PFUser {
//        let user = pfUserToUser(pfUser)
//        callback(user) }
//    })
//}

func fetchUnviewedUsers(callback:([User]) -> ()) {
  var currentUserId = PFUser.currentUser()!.objectId!
  
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
            
            callback(users)
          }
        })
    })
}

enum UserAction: String {
  case Like = "liked"
  case Skip = "skipped"
  case Match = "matched"
}

func saveSkip(user: User) {
  saveAction( user, UserAction.Skip)
}

func saveLike(user: User) {
  //saveAction( user, UserAction.Like)
  PFQuery(className: "Action")
    .whereKey("byUser", equalTo: user.id)
    .whereKey("toUser", equalTo: PFUser.currentUser()!.objectId!)
    .whereKey("type", equalTo: "liked")
    .getFirstObjectInBackgroundWithBlock({
      object, error in
      
      var matched = false
      
      if object != nil {
        matched = true
        object!.setObject("matched", forKey: "type")
        object!.saveInBackgroundWithBlock(nil)
      }
      
      saveAction(user, matched ? .Match : .Like)
    })
}

private func saveAction(user: User, action: UserAction) {
  let obj = PFObject(className: "Action")
  obj.setObject(PFUser.currentUser()!.objectId!, forKey: "byUser")
  obj.setObject(user.id, forKey: "toUser")
  obj.setObject(action.rawValue, forKey: "type")
  obj.saveInBackgroundWithBlock(nil)
}
