//
//  Message.swift
//  WeeDate
//
//  Created by Kenneth Wilcox on 7/12/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import Foundation

struct Message {
  let message: String
  let senderID: String
  let date: NSDate
}

private let ref = Firebase(url: "\(APIKeys.Firebase.baseUrl)/messages")
private let dateFormat = "yyyyMMddHHmmss"

private func dateFormatter() -> NSDateFormatter {
  let dateFormatter = NSDateFormatter()
  dateFormatter.dateFormat = dateFormat
  return dateFormatter
}

func saveMessage(matchID: String, message: Message) {
  ref.childByAppendingPath(matchID).updateChildValues([
    dateFormatter().stringFromDate(message.date): [
      "message": message.message,
      "sender": message.senderID
  ]])
}