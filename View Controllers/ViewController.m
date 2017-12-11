//
//  ViewController.m
//  signature
//
//  Created by Vignesh on 2/10/16.
//  Copyright © 2016 vigneshuvi. All rights reserved.
//

#import "ViewController.h"
#import "CaptureSignatureViewController.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGFloat borderWidth = 2.0f;
    
    self.signatureImageView.layer.borderColor = [UIColor grayColor].CGColor;
    self.signatureImageView.layer.borderWidth = borderWidth;
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    NSLog(@"%@",_dataDict);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Sample protocol delegate


- (IBAction)getSign:(id)sender
{
    CaptureSignatureViewController *loginvc =[[CaptureSignatureViewController alloc] initWithNibName:@"CaptureSignatureViewController" bundle:nil];
    loginvc.delegate = self;

    [self.navigationController presentViewController:loginvc animated:YES completion:nil];

    
}
- (IBAction)submitBtnAction:(id)sender
{
    [self submitSignWS];
}

- (IBAction)backBtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)submitSignWS
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:_dataDict];

    [dict setValue:[AppDelegate appDelegate].venderId forKey:@"vendor_id"];
    [dict setValue:@XKEY forKey:@"X-API-KEY"];
    [manager POST:[NSString stringWithFormat:@"%sform_submit/",URLBase] parameters:dict
constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     
     {
         NSData *imageData = UIImageJPEGRepresentation(_signatureImageView.image,0.5);

         [formData appendPartWithFileData:imageData name:@"signatureImg" fileName:@"NewImage.png" mimeType:@"image/png"];
         
     } success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         NSLog(@"Response Object%@",responseObject);
         
         NSString *responseCode =[responseObject valueForKey:@"responseCode"];
        
         
         if ([responseCode isEqualToString:@"success"])
         {
            
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Saved Successfully"
                                                            delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil];
             [alert show];
             [[AppDelegate appDelegate] showSideMenu];
            
         }
        
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
         
         
     }];
    
}

@end
