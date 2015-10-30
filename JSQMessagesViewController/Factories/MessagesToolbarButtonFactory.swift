//
//  MessagesToolbarButtonFactory.swift
//  MSTY
//
//  Created by Maciej Trybilo on 24/07/2015.
//  Copyright (c) 2015 MSTY Ltd. All rights reserved.
//

import Foundation

@objc class MessagesToolbarButtonFactory : NSObject{
    
    static func defaultAccessoryButtonItem() -> UIButton {
        
        let accessoryImage = UIImage.jsq_defaultAccessoryImage()
        let normalImage = accessoryImage
        let highlightedImage = accessoryImage
        
        let accessoryButton = UIButton(frame: CGRectZero)
        accessoryButton.setImage(normalImage, forState: .Normal)
        accessoryButton.setImage(highlightedImage, forState: .Normal)
        
        accessoryButton.contentMode = UIViewContentMode.ScaleAspectFit
        accessoryButton.backgroundColor = UIColor.clearColor()
        accessoryButton.tintColor = UIColor.lightGrayColor()
        
        return accessoryButton
    }
}
