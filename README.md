# README #

### What is this repository for? ###

* This app demonstrates the basic functionality of ONYX for iOS & can be used to start a project that uses ONYX from scratch

### Fork and Check out ###

* Fork a copy of onyx-ios-helloworld
* Check out your forked copy in Xcode on your local machine

### Enter License Key ###

* Contact Diamond Fortress (www.diamondfortress.com/contact) to purchase a license key
* Enter license key in ViewController.mm  at line 63 vc.license = @"xxxx-xxxx-xxxx-x-x";

### Run ###

* Must have actual device to run, Simulators will not work


# ADDING ONYX TO EXISTING PROJECT #

## Importing ONYX into your Project ##

Fork a copy of onyx-ios-helloworld

Check out your forked copy in Xcode on your local machine

Open your existing Xcode project on your local machine

Drag the 'Onyx' Group from the onyx-ios-helloworld project and drop it in your project. The Onyx group should contain the following frameworks and folder:
- onyx-core.framework
- OnyxKit.framework
- opencv2.framework
- Resources

When prompted, make sure beside 'Destination:' the 'Copy items if needed' box is checked, and beside 'Added Folders:' the 'Create groups' box is checked.

After Onyx has been imported, Xcode will try to automatically set up framework search paths for you. Please verify these paths are correct before continuing. The Onyx group you've imported already has the opencv2 and onyx-core frameworks. If either of these frameworks are already a part of your project, you must remove them and us the version imported to prevent duplicate symbols.

### You must include these Apple frameworks in your project: ###

 - CoreMedia
 - AVFoundation
 - AssetsLibrary
 
Click on your project to display your settings. Under the 'General' tab scroll down to 'Linked Frameworks and Libraries', click the '+' to add the frameworks. Choos the frameworks from the list, and then click the 'Add' button.

### Setting Linker Flags ###

Make sure you set 'Other Linker Flags' in your target's 'Build Settings' to:

- -ObjC - all_load

Click on your project to display settings. Under 'Build Settings' scroll down to 'Linking' and find the 'Other Linker Flags' setting. Click '>' to expand and then click '+' to add the linker flag.


# USING ONYX #

### Change Method File Extension ###

All method files that use ONYX must have an .mm extension. Xcode will compile .mm files with C++ flags. Any method files not using ONYX can keep their .m extension.

To rename a method file simply click on the file name and then click again, which will allow you to edit the file name. Add an additional 'm' to the extension and press return.

### Importing the ONYX View Controller ###

After you have the framework added to your project, you must then import the OnyxViewController.h header file into your project view controller header file (typically 'ViewController.h').

Make suer whatever view controller you wish to use ONYX is also a delegate for OnyxViewController:

```objective-c
#import <OnyxKit/OnyxViewController.h>
@interface ViewController: UIViewController <OnyxViewControllerDelegate>
```
### Using the ONYX View Controller ###

The OnyxViewController is a modal that can be presented programmatically at any time.

Insert the follow code whenever you want to invoke the OnyxViewController:

```objective-c
OnyxViewController *vc = [[OnyxViewController alloc] init];
vc.delegate = self;
vc.state = ONYX_SINGLE;
vc.license = @"Insert your ONYX License Key Here.";
[self presentViewController:vc animated:YES completion:nil];
```
In the 'Insert your ONYX License Key Here' field type the license key you purchased from Diamond Fortress Technologies, Inc.

That's it. That is all you need to do to present ONYX.

### ONYX View Controller States ###

ONYX_SINGLE [Default] - The single state will capture one print and perform a callback with this print

ONYX_ENROLL - The enroll state will capture three prints by default and then peform a fourth capture. The fourth capture is match against the best quality print of the initial captures.

### ONYX View Controller Attributes ###

