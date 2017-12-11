//
//  ForgotPasswordViewController.m
//  INDIA CME
//
//  Created by DILIP KUMAR on 17/05/17.
//  Copyright © 2017 Apple. All rights reserved.
//

#import "ChangePasswordViewController.h"

#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "AppDelegate.h"
@interface ChangePasswordViewController ()
{
    NSTimer *timer;
    int min;
    int sec;
}

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [menuBtn addTarget:self.viewDeckController action:@selector(toggleLeftView) forControlEvents:UIControlEventTouchUpInside];
    
    [_activityInd setHidden:YES];
    
    [_oldTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    [_newwTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    [_confirmTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    _submitBtn.layer.cornerRadius=15.0f;
    _submitBtn.layer.borderWidth=1.0f;
    _submitBtn.clipsToBounds=YES;
    _submitBtn.layer.borderColor=[[UIColor clearColor] CGColor];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [self.viewDeckController setLeftLedge:70];
   
}

-(void)viewDidAppear:(BOOL)animated
{
    
    [self.viewDeckController closeLeftViewAnimated:YES];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField==_oldTF)
    {
        //_lbl1.backgroundColor =[UIColor redColor];
        _lbl2.backgroundColor =[UIColor whiteColor];
        _lbl3.backgroundColor =[UIColor whiteColor];

    }
    
    if (textField==_newwTF)
    {
        _lbl1.backgroundColor =[UIColor whiteColor];
        //_lbl2.backgroundColor =[UIColor redColor];
        _lbl3.backgroundColor =[UIColor whiteColor];

        
    }
    if (textField==_confirmTF)
    {
        _lbl1.backgroundColor =[UIColor whiteColor];
        _lbl2.backgroundColor =[UIColor whiteColor];
       // _lbl3.backgroundColor =[UIColor redColor];
        
        
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if (textField==_oldTF)
    {
        _lbl1.textColor =[UIColor whiteColor];
        _oldTF.textColor =[UIColor whiteColor];

    }
    
    if (textField==_newwTF)
    {
        _lbl2.textColor =[UIColor whiteColor];
        _newwTF.textColor =[UIColor whiteColor];

    }
    if (textField==_confirmTF)
    {
        _lbl3.textColor =[UIColor whiteColor];
        _confirmTF.textColor =[UIColor whiteColor];

    }
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)continueBtnTpd:(id)sender
{
 
    NSString *message=nil;
        
    
    if ([_oldTF.text isEqualToString:@""])
    {
        message=@"Please enter your new password";
    }
    else if ([_newwTF.text isEqualToString:@""])
    {
        message=@"Please enter verify password";
    }
   
    else if (![_newwTF.text isEqualToString:_confirmTF.text])
    {
        message=@"Password does not match!";
    }
    
    
    
    
    if (message)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate: self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        
    }
    else
    {
        
        [_activityInd setHidden:NO];
        [_activityInd stopAnimating];

        
        if ([[AppDelegate appDelegate] connected])
        {
            NSLog(@"yes");
            [self loadChangePaswdWS];
            
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

-(void)loadChangePaswdWS
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:[AppDelegate appDelegate].venderId forKey:@"Vend_Id"];
    [dict setValue:_newwTF.text forKey:@"New_Pass"];
    [dict setValue:_oldTF.text forKey:@"Old_Pass"];
    [dict setValue:_confirmTF.text forKey:@"Conf_Pass"];
    [dict setValue:@XKEY forKey:@"X-API-KEY"];


    [manager POST:[NSString stringWithFormat:@"%schanged_password/",URLBase] parameters:dict
constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     
     {
         
     } success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         [_activityInd stopAnimating];
         [_activityInd setHidden:YES];
         NSLog(@"Response Object%@",responseObject);
         
         NSString *responseCode =[responseObject valueForKey:@"responseCode"];
         
        NSString *resMsg =[responseObject valueForKey:@"message"];
         
         if ([responseCode isEqualToString:@"success"])
         {
             
             
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                             message:resMsg
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
             [alert show];
             [[AppDelegate appDelegate] showSideMenu];

             
         }
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
         [_activityInd stopAnimating];
         [_activityInd setHidden:YES];
         NSLog(@"Error: %@", error);
        
         
     }];
}
@end
