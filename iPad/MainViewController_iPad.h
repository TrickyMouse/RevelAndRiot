//
//  MainViewController_iPad.h
//  RevelAndRiot
//
//  Created by Keith Greene on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsViewController_iPad.h"
#import "PhotoViewController_iPad.h"
#import "ResourceViewController_iPad.h"
#import "AboutViewController_iPad.h"
#import "ContactViewController_iPad.h"

@class NewsViewController_iPad;
@class PhotoViewController_iPad;
@class ResourceViewController_iPad;
@class AboutViewController_iPad;
@class ContactViewController_iPad;


@interface MainViewController_iPad : UIViewController {
	NewsViewController_iPad *newsViewController;
	PhotoViewController_iPad *photoViewController;
	ResourceViewController_iPad *resourceViewController;
	AboutViewController_iPad *aboutViewController;
	ContactViewController_iPad *contactViewController;
	
	IBOutlet UIButton *newsButton;
	IBOutlet UIButton *photosButton;
	IBOutlet UIButton *resourcesButton;
	IBOutlet UIButton *shopButton;
	IBOutlet UIButton *aboutButton;
	IBOutlet UIButton *contactButton;
	
	
}

@property (nonatomic, retain) NewsViewController_iPad *newsViewController;
@property (nonatomic, retain) PhotoViewController_iPad *photoViewController;
@property (nonatomic, retain) ResourceViewController_iPad *resourceViewController;
@property (nonatomic, retain) AboutViewController_iPad *aboutViewController;
@property (nonatomic, retain) ContactViewController_iPad *contactViewController;

-(IBAction) newsButtonPressed:(id)sender;
-(IBAction) photosButtonPressed:(id)sender;
-(IBAction) resourcesButtonPressed:(id)sender;
-(IBAction) shopButtonPressed:(id)sender;
-(IBAction) aboutButtonPressed:(id)sender;
-(IBAction) contactButtonPressed:(id)sender;

@end
