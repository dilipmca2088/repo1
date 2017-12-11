//
//  CaptureSignatureViewController.m
//  signature
//
//  Created by Vignesh on 2/10/16.
//  Copyright © 2016 vigneshuvi. All rights reserved.
//

#import "CaptureSignatureViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "AppDelegate.h"
#import "FinalFormViewController.h"

#define USER_SIGNATURE_PATH  @"user_signature_path"


@interface CaptureSignatureViewController ()

{
    
    NSData *signData;

}

@end

@implementation CaptureSignatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:USER_SIGNATURE_PATH];
    

    self.view.frame = [[UIScreen mainScreen] bounds];
    [self.view setTransform:CGAffineTransformMakeRotation(M_PI_2)];
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    self.view.frame = CGRectMake(0, 0, screenFrame.size.height, screenFrame.size.width);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)canBecomeFirstResponder
{
    return YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
    NSLog(@"%@",_dataDict);


}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:USER_SIGNATURE_PATH];
    NSMutableArray *signPathArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [self.signatureView setPathArray:signPathArray];
    [self.signatureView setNeedsDisplay];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        // your code
    }
}


-(IBAction)captureSign:(id)sender
{

    [self.signatureView captureSignature];
    [self startSampleProcess:signedDate];
    
    
    // [self submitSignWS];
    
    
    
}

-(void)startSampleProcess:(NSString*)text
{
    UIImage *captureImage = [self.signatureView signatureImage:CGPointMake(self.signatureView.frame.origin.x+10 , self.signatureView.frame.size.height-25) text:@""];
    
    FinalFormViewController *capVC =[[FinalFormViewController alloc] initWithNibName:@"FinalFormViewController" bundle:nil];
    [capVC setNewdataArray:_formFieldsArr];
    [capVC setNewdataDict:_dataDict];
    [capVC setValueArr:_dataValArr];
    [capVC setMainTitle:_examTitle];
    [capVC setSignImg:captureImage];
    [self.navigationController pushViewController:capVC animated:YES];

    
 // [self.delegate processCompleted:captureImage];

}


-(void)changeOrientation
{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown) {
        //[[NSBundle mainBundle] loadNibNamed:@"Portrait" owner:self options:nil];
    }
    else
    {
        [[NSBundle mainBundle] loadNibNamed:@"CaptureSignatureViewController" owner:self options:nil];
    }
    
}


@end
