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

#import "JSQMstyMediaItem.h"

#import "JSQMessagesMediaPlaceholderView.h"
#import "JSQMessagesMediaViewBubbleImageMasker.h"

#import "MSTY-Swift.h"

@interface JSQMstyMediaItem ()

@property (strong, nonatomic) UIImageView *cachedImageView;
@property (strong, nonatomic) CircularProgressView *progressView;

@end


@implementation JSQMstyMediaItem

#pragma mark - Initialization

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        _image = [UIImage imageWithCGImage:image.CGImage];
        _cachedImageView = nil;
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image
              imageIdentifier:(NSString *)imageIdentifier
                     imageURL:(NSURL *)imageURL
               mstyIdentifier:(NSString *)mstyIdentifier
                    delivered:(BOOL)delivered
                       failed:(BOOL)failed
                          row:(NSInteger)row
{
    self = [super init];
    if (self) {
        _image = nil;
        _cachedImageView = nil;
        _imageIdentifier = imageIdentifier;
        _imageURL = imageURL;
        _mstyIdentifier = mstyIdentifier;
        _row = row;
        
        if (!delivered) {
            _progressView = [[CircularProgressView alloc] initWithFrame:CGRectMake(0, 0, 46, 46)];
            
            UIImageView *playButton = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"browse-play-btn"]];
            playButton.frame = _progressView.bounds;
            
            _progressView.fullView = playButton;
            
            UIImageView *retryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"retry-msty"]];
            retryView.frame = _progressView.bounds;
            
            _progressView.retryView = retryView;
            _progressView.retry = failed;
            
            //[_progressView setProgress:0.0 animate:NO];
            [_progressView setProgress:0.1 animate:YES];
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(imageUploadProgressUpdated:)
                                                         name:@"ImageUploadProgressNotification"
                                                       object:nil];
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(messageDelivered:)
                                                         name:@"MessageDeliveredNotification"
                                                       object:nil];
        }
    }
    return self;
}

- (void)dealloc
{
    _cachedImageView = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)imageUploadProgressUpdated:(NSNotification *)note
{
    NSString *changedImageId = note.userInfo[@"imageId"];
    
    if ([changedImageId isEqualToString: self.imageIdentifier]) {
        NSNumber *progress = (NSNumber *)note.userInfo[@"progress"];
        [self.progressView setProgress:0.1 + [progress floatValue] * 0.8 animate:YES];
    }
}

- (void)messageDelivered:(NSNotification *)note
{
    NSString *clientId = note.userInfo[@"clientId"];
    
    if ([clientId isEqualToString:self.mstyIdentifier]) {
        [self.progressView setProgress:1.0 animate:YES];
    }
}

#pragma mark - Setters

- (void)setImage:(UIImage *)image
{
    _image = [UIImage imageWithCGImage:image.CGImage];
    _cachedImageView = nil;
}

- (UIImage *)image {
    
    if (_image == nil) {
        Services * services = [Services shared];
        ImagesDataEngine * imagesDataEngine = services.imagesDataEngine;
        _image = [imagesDataEngine fetchBlurredImage:self.imageIdentifier imageURL:self.imageURL];
    }
    
    return _image;
}

- (void)setAppliesMediaViewMaskAsOutgoing:(BOOL)appliesMediaViewMaskAsOutgoing
{
    [super setAppliesMediaViewMaskAsOutgoing:appliesMediaViewMaskAsOutgoing];
    _cachedImageView = nil;
}

#pragma mark - JSQMessageMediaData protocol

- (UIView *)mediaView
{
    if (self.image == nil) {
        return nil;
    }
    
    if (self.cachedImageView == nil) {
        CGSize size = [self mediaViewDisplaySize];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:self.image];
        imageView.frame = CGRectMake(0.0f, 0.0f, size.width, size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        
        imageView.tag = 1000 + self.row;
        
        imageView.layer.cornerRadius = size.height / 2;
        
        if (self.progressView != nil) {
            self.progressView.center = CGPointMake(size.width/2, size.height/2);
            [imageView addSubview: self.progressView];
        } else {
            UIImageView *playButton = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"browse-play-btn"]];
            playButton.frame = CGRectMake(0, 0, 46, 46);
            playButton.center = CGPointMake(size.width/2, size.height/2);
            [imageView addSubview:playButton];
        }
        
        self.cachedImageView = imageView;
    }
    
    return self.cachedImageView;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object
{
    if (![super isEqual:object]) {
        return NO;
    }
    
    JSQMstyMediaItem *mstyItem = (JSQMstyMediaItem *)object;
    
    return [self.image isEqual:mstyItem.image];
}

- (NSUInteger)hash
{
    return self.mstyIdentifier.hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: image=%@, appliesMediaViewMaskAsOutgoing=%@>",
            [self class], self.image, @(self.appliesMediaViewMaskAsOutgoing)];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _image = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(image))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.image forKey:NSStringFromSelector(@selector(image))];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    JSQMstyMediaItem *copy = [[[self class] allocWithZone:zone] initWithImage:self.image];
    copy.appliesMediaViewMaskAsOutgoing = self.appliesMediaViewMaskAsOutgoing;
    return copy;
}

@end
