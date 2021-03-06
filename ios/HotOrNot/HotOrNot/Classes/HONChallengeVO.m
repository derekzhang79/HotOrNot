//
//  HONChallengeVO.m
//  HotOrNot
//
//  Created by Matthew Holcombe on 09.07.12.
//  Copyright (c) 2012 Built in Menlo, LLC. All rights reserved.
//

#import "HONAppDelegate.h"
#import "HONChallengeVO.h"

@implementation HONChallengeVO

@synthesize dictionary;
@synthesize challengeID, creatorID, imageURL, image2URL, scoreCreator, scoreChallenger, status, subjectName, creatorName, creatorFB, challengerName, addedDate, startedDate, endDate;

+ (HONChallengeVO *)challengeWithDictionary:(NSDictionary *)dictionary {
	HONChallengeVO *vo = [[HONChallengeVO alloc] init];
	vo.dictionary = dictionary;
	
	vo.challengeID = [[dictionary objectForKey:@"id"] intValue];
	vo.creatorID = [[dictionary objectForKey:@"creator_id"] intValue];
	
	switch ([[dictionary objectForKey:@"status"] intValue]) {
		case 1:
			vo.status = @"Accept";
			break;
			
		case 2:
			vo.status = @"Waiting";
			break;
			
		case 4:
			vo.status = @"Started";
			break;
		
		case 5:
			vo.status = @"Completed";
			break;
		
		case 7:
			vo.status = @"Waiting";
			break;
			
		default:
			vo.status = @"Accept";
			break;
	}
	
	vo.imageURL = [dictionary objectForKey:@"img_url"];
	vo.image2URL = [dictionary objectForKey:@"img2_url"];
	vo.scoreCreator = [[[dictionary objectForKey:@"score"] objectForKey:@"creator"] intValue];
	vo.scoreChallenger = [[[dictionary objectForKey:@"score"] objectForKey:@"challenger"] intValue];
	vo.subjectName = [dictionary objectForKey:@"subject"];
	vo.creatorName = [dictionary objectForKey:@"creator"];
	vo.creatorFB = [dictionary objectForKey:@"creator_fb"];
	vo.challengerName = [dictionary objectForKey:@"challenger"];
	
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	vo.addedDate = [dateFormat dateFromString:[dictionary objectForKey:@"added"]];
	vo.startedDate = [dateFormat dateFromString:[dictionary objectForKey:@"started"]];
	vo.endDate = [vo.startedDate dateByAddingTimeInterval:(60 * 60 * [[HONAppDelegate challengeDuration] intValue])];
	
	return (vo);
}

- (void)dealloc {
	self.dictionary = nil;
	self.status = nil;
	self.imageURL = nil;
	self.image2URL = nil;
	self.subjectName = nil;
	self.creatorName = nil;
	self.creatorFB = nil;
	self.challengerName = nil;
	self.startedDate = nil;
	self.addedDate = nil;
	self.endDate = nil;
}

@end
