//
//  SettingsViewController.m
//  Emergency
//
//  Created by Bojun Wu on 5/2/13.
//  Copyright (c) 2013 Bojun Wu. All rights reserved.
//Reference http://www.youtube.com/watch?v=_TCjzFKZu8Q

#import "SettingsViewController.h"
#import "HomeController.h"
@interface SettingsViewController ()

@end

@implementation SettingsViewController


- (IBAction)back:(id)sender
{   
  

  
    [[self navigationController] dismissViewControllerAnimated:YES completion:nil];


}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];

    return YES;
}
-(IBAction)ReturnKeyButton:(id)sender{
    [sender resignFirstResponder];
    
}
-(IBAction) save{
    NSUserDefaults *emailadd1 = [NSUserDefaults standardUserDefaults];
    [emailadd1 setObject:email1.text forKey:@"string"];
    [email1 resignFirstResponder];

   
    NSUserDefaults *emailadd2 = [NSUserDefaults standardUserDefaults];
    [emailadd2 setObject:email2.text forKey:@"string2"];
    [email2 resignFirstResponder];
    
    NSUserDefaults *emailadd3 = [NSUserDefaults standardUserDefaults];
    [emailadd3 setObject:email3.text forKey:@"string3"];
    [email3 resignFirstResponder];
    
    NSUserDefaults *emailadd4 = [NSUserDefaults standardUserDefaults];
    [emailadd4 setObject:email4.text forKey:@"string4"];
    [email4 resignFirstResponder];
    
    NSUserDefaults *emailadd5 = [NSUserDefaults standardUserDefaults];
    [emailadd5 setObject:email5.text forKey:@"string5"];
    [email5 resignFirstResponder];
    
    NSUserDefaults *emailadd6 = [NSUserDefaults standardUserDefaults];
    [emailadd6 setObject:email6.text forKey:@"string6"];
    [email6 resignFirstResponder];
    
    NSUserDefaults *emailadd7 = [NSUserDefaults standardUserDefaults];
    [emailadd7 setObject:email7.text forKey:@"string7"];
    [email7 resignFirstResponder];
    
    NSUserDefaults *emailadd8 = [NSUserDefaults standardUserDefaults];
    [emailadd8 setObject:email8.text forKey:@"string8"];
    [email8 resignFirstResponder];
    NSUserDefaults *emailadd9 = [NSUserDefaults standardUserDefaults];
    [emailadd9 setObject:email9.text forKey:@"string9"];
    [email9 resignFirstResponder];
    
    


}
-(void)viewDidLoad{
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc]
                                                 initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                 target:self
                                                 action:@selector(save)];
    [[self navigationItem] setRightBarButtonItem:doneItem];
    self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];

    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemReply
                                   target:self
                                   action:@selector(back:)];
    [[self navigationItem] setLeftBarButtonItem:cancelItem];
   
    NSUserDefaults *emailadd1 = [NSUserDefaults standardUserDefaults];
    NSString *e1 =[emailadd1 stringForKey:@"string"];
    email1.text = e1;
    
    NSUserDefaults *emailadd2 = [NSUserDefaults standardUserDefaults];
    NSString *e2 =[emailadd2 stringForKey:@"string2"];
    email2.text = e2;
    
    NSUserDefaults *emailadd3 = [NSUserDefaults standardUserDefaults];
    NSString *e3 =[emailadd3 stringForKey:@"string3"];
    email3.text = e3;
    
    NSUserDefaults *emailadd4 = [NSUserDefaults standardUserDefaults];
    NSString *e4 =[emailadd4 stringForKey:@"string4"];
    email4.text = e4;
    
    NSUserDefaults *emailadd5 = [NSUserDefaults standardUserDefaults];
    NSString *e5 =[emailadd5 stringForKey:@"string5"];
    email5.text = e5;
//    
    NSUserDefaults *emailadd6 = [NSUserDefaults standardUserDefaults];
    NSString *e6 =[emailadd6 stringForKey:@"string6"];
    email6.text = e6;

    NSUserDefaults *emailadd7 = [NSUserDefaults standardUserDefaults];
    NSString *e7 =[emailadd7 stringForKey:@"string7"];
    email7.text = e7;

    NSUserDefaults *emailadd8 = [NSUserDefaults standardUserDefaults];
    NSString *e8 =[emailadd8 stringForKey:@"string8"];
    email8.text = e8;

    NSUserDefaults *emailadd9 = [NSUserDefaults standardUserDefaults];
    NSString *e9 =[emailadd9 stringForKey:@"string9"];
    email9.text = e9;

    


    [scroll setScrollEnabled:YES];
    [scroll setContentSize:CGSizeMake(320, 800)];
   
    


}
@end
