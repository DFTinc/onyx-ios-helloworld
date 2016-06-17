//
//  ViewController.h
//  onyx-ios-helloworld
//
//  Created by Chace Hatcher on 6/17/16.
//  Copyright © 2016 Diamond Fortress Technologies, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <OnyxKit/OnyxViewController.h>

@interface ViewController : UIViewController <OnyxViewControllerDelegate, UIScrollViewDelegate, MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *rawImage;
@property (strong, nonatomic) IBOutlet UIImageView *processedImage;
@property (strong, nonatomic) IBOutlet UIImageView *enhancedImage;
@property (strong, nonatomic) IBOutlet UITextView *detailTextView;
@property NSData *WSQData;
@property NSData *invertedMirroredWSQData;

@property ProcessedFingerprint *fp;

- (IBAction)capture:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)save:(id)sender;



@end

