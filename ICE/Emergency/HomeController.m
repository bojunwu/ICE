//
//  HomeController.m
//  Emergency
//
//  Created by Bojun Wu on 4/21/13.
//  Copyright (c) 2013 Bojun Wu. All rights reserved.
//
#import <Foundation/NSBundle.h>
#import "HomeController.h"
#import "lame.h"
//#import "MailViewController.h"





@implementation HomeController
@synthesize player;
@synthesize recordedFile;
@synthesize locationMgr = _locationMgr;





-(void)loadView
{
    [super loadView];
    UINavigationItem *n = [self navigationItem];
    
    [n setTitle:@"Emergency"];
    [[UINavigationBar appearance] setTintColor:[UIColor redColor]];
    UIView * contentView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	contentView.backgroundColor = [UIColor whiteColor];
	
       
    
    UILabel *author = [[UILabel alloc] initWithFrame:CGRectMake(220.0f, 455.0f, 120.0f, 30.0f)];
    author.text = @"by Bojun Wu";
    [author setBackgroundColor:[UIColor clearColor]];
    [contentView addSubview:author];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(50.0f, 45.0f, 280.0f, 50.0f)];
    title.text = @"Select Message Sending Type";
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
    [button3 addTarget:self action:@selector(openmail:) forControlEvents:UIControlEventTouchUpInside];
    [button3 setBackgroundImage:st forState:UIControlStateNormal];
    
    
    [contentView addSubview:button3];

      self.view = contentView;
    
    
}
//
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

- (IBAction)mail:(id)sender
{
    if ([MFMailComposeViewController canSendMail])
    {
        //stop recording
        
     
        
        
        
        
        
        
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:@"Hi"];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"bennywu@nmsu.edu", nil];
        [mailer setToRecipients:toRecipients];
        
//        UIImage *myImage = [UIImage imageNamed:@""];
//        NSData *imageData = UIImagePNGRepresentation(myImage);
//        [mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@""];
        NSLog(@"check1");
               if(_GPSLocationWithTimeStamp==nil){
                   NSString *emailBody=@"I need help ASAP.";
                   [mailer setMessageBody:emailBody isHTML:NO];

        }
               else{
                   NSString *emailBody = _GPSLocationWithTimeStamp;
                   [mailer setMessageBody:emailBody isHTML:NO];

               }

                        NSLog(@"check3");
        // only for iPad
        // mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        
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
//    NSString *mp3FilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/downloadFile.mp3"];
//
//    NSFileManager* fileManager=[NSFileManager defaultManager];
//    [fileManager removeItemAtPath:mp3FilePath error:nil];
//
    
}






- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	switch (result)
	{
		case MFMailComposeResultCancelled:
			NSLog(@"Mail cancelled");
//        {NSNotification *notification = [Notification notifyWithText:@"Hello World!" andDetail:@"This is a test"];
//            notification.delegate = self;
//            [notification setBackgroundColor:[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0]];}
//            NSLog(@"1");
//           [self performSelector:@selector(showNotification:) withObject:nil];
//            NSLog(@"2");
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

//    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)Facebook:(id)sender {
    if ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=6) {
        //  if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        //{
        slComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        if(_GPSLocationWithTimeStamp==nil){
            [slComposerSheet setInitialText:@"Emergency! Please Help Me ASAP."];}
        else{
        [slComposerSheet setInitialText:[NSString stringWithFormat:@"%@", _GPSLocationWithTimeStamp]];

        }
        
//        [slComposerSheet addImage:[UIImage imageNamed:@"ios6.jpg"]];
       
        [self presentViewController:slComposerSheet animated:YES completion:nil];
        // }
        
        [slComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
            NSLog(@"start completion block");
            NSString *output;
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    output = @"Action Cancelled";
                    break;
                case SLComposeViewControllerResultDone:
                    output = @"Post Successfull";
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
//    if(NSClassFromString(@"SLComposeViewController") != nil)
    
        SLComposeViewController *twitterController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
            SLComposeViewControllerCompletionHandler __block completionHandler = ^(SLComposeViewControllerResult result) {
                [twitterController dismissViewControllerAnimated:YES completion:nil];
                switch(result) {
                    case SLComposeViewControllerResultDone: {
                        NSLog(@"Posted....");
                        NSString *output;
                        output = @"Post Successfull";
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter Message" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                                        [alert show];

                    }
                        break;
                    default:{
//                        NSString *output;
//                        output = @"Action Cancelled";
//                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter Message" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//                        [alert show];
                        NSLog(@"Cancelled.....");
                    }
                        break;
                }
            };
            
            
            if(_GPSLocationWithTimeStamp==nil){
                [twitterController setInitialText:@"Emergency! Please Help Me ASAP."];}
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
        
        FILE *pcm = fopen([cafFilePath cStringUsingEncoding:1], "rb");  //source 被转换的音频文件位置
        fseek(pcm, 4*1024, SEEK_CUR);                                   //skip file header
        FILE *mp3 = fopen([mp3FilePath cStringUsingEncoding:1], "wb");  //output 输出生成的Mp3文件位置
        
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

	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    UIButton *makeSoundButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 340, 100, 50)];
    makeSoundButton.backgroundColor = [UIColor clearColor];
    [makeSoundButton setTitle:@"Record" forState:UIControlStateNormal];
        [makeSoundButton addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:makeSoundButton];
    [makeSoundButton release];
    
    UIButton *pButton = [[UIButton alloc] initWithFrame:CGRectMake(160, 340, 100, 50)];
    playButton = pButton;
    [playButton setEnabled:NO];
    playButton.backgroundColor = [UIColor clearColor];
    [playButton setTitle:@"Play" forState:UIControlStateNormal];
    [playButton addTarget:self action:@selector(playPause) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:playButton];
    [pButton release];
    
    //    UIButton *zButton = [[UIButton alloc] initWithFrame:CGRectMake(220, 30, 100, 50)];
    //    zButton.backgroundColor = [UIColor blueColor];
    //    [zButton setTitle:@"转mp3" forState:UIControlStateNormal];
    //    [zButton addTarget:self action:@selector(audio_PCMtoMP3) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:zButton];
    //    [zButton release];
    
    
    
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/downloadFile.caf"];
    NSLog(@"%@",path);
    self.recordedFile = [[[NSURL alloc] initFileURLWithPath:path] autorelease];
    NSLog(@"%@",recordedFile);
    NSString *mp3FilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/downloadFile.mp3"];
    
    
    NSFileManager* fileManager=[NSFileManager defaultManager];
    [fileManager removeItemAtPath:mp3FilePath error:nil];
    
	// Do any additional setup after loading the view.
}
- (void)playPause
{
    //If the track is playing, pause and achange playButton text to "Play"
    if([player isPlaying])
    {
        [player pause];
        [playButton setTitle:@"Play" forState:UIControlStateNormal];
    }
    //If the track is not player, play the track and change the play button to "Pause"
    else
    {
        [player play];
        [playButton setTitle:@"Pause" forState:UIControlStateNormal];
    }
}

-(void)touchDown
{
    [playButton setEnabled:NO];
    NSLog(@"==%@==",recordedFile);
    
    session = [AVAudioSession sharedInstance];
    session.delegate = self;
    UILabel *state = [[UILabel alloc] initWithFrame:CGRectMake(70.0f, 380.0f, 100.0f, 30.0f)];
    
    state.text = @"Recording";
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
    /*
     NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
     [NSNumber numberWithFloat:44100.0], AVSampleRateKey,
     [NSNumber numberWithInt:kAudioFormatMPEG4AAC], AVFormatIDKey,
     [NSNumber numberWithInt:2], AVNumberOfChannelsKey,
     nil];
     */
    //录音设置
    NSMutableDictionary *settings = [[NSMutableDictionary alloc] init];
    //录音格式 无法使用
    [settings setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey: AVFormatIDKey];
    //采样率
    [settings setValue :[NSNumber numberWithFloat:11025.0] forKey: AVSampleRateKey];//44100.0
    //通道数
    [settings setValue :[NSNumber numberWithInt:2] forKey: AVNumberOfChannelsKey];
    //线性采样位数
    //[recordSettings setValue :[NSNumber numberWithInt:16] forKey: AVLinearPCMBitDepthKey];
    //音频质量,采样质量
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
    state.text = @"Done";
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
    [playButton setTitle:@"Play" forState:UIControlStateNormal];
    NSLog(@"1");
    
}


//program mark GPS
- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
      double newLatitude = newLocation.coordinate.latitude;
    double newLongitude = newLocation.coordinate.longitude;
    
//     double horizontalAccuracy = newLocation.horizontalAccuracy;
    
//   NSString *GPSLocation = [NSString stringWithFormat:@"Lat: %f \n  Long: %f \n",  newLatitude, newLongitude];
    _GPSLocationWithTimeStamp = [NSString stringWithFormat:@"This is my GPS coordinates\nPlease send help \nLatitude: %f \nLongitude: %f \n",  newLatitude, newLongitude];
    

   UILabel *gps = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 355.0f, 320.0f, 120.0f)];
    gps.text = [NSString stringWithFormat:@"Lat: %f \n Long: %f \n",  newLatitude, newLongitude];
    [gps setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:gps];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration: 5.0];
    [gps setAlpha:0];
    
    [UIView setAnimationDuration: 0.0];
    [_GPSLocationWithTimeStamp retain];
}
@end





