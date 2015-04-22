//
//  ContactViewController.h
//  RevelAndRiot
//
//  Created by Keith Greene on 11-01-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@class MainViewController;

@interface ContactViewController : UIViewController <MFMailComposeViewControllerDelegate, UITextFieldDelegate> {

	IBOutlet UIButton *menuButton;
	IBOutlet UIButton *commentsButton;
	IBOutlet UIButton *streetTeamButton;
	IBOutlet UIButton *mailingListButton;
	IBOutlet UIButton *orderButton;
	IBOutlet UIImageView *mailingListLabel;
	IBOutlet UITextField *emailField;
	IBOutlet UIButton *sendButton;
	IBOutlet UIView *mailingList;
	IBOutlet UIButton *cancelButton;
	BOOL cancelButtonWasPressed;
	IBOutlet UIView *backgroundView;
	
}

@property (nonatomic, retain) MainViewController *mainViewController;
@property (nonatomic, retain) NSString *emailChoice;
@property (nonatomic, retain) NSData *receivedData;

- (IBAction) menuButtonPressed:(id)sender;
- (IBAction) commentsButtonPressed:(id)sender;
- (IBAction) streetTeamButtonPressed:(id)sender;
- (IBAction) mailingListButtonPressed:(id)sender;
- (IBAction) orderButtonPressed:(id)sender;
- (IBAction) cancelButtonPressed:(id)sender;
- (IBAction) mailIt;
- (IBAction) sendMailingList:(id)sender;

@end
