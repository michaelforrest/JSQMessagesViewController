//
//  SendButton.swift
//  MSTY
//
//  Created by Maciej Trybilo on 24/07/2015.
//  Copyright (c) 2015 MSTY Ltd. All rights reserved.
//

import Foundation

class SendButton: UIButton {
    
    override var enabled: Bool {
        
        didSet {
            
            if enabled {
                backgroundColor = Palette.MstyYellow
                layer.borderWidth = 0
            } else {
                backgroundColor = UIColor.whiteColor()
                layer.borderWidth = 1.5
            }
        }
    }
    
    init() {
        
        super.init(frame: CGRectZero)
        
        configure()
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        configure()
    }
    
    private func configure() {
        
        let sendTitle = NSLocalizedString("Send",
            tableName   : "JSQMessages",
            bundle      : NSBundle.mainBundle(),
            value       : "Send",
            comment     : "Text for the send button on the messages view toolbar")
        
        let tintColor = UIColor.whiteColor()
        
        self.setTitle(sendTitle, forState: .Normal)
        self.setTitleColor(tintColor, forState: .Normal)
        self.setTitleColor(tintColor.jsq_colorByDarkeningColorWithValue(0.1), forState: .Highlighted)
        self.setTitleColor(Palette.MstyYellow, forState: .Disabled)
        
        self.titleLabel?.font = UIFont(name: "GothamRndSSm-Medium", size: 14.5)
        self.titleLabel?.adjustsFontSizeToFitWidth = false
        self.contentMode = .Center
        self.tintColor = tintColor
        
        self.sizeToFit()
        
        var frame = self.frame
        frame.size.width += 19
        frame.size.height = InitialTextViewHeight
        
        self.frame = frame
        
        self.layer.cornerRadius = InitialTextViewHeight / 2
        self.layer.borderColor = Palette.MstyYellow.CGColor
    }
    
}
