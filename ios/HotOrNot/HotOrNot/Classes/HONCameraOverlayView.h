//
//  HONCameraOverlayView.h
//  HotOrNot
//
//  Created by Matthew Holcombe on 09.27.12.
//  Copyright (c) 2012 Built in Menlo, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HONImagePickerViewController.h"

@interface HONCameraOverlayView : UIView

- (void)hidePreview;
- (void)showPreview:(UIImage *)image;

@property (nonatomic, weak) HONImagePickerViewController *delegate;
@property (nonatomic, weak) UIButton *captureButton;
@property (nonatomic, weak) UIButton *flashButton;
@property (nonatomic, weak) UIButton *changeCameraButton;
@property (nonatomic, weak) UIButton *cameraRollButton;
@property (nonatomic, weak) UIButton *nextButton;
@property (nonatomic, weak) UIButton *backButton;
@property (nonatomic, weak) NSString *subjectName;

@end
