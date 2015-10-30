//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#ifndef JSQMessages_JSQMessages_h
#define JSQMessages_JSQMessages_h

#import "Controllers/JSQMessagesViewController.h"

//  Views
#import "Views/JSQMessagesCollectionView.h"
#import "Views/JSQMessagesTypingIndicatorFooterView.h"
#import "Views/JSQMessagesLoadEarlierHeaderView.h"

//  Layout
#import "Layout/JSQMessagesCollectionViewFlowLayout.h"
#import "Layout/JSQMessagesCollectionViewLayoutAttributes.h"
#import "Layout/JSQMessagesCollectionViewFlowLayoutInvalidationContext.h"

//  Toolbar
#import "Views/JSQMessagesInputToolbar.h"

//  Model
#import "Model/JSQMessage.h"
#import "Model/JSQTextMessage.h"
#import "Model/JSQMediaMessage.h"

#import "Model/JSQMediaItem.h"
#import "Model/JSQMstyMediaItem.h"
#import "Model/JSQLocationMediaItem.h"
#import "Model/JSQVideoMediaItem.h"

#import "Model/JSQMessagesBubbleImage.h"
#import "Model/JSQMessagesAvatarImage.h"

//  Protocols
#import "Model/JSQMessageData.h"
#import "Model/JSQMessageMediaData.h"
#import "Model/JSQMessageAvatarImageDataSource.h"
#import "Model/JSQMessageBubbleImageDataSource.h"
#import "Model/JSQMessagesCollectionViewDataSource.h"
#import "Model/JSQMessagesCollectionViewDelegateFlowLayout.h"

//  Factories
#import "Factories/JSQMessagesAvatarImageFactory.h"
#import "Factories/JSQMessagesBubbleImageFactory.h"
#import "Factories/JSQMessagesMediaViewBubbleImageMasker.h"
#import "Factories/JSQMessagesTimestampFormatter.h"

//  Categories
//#import "Categories/JSQSystemSoundPlayer+JSQMessages.h"
#import "Categories/NSString+JSQMessages.h"
#import "Categories/UIColor+JSQMessages.h"
#import "Categories/UIImage+JSQMessages.h"
#import "Categories/UIView+JSQMessages.h"

#endif
