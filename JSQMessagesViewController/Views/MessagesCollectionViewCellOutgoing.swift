//
//  MessagesCollectionViewCellOutgoing.swift
//  MSTY
//
//  Created by Maciej Trybilo on 06/11/2014.
//  Copyright (c) 2014 MSTY. All rights reserved.
//

import Foundation

class MessagesCollectionViewCellOutgoing: JSQMessagesCollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.messageBubbleTopLabel?.textAlignment = NSTextAlignment.Right
        self.cellBottomLabel?.textAlignment = NSTextAlignment.Right
    }
    
    override class func nib() -> UINib {
        return UINib(nibName: "JSQMessagesCollectionViewCellOutgoing", bundle: NSBundle.mainBundle())
    }
    
}