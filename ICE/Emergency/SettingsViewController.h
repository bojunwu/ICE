//
//  SettingsViewController.h
//  Emergency
//
//  Created by Bojun Wu on 5/2/13.
//  Copyright (c) 2013 Bojun Wu. All rights reserved.
//Reference http://www.youtube.com/watch?v=_TCjzFKZu8Q

#import <UIKit/UIKit.h>
#import "HomeController.h"
@interface SettingsViewController : UIViewController
<UITextFieldDelegate>
{
    

    IBOutlet UILabel *label1;
    IBOutlet UITextField *email1;
    IBOutlet UITextField *email2;
    IBOutlet UITextField *email3;
    IBOutlet UITextField *email4;
    IBOutlet UITextField *email5;

    IBOutlet UITextField *email6;
    IBOutlet UITextField *email7;
    IBOutlet UITextField *email8;
    IBOutlet UITextField *email9;
    
    IBOutlet UIScrollView *scroll;
    
    }
-(IBAction) save;
-(IBAction) load;
- (IBAction)back:(id)sender;
-(IBAction)ReturnKeyButton:(id)sender;
@end
