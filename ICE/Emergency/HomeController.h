//
//  HomeController.h
//  Emergency
//
//  Created by Bojun Wu on 4/21/13.
//  Copyright (c) 2013 Bojun Wu. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>
#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
#import "SettingsViewController.h"
#import "LightViewController.h"
//#import "MailViewController.h"
@interface HomeController : UIViewController
<MFMessageComposeViewControllerDelegate>
{
    SLComposeViewController *slComposerSheet;
    UIButton *playButton;
    AVAudioSession *session;
    
    NSURL *recordedFile;
    AVAudioPlayer *player;
    AVAudioRecorder *recorder;
}
@property (nonatomic , retain) AVAudioPlayer *player;
@property (nonatomic , retain) NSURL *recordedFile;
@property (retain) CLLocationManager * locationMgr;
@property (nonatomic ,retain) NSString * GPSLocationWithTimeStamp;
@property (nonatomic ,retain) NSString * e1;

//-(IBAction)showNotification:(id)sender;
//@interface MailViewController : UIViewController <MFMailComposeViewControllerDelegate>


@end







