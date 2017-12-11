//
//  LoginViewController.m
//  INDIA CME
//
//  Created by DILIP KUMAR on 17/05/17.
//  Copyright © 2017 Apple. All rights reserved. 
//

#import "LoginViewController.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "AppDelegate.h"
#import "RegisterViewController.h"
#import "ForgotViewController.h"
#import "CentreViewController.h"
#import "BankViewController.h"
#import "ViewController.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
     [passwordTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
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

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
  
    if (textField==emailTF)
    {
        //_lbl1.backgroundColor =[UIColor redColor];
        _lbl2.backgroundColor =[UIColor whiteColor];
        
    }
    
    if (textField==passwordTF)
    {
        //_lbl2.backgroundColor =[UIColor redColor];
        _lbl1.backgroundColor =[UIColor whiteColor];

    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
   
    if (textField==emailTF)
    {
        _lbl1.textColor =[UIColor whiteColor];
    }
    
    if (textField==passwordTF)
    {
        _lbl2.textColor =[UIColor whiteColor];
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField==emailTF)
    {
        if (emailTF.text.length==10)
        {
            [emailTF setEnabled:YES];
        }
        
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)signinBtnTpd:(id)sender
{
 
    [emailTF resignFirstResponder];
    [passwordTF resignFirstResponder];
    
    NSString *message=nil;
    
     if([emailTF.text isEqualToString:@""])
    {
        message = @"Please enter email!";
    }
    else if(![AppDelegate validateEmailWithString:emailTF.text])
    {
        message = @"Invalid email address!";
    }

    else if ([passwordTF.text isEqualToString:@""])
    {
        message=@"Enter the  Password!";
    }
    
    if (message)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message
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
            [self loadLoginUserWS];
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
-(void)loadLoginUserWS
{
    activity.hidden=NO;
    [activity startAnimating];
        
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    NSString *foo3 = emailTF.text;
    NSArray* str3 = [foo3 componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString* strMoble = [str3 componentsJoinedByString:@""];
    
    
    NSString *foo2 = passwordTF.text;
    NSArray* str2 = [foo2 componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString* strPassword = [str2 componentsJoinedByString:@""];

    [dict setValue:strMoble forKey:@"Email"];
    [dict setValue:strPassword forKey:@"Pass"];
    [dict setValue:@XKEY forKey:@"X-API-KEY"];
    [manager POST:[NSString stringWithFormat:@"%slogin/",URLBase] parameters:dict
constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     
     {
         
     } success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         [activity stopAnimating];
         activity.hidden=YES;
         NSLog(@"Response Object%@",responseObject);
         
         NSString *responseCode =[responseObject valueForKey:@"responseCode"];
         
         [AppDelegate appDelegate].venderId=[[responseObject valueForKey:@"data" ] valueForKey:@"vend_id"];
         
         [AppDelegate appDelegate].status=[[responseObject valueForKey:@"data" ] valueForKey:@"vend_status"];
         
          [AppDelegate appDelegate].primaryImg=[[responseObject valueForKey:@"data" ] valueForKey:@"primaryimg"];
         
          [AppDelegate appDelegate].welcomeStr=[[responseObject valueForKey:@"data" ] valueForKey:@"centername"];
         
         NSString *message =[responseObject valueForKey:@"message"];
         
         if ([responseCode isEqualToString:@"success"])
         {
             
             if ([[AppDelegate appDelegate].status isEqualToString:@"0"])
             {
                 CentreViewController *loginvc =[[CentreViewController alloc] initWithNibName:@"CentreViewController" bundle:nil];
                 
                 [self presentViewController:loginvc animated:YES completion:nil];
                 
             }
             else
             {
                 [[AppDelegate appDelegate] showSideMenu];
                 
             }
             
             

         }
         
         if ([responseCode isEqualToString:@"failed"])
         
         {
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
             [alert show];
             
  
         }
         
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
         NSLog(@"Error: %@", error);         
         [activity stopAnimating];
         activity.hidden=YES;
         
     }];
    

}

- (IBAction)forgotPasBtnTpd:(id)sender
{
    ForgotViewController *loginvc =[[ForgotViewController alloc] initWithNibName:@"ForgotViewController" bundle:nil];
    
    [self presentViewController:loginvc animated:YES completion:nil];
}

- (IBAction)registerBtnTpd:(id)sender
{
//    CentreViewController *loginvc =[[CentreViewController alloc] initWithNibName:@"CentreViewController" bundle:nil];
//    
//    [self presentViewController:loginvc animated:YES completion:nil];
    
    
//    ViewController *loginvc =[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
//    
//    [self presentViewController:loginvc animated:YES completion:nil];
    RegisterViewController *loginvc =[[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    
    [self presentViewController:loginvc animated:YES completion:nil];
    
//    BankViewController *loginvc =[[BankViewController alloc] initWithNibName:@"BankViewController" bundle:nil];
//    
//    [self presentViewController:loginvc animated:YES completion:nil];
}

@end
