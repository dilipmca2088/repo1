//
//  RegisterViewController.m
//  INDIA CME
//
//  Created by DILIP KUMAR on 17/05/17.
//  Copyright © 2017 Apple. All rights reserved.
//

#import "ProfileViewController.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "IIViewDeckController.h"

@interface ProfileViewController ()
{
        int p1;
    NSString *common;

}

@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [menuBtn addTarget:self.viewDeckController action:@selector(toggleLeftView) forControlEvents:UIControlEventTouchUpInside];
    
     self.scrollView.contentSize =CGSizeMake(320,1600);
    _specView.hidden=YES;
    activity.hidden=YES;
    
    _certImageView.hidden=YES;
    
    powerView.hidden=YES;
    gensetView.hidden=YES;
    systemView.hidden=YES;
    printerView.hidden=YES;
    cctvView.hidden=YES;
    acView.hidden=YES;

    
    [cityTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
      [centreNameTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
      [addressTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [inchargeTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
     [inchargeContTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [inchargeEmailTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [itPersonNameTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [cityTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [itPersonContactTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [itPersonEmailTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
     [systemAvailTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
     [processorTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
     [ramTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
     [hdTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
     [maleTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [feMaleTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [printerTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [waitingTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [parkingTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [fstInternetTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [fstIntSpeedTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [secInternetTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [secIntSpeedTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [cctvTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [acTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
     [upspowerunitTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [upsbackupTimeTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [genpowerunitTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [genFuelChargeTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [noSysTF1 setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [processorTF1 setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [ramTF1 setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [hd1 setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    [noSysTF2 setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [processorTF2 setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [ramTF2 setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [hd2 setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    
    self.mainSpecArray=[NSMutableArray array];
    
    _regiterBtn.layer.cornerRadius=15.0f;
    _regiterBtn.layer.borderWidth=1.0f;
    _regiterBtn.clipsToBounds=YES;
    _regiterBtn.layer.borderColor=[[UIColor clearColor] CGColor];
    
    [self getCenterRequestWS];
    
    
}

-(void)getCenterRequestWS
{
    activity.hidden=NO;
    [activity startAnimating];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:[AppDelegate appDelegate].venderId forKey:@"Id"];
    [dict setValue:@XKEY forKey:@"X-API-KEY"];
    
    [manager POST:[NSString stringWithFormat:@"%scenter/",URLBase] parameters:dict
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
             
              [AppDelegate appDelegate].status=[[[responseObject valueForKey:@"data"] valueForKey:@"vend_status"] objectAtIndex:0];
             
    cityTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"cityname"] objectAtIndex:0];
      centreNameTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"centername"] objectAtIndex:0];
      addressTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"address"] objectAtIndex:0];
      inchargeTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"cityname"] objectAtIndex:0];
      inchargeContTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"cityname"] objectAtIndex:0];
      inchargeEmailTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"cityname"] objectAtIndex:0];
      itPersonNameTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"itpersonname"] objectAtIndex:0];
      itPersonContactTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"itpersoncontact"] objectAtIndex:0];
      itPersonEmailTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"itpersonemail"] objectAtIndex:0];
      
      systemAvailTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"totalsystem"] objectAtIndex:0];
      processorTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"firstprocessor"] objectAtIndex:0];
      ramTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"firstram"] objectAtIndex:0];
      hdTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"firsthd"] objectAtIndex:0];
      
      maleTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"maletoilet"] objectAtIndex:0];
      feMaleTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"femaletoilet"] objectAtIndex:0];
      waitingTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"waitingspacecapacity"] objectAtIndex:0];
      
      inchargeTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"centerincharg"] objectAtIndex:0];
      inchargeContTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"centerinchargcontact"] objectAtIndex:0];
      inchargeEmailTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"centeremail"] objectAtIndex:0];
      
      
      parkingTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"parkingspace"] objectAtIndex:0];
      
      fstIntSpeedTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"firstinternetspeed"] objectAtIndex:0];
      
       secIntSpeedTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"secondaryinternetspeed"] objectAtIndex:0];
      
      cctvTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"cctv"] objectAtIndex:0];
      
      acTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"aircondition"] objectAtIndex:0];
      
      
      upspowerunitTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"powerunit"] objectAtIndex:0];
      
      upsbackupTimeTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"powertime"] objectAtIndex:0];
      
      genpowerunitTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"gensetpower"] objectAtIndex:0];
      
      genFuelChargeTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"gensetfuel"] objectAtIndex:0];

      
      
      
      noSysTF1.text=[[[responseObject valueForKey:@"data"] valueForKey:@"cityname"] objectAtIndex:0];
      
      processorTF1.text=[[[responseObject valueForKey:@"data"] valueForKey:@"cityname"] objectAtIndex:0];
      
      ramTF1.text=[[[responseObject valueForKey:@"data"] valueForKey:@"cityname"] objectAtIndex:0];
      
      hd1.text=[[[responseObject valueForKey:@"data"] valueForKey:@"cityname"] objectAtIndex:0];
      
      
      noSysTF2.text=[[[responseObject valueForKey:@"data"] valueForKey:@"cityname"] objectAtIndex:0];
      
      processorTF2.text=[[[responseObject valueForKey:@"data"] valueForKey:@"cityname"] objectAtIndex:0];
      
      ramTF2.text=[[[responseObject valueForKey:@"data"] valueForKey:@"cityname"] objectAtIndex:0];
      
      hd2.text=[[[responseObject valueForKey:@"data"] valueForKey:@"cityname"] objectAtIndex:0];
      
      
      
      
      
      
             
         }
         
         else
         {
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Wrong credentials"
                                                            delegate:self
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    
    [self.viewDeckController closeLeftViewAnimated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.viewDeckController setLeftLedge:70];

    [self.navigationController setNavigationBarHidden:YES];
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

  
}

