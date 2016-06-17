//
//  ViewController.m
//  onyx-ios-helloworld
//
//  Created by Chace Hatcher on 6/17/16.
//  Copyright © 2016 Diamond Fortress Technologies, Inc. All rights reserved.
//

#import "ViewController.h"
#import "OnyxKit/ProcessedFingerprint.h"

#import <malloc/malloc.h>

@interface ViewController ()


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)Onyx:(OnyxViewController *)controller didOutputProcessedFingerprint:(ProcessedFingerprint *)fingerprint fromSet:(NSArray *)fingerprints{
    
    for (ProcessedFingerprint * p in fingerprints) {
        NSLog(@"%fx%f print: %d", p.size.width, p.size.height, p.nfiqscore);
        NSLog(@"finger: %lu", (long)p.finger);
    }
    
    _rawImage.image = [fingerprint sourceImage];
    
    _processedImage.image = [fingerprint processedImage];
    
    _enhancedImage.image = [fingerprint blackWhiteProcessed];
    
    _detailTextView.text = [_detailTextView.text stringByAppendingString:[NSString stringWithFormat:@"%zdb\n", malloc_size((__bridge const void *) fingerprint)]];
    
    _detailTextView.text = [_detailTextView.text stringByAppendingString:[NSString stringWithFormat:@"size: %fx%f\n", fingerprint.size.width, fingerprint.size.height]];
    _detailTextView.text = [_detailTextView.text stringByAppendingString:[NSString stringWithFormat:@"quality: %f\n", [fingerprint quality]]];
    _detailTextView.text = [_detailTextView.text stringByAppendingString:[NSString stringWithFormat:@"nfiqscore: %d\n", [fingerprint nfiqscore]]];
    _detailTextView.text = [_detailTextView.text stringByAppendingString:[NSString stringWithFormat:@"mlpscore: %f\n", [fingerprint mlpscore]]];
    
    _fp = fingerprint;
    
}

- (IBAction)capture:(id)sender {
    OnyxViewController *vc = [[OnyxViewController alloc] init];
    
    vc.delegate = self;
    vc.state = ONYX_ENROLL;
    vc.showTutorial = false;
    vc.hideHandSelect = false;
    vc.license = @"xxxx-xxxx-xxxx-x-x";
    vc.showDebug = false;
    
    vc.focusMeasurementRequirement = 0.1;
    vc.frameCount = 3;
    vc.thresholdValue = 100;
    
    vc.useFlash = false;
    
    [self presentViewController:vc animated:NO completion:nil];
}



- (IBAction)save:(id)sender {
    UIImageWriteToSavedPhotosAlbum([_fp sourceImage], nil, nil, nil);
    UIImageWriteToSavedPhotosAlbum([_fp processedImage], nil, nil, nil);
    UIImageWriteToSavedPhotosAlbum([_fp enhancedImage], nil, nil, nil);
    UIImageWriteToSavedPhotosAlbum([_fp invertedMirroredProcessedImage], nil, nil, nil);
    UIImageWriteToSavedPhotosAlbum([_fp blackWhiteProcessed], nil, nil, nil);
    
}
@end
