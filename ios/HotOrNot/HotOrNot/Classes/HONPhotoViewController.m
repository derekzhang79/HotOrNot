//
//  HONPhotoViewController.m
//  HotOrNot
//
//  Created by Matthew Holcombe on 10.04.12.
//  Copyright (c) 2012 Built in Menlo, LLC. All rights reserved.
//

#import "HONPhotoViewController.h"
#import "UIImageView+WebCache.h"
#import "HONAppDelegate.h"

@interface HONPhotoViewController ()
@property (nonatomic, strong) NSString *imgURL;
@end

@implementation HONPhotoViewController

@synthesize imgURL = _imgURL;

- (id)initWithImagePath:(NSString *)imageURL {
	if ((self = [super init])) {
		_imgURL = imageURL;
		self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:1.0];
	}
	
	return (self);
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}


#pragma mark - View Lifecycle
- (void)loadView {
	[super loadView];
	
	UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 1296.0, 968.0)];
	imgView.userInteractionEnabled = YES;
	[imgView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@_l.jpg", self.imgURL]] placeholderImage:nil];
	[self.view addSubview:imgView];
	
//	UIImageView *tmpView = [[UIImageView alloc] initWithFrame:CGRectMake(50.0, 100.0, 100.0, 100.0)];
//	tmpView.image = [HONAppDelegate cropImage:[UIImage imageNamed:@"firstRun_image01.png"] toRect:CGRectMake(30.0, 30.0, 100.0, 100.0)];
//	[self.view addSubview:tmpView];
	
	UIImageView *headerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 45.0)];
	headerImgView.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1.0];
	[headerImgView setImage:[UIImage imageNamed:@"headerTitleBackground.png"]];
	headerImgView.userInteractionEnabled = YES;
	[self.view addSubview:headerImgView];
	
	UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
	backButton.frame = CGRectMake(5.0, 5.0, 54.0, 34.0);
	[backButton setBackgroundImage:[UIImage imageNamed:@"backButton_nonActive.png"] forState:UIControlStateNormal];
	[backButton setBackgroundImage:[UIImage imageNamed:@"backButton_Active.png"] forState:UIControlStateHighlighted];
	[backButton addTarget:self action:@selector(_goDone) forControlEvents:UIControlEventTouchUpInside];
	//backButton = [[SNAppDelegate snHelveticaNeueFontMedium] fontWithSize:11.0];
	[backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[backButton setTitle:@"Done" forState:UIControlStateNormal];
	[headerImgView addSubview:backButton];
	
	
	UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(_goPinch:)];
	[imgView addGestureRecognizer:pinchRecognizer];
	
	UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(_goPan:)];
	[imgView addGestureRecognizer:panRecognizer];
}

- (void)viewDidLoad {
	[super viewDidLoad];
}


#pragma mark - Navigation
- (void)_goDone {
	[self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Interaction
- (void)_goPinch:(UIPinchGestureRecognizer *)recognizer {
	
	//NSLog(@"%f", recognizer.scale);
	
	//if (recognizer.view.transform.a >= 1.0 && recognizer.view.transform.a <= 2.0) {
	recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
	recognizer.scale = 1.0;
	//}
	
	if (recognizer.state == UIGestureRecognizerStateEnded) {
		if (recognizer.view.transform.a < 0.25) {
			[UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
				recognizer.view.transform = CGAffineTransformMake(0.25, 0.0, 0.0, 0.25, 0.0, 0.0);
			} completion:nil];
		}
		
		
		if (recognizer.view.transform.a > 2.5) {
			[UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
				recognizer.view.transform = CGAffineTransformMake(2.5, 0.0, 0.0, 2.5, 0.0, 0.0);
			} completion:nil];
		}
		
		CGPoint finalPoint = recognizer.view.center;
		if (recognizer.view.frame.size.width < self.view.bounds.size.width)
			finalPoint.x = MIN(MAX(finalPoint.x, recognizer.view.frame.size.width * 0.5), self.view.bounds.size.width - (recognizer.view.frame.size.width * 0.5));
		else
			finalPoint.x = MAX(MIN(finalPoint.x, recognizer.view.frame.size.width * 0.5), self.view.bounds.size.width - (recognizer.view.frame.size.width * 0.5));
		
		if (recognizer.view.frame.size.height < self.view.bounds.size.height)
			finalPoint.y = MIN(MAX(finalPoint.y, recognizer.view.frame.size.height * 0.5), self.view.bounds.size.height - (recognizer.view.frame.size.height * 0.5));
		else
			finalPoint.y = MAX(MIN(finalPoint.y, recognizer.view.frame.size.height * 0.5), self.view.bounds.size.height - (recognizer.view.frame.size.height * 0.5));
		
		[UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
			recognizer.view.center = finalPoint;
		} completion:nil];
		
		
		
	}
	
	//CGFloat scale = MIN(MAX(recognizer.view.transform.a, 1.0), 2.0);
	//recognizer.view.transform = CGAffineTransformMake(scale, 0.0, 0.0, scale, 0.0, 0.0);
	NSLog(@"(%f, %f)", recognizer.view.transform.a, recognizer.view.transform.a);
}


- (void)_goPan:(UIPanGestureRecognizer *)recognizer {
	CGPoint translation = [recognizer translationInView:self.view];
	recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
	[recognizer setTranslation:CGPointMake(0.0, 0.0) inView:self.view];
	
	
	if (recognizer.state == UIGestureRecognizerStateEnded) {
		CGPoint velocity = [recognizer velocityInView:self.view];
		float slideFactor = 0.2 * (sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y)) * 0.005);
		
		CGPoint finalPoint = CGPointMake(recognizer.view.center.x + (velocity.x * slideFactor), recognizer.view.center.y + (velocity.y * slideFactor));
		if (recognizer.view.frame.size.width < self.view.bounds.size.width)
			finalPoint.x = MIN(MAX(finalPoint.x, recognizer.view.frame.size.width * 0.5), self.view.bounds.size.width - (recognizer.view.frame.size.width * 0.5));
		else
			finalPoint.x = MAX(MIN(finalPoint.x, recognizer.view.frame.size.width * 0.5), self.view.bounds.size.width - (recognizer.view.frame.size.width * 0.5));
		
		if (recognizer.view.frame.size.height < self.view.bounds.size.height)
			finalPoint.y = self.view.center.y;//MIN(MAX(finalPoint.y, recognizer.view.frame.size.height * 0.5), self.view.bounds.size.height - (recognizer.view.frame.size.height * 0.5));
		else
			finalPoint.y = MAX(MIN(finalPoint.y, recognizer.view.frame.size.height * 0.5), self.view.bounds.size.height - (recognizer.view.frame.size.height * 0.5));
		
		[UIView animateWithDuration:slideFactor delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
			recognizer.view.center = finalPoint;
		} completion:nil];
	}
}


@end