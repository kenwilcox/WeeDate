//
//  ChatViewController.swift
//  WeeDate
//
//  Created by Kenneth Wilcox on 7/12/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import Foundation
import Parse

class ChatViewController: JSQMessagesViewController {
  
  var messages: [JSQMessage] = []
  let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleBlueColor())
  let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleLightGrayColor())
  var senderAvatar: UIImage!
  var recipientAvatar: UIImage!
  var recipient: User!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override var senderDisplayName: String! {
    get {
      return currentUser()!.name
    }
    
    set {
      super.senderDisplayName = newValue
    }
  }

  override var senderId: String! {
    get {
      return currentUser()!.id
    }
    
    set {
      super.senderId = newValue
    }
  }
  
  override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
    
    var data = self.messages[indexPath.row]
    return data
  }
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return messages.count
  }
  
  override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
    
    var data = self.messages[indexPath.row]
    if data.senderId == PFUser.currentUser()!.objectId {
      return outgoingBubble
    } else {
      return incomingBubble
    }
  }
  
  override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
    
    var imgAvatar = JSQMessagesAvatarImage.avatarWithImage( JSQMessagesAvatarImageFactory.circularAvatarImage( UIImage(named: "profile-header"), withDiameter: 60 ) )
    if (self.messages[indexPath.row].senderId == self.senderId) {
      if (self.senderAvatar != nil) {
        imgAvatar = JSQMessagesAvatarImage.avatarWithImage( JSQMessagesAvatarImageFactory.circularAvatarImage( self.senderAvatar, withDiameter: 60 ) )
      } else {
        currentUser()!.getPhoto({ (image) -> () in
          self.senderAvatar = image
          self.updateAvatarImageForIndexPath( indexPath, avatarImage: image)
        })
      }
    } else {
      if (self.recipientAvatar != nil) {
        imgAvatar = JSQMessagesAvatarImage.avatarWithImage( JSQMessagesAvatarImageFactory.circularAvatarImage( self.recipientAvatar, withDiameter: 60 ) )
      } else {
//        getUserAsync( self.messages[indexPath.row].senderId, { (user) -> () in
//          self.updateAvatarForRecipient( indexPath, user: user ) } )
        self.recipient.getPhoto({ (image) -> () in
          self.updateAvatarImageForIndexPath( indexPath, avatarImage: image)
        })
      }
    }
    return imgAvatar
  }
  
  override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
    
    var localSenderId = senderId
    var localRecipientId = self.recipient.id
    if (messages.count % 2 == 1)
    {
      localSenderId = self.recipient.id
      localRecipientId = senderId
    }
    
    let m = JSQMessage(senderId: localSenderId, senderDisplayName: senderDisplayName, date: date, text: text)
    self.messages.append(m)
    finishSendingMessage()
  }
  
  func updateAvatarImageForIndexPath( indexPath: NSIndexPath, avatarImage: UIImage) {
    let cell: JSQMessagesCollectionViewCell = self.collectionView.cellForItemAtIndexPath(indexPath) as! JSQMessagesCollectionViewCell
    cell.avatarImageView.image = JSQMessagesAvatarImageFactory.circularAvatarImage( avatarImage, withDiameter: 60 )
  }
  
//  func updateAvatarForRecipient( indexPath: NSIndexPath, user: User ) {
//    user.getPhoto({ (image) -> () in
//      self.recipientAvatar = image
//      self.updateAvatarImageForIndexPath( indexPath, avatarImage: image)
//    })
//  }
}