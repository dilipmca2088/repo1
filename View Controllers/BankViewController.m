//
//  RegisterViewController.m
//  INDIA CME
//
//  Created by DILIP KUMAR on 17/05/17.
//  Copyright © 2017 Apple. All rights reserved.
//

#import "BankViewController.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "ViewController.h"
#import "LocationViewController.h"

@interface BankViewController ()
{
        int p1;
    NSString *checkUpdateInsert;

}

@end

@implementation BankViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

     self.scrollView.contentSize =CGSizeMake(320,400);
    _specView.hidden=YES;
    activity.hidden=YES;

    _certImageView.hidden=YES;
    

    [actHolNameTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
      [actNumberTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
      [ifscCodeTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [bankNameTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
     [branchNameTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [actTypeTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [panNoTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    
    self.mainSpecArray=[NSMutableArray array];
    
    _regiterBtn.layer.cornerRadius=15.0f;
    _regiterBtn.layer.borderWidth=1.0f;
    _regiterBtn.clipsToBounds=YES;
    _regiterBtn.layer.borderColor=[[UIColor clearColor] CGColor];
    
    checkUpdateInsert=@"";

    
    if ([[AppDelegate appDelegate] connected])
    {
        NSLog(@"yes");
        activity.hidden=NO;
        [activity startAnimating];
        [self getBankDetailsWS];
        
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
   
    [self.navigationController setNavigationBarHidden:YES];
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    actNumberTF.inputAccessoryView = numberToolbar;

    CGRect pickerFrame = CGRectMake(0, 360, 0, 0);
    
    picker1=[[UIPickerView alloc] initWithFrame:pickerFrame];
    
    pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,330, _pickerActionSheet.bounds.size.width, 44)];

  
}

-(void)cancelNumberPad
{
    [actNumberTF resignFirstResponder];

}

-(void)doneWithNumberPad
{
    
    [actNumberTF resignFirstResponder];

}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.scrollView.contentSize =CGSizeMake(320,600);
 
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==actTypeTF||textField==panNoTF)
    {
        self.scrollView.contentSize =CGSizeMake(320,400);

    }
  
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



- (IBAction)cancelBtnAction:(id)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (IBAction)registerBtnTpd:(id)sender
{
    
    
    if ([checkUpdateInsert isEqualToString:@"T"])
    {
       
        NSString *message = nil;
        
        if([actHolNameTF.text isEqualToString:@""])
        {
            message = @"Please enter account holder name!";
        }
        else if([actNumberTF.text isEqualToString:@""])
        {
            message = @"Please enter account number!";
        }
        
        else if([ifscCodeTF.text isEqualToString:@""])
        {
            message = @"Please enter ifse code!";
        }
        else if([bankNameTF.text isEqualToString:@""])
        {
            message = @"Please enter bank name!";
        }
        
        else if([branchNameTF.text isEqualToString:@""])
        {
            message = @"Please enter branch name!";
        }
        
        else if([actTypeTF.text isEqualToString:@""])
        {
            message = @"Please enter account type!";
        }
        
        else if([panNoTF.text isEqualToString:@""])
        {
            message = @"Please enter pan numbere!";
        }
        
        
        if (!message)
        {
            activity.hidden=NO;
            [activity startAnimating];
            
            [self loadBankWS];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
        }

    }
    
    else
    {
        [self updateBankWS];
        
    }
    
}

-(void)loadBankWS
{
    activity.hidden=NO;
    [activity startAnimating];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
 
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:[AppDelegate appDelegate].venderId forKey:@"user_id"];
    [dict setValue:actHolNameTF.text forKey:@"account_name"];
    [dict setValue:actNumberTF.text forKey:@"account_number"];
    [dict setValue:ifscCodeTF.text forKey:@"ifsc_code"];
    [dict setValue:bankNameTF.text forKey:@"bank_name"];
    [dict setValue:branchNameTF.text forKey:@"branch_name"];
    [dict setValue:actTypeTF.text forKey:@"account_type"];
    [dict setValue:panNoTF.text forKey:@"pan_number"];
    [dict setValue:@XKEY forKey:@"X-API-KEY"];

    [manager POST:[NSString stringWithFormat:@"%sbankdetailed/",URLBase] parameters:dict
constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     
     {
         
     } success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         [activity stopAnimating];
         activity.hidden=YES;
         
         NSLog(@"Response Object%@",responseObject);
         NSString *responseCode =[responseObject valueForKey:@"responseCode"];
         
         if ([responseCode isEqualToString:@"success"])
         { 
             LocationViewController *loginvc =[[LocationViewController alloc] initWithNibName:@"LocationViewController" bundle:nil];
             
             [self presentViewController:loginvc animated:YES completion:nil];
        }
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
         
         [activity stopAnimating];
         activity.hidden=YES;
         
     }];
}

-(void)updateBankWS
{
    activity.hidden=NO;
    [activity startAnimating];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:[AppDelegate appDelegate].venderId forKey:@"vendid"];
    [dict setValue:actHolNameTF.text forKey:@"account_name"];
    [dict setValue:actNumberTF.text forKey:@"account_number"];
    [dict setValue:ifscCodeTF.text forKey:@"ifsc_code"];
    [dict setValue:bankNameTF.text forKey:@"bank_name"];
    [dict setValue:branchNameTF.text forKey:@"branch_name"];
    [dict setValue:actTypeTF.text forKey:@"account_type"];
    [dict setValue:panNoTF.text forKey:@"pan_number"];
    [dict setValue:@XKEY forKey:@"X-API-KEY"];
    
    [manager POST:@"http://culinkservices.com/api/example/updatebank/" parameters:dict
constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     
     {
         
     } success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         [activity stopAnimating];
         activity.hidden=YES;
         
         NSLog(@"Response Object%@",responseObject);
         NSString *responseCode =[responseObject valueForKey:@"responseCode"];
         
         if ([responseCode isEqualToString:@"success"])
         {
             
             if ([AppDelegate appDelegate].status==0)
             {
                 
                 LoginViewController *loginvc =[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
                 
                 [self presentViewController:loginvc animated:YES completion:nil];
             }
             
             else
                 
             {
                 
                 [[AppDelegate appDelegate] showSideMenu];
             }
            
         }
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
         
         [activity stopAnimating];
         activity.hidden=YES;
         
     }];
}

-(void)getBankDetailsWS
{
    activity.hidden=NO;
    [activity startAnimating];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
     [dict setValue:[AppDelegate appDelegate].venderId forKey:@"Id"];
    [dict setValue:@XKEY forKey:@"X-API-KEY"];
    
    [manager POST:[NSString stringWithFormat:@"%sbank/",URLBase] parameters:dict
constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     
     {
         
     } success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         [activity stopAnimating];
         activity.hidden=YES;
         
         NSLog(@"Response Object%@",responseObject);
         NSString *responseCode =[responseObject valueForKey:@"responseCode"];
         
         if ([responseCode isEqualToString:@"success"])
         {
             
             NSArray *examArray =[responseObject valueForKey:@"data"];
             
             if (examArray.count==0)
             {
                 checkUpdateInsert=@"T";
             }
             else
             {
    actHolNameTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"accountname"] objectAtIndex:0];
                 
    actNumberTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"accountnumber"] objectAtIndex:0];
                 
    ifscCodeTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"ifsccode"] objectAtIndex:0];
                 
    bankNameTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"bankname"] objectAtIndex:0];
                 
    branchNameTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"branchname"] objectAtIndex:0];
                 
    actTypeTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"accounttype"] objectAtIndex:0];
                 
    panNoTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"pannumber"] objectAtIndex:0];
              
                 
             }
             
         }
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
         
         [activity stopAnimating];
         activity.hidden=YES;
         
     }];
}


