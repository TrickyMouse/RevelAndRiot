//
//  AppDelegate_iPhone.h
//  RevelAndRiot
//
//  Created by Keith Greene on 11-01-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;

@interface AppDelegate_iPhone : NSObject <UIApplicationDelegate, NSXMLParserDelegate> {
    UIWindow *window;
	MainViewController *mainViewController;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic) BOOL revelOn;
@property (nonatomic) BOOL merchPhotosDownloaded;
@property (nonatomic) BOOL mannequeerPhotosDownloaded;
@property (nonatomic) BOOL LGBTQPhotosDownloaded;
@property (nonatomic, retain) MainViewController *mainViewController;
@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *Title;
@property (nonatomic, retain) NSString *html;
@property (nonatomic, retain) NSString *merchPhotoHTML;
@property (nonatomic, retain) NSString *mannequeerPhotoHTML;
@property (nonatomic, retain) NSString *LGBTQPhotoHTML;

//@property (nonatomic, retain) NSString *aboutHTML;

@end

