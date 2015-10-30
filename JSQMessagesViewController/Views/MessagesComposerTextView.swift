//
//  MessagesComposerTextView.swift
//  MSTY
//
//  Created by Maciej Trybilo on 24/07/2015.
//  Copyright (c) 2015 MSTY Ltd. All rights reserved.
//

import Foundation

let InitialTextViewHeight: CGFloat = 32

class MessagesComposerTextView: UITextView {
    
    let fontToSet = UIFont(name: "GothamRndSSm-Book", size: 13)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = UIColor.whiteColor()
        
        self.font = fontToSet
        self.textColor = UIColor.blackColor()
        self.textAlignment = NSTextAlignment.Natural
        
        self.contentMode = UIViewContentMode.Redraw
        self.dataDetectorTypes = UIDataDetectorTypes.None
        self.keyboardAppearance = UIKeyboardAppearance.Default
        self.keyboardType = UIKeyboardType.Default
        self.returnKeyType = UIReturnKeyType.Default
    }
    
    override func hasText() -> Bool {
        
        return NSString(string: text.jsq_stringByTrimingWhitespace()).length > 0
    }
    
}
