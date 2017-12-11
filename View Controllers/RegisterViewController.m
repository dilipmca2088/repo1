//
//  RegisterViewController.m
//  INDIA CME
//
//  Created by DILIP KUMAR on 17/05/17.
//  Copyright © 2017 Apple. All rights reserved.
//

#import "RegisterViewController.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "CentreViewController.h"

@interface RegisterViewController ()
{
        int p1;

}

@end

@implementation RegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.scrollView.contentSize =CGSizeMake(320,500);
    _specView.hidden=YES;
    activity.hidden=YES;

    _certImageView.hidden=YES;
    [firstNameTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
      [pswdTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
      [emailTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [conpswdTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
     [postaddTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [sexTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [stateTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [cityTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [countryTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [pinTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    
    self.stateArray=[NSMutableArray array];
    self.cityArray=[NSMutableArray array];
    self.countryArray=[NSMutableArray array];

    _regiterBtn.layer.cornerRadius=15.0f;
    _regiterBtn.layer.borderWidth=1.0f;
    _regiterBtn.clipsToBounds=YES;
    _regiterBtn.layer.borderColor=[[UIColor clearColor] CGColor];
    

    
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
    pinTF.inputAccessoryView = numberToolbar;

    CGRect pickerFrame = CGRectMake(0, 360, 0, 0);
    
    picker1=[[UIPickerView alloc] initWithFrame:pickerFrame];
    countryTF.text =@"";
    
    pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,330, _pickerActionSheet.bounds.size.width, 44)];

  
}

-(void)cancelNumberPad
{
    [pinTF resignFirstResponder];

}

-(void)doneWithNumberPad
{
    
    [pinTF resignFirstResponder];

}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
 
    if (textField==stateTF||textField==cityTF||textField==countryTF)
    {
        self.scrollView.contentSize =CGSizeMake(320,670);
        
    }
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if (textField==pinTF)
    {
       self.scrollView.contentSize =CGSizeMake(320,500);
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
    NSString *message = nil;
    
    if([firstNameTF.text isEqualToString:@""])
    {
        message = @"Please enter name!";
    }
    else if([emailTF.text isEqualToString:@""])
    {
        message = @"Please enter email!";
    }
    else if(![AppDelegate validateEmailWithString:emailTF.text])
    {
        message = @"Invalid email address!";
    }
    else if([pswdTF.text isEqualToString:@""])
    {
        message = @"Please enter password!";
    }
    else if([conpswdTF.text isEqualToString:@""])
    {
        message = @"Please enter confirm password!";
    }
    
    else if([postaddTF.text isEqualToString:@""])
    {
        message = @"Please enter post address!";
    }
   
    else if([sexTF.text isEqualToString:@""])
    {
        message = @"Please enter gender!";
    }
    
    else if([stateTF.text isEqualToString:@""])
    {
        message = @"Please enter state!";
    }
    
    else if([cityTF.text isEqualToString:@""])
    {
        message = @"Please enter city!";
    }
    
    else if([countryTF.text isEqualToString:@""])
    {
        message = @"Please enter country!";
    }
    
    else if([pinTF.text isEqualToString:@""])
    {
        message = @"Please enter pincode!";
    }
    
    if (!message)
    {
        
        
      
        
        if ([[AppDelegate appDelegate] connected])
        {
            NSLog(@"yes");
            activity.hidden=NO;
            [activity startAnimating];
            [self loadRegisterUserWS];
            
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

-(void)loadRegisterUserWS
{
    activity.hidden=NO;
    [activity startAnimating];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
 
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    
    NSString *foo = firstNameTF.text;
    NSArray* strFirst = [foo componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString*name = [strFirst componentsJoinedByString:@""];
    
    
    NSString *foo1 = postaddTF.text;
    NSArray* str1 = [foo1 componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString* strPostAdd = [str1 componentsJoinedByString:@""];
    
    
    NSString *foo2 = emailTF.text;
    NSArray* str2 = [foo2 componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString* strEmail = [str2 componentsJoinedByString:@""];
    
    NSString *foo3 = pswdTF.text;
    NSArray* str3 = [foo3 componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString* strPswd = [str3 componentsJoinedByString:@""];
    
    NSString *foo4 = conpswdTF.text;
    NSArray* str4 = [foo4 componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString* strCnfPswd = [str4 componentsJoinedByString:@""];
    
    
    NSString *foo5 = sexTF.text;
    NSArray* str5 = [foo5 componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString* strSex = [str5 componentsJoinedByString:@""];
    
    NSString *foo6 = cityTF.text;
    NSArray* str6 = [foo6 componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString* strCity = [str6 componentsJoinedByString:@""];
    
    NSString *foo7 = countryTF.text;
    NSArray* str7 = [foo7 componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString* strCoun = [str7 componentsJoinedByString:@""];
    
    
    NSString *foo8 = pinTF.text;
    NSArray* str8 = [foo8 componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString* strPin = [str8 componentsJoinedByString:@""];
    
    NSString *foo9 = stateTF.text;
    NSArray* str9 = [foo9
                     componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString* strState = [str9 componentsJoinedByString:@""];
    [dict setValue:name forKey:@"vend_name"];
    [dict setValue:strEmail forKey:@"vend_email"];
    [dict setValue:strPswd forKey:@"vend_pass"];
    [dict setValue:strCnfPswd forKey:@"vend_conf_pass"];
    [dict setValue:strPostAdd forKey:@"vend_post_add"];
    //[dict setValue:strSex forKey:@"vend_sex"];
    [dict setValue:strCity forKey:@"vend_city"];
    [dict setValue:strCoun forKey:@"vend_coun"];
    [dict setValue:strState forKey:@"vend_state"];
    [dict setValue:strPin forKey:@"vend_pincode"];
    [dict setValue:@XKEY forKey:@"X-API-KEY"];

    [manager POST:@"http://culinkservsices.com/api/example/signup/" parameters:dict
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
             LoginViewController *loginvc =[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
             
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


-(void)stateWS
{
    activity.hidden=NO;
    [activity startAnimating];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    [dict setValue:@XKEY forKey:@"X-API-KEY"];
    
    [manager POST:@"http://culinkservices.com/api/example/select_state/" parameters:dict
constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     
     {
         
     } success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         [activity stopAnimating];
         activity.hidden=YES;
         
         NSLog(@"Response Object%@",responseObject);
         NSString *responseCode =[responseObject valueForKey:@"responseCode"];
         
         _stateArray =[[responseObject valueForKey:@"data"] valueForKey:@"state"];
         
         [self createActionSheetWithBtnTag:match];

         
         if ([responseCode isEqualToString:@"success"])
         {
            
         }
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
         
         [activity stopAnimating];
         activity.hidden=YES;
         
     }];
}



-(void)cityWS
{
    activity.hidden=NO;
    [activity startAnimating];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:stateTF.text forKey:@"state"];

    [dict setValue:@XKEY forKey:@"X-API-KEY"];
    
    [manager POST:@"http://culinkservices.com/api/example/select_city/" parameters:dict
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
             
             _cityArray =[[responseObject valueForKey:@"data"] valueForKey:@"city_name"];
             
             [self createActionSheetWithBtnTag:match];
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


- (IBAction)disclosureBtnTapped:(UIButton *)button {
    
    
    match=button.tag;
    switch (match) {

        case 1:
            [self stateWS];
           // self.selectedValueStr = [_stateArray objectAtIndex:0];

            break;
            
        case 2:
            
            
            if ([stateTF.text isEqualToString:@""])
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please select state" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                
                
            }
            else
            {
                
                 [self cityWS];
            }

            
           
           // self.selectedValueStr = [_cityArray objectAtIndex:0];

            break;
            
        case 3:
            self.selectedValueStr = @"India";
            [self createActionSheetWithBtnTag:match];
            break;
            default:
            break;
    }
}


- (void)pickerDoneTapped
{
    
    //self.selectProfession.text=self.professionStr;
    
    
    switch (match) {
       
        case 1:
            stateTF.text=self.selectedValueStr;
            break;
            
        case 2:
            cityTF.text=self.selectedValueStr;
            break;
            
        case 3:
            countryTF.text=self.selectedValueStr;
            break;

            
        default:
            break;
    }
    
    [pickerToolbar setHidden:YES];
    [picker1 setHidden:YES];}

- (void)pickerCancelTapped
{
    
    [pickerToolbar setHidden:YES];
    [picker1 setHidden:YES];
}



#pragma mark - ActionSheet Delegate Methods

-(void)actionSheet:(UIActionSheet *)myActionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSLog(@"Button no %d tapped!",buttonIndex);
}

#pragma mark - Picker Delegate & DataSource Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    NSLog(@"thePickerView tag >> %ld",(long)thePickerView.tag);
    
    switch (match) {
       
        case 1:
            return [_stateArray count];
            break;
            
        case 2:
            return [_cityArray count];
            break;
        case 3:
            return 1;
            break;
            

    
        default:
            return 0;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    switch (match) {
        
        case 1:
            return [_stateArray objectAtIndex:row];
            break;
            
        case 2:
            return [_cityArray objectAtIndex:row];
            break;
            
        case 3:
            return (row == 0)?@"India":@"" ;
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
            self.selectedValueStr=[_stateArray objectAtIndex:row];
            break;
            
        case 2:
            self.selectedValueStr=[_cityArray objectAtIndex:row];
             break;
            
        case 3:
             self.selectedValueStr= (row == 0)?@"India":@"" ;
            break;

        default:
            break;
    }

}


@end
