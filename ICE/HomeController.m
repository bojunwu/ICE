
//
//  HomeController.m
//  Emergency
//
//  Created by Bojun Wu on 4/21/13.
//  Copyright (c) 2013 Bojun Wu. All rights reserved.
//
#import <Foundation/NSBundle.h>
#import "SettingsViewController.h"
#import "HomeController.h"
#import "lame.h"
#import "LightViewController.h"





@implementation HomeController
@synthesize player;
@synthesize recordedFile;
@synthesize locationMgr = _locationMgr;





-(void)loadView
{
    [super loadView];
    UINavigationItem *n = [self navigationItem];
    
    [n setTitle:NSLocalizedString(@"Emergency", @"Name of application")];
    [[UINavigationBar appearance] setTintColor:[UIColor redColor]];
    UIView * contentView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	contentView.backgroundColor = [UIColor whiteColor];
	
    
    
    UILabel *author = [[UILabel alloc] initWithFrame:CGRectMake(220.0f, 455.0f, 120.0f, 30.0f)];
    author.text = NSLocalizedString(@"by Bojun Wu", @"author");
    [author setBackgroundColor:[UIColor clearColor]];
    [contentView addSubview:author];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(50.0f, 45.0f, 280.0f, 50.0f)];
    title.text = NSLocalizedString(@"Select Message Sending Type", @"no");
    [title setBackgroundColor:[UIColor clearColor]];
    [contentView addSubview:title];
    
    
    
    
    UIImage *em = [UIImage imageNamed:@"mail.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [button setFrame:CGRectMake(90.0f, 120.0f, 75.0f, 100.0f)];
    button.frame = CGRectMake(123, 193, 75.0f, 100.0f);
    [button addTarget:self action:@selector(openmail:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:em forState:UIControlStateNormal];
    
    
    [contentView addSubview:button];
    
    
    
    
    UIImage *tw = [UIImage imageNamed:@"twitter.png"];
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button1.frame = CGRectMake(124, 104, 75.0f, 100.0f);
    [button1 addTarget:self action:@selector(Twitter:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setBackgroundImage:tw forState:UIControlStateNormal];
    
    
    [contentView addSubview:button1];
    
    
    
    UIImage *fb = [UIImage imageNamed:@"facebook.png"];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [button2 setFrame:CGRectMake(90.0f, 260.0f, 100.0f, 30.0f)];
    button2.frame = CGRectMake(155, 161, 100.0f, 75.0f);
    [button2 addTarget:self action:@selector(Facebook:) forControlEvents:UIControlEventTouchUpInside];
    [button2 setBackgroundImage:fb forState:UIControlStateNormal];
    
    
    [contentView addSubview:button2];
    
    
    
    
    UIImage *st = [UIImage imageNamed:@"star.png"];
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button3.frame = CGRectMake(67, 160, 100.0f, 75.0f);
    [button3 addTarget:self action:@selector(sms:) forControlEvents:UIControlEventTouchUpInside];
    [button3 setBackgroundImage:st forState:UIControlStateNormal];
    
    
    
    
    [contentView addSubview:button3];
    
    UIImage *set = [UIImage imageNamed:@"Setting.png"];
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button4.frame = CGRectMake(10, 440, 55.0f, 55.0f);
    [button4 addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    [button4 setBackgroundImage:set forState:UIControlStateNormal];
    
     [contentView addSubview:button4];
    
    UIImage *flash = [UIImage imageNamed:@"light.png"];
    UIButton *button5 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button5.frame = CGRectMake(80, 445, 45.0f, 45.0f);
    [button5 addTarget:self action:@selector(light) forControlEvents:UIControlEventTouchUpInside];
    [button5 setBackgroundImage:flash forState:UIControlStateNormal];
    
    [contentView addSubview:button5];
  
    
    
    self.view = contentView;
    
    
}

-(void)light{
    LightViewController *light = [[LightViewController alloc] init];
    
    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:light];
    [navController setModalPresentationStyle:UIModalPresentationFullScreen];
    [navController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    
    [self presentViewController:navController animated:YES completion:nil];
    
}

-(void)setting{
    SettingsViewController *settingController = [[SettingsViewController alloc] init];
    
    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:settingController];
    [navController setModalPresentationStyle:UIModalPresentationFullScreen];
    [navController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    
    [self presentViewController:navController animated:YES completion:nil];

}

- (IBAction)openmail:(id)sender{
    if(recorder){
        [ NSTimer scheduledTimerWithTimeInterval:0.0f
                                          target:self
                                        selector:@selector(touchUp)
                                        userInfo:nil
                                         repeats:NO];
    }
    [ NSTimer scheduledTimerWithTimeInterval:0.2f
                                      target:self
                                    selector:@selector(mail:)
                                    userInfo:nil
                                     repeats:NO];
    
}
-(IBAction)sms:(id)sender{
//    if ([MFMessageComposeViewController canSendText]){
    MFMessageComposeViewController *sms = [[MFMessageComposeViewController alloc] init];
    sms.messageComposeDelegate = self;
            if(_GPSLocationWithTimeStamp==nil){
            NSString *Body=NSLocalizedString(@"I need help ASAP.", @"no");
            [sms setBody:Body];
            
        }
        else{
            NSString *Body = _GPSLocationWithTimeStamp;
            [sms setBody:Body];
        
            
        }
    NSUserDefaults *emailadd1 = [NSUserDefaults standardUserDefaults];
    NSString *sms1 =[emailadd1 stringForKey:@"string6"];
    NSString *sms2 =[emailadd1 stringForKey:@"string7"];
    NSString *sms3 =[emailadd1 stringForKey:@"string8"];
    NSString *sms4 =[emailadd1 stringForKey:@"string9"];
       NSLog(@"%@",sms1);
    NSLog(@"%@",sms2);
    NSLog(@"%@",sms3);
    NSLog(@"%@",sms4);

    
    NSArray *toRecipients = [NSArray arrayWithObjects: sms1,sms2,sms3,sms4,nil];
    sms.recipients = toRecipients;
    
    [self presentModalViewController:sms animated:YES];

    

}
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissModalViewControllerAnimated:YES];
    if (result == MessageComposeResultCancelled)
       NSLog(@"Message cancelled");
    else if (result == MessageComposeResultSent)
        NSLog(@"Message sent");
    else
        NSLog(@"Message failed");
}


- (IBAction)mail:(id)sender
{
    if ([MFMailComposeViewController canSendMail])
    {

        
        
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:NSLocalizedString(@"Emergency", @"Name of application")];
        NSUserDefaults *emailadd1 = [NSUserDefaults standardUserDefaults];
        NSString *e1 =[emailadd1 stringForKey:@"string"];
        NSString *e2 =[emailadd1 stringForKey:@"string2"];
        NSString *e3 =[emailadd1 stringForKey:@"string3"];
        NSString *e4 =[emailadd1 stringForKey:@"string4"];
        NSString *e5 =[emailadd1 stringForKey:@"string5"];
         NSLog(@"%@",e1);
         NSLog(@"%@",e2);
         NSLog(@"%@",e3);
         NSLog(@"%@",e4);
        
        NSArray *toRecipients = [NSArray arrayWithObjects: e1,e2,e3,e4,e5 ,nil];
        [mailer setToRecipients:toRecipients];
                      if(_GPSLocationWithTimeStamp==nil){
            NSString *emailBody=NSLocalizedString(@"I need help ASAP.", @"no");
            [mailer setMessageBody:emailBody isHTML:NO];
            
        }
        else{
            NSString *emailBody = _GPSLocationWithTimeStamp;
            [mailer setMessageBody:emailBody isHTML:NO];
            
        }
             [self presentModalViewController:mailer animated:YES];
        NSString *mp3FilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/downloadFile.mp3"];
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: mp3FilePath];
        NSData *myData = [NSData dataWithContentsOfURL:fileURL];
        [mailer addAttachmentData:myData mimeType:@"audio/mpeg" fileName:@"recording.mp3"];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        
    }
      
}






- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	switch (result)
	{
		case MFMailComposeResultCancelled:
			NSLog(@"Mail cancelled");
         			break;
		case MFMailComposeResultSaved:
			NSLog(@"Mail saved");
			break;
		case MFMailComposeResultSent:
			NSLog(@"Mail sent");
			break;
		case MFMailComposeResultFailed:
			NSLog(@"Mail failed");
			break;
		default:
			NSLog(@"Mail not sent");
			break;
	}
    
	[self dismissModalViewControllerAnimated:YES];
   
    
}

- (IBAction)Facebook:(id)sender {
     {
       
        slComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        if(_GPSLocationWithTimeStamp==nil){
            [slComposerSheet setInitialText:@"Emergency! Please Help Me ASAP."];}
        else{
            [slComposerSheet setInitialText:[NSString stringWithFormat:@"%@", _GPSLocationWithTimeStamp]];
            
        }
    
        [self presentViewController:slComposerSheet animated:YES completion:nil];
       
        
        [slComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
            NSLog(@"start completion block");
            NSString *output;
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    output = NSLocalizedString(@"Action Cancelled", @"no");
                    break;
                case SLComposeViewControllerResultDone:
                    output = NSLocalizedString(@"Post Successfull", @"no");
                    break;
                default:
                    break;
            }
            if (result != SLComposeViewControllerResultCancelled)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook Message" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
            }
        }];
        
    }}

