    //
//  ContactViewController_iPad.m
//  RevelAndRiot
//
//  Created by Keith Greene on 11-02-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ContactViewController_iPad.h"
#import <QuartzCore/QuartzCore.h>

@implementation ContactViewController_iPad

@synthesize mainViewController;
@synthesize emailChoice;
@synthesize receivedData;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization.
 }
 return self;
 }
 */

- (IBAction)menuButtonPressed:(id)sender {
	NSLog(@"MENU BUTTON PRESSED");
	
	if (self.mainViewController == nil) {
		MainViewController_iPad *subView = [[MainViewController_iPad alloc] initWithNibName:@"MainViewController_iPad" bundle:[NSBundle mainBundle]];
		self.mainViewController = subView;
		[subView release];
	}
	
	//[self.view addSubview:[newsViewController view]];
	UIView *currentView = self.view;
	// get the the underlying UIWindow, or the view containing the current view
	UIView *theWindow = [currentView superview];
	
	UIView *newView = mainViewController.view; 
	
	// remove the current view and replace with myView1
	[currentView removeFromSuperview];
	[theWindow addSubview:newView];
	
	// set up an animation for the transition between the views
	CATransition *animation = [CATransition animation];
	[animation setDuration:0.5];
	[animation setType:kCATransitionPush];
	/*if (UIInterfaceOrientationPortrait) {
		[animation setSubtype:kCATransitionFromRight];
	} else {*/
		[animation setSubtype:kCATransitionFromLeft];
	//}
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	[[theWindow layer] addAnimation:animation forKey:@"SwitchToView1"];
}

- (IBAction) commentsButtonPressed:(id)sender {
	NSLog(@"commentsButton");
	emailChoice = @"info@revelandriot.com";
	[self mailIt];
}

- (IBAction) streetTeamButtonPressed:(id)sender {
	NSLog(@"streetTeamButton");
	emailChoice = @"team@revelandriot.com";
	[self mailIt];
}

- (IBAction) mailingListButtonPressed:(id)sender {
	NSLog(@"mailingListButton");
	//emailChoice = @"info@revelandriot.com";
	//[self mailIt];
	
	mailingList.hidden = NO;
	cancelButton.hidden = NO;
	backgroundView.hidden = NO;
}

- (IBAction) sendMailingList:(id)sender {
	[emailField resignFirstResponder];
	NSLog(@"SEND BUTTON PRESSED");
	
	NSString *email = [[NSString alloc] initWithFormat:@"%@",emailField.text];
	NSLog(@"%@", email);
	
	NSString *emailString = [[NSString alloc] initWithFormat:@"gsom_email_field=%@&gsomsubscribe=Subscribe",email];
	[email release];
	NSString *myRequestString = emailString;
	NSData *myRequestData = [ NSData dataWithBytes: [ myRequestString UTF8String ] length: [ myRequestString length ] ];
	NSMutableURLRequest *request = [ [ NSMutableURLRequest alloc ] initWithURL: [ NSURL URLWithString: @"http://revelandriot.com/" ] ]; 
	[ request setHTTPMethod: @"POST" ];
	[ request setHTTPBody: myRequestData ];
	NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
	NSLog (@"%@", returnData);
	[emailString release];
	[request release];
	mailingList.hidden = YES;
	cancelButton.hidden = YES;
}


- (IBAction) orderButtonPressed:(id)sender {
	NSLog(@"orderButton");
	emailChoice = @"sales@revelandriot.com";
	[self mailIt];
}



-(IBAction)mailIt {
	
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	NSArray *toRecipients = [NSArray arrayWithObject:emailChoice];
	[picker setToRecipients:toRecipients];
	
	[self presentModalViewController:picker animated:YES];
	
}

-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	[self dismissModalViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	if (cancelButtonWasPressed = NO) {
		
		[self performSelector:@selector(sendMailingList:) withObject:nil afterDelay:0];
	}
}

- (IBAction) cancelButtonPressed:(id)sender {
	cancelButtonWasPressed = YES;
	backgroundView.hidden = YES;
	mailingList.hidden = YES;
	cancelButton.hidden = YES;
	[emailField resignFirstResponder];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	backgroundView.hidden = YES;
	mailingList.hidden = YES;
	cancelButton.hidden = YES;
	
	NSLog(@"self.view=%@", self.view);
	
	// uncomment the following only if desperate
	self.view.frame = CGRectMake(0, 20, 768, 1004);
	// NSLog(@"self.view=%@", self.view);
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
 }*/


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
