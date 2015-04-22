//
//  MainViewController.h
//  RevelAndRiot
//
//  Created by Keith Greene on 11-01-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsViewController.h"
#import "PhotoViewController.h"
#import "ResourceViewController.h"
#import "AboutViewController.h"
#import "ContactViewController.h"

@class NewsViewController;
@class PhotoViewController;
@class ResourceViewController;
@class AboutViewController;
@class ContactViewController;

@interface MainViewController : UIViewController {
	NewsViewController *newsViewController;
	PhotoViewController *photoViewController;
	ResourceViewController *resourceViewController;
	AboutViewController *aboutViewController;
	ContactViewController *contactViewController;
	
	IBOutlet UIButton *newsButton;
	IBOutlet UIButton *photosButton;
	IBOutlet UIButton *resourcesButton;
	IBOutlet UIButton *shopButton;
	IBOutlet UIButton *aboutButton;
	IBOutlet UIButton *contactButton;
	

}

@property (nonatomic, retain) NewsViewController *newsViewController;
@property (nonatomic, retain) PhotoViewController *photoViewController;
@property (nonatomic, retain) ResourceViewController *resourceViewController;
@property (nonatomic, retain) AboutViewController *aboutViewController;
@property (nonatomic, retain) ContactViewController *contactViewController;

-(IBAction) newsButtonPressed:(id)sender;
-(IBAction) photosButtonPressed:(id)sender;
-(IBAction) resourcesButtonPressed:(id)sender;
-(IBAction) shopButtonPressed:(id)sender;
-(IBAction) aboutButtonPressed:(id)sender;
-(IBAction) contactButtonPressed:(id)sender;

@end