- (IBAction)Twitter:(id)sender {
   
    
    SLComposeViewController *twitterController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
     {
        SLComposeViewControllerCompletionHandler __block completionHandler = ^(SLComposeViewControllerResult result) {
            [twitterController dismissViewControllerAnimated:YES completion:nil];
            switch(result) {
                case SLComposeViewControllerResultDone: {
                    NSLog(@"Posted....");
                    NSString *output;
                    output = NSLocalizedString(@"Post Successfull", @"no");
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter Message" message:output delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    
                }
                    break;
                default:{
                    
                    NSLog(@"Cancelled.....");
                }
                    break;
            }
        };
        
        
        if(_GPSLocationWithTimeStamp==nil){
            [twitterController setInitialText: NSLocalizedString(@"Emergency! Please Help Me ASAP.", @"no")];}
        else{
            [twitterController setInitialText:[NSString stringWithFormat:@"%@", _GPSLocationWithTimeStamp]];
            
        }
        
        [twitterController setCompletionHandler:completionHandler];
        [self presentViewController:twitterController animated:YES completion:nil];
        NSLog(@"1");
    }
    
}










//Program mark sound part





- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//-(void)dealloc
//{
//    [player release];
//    [recordedFile release];
//    [super dealloc];
//}

- (void)audio_PCMtoMP3
{
    NSString *cafFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/downloadFile.caf"];
    
    NSString *mp3FilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/downloadFile.mp3"];
    
    
    NSFileManager* fileManager=[NSFileManager defaultManager];
    [fileManager removeItemAtPath:mp3FilePath error:nil];
    
    NSLog(@"3333");
    @try {
        int read, write;
        
        FILE *pcm = fopen([cafFilePath cStringUsingEncoding:1], "rb");  
        fseek(pcm, 4*1024, SEEK_CUR);
        FILE *mp3 = fopen([mp3FilePath cStringUsingEncoding:1], "wb");         
        const int PCM_SIZE = 8192;
        const int MP3_SIZE = 8192;
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        lame_set_in_samplerate(lame, 11025.0);
        lame_set_VBR(lame, vbr_default);
        lame_init_params(lame);
        
        do {
            read = fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
            if (read == 0)
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            else
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            
            fwrite(mp3_buffer, write, 1, mp3);
            
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[exception description]);
    }
    @finally {
        [playButton setEnabled:YES];
        NSError *playerError;
        AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[[[NSURL alloc] initFileURLWithPath:mp3FilePath] autorelease] error:&playerError];
        self.player = audioPlayer;
        player.volume = 1.0f;
        if (player == nil)
        {
            NSLog(@"ERror creating player: %@", [playerError description]);
        }
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategorySoloAmbient error: nil];
        player.delegate = self;
        [audioPlayer release];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.locationMgr = [[CLLocationManager alloc] init];
    self.locationMgr.delegate = self;
    self.locationMgr.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    [self.locationMgr startUpdatingLocation];
    self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    UIButton *makeSoundButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 340, 100, 50)];
    makeSoundButton.backgroundColor = [UIColor clearColor];
    [makeSoundButton setTitle:NSLocalizedString(@"Record", @"no") forState:UIControlStateNormal];
    [makeSoundButton addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:makeSoundButton];
    [makeSoundButton release];
    
    UIButton *pButton = [[UIButton alloc] initWithFrame:CGRectMake(160, 340, 100, 50)];
    playButton = pButton;
    [playButton setEnabled:NO];
    playButton.backgroundColor = [UIColor clearColor];
    [playButton setTitle:NSLocalizedString(@"Play", @"no") forState:UIControlStateNormal];
    [playButton addTarget:self action:@selector(playPause) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:playButton];
    [pButton release];
    
      
    
    
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/downloadFile.caf"];
    NSLog(@"%@",path);
    self.recordedFile = [[[NSURL alloc] initFileURLWithPath:path] autorelease];
    NSLog(@"%@",recordedFile);
    NSString *mp3FilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/downloadFile.mp3"];
    
    
    NSFileManager* fileManager=[NSFileManager defaultManager];
    [fileManager removeItemAtPath:mp3FilePath error:nil];
    
	}
