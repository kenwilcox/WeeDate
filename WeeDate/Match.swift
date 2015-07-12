//
//  Match.swift
//  WeeDate
//
//  Created by Kenneth Wilcox on 7/11/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import Foundation
import Parse

struct Match {
  let id: String
  let user: User
}

func fetchMatches (callBack: ([Match]) -> ()) {
  PFQuery(className: "Action")
    .whereKey("byUser", equalTo: PFUser.currentUser()!.objectId!)
    .whereKey("type", equalTo: "matched")
    .findObjectsInBackgroundWithBlock({
      objects, error in
      
      if let matches = objects as? [PFObject] {
        let matchedUsers = matches.map({
          (object)->(matchID: String, userID: String) in
          (object.objectId!, object.objectForKey("toUser") as! String)
        })
        let userIDs = matchedUsers.map({$0.userID})
        
        PFUser.query()!
          .whereKey("objectId", containedIn: userIDs)
          .orderByAscending("objectId")
          .findObjectsInBackgroundWithBlock({
            objects, error in
            
            if let users = objects as? [PFUser] {
              var m = Array<Match>()
              
              for (index, user) in enumerate(users) {
                // Search the matchedUsers array for the matchID belonging to the current user obejct
                var matchID: String = ""
                for matchedUser in matchedUsers
                {
                  if (matchedUser.userID == user.objectId)
                  {
                    matchID = matchedUser.matchID
                    break
                  }
                }
                m.append(Match(id: matchID, user: pfUserToUser(user)))
              }
              
              callBack(m)
            }
          })
      }
    })
}

