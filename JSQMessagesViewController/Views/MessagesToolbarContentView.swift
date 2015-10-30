//
//  MessagesToolbarContentView.swift
//  MSTY
//
//  Created by Maciej Trybilo on 24/07/2015.
//  Copyright (c) 2015 MSTY Ltd. All rights reserved.
//

import Foundation

class MessagesToolbarContentView: UIView {

    weak var textView: MessagesComposerTextView!
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var textViewContainer: UIView!
    
    @IBOutlet weak var leftBarButtonContainerView: UIView!
    @IBOutlet weak var rightBarButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightBarButtonHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var rightBarButtonContainerView: UIView!
    
    var placeholderTextView: UITextView?
    
    var placeholderText: String = "" {
        didSet {
            placeholderTextView?.text = placeholderText
        }
    }
    
    var leftBarButtonItem: UIButton? {
        
        didSet {
            
            if let leftBarButtonItem = leftBarButtonItem {
                leftBarButtonContainerView.addSubview(leftBarButtonItem)
            } else {
                oldValue?.removeFromSuperview()
            }
        }
    }
    

    var rightBarButtonItem: UIButton? {
        
        didSet {
            
            if let rightBarButtonItem = rightBarButtonItem {
                
                rightBarButtonContainerView.addSubview(rightBarButtonItem)
                
                rightBarButtonWidthConstraint.constant = rightBarButtonItem.bounds.size.width
                rightBarButtonHeightConstraint.constant = rightBarButtonItem.bounds.size.height
                
            } else {
                oldValue?.removeFromSuperview()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        translatesAutoresizingMaskIntoConstraints = false
        
        leftBarButtonContainerView.backgroundColor = UIColor.whiteColor()
        rightBarButtonContainerView.backgroundColor = UIColor.whiteColor()
        
        textViewContainer.backgroundColor = UIColor.whiteColor()
        
        textViewContainer.layer.cornerRadius = textViewContainer.bounds.size.height / 2
        
        textViewContainer.layer.borderColor = Palette.MstyLightGray.CGColor
        textViewContainer.layer.borderWidth = 1
        
        let placeholderTextView = UITextView(frame: textView.bounds)
        placeholderTextView.text = placeholderText
        placeholderTextView.font = textView.fontToSet
        placeholderTextView.textColor = Palette.MstyLightGray
        placeholderTextView.userInteractionEnabled = false
        placeholderTextView.backgroundColor = UIColor.clearColor()
        
        textView.addSubview(placeholderTextView)
        
        self.placeholderTextView = placeholderTextView
        
        addTextViewNotificationObservers()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        // hack scaling down the font in the placeholder
        
        if let placeholderTextView = placeholderTextView {
            
            var textRect: CGRect
            
            repeat {
                
                textRect = placeholderTextView.attributedText.boundingRectWithSize(CGSizeMake(CGFloat.max, placeholderTextView.bounds.size.height),
                    options: [NSStringDrawingOptions.UsesFontLeading, NSStringDrawingOptions.UsesLineFragmentOrigin],
                    context: nil)
                
                if textRect.width > textView.bounds.size.width {
                    if let font = placeholderTextView.font {
                        placeholderTextView.font = font.fontWithSize(font.pointSize - 1)
                    }
                }
                
            } while textRect.width > textView.bounds.size.width
            
        }
        
        // Dirty hack to prevent strange movements when entering the chat screen
        if self.textView.contentSize.height == 33 || self.textView.contentSize.height < InitialTextViewHeight {
            return
        }
        
        self.textViewHeightConstraint.constant = self.textView.contentSize.height
        
        // Dirty hack to fix the size after sending the message when the height is larger
        if textView.text == "" {
            self.textViewHeightConstraint.constant = 32
        }
        
        self.textView.setContentOffset(CGPointZero, animated: false)
    }
    
    func addTextViewNotificationObservers() {
    
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "didReceiveTextViewNotification:",
            name    : UITextViewTextDidChangeNotification,
            object  : textView)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "didReceiveTextViewNotification:",
            name    : UITextViewTextDidBeginEditingNotification,
            object  : textView)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "didReceiveTextViewNotification:",
            name    : UITextViewTextDidEndEditingNotification,
            object  : textView)
    }
    
    func didReceiveTextViewNotification(note: NSNotification) {
        setNeedsLayout()
        
        placeholderTextView?.hidden = textView.hasText()
    }
    
}
