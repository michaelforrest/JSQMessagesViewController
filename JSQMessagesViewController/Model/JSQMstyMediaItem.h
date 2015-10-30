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

#import "JSQMediaItem.h"

@class MstyMessage;

/**
 *  The `JSQMstyMediaItem` class is a concrete `JSQMediaItem` subclass that implements the `JSQMessageMediaData` protocol
 *  and represents a msty media message. An initialized `JSQMstyMediaItem` object can be passed
 *  to a `JSQMediaMessage` object during its initialization to construct a valid media message object.
 *  You may wish to subclass `JSQMstyMediaItem` to provide additional functionality or behavior.
 */
@interface JSQMstyMediaItem : JSQMediaItem <JSQMessageMediaData, NSCoding, NSCopying> {
    UIImage *_image;
}

/**
 *  The image for the Msty media item. The default value is `nil`.
 */
@property (copy, nonatomic) UIImage *image;
@property (nonatomic) NSString *imageIdentifier;
@property (nonatomic) NSURL *imageURL;
@property (nonatomic) NSString *mstyIdentifier;
@property (nonatomic) NSInteger row;

/**
 *  Initializes and returns a Msty media item object having the given image.
 *
 *  @param image The image for the Msty media item. This value may be `nil`.
 *
 *  @return An initialized `JSQMstyMediaItem` if successful, `nil` otherwise.
 *
 *  @discussion If the image must be dowloaded from the network, 
 *  you may initialize a `JSQMstyMediaItem` object with a `nil` image. 
 *  Once the image has been retrieved, you can then set the image property.
 */
- (instancetype)initWithImage:(UIImage *)image;

- (instancetype)initWithImage:(UIImage *)image
              imageIdentifier:(NSString *)imageIdentifier
                     imageURL:(NSURL *)imageURL
               mstyIdentifier:(NSString *)mstyIdentifier
                    delivered:(BOOL)delivered
                       failed:(BOOL)failed
                          row:(NSInteger)row;

@end
