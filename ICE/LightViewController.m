//
//  LightViewController.m
//  Emergency
//
//  Created by Bojun Wu on 5/3/13.
//  Copyright (c) 2013 Bojun Wu. All rights reserved.
//

#import "LightViewController.h"

@implementation LightViewController
@synthesize isLightOn;
@synthesize btnOnOff;
@synthesize btnShine;
@synthesize labelFreq;
@synthesize sliderFreq;
@synthesize switchShine;

#define MIN_FREQ   1
#define MAX_FREQ   10

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
        self.title = @"Flashlight";
    }
    return self;
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    isLightOn = YES;
    shineFreq = MIN_FREQ;
    labelFreq.text = [NSString stringWithFormat:@"%dhz",shineFreq];
    sliderFreq.value = shineFreq*1.0/(MAX_FREQ-MIN_FREQ);
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemReply
                                   target:self
                                   action:@selector(back:)];
    [[self navigationItem] setLeftBarButtonItem:cancelItem];

    switchShine.on = enableShine;
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (![device hasTorch]) {
              
#if 1
        
               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Flashlight" message:@"No flashlight！" delegate:nil
                                              cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        
        [alert show];
             [alert release];
#endif
        
    }
    
    
    
    [self turnOnLed:YES];
  }
- (IBAction)back:(id)sender
{
    
    
    
    [[self navigationController] dismissViewControllerAnimated:YES completion:nil];
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    }



-(void) turnOnLed:(bool)update
{
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        [device setTorchMode: AVCaptureTorchModeOn];
        [device unlockForConfiguration];
    }
    if (update)
    {
        [btnOnOff setImage:[UIImage imageNamed:@"BtnOn.png"] forState:UIControlStateNormal];
    }
    
    
}
-(void) turnOffLed:(bool)update
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        [device setTorchMode: AVCaptureTorchModeOff];
        [device unlockForConfiguration];
    }
    if (update)
    {
        [btnOnOff setImage:[UIImage imageNamed:@"BtnOff.png"] forState:UIControlStateNormal];
    }
    
}

-(IBAction)onBtnOnOff:(id)sender
{
    
    
    if (isShineOn) {
        [self onBtnShine:nil];
    }else{
        isLightOn = 1-isLightOn;
        if (isLightOn) {
            [self turnOnLed:YES];
        }else{
            [self turnOffLed:YES];
        }
    }
    
}



-(IBAction)onBtnOnOffDown:(id)sender
{
    
    
}

-(IBAction)onBtnSettingDown:(id)sender
{
    
    
}

-(IBAction)onSwitch:(id)sender
{
    UISwitch *uiSwitch = (UISwitch *)sender;
    
    enableShine = uiSwitch.on;
    
    {
        
        if (!enableShine)
        {
            
            if (sender)
            {
                if (isLightOn) {
                    [self turnOnLed:YES];
                }else{
                    [self turnOffLed:YES];
                }
                isShineOn = NO;
            }else{
                isLightOn = NO;
                [self turnOffLed:YES];
                [btnOnOff setImage:[UIImage imageNamed:@"BtnOff.png"] forState:UIControlStateNormal];
            }
            
        }else{
            if (sender)
            {
                isShineOn = YES;
            }
            else{
                [btnOnOff setImage:[UIImage imageNamed:@"BtnOn.png"] forState:UIControlStateNormal];
            }
            isLightOn = YES;
            [self turnOnLed:YES];
        }
        
        if (enableShine) {
            [btnShine setImage:[UIImage imageNamed:@"BtnOn.png"] forState:UIControlStateNormal];
        }else{
            [btnShine setImage:[UIImage imageNamed:@"BtnOff.png"] forState:UIControlStateNormal];
            
        }
        [self SliderProgressUp:nil];
        
    }
    
}


-(IBAction)onBtnShine:(id)sender
{
    enableShine = 1-enableShine;
    if (!enableShine)
    {
        
        if (sender)
        {
            if (isLightOn) {
                [self turnOnLed:YES];
            }else{
                [self turnOffLed:YES];
            }
            isShineOn = NO;
        }else{
            isLightOn = NO;
            [self turnOffLed:YES];
            [btnOnOff setImage:[UIImage imageNamed:@"BtnOff.png"] forState:UIControlStateNormal];
            switchShine.on = enableShine;
        }
        
    }else{
        
        if (sender)
        {
            isShineOn = YES;
        }
        else{
            [btnOnOff setImage:[UIImage imageNamed:@"BtnOn.png"] forState:UIControlStateNormal];
            switchShine.on = enableShine;
        }
        isLightOn = YES;
        [self turnOnLed:YES];
    }
    
    if (enableShine) {
        [btnShine setImage:[UIImage imageNamed:@"BtnOn.png"] forState:UIControlStateNormal];
    }else{
        [btnShine setImage:[UIImage imageNamed:@"BtnOff.png"] forState:UIControlStateNormal];
        
    }
    [self SliderProgressUp:nil];
    
}


- (IBAction) SliderProgressUp:(id)sender
{
    
   
    double time = 1.0/shineFreq;
    
    if (!enableShine) {
        return;
    }
    
    if (timerShine) {
        // [timerShine release];
        
        [timerShine invalidate];
        timerShine = nil;
        
        
    }
    timerShine= [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(onTimerShine) userInfo:nil repeats:YES];
    
    
    
    
}


- (void) SliderProgressChanged:(id)sender
{
    UISlider *slider=(UISlider *)sender;
	
    int percent=(int)(slider.value*100);
    shineFreq = MIN_FREQ+(MAX_FREQ-MIN_FREQ)*percent/100.0;
    labelFreq.text = [NSString stringWithFormat:@"%d hz",shineFreq];
    
}


-(void) onTimerShine
{
    static int count=0;
    
    if (!enableShine) {
        return;
    }
    
    if (count%2) {
        [self turnOnLed:NO];
    }else{
        [self turnOffLed:NO];
    }
    count ++;
    
}


#pragma mark mogo ad Delegate methods


- (UIViewController *)viewControllerForPresentingModalView {
	return self;
}







@end
