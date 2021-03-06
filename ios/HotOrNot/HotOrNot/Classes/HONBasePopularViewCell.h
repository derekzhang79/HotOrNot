//
//  HONBasePopularViewCell.h
//  HotOrNot
//
//  Created by Matthew Holcombe on 09.07.12.
//  Copyright (c) 2012 Built in Menlo, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HONBasePopularViewCell : UITableViewCell
+ (NSString *)cellReuseIdentifier;

- (id)initAsTopCell:(int)points withSubject:(NSString *)subject;
- (id)initAsBottomCell;
- (id)initAsMidCell:(int)index;

- (void)didSelect;

@end
