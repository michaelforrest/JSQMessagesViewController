//
//  MessagesCollectionViewCellIncoming.swift
//  MSTY
//
//  Created by Maciej Trybilo on 06/11/2014.
//  Copyright (c) 2014 MSTY. All rights reserved.
//

import Foundation

class MessagesCollectionViewCellIncoming: JSQMessagesCollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.messageBubbleTopLabel?.textAlignment = NSTextAlignment.Left
        self.cellBottomLabel?.textAlignment = NSTextAlignment.Left
    }
    
    override class func nib() -> UINib {
        return UINib(nibName: "JSQMessagesCollectionViewCellIncoming", bundle: NSBundle.mainBundle())
    }
    
}