- (IBAction)backBtnTpd:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - create Picker With ActionSheet

- (void)createActionSheetWithBtnTag:(int)btnTag
{
    
    p1=btnTag;
    [pickerToolbar setHidden:NO];
    [picker1 setHidden:NO];
    
    picker1.showsSelectionIndicator = YES;
    picker1.userInteractionEnabled=YES;
    picker1.delegate = self;
    [picker1 setTag:btnTag];
    picker1.backgroundColor = [UIColor whiteColor];
    picker1.dataSource = self;
    [picker1 selectRow:0 inComponent:0 animated:YES];
    [self.view addSubview:picker1];
    
    
    [pickerToolbar setBarStyle:UIBarStyleBlack];
    [pickerToolbar sizeToFit];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(pickerCancelTapped)];
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(pickerDoneTapped)];
    [pickerToolbar setItems:[NSArray arrayWithObjects:cancelButton,spacer,doneButton, nil] animated:NO];
    
    [picker1 addSubview:pickerToolbar];
    [self.view addSubview:pickerToolbar];
    
    [picker1 setBounds:CGRectMake(0,0,320,220)];
    
    
}



#pragma mark - ActionSheet Delegate Methods

-(void)actionSheet:(UIActionSheet *)myActionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSLog(@"Button no %d tapped!",buttonIndex);
}

#pragma mark - Picker Delegate & DataSource Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    NSLog(@"thePickerView tag >> %ld",(long)thePickerView.tag);
    
    switch (match)
    {
       
        case 1:
            return 2;
            break;
    
        default:
            return 0;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    switch (match)
    {
        
        case 1:
            return (row == 0)?@"Male":@"Female";
            break;
            
        default:
            return 0;
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row  inComponent:(NSInteger)component {
    
    switch (match)
    {

        case 1:
            self.selectedValueStr=(row == 0)?@"Male":@"Female";
            break;
               default:
            break;
    }

}


@end
