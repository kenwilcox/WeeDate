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
