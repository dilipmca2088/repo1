//
//  LoginViewController.m
//  INDIA CME
//
//  Created by DILIP KUMAR on 17/05/17.
//  Copyright © 2017 Apple. All rights reserved.
//

#import "ForgotViewController.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "AppDelegate.h"
#import "RegisterViewController.h"

@interface ForgotViewController ()

@end

@implementation ForgotViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
     [emailTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
     activity.hidden=YES;
    _signinBtn.layer.cornerRadius=15.0f;
    _signinBtn.layer.borderWidth=1.0f;
    _signinBtn.clipsToBounds=YES;
    _signinBtn.layer.borderColor=[[UIColor clearColor] CGColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationController setNavigationBarHidden:YES];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)signinBtnTpd:(id)sender
{
    
    NSString *message=nil;
    
    
     if([emailTF.text isEqualToString:@""])
    {
        message = @"Please enter email!";
    }
    else if(![AppDelegate validateEmailWithString:emailTF.text])
    {
        message = @"Invalid email address!";
    }
    
    if (message)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
  
    }
    else
    {
        if ([[AppDelegate appDelegate] connected])
        {
            NSLog(@"yes");
            activity.hidden=NO;
            [activity startAnimating];
            [self loadForgotPaswdWS];
            
        }
        else
        {
            NSLog(@"no");
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please Check your Internet Connection"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
            
            
        }

    }
}
-(void)loadForgotPaswdWS
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];

    [dict setValue:emailTF.text forKey:@"Vend_Email"];
    [dict setValue:@XKEY forKey:@"X-API-KEY"];
    [manager POST:[NSString stringWithFormat:@"%sforgot_pass/",URLBase] parameters:dict
constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     
     {
         
     } success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         [activity stopAnimating];
         [activity setHidden:YES];
         NSLog(@"Response Object%@",responseObject);
         NSString *responseCode =[responseObject valueForKey:@"responseCode"];
         
         NSString *resMsg =[responseObject valueForKey:@"message"];
         
         if ([responseCode isEqualToString:@"success"])
         {
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:resMsg delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
             [alert show];
         }
         
         else
             
         {
             
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                             message:resMsg
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
             [alert show];

             
         }
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
         [activity stopAnimating];
         [activity setHidden:YES];
         NSLog(@"Error: %@", error);
         
         
     }];
}

- (IBAction)backBtnAction:(id)sender;

{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