- (void)playPause
{
       if([player isPlaying])
    {
        [player pause];
        [playButton setTitle:NSLocalizedString(@"Play", @"no") forState:UIControlStateNormal];
    }
    else
    {
        [player play];
        [playButton setTitle:NSLocalizedString(@"Pause", @"no") forState:UIControlStateNormal];
    }
}

-(void)touchDown
{
    [playButton setEnabled:NO];
    NSLog(@"==%@==",recordedFile);
    
    session = [AVAudioSession sharedInstance];
    session.delegate = self;
    UILabel *state = [[UILabel alloc] initWithFrame:CGRectMake(70.0f, 380.0f, 100.0f, 30.0f)];
    
    state.text = NSLocalizedString(@"Recording", @"no");
    [state setBackgroundColor:[UIColor clearColor]];
    
    
    [self.view addSubview:state];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration: 5.05];
    [state setAlpha:0];
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    [ NSTimer scheduledTimerWithTimeInterval:5.0f
                                      target:self
                                    selector:@selector(touchUp)
                                    userInfo:nil
                                     repeats:NO];
    
    
    
    
    
    
    if(session == nil)
        NSLog(@"Error creating session: %@", [sessionError description]);
    else
        [session setActive:YES error:nil];
    
    NSMutableDictionary *settings = [[NSMutableDictionary alloc] init];

    [settings setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey: AVFormatIDKey];
    
    [settings setValue :[NSNumber numberWithFloat:11025.0] forKey: AVSampleRateKey];//44100.0
    
    [settings setValue :[NSNumber numberWithInt:2] forKey: AVNumberOfChannelsKey];
  
    [settings setValue:[NSNumber numberWithInt:AVAudioQualityMin] forKey:AVEncoderAudioQualityKey];
    
    
    recorder = [[AVAudioRecorder alloc] initWithURL:recordedFile settings:settings error:nil];
    [recorder prepareToRecord];
    [recorder record];
    [settings release];
    [UIView setAnimationDuration: 0.0];
}
-(void)touchUp
{
    [recorder stop];
    
    if(recorder)
    {
        [recorder release];
        recorder = nil;
    }
    UILabel *state = [[UILabel alloc] initWithFrame:CGRectMake(70.0f, 380.0f, 100.0f, 30.0f)];
    state.text = NSLocalizedString(@"Done", @"no");
    [state setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:state];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration: 3.0];
    [state setAlpha:0];
    
    [ NSTimer scheduledTimerWithTimeInterval:0.1f
                                      target:self
                                    selector:@selector(audio_PCMtoMP3)
                                    userInfo:nil
                                     repeats:NO];
    [UIView setAnimationDuration: 0.0];
    
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [playButton setTitle:NSLocalizedString(@"Play", @"no") forState:UIControlStateNormal];
    NSLog(@"1");
    
}


//program mark GPS
- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    double newLatitude = newLocation.coordinate.latitude;
    double newLongitude = newLocation.coordinate.longitude;
    
      //   NSString *GPSLocation = [NSString stringWithFormat:@"Lat: %f \n  Long: %f \n",  newLatitude, newLongitude];
    _GPSLocationWithTimeStamp = [NSString stringWithFormat:NSLocalizedString(@"This is my GPS coordinates\nPlease send help \nLatitude: %f \nLongitude: %f \n", @"no"),  newLatitude, newLongitude];
    
    
    UILabel *gps = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 355.0f, 320.0f, 120.0f)];
    gps.text = [NSString stringWithFormat:NSLocalizedString(@"Lati: %f   Long: %f \n", @"1"), newLatitude, newLongitude];
    [gps setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:gps];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration: 5.0];
    [gps setAlpha:0];
    
    [UIView setAnimationDuration: 0.0];
    [_GPSLocationWithTimeStamp retain];
}
@end





