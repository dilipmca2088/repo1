//
//  ForgotPasswordViewController.m
//  INDIA CME
//
//  Created by DILIP KUMAR on 17/05/17.
//  Copyright © 2017 Apple. All rights reserved.
//

#import "HelpViewController.h"

#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "AppDelegate.h"
@interface HelpViewController ()
{
    NSTimer *timer;
    int min;
    int sec;
    UIToolbar* pickerToolbar;
    
    IBOutlet UIPickerView *picker1;
}

@end

@implementation HelpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [menuBtn addTarget:self.viewDeckController action:@selector(toggleLeftView) forControlEvents:UIControlEventTouchUpInside];
    
    [_activityInd setHidden:YES];
    
    [_nameTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    [_emailTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    [_phoneTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    _submitBtn.layer.cornerRadius=15.0f;
    _submitBtn.layer.borderWidth=1.0f;
    _submitBtn.clipsToBounds=YES;
    _submitBtn.layer.borderColor=[[UIColor clearColor] CGColor];
    
    
    _msgTXT.layer.cornerRadius=5.0f;
    _msgTXT.layer.borderWidth=1.0f;
    _msgTXT.clipsToBounds=YES;
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [self.viewDeckController setLeftLedge:70];
   
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    
    CGRect pickerFrame = CGRectMake(0, 360, 0, 0);
    
    picker1=[[UIPickerView alloc] initWithFrame:pickerFrame];
    pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,330, _pickerActionSheet.bounds.size.width, 44)];
    _phoneTF.inputAccessoryView = numberToolbar;
    
    
}

-(void)cancelNumberPad
{
    [_phoneTF resignFirstResponder];
}

-(void)doneWithNumberPad
{
    [_phoneTF resignFirstResponder];
}


-(void)viewDidAppear:(BOOL)animated
{
    [self.viewDeckController closeLeftViewAnimated:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField==_nameTF)
    {
        //_lbl1.backgroundColor =[UIColor redColor];
        _lbl2.backgroundColor =[UIColor whiteColor];
        _lbl3.backgroundColor =[UIColor whiteColor];

    }
    
    if (textField==_emailTF)
    {
        _lbl1.backgroundColor =[UIColor whiteColor];
        //_lbl2.backgroundColor =[UIColor redColor];
        _lbl3.backgroundColor =[UIColor whiteColor];

        
    }
    if (textField==_phoneTF)
    {
        _lbl1.backgroundColor =[UIColor whiteColor];
        _lbl2.backgroundColor =[UIColor whiteColor];
       // _lbl3.backgroundColor =[UIColor redColor];
        
        
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if (textField==_nameTF)
    {
        _lbl1.textColor =[UIColor whiteColor];
        _nameTF.textColor =[UIColor whiteColor];

    }
    
    if (textField==_emailTF)
    {
        _lbl2.textColor =[UIColor whiteColor];
        _emailTF.textColor =[UIColor whiteColor];

    }
    if (textField==_phoneTF)
    {
        _lbl3.textColor =[UIColor whiteColor];
        _phoneTF.textColor =[UIColor whiteColor];

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
        
    
    if ([_nameTF.text isEqualToString:@""])
    {
        message=@"Please enter your name";
    }
    else if ([_emailTF.text isEqualToString:@""])
    {
        message=@"Please enter email id";
    }
   
    else if ([_phoneTF.text isEqualToString:@""])
    {
        message=@"Please enter phone no";
    }
    
    else if ([_msgTXT.text isEqualToString:@""])
    {
        message=@"Please enter message";
    }
   
    
    if (message)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate: self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        
    }
    else
    {
        
       
        
        if ([[AppDelegate appDelegate] connected])
        {
            NSLog(@"yes");
            [_activityInd setHidden:NO];
            [_activityInd stopAnimating];
            
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
    [dict setValue:_nameTF.text forKey:@"name"];
    [dict setValue:_emailTF.text forKey:@"email"];
    [dict setValue:_phoneTF.text forKey:@"mobile"];
    [dict setValue:_msgTXT.text forKey:@"message"];
    [dict setValue:@XKEY forKey:@"X-API-KEY"];


    [manager POST:[NSString stringWithFormat:@"%scontact_us/",URLBase] parameters:dict
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

             _nameTF.text=@"";
             _emailTF.text=@"";
             _phoneTF.text=@"";
             _msgTXT.text=@"";
             
         }
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
         [_activityInd stopAnimating];
         [_activityInd setHidden:YES];
         NSLog(@"Error: %@", error);
        
         
     }];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    
    if (textField==_phoneTF)
    {
        // Prevent crashing undo bug – see note below.
        if(range.length + range.location > textField.text.length)
        {
            return NO;
        }
        
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return newLength <= 10;
    }
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"])
    {
        
        [textView resignFirstResponder];
        // Return FALSE so that the final '\n' character doesn't get added
        return NO;
    }
    // For any other character return TRUE so that the text gets added to the view
    return YES;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
  //  _msgTXT.frame=CGRectMake(13,180,292,151);
    
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
   // _msgTXT.frame=CGRectMake(13,380,292,151);
    
    return YES;
    
}

@end