-(void)cancelNumberPad
{
    [_otpTF resignFirstResponder];

}

-(void)doneWithNumberPad
{
    
    [_otpTF resignFirstResponder];

}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    
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
    [self loadRegisterUserWS];
    
   /* NSString *message = nil;
    
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
        activity.hidden=NO;
        [activity startAnimating];
        
        [self loadRegisterUserWS];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }*/
    
    
    
    
}

-(void)loadRegisterUserWS
{
    activity.hidden=NO;
    [activity startAnimating];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
 
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    [dict setValue:[AppDelegate appDelegate].venderId forKey:@"id"];

    [dict setValue:cityTF.text forKey:@"Cityname"];
    [dict setValue:centreNameTF.text forKey:@"Center"];
    [dict setValue:addressTF.text forKey:@"Address"];
    [dict setValue:inchargeTF.text forKey:@"InchargName"];
    [dict setValue:inchargeContTF.text forKey:@"InchargCon"];
    [dict setValue:inchargeEmailTF.text forKey:@"Email"];
    [dict setValue:itPersonNameTF.text forKey:@"ItName"];
    [dict setValue:itPersonContactTF.text forKey:@"ItContact"];
    [dict setValue:itPersonEmailTF.text forKey:@"ItEmail"];
    [dict setValue:systemAvailTF.text forKey:@"TotalSystem"];
    [dict setValue:processorTF.text forKey:@"Processor"];
    [dict setValue:ramTF.text forKey:@"Ram"];
    [dict setValue:hdTF.text forKey:@"Hd"];
    [dict setValue:maleTF.text forKey:@"MaleToilet"];
    [dict setValue:feMaleTF.text forKey:@"FemaleToilet"];
    [dict setValue:waitingTF.text forKey:@"WaitingSpace"];
    [dict setValue:parkingTF.text forKey:@"ParkingSpace"];
    [dict setValue:fstIntSpeedTF.text forKey:@"FirstInternet"];
    [dict setValue:secIntSpeedTF.text forKey:@"SecondInternet"];
    [dict setValue:cctvTF.text forKey:@"Cctv"];
    [dict setValue:acTF.text forKey:@"AirCondition"];
    [dict setValue:printerTF.text forKey:@"Printer"];
    [dict setValue:upspowerunitTF.text forKey:@"PowerUnit"];
    [dict setValue:upsbackupTimeTF.text forKey:@"PowerTime"];
    [dict setValue:genpowerunitTF.text forKey:@"GenPower"];
    [dict setValue:genFuelChargeTF.text forKey:@"GenFuel"];
    [dict setValue:@XKEY forKey:@"X-API-KEY"];

    [manager POST:@"http://culinkservices.com/api/example/signup/" parameters:dict
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
            self.selectedValueStr = @"LEASED LINE";
            [self createActionSheetWithBtnTag:match];
            break;
            
        case 2:
            self.selectedValueStr = @"LEASED LINE";
            [self createActionSheetWithBtnTag:match];
            break;
            default:
            break;
    }
}


