//
//  revelViewCell.h
//  RevelAndRiot
//
//  Created by Keith Greene on 11-01-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface revelViewCell : UITableViewCell {
	
	IBOutlet UILabel *articleName;
	IBOutlet UILabel *articleContent;
	
	IBOutlet UIView *viewForBackground;

}

@property (nonatomic,retain) IBOutlet UILabel *articleName;
@property (nonatomic,retain) IBOutlet UILabel *articleContent;

@property (nonatomic,retain)IBOutlet UIView *viewForBackground;

@end