```objective-c
/*!
 * @brief The OnyxViewController's delegate
 */
@property (strong, nonatomic) id delegate;

/*!
 * @brief The OnyxViewController's internal state
 */
@property int state;

/*!
 * @brief The number of enroll captures to take [default: 3]
 */
@property int enrollCount;

/*!
 * @brief The OnyxViewController's brand image (Not implemented)
 */
@property UIImage *brand;

/*!
 * @brief The OnyxViewController's license key
 */
@property NSString *license;

/*!
 * @brief Option to hide hand selection [default: false]
 */
@property bool hideHandSelect;

/*!
 * @brief The internal finger direction
 */
@property NSInteger fingerDirection;

/*!
 * @brief The internal finger
 */
@property NSInteger selectedFinger;

/*!
 * @brief Option to reverse hand selection
 */
@property bool reverseHand;

/*!
 * @brief The onyx-core's version number
 */
@property (readonly) NSString *onyxcoreversion;

/*!
 * @brief Option to show tutorial page [default: false]
 */
@property bool showTutorial;

/*!
 * @brief Option to show match score at end of enrollment [default: false]
 */
@property bool showMatchScore;

/*!
 * @brief Option to change LED brightness for camera
 */
@property float LEDBrightness; // (0.0, 1.0]

/*!
 * @brief Option 
 */
@property bool useAutoFocus;

/*!
 * @brief Boolean to toggle on/off flashing during capture.
 */
@property bool useFlash;

/*!
 * @brief Text for a custom label in the info view.
 */
@property NSString *infoText;

/*!
 * @brief Boolean for showing debug info on screen
 */
@property bool showDebug;
```
### ONYX Delegate Methods ###

To implement the following 'didOutputProcessedFingerprint' method you must import the 'ProcessedFingerprint.h' header file into whatever view controller header file you are using.

```objective-c
#import <OnyxKit/ProcessedFingerprint.h>
```

This method will return a fingerprint object:

```objective-c
-(void) Onyx:(OnyxViewController *)controller
didOutputProcessedFingerprint:(ProcessedFingerprint *)fingerprint
fromSet:(NSArray *)fingerprints;
```
The 'ProcessedFingerprint' object has the following attributes:

```objective-c
/*!
 @class ProcessedFingerprint
 @abstract Object returned from OnyxViewController that holds all data on fingerprint.
 */
@interface ProcessedFingerprint : NSObject
/*!
 * @brief The source image.
 */
@property UIImage *sourceImage;
/*!
 * @brief The processed image.
 */
@property UIImage *processedImage;
/*!
 * @brief The enhanced image.
 */
@property UIImage *enhancedImage;
/*!
 * @brief The inverted and y-axis flipped processed image.
 */
@property UIImage *invertedMirroredProcessedImage;
/*!
 * @brief The fingerprint template, to be used with Onyx matchers.
 */
@property NSData *fingerprintTemplate;
/*!
 * @brief The WSQ data.
 */
@property NSData *WSQ;
/*!
 * @brief The inverted and mirrored WSQ data.
 */
@property NSData *invertedMirroredWSQ;
/*!
 * @brief Black and white image of the processed image.
 */
@property UIImage *blackWhiteProcessed;
/*!
 * @brief The quality score. Any score over 15 is acceptable.
 */
@property float quality;
/*!
 * @brief The focus measure score. [0, 1] 0.1 is acceptable.
 */
@property float focusMeasure;
/*!
 * @brief The nfiqscore of the WSQ file.
 */
@property int nfiqscore;
/*!
 * @brief The mlscore of the WSQ file.
 */
@property float mlpscore;
/*!
 * @brief The direction of the finger.
 * Images will be flipped upright beforehand.
 */
@property NSInteger fingerDirection;
/*!
 * @brief The finger number.
 */
@property NSInteger finger;
/*!
 * @brief image size for all returned images.
 */
@property CGSize size;
```
### Matching Fingerprint Templates ###

To perform a 1 to 1 match of fingerprint tempalates on-device you must import the 'OnyxMatch.h' header file into your .mm implementation file.

```objective-c
#import <OnyxKit/OnyxMatch.h>
```
 Then use the following implementation to match fingerprint templates:
 
 ```objective-c
 - (void)Onyx:(OnyxViewController *)controller
 didOutputProcessedFingerprint:(ProcessedFingerprint *)fingerprint
 fromSet:(NSArray *)fingerprints {
 
  NSString *tempFingerprint = [NSData dataWithData:fingerprint.fingerprintTemplate];
 
  NSLog(@"Comparing prints");
 
  bool matched = false;
  NSData *fp = "get your stored fingerprint template";
  float matchValue = [OnyxMatch match:fp with:tempFingerprint];
  
  NSLog(@"match value (%.2f)", matchValue);
  
  if(matchVlaue > 0.03) {
  
    NSLog(@"User Authenticated!");
    matched = true;
  
  }
  
  if (matched) {
    
    NSLog(@"Fingerprint validated");
    //Your implementation here:
    
  }
}
```
### For Additional Support ###
Please see our support portal at:

http://support.diamondfortress.com

Email Support is available by contacting:

support@diamondfortress.com

We also have premium support packages available at all evels for additional cost. Please contact your DFT representative for more details.
