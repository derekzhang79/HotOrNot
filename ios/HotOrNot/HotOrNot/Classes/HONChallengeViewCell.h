//
//  HONChallengeViewCell.h
//  HotOrNot
//
//  Created by Matthew Holcombe on 09.07.12.
//  Copyright (c) 2012 Built in Menlo, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HONChallengeVO.h"

@interface HONChallengeViewCell : UITableViewCell

+ (NSString *)cellReuseIdentifier;

@property (nonatomic, strong) HONChallengeVO *challengeVO;

@end