- (void)pickerDoneTapped
{
    switch (match)
    {
       
        case 1:
            fstInternetTF.text=self.selectedValueStr;
            break;
            
        case 2:
            secInternetTF.text=self.selectedValueStr;
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


#pragma mark - Picker Delegate & DataSource Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    NSLog(@"thePickerView tag >> %ld",(long)thePickerView.tag);
    
    switch (match) {
       
        case 1:
            return 2;
            break;
            
        case 2:
            return 2;
            break;

    
        default:
            return 0;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    switch (match) {
        
        case 1:
            return (row == 0)?@"LEASED LINE":@"BROADBAND";
            break;
            
        case 2:
            return (row == 0)?@"LEASED LINE":@"BROADBAND";
            break;
            
        default:
            return 0;
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row  inComponent:(NSInteger)component
{
    
    switch (match)
    {

        case 1:
            self.selectedValueStr=(row == 0)?@"LEASED LINE":@"BROADBAND";
            break;
            
        case 2:
            self.selectedValueStr=(row == 0)?@"LEASED LINE":@"BROADBAND";
            break;
            
            
               default:
            break;
    }

}

- (IBAction)radioBtnAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
   NSLog(@"%d", (int)[button tag]);
    
    int radioBtn=(int)[button tag];

    if (radioBtn==0)
    {
        powerView.hidden=NO;
        
        _backupYes.selected=YES;
        _backupNO.selected=NO;
    }
    if (radioBtn==1)
    {
        powerView.hidden=YES;

        _backupYes.selected=NO;
        _backupNO.selected=YES;
    }
    
    if (radioBtn==2)
    {
        gensetView.hidden=NO;
        _genSetYes.selected=YES;
        _genSetNO.selected=NO;
    }
    if (radioBtn==3)
    {
        gensetView.hidden=YES;
        _genSetYes.selected=NO;
        _genSetNO.selected=YES;
    }
    if (radioBtn==4)
    {
        systemView.hidden=NO;
        _systemYes.selected=YES;
        _systemNO.selected=NO;
    }
    if (radioBtn==5)
    {
        systemView.hidden=YES;
        _systemYes.selected=NO;
        _systemNO.selected=YES;
        
    }
    if (radioBtn==6)
    {
        printerView.hidden=NO;
        
        _printerYes.selected=YES;
        _printerNo.selected=NO;
    }
    if (radioBtn==7)
    {
        printerView.hidden=YES;
        _printerYes.selected=NO;
        _printerNo.selected=YES;
        
    }
    if (radioBtn==8)
    {
        cctvView.hidden=NO;
        _ccYes.selected=YES;
         _ccNo.selected=NO;
    }
    if (radioBtn==9)
    {
        cctvView.hidden=YES;
        _ccYes.selected=NO;
        _ccNo.selected=YES;
    }
    
    if (radioBtn==10)
    {
        acView.hidden=NO;
        _acYes.selected=YES;
        _acNo.selected=NO;
    }
    if (radioBtn==11)
    {
        acView.hidden=YES;
        _acYes.selected=NO;
        _acNo.selected=YES;
        
    }
}
- (IBAction)cameraBtnAction:(id)sender
{
    
    UIButton *button = (UIButton *)sender;
    NSLog(@"%d", (int)[button tag]);
    
    camMatch=(int)[button tag];
    
    
    if (camMatch==1)
    {
        
        UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"choose" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Gallery",nil];
        
        popupQuery.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        [popupQuery setTag:10];
        [popupQuery showInView:self.view];

        
    }
    if (camMatch==2)
    {
        
        UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"choose" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Gallery",nil];
        
        popupQuery.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        [popupQuery setTag:10];
        [popupQuery showInView:self.view];
    }
    if (camMatch==3)
    {
        
        UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"choose" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Gallery",nil];
        
        popupQuery.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        [popupQuery setTag:10];
        [popupQuery showInView:self.view];
    }
    
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if ([actionSheet tag]==10)
    {
        switch (buttonIndex)
        {
            case 0:
            {
                
                if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                {
                    UIImagePickerController* picker = [[UIImagePickerController alloc] init];
                    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    picker.delegate = self;
                    [self presentViewController:picker animated:YES completion:NULL];
                }
                

                
            }
                break;
                
            case 1:
            {
                
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.allowsImageEditing = YES;
                
                if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeSavedPhotosAlbum])
                    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                
                [self presentViewController:imagePicker animated:YES completion:nil];
            }
           
                break;
            default:
                break;
        }
    }
}

- (void)imagePickerController:(UIImagePickerController *)imagePicker
        didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
   
    
    if (camMatch==1)
    {
         NSString *documentName = [NSString stringWithFormat:@"%@/regImage1.png", [AppDelegate appDelegate].applicationDocumentsDirectory];
        _image1.image=image;
       
        NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(image)];
        [imageData writeToFile:documentName atomically:YES];
        
        [imagePicker dismissViewControllerAnimated:YES completion:nil];
    }
    
    if (camMatch==2)
    {
         NSString *documentName = [NSString stringWithFormat:@"%@/regImage2.png", [AppDelegate appDelegate].applicationDocumentsDirectory];
        _image2.image=image;
        
        NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(image)];
        [imageData writeToFile:documentName atomically:YES];
        
        [imagePicker dismissViewControllerAnimated:YES completion:nil];
    }
    
    if (camMatch==3)
    {
         NSString *documentName = [NSString stringWithFormat:@"%@/regImage3.png", [AppDelegate appDelegate].applicationDocumentsDirectory];
        _image3.image=image;
        
        NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(image)];
        [imageData writeToFile:documentName atomically:YES];
        
        [imagePicker dismissViewControllerAnimated:YES completion:nil];
    }
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)imagePicker
{
    
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
}

@end
