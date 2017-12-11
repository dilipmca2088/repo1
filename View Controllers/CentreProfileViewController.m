//
//  RegisterViewController.m
//  INDIA CME
//
//  Created by DILIP KUMAR on 17/05/17.
//  Copyright © 2017 Apple. All rights reserved.
//

#import "CentreProfileViewController.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "BankViewController.h"
#import "AddPhotoViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface CentreProfileViewController ()
{
        int p1;
        int i;

    NSString *common;
     NSMutableDictionary *aImageDic;
    NSMutableData *data;
    
    UIImage *image1 ;
    UIImage *image2 ;
    NSArray *array;
    NSMutableArray *images;
    NSMutableArray *imagesDocs;

    NSData *imageData1;
    NSString *p;
    NSString *s;
    NSString *d;
    NSString *checkAddress;
    NSString *checkSystem;

    

}
@property (nonatomic, strong) ALAssetsLibrary *specialLibrary;


@end

@implementation CentreProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _primaryImg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[AppDelegate appDelegate].primaryImg]]];
    
    _primaryImg.layer.cornerRadius=30.0f;
    _primaryImg.layer.borderWidth=1.0f;
    _primaryImg.clipsToBounds=YES;
   

    [menuBtn addTarget:self.viewDeckController action:@selector(toggleLeftView) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view from its nib.
    i=0;
    p=@"";
    s=@"";
    d=@"";
    checkAddress=@"";
    checkSystem=@"";

     self.scrollView.contentSize =CGSizeMake(320,1500);
    _specView.hidden=YES;
    activity.hidden=YES;
    
    _certImageView.hidden=YES;
    powerView.hidden=YES;
    gensetView.hidden=YES;
    systemView.hidden=YES;
    printerView.hidden=YES;
    cctvView.hidden=YES;
    acView.hidden=YES;
    fstIntSpeedTF.hidden=YES;
    secIntSpeedTF.hidden=YES;

    
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
    
    [noSysTF3 setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [processorTF3 setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [ramTF3 setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [hd3 setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    self.mainSpecArray=[NSMutableArray array];

    
    _regiterBtn.layer.cornerRadius=15.0f;
    _regiterBtn.layer.borderWidth=1.0f;
    _regiterBtn.clipsToBounds=YES;
    _regiterBtn.layer.borderColor=[[UIColor clearColor] CGColor];
    
    
    if ([[AppDelegate appDelegate] connected])
    {
        NSLog(@"yes");
        activity.hidden=NO;
        [activity startAnimating];
        [self getCenterRequestWS];
        
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
            NSArray *examArray =[responseObject valueForKey:@"data"];
             
             if (examArray.count==0)
             {
             }
             else
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
             
                 printerTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"printer"] objectAtIndex:0];
                 
             upspowerunitTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"powerunit"] objectAtIndex:0];
             
             upsbackupTimeTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"powertime"] objectAtIndex:0];
             
             genpowerunitTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"gensetpower"] objectAtIndex:0];
             
             genFuelChargeTF.text=[[[responseObject valueForKey:@"data"] valueForKey:@"gensetfuel"] objectAtIndex:0];
             
                 
                 NSString *sysNo =[[[responseObject valueForKey:@"data"] valueForKey:@"number"] objectAtIndex:0];
                 
                 
                  NSString *processor =[[[responseObject valueForKey:@"data"] valueForKey:@"processor"] objectAtIndex:0];
                 
                  NSString *ram =[[[responseObject valueForKey:@"data"] valueForKey:@"ram"] objectAtIndex:0];
                 
                 
                  NSString *hd =[[[responseObject valueForKey:@"data"] valueForKey:@"hd"] objectAtIndex:0];
                 
                 
                 NSArray *sysNoArr = [sysNo componentsSeparatedByString:@","];
                 
                 NSArray *processorArr = [processor componentsSeparatedByString:@","];
                 
                 NSArray *ramArr = [ram componentsSeparatedByString:@","];
                 
                 NSArray *hdArr = [hd componentsSeparatedByString:@","];
                 
                 
                 if([sysNoArr count]==3)
                 {
                    noSysTF1.text=[sysNoArr objectAtIndex:0];
                    noSysTF2.text=[sysNoArr objectAtIndex:1];
                    noSysTF3.text=[sysNoArr objectAtIndex:2];

                 }
                 
                 if([processorArr count]==3)
                 {
                     processorTF1.text=[processorArr objectAtIndex:0];
                     processorTF2.text=[processorArr objectAtIndex:1];
                     processorTF3.text=[processorArr objectAtIndex:2];
                     
                 }
                 
                 if([ramArr count]==3)
                 {
                     ramTF1.text=[ramArr objectAtIndex:0];
                     ramTF2.text=[ramArr objectAtIndex:1];
                     ramTF3.text=[ramArr objectAtIndex:2];
                     
                 }
                 
                 if([hdArr count]==3)
                 {
                     hd1.text=[hdArr objectAtIndex:0];
                     hd2.text=[hdArr objectAtIndex:1];
                     hd3.text=[hdArr objectAtIndex:2];
                     
                 }
                 

                 
                 if([sysNoArr count]==2)
                 {
                     noSysTF1.text=[sysNoArr objectAtIndex:0];
                     noSysTF2.text=[sysNoArr objectAtIndex:1];
                     
                 }
                 
                 if([processorArr count]==2)
                 {
                     processorTF1.text=[processorArr objectAtIndex:0];
                     processorTF2.text=[processorArr objectAtIndex:1];
                     
                 }
                 
                 if([ramArr count]==2)
                 {
                     ramTF1.text=[ramArr objectAtIndex:0];
                     ramTF2.text=[ramArr objectAtIndex:1];
                     
                 }
                 
                 if([hdArr count]==2)
                 {
                     hd1.text=[hdArr objectAtIndex:0];
                     hd2.text=[hdArr objectAtIndex:1];
                     
                 }
                 
                 if([sysNoArr count]==1)
                 {
                     noSysTF1.text=[sysNoArr objectAtIndex:0];
                     
                 }
                 
                 if([processorArr count]==1)
                 {
                     processorTF1.text=[processorArr objectAtIndex:0];
                     
                 }
                 
                 if([ramArr count]==1)
                 {
                     ramTF1.text=[ramArr objectAtIndex:0];
                     
                 }
                 
                 if([hdArr count]==1)
                 {
                     hd1.text=[hdArr objectAtIndex:0];
                     
                 }

             
         }
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
-(void)viewDidAppear:(BOOL)animated
{
    
    [self.viewDeckController closeLeftViewAnimated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.viewDeckController setLeftLedge:70];

     aImageDic =[[NSMutableDictionary alloc] init];
    _finalImageArray=[[NSMutableArray alloc] init];


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
    inchargeContTF.inputAccessoryView = numberToolbar;
    itPersonContactTF.inputAccessoryView = numberToolbar;
    itPersonContactTF.inputAccessoryView = numberToolbar;

   
}

-(void)cancelNumberPad
{
    [inchargeContTF resignFirstResponder];
    [itPersonContactTF resignFirstResponder];
    [itPersonContactTF resignFirstResponder];
    
    
}

-(void)doneWithNumberPad
{
    
    [inchargeContTF resignFirstResponder];
    [itPersonContactTF resignFirstResponder];
    [itPersonContactTF resignFirstResponder];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    
    if (textField==itPersonContactTF||textField==inchargeContTF)
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

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==noSysTF1||textField==processorTF1||textField==ramTF1||textField==hd1||textField==noSysTF2||textField==processorTF2||textField==ramTF2||textField==hd2||textField==noSysTF3||textField==processorTF3||textField==ramTF3||textField==hd3)
    {
        
        self.scrollView.contentSize =CGSizeMake(320,1850);
        
    }
    
    else
    {
        
        
    }

    
    if (textField==cityTF||textField==centreNameTF||textField==addressTF||textField==inchargeTF||textField==inchargeContTF||textField==inchargeEmailTF||textField==itPersonNameTF||textField==itPersonContactTF||textField==systemAvailTF||textField==processorTF||textField==hdTF||textField==hdTF)
    {
        
        
        [_submitBtn setTitle:@"Submit to admin for updating" forState:UIControlStateNormal];
        _submitBtn.frame =CGRectMake(40, 530, 250, 30);
        
    }

    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField==noSysTF1||textField==processorTF1||textField==ramTF1||textField==hd1||textField==noSysTF2||textField==processorTF2||textField==ramTF2||textField==hd2||textField==noSysTF3||textField==processorTF3||textField==ramTF3||textField==hd3)
    {
        
        self.scrollView.contentSize =CGSizeMake(320,1700);
        
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
    
    if([cityTF.text isEqualToString:@""])
    {
        message = @"Please enter city!";
    }
    
    else if([centreNameTF.text isEqualToString:@""])
    {
        message = @"Please enter centre name!";
    }
    else if([addressTF.text isEqualToString:@""])
    {
        message = @"Please enter address!";
    }
    
//    else if([checkAddress isEqualToString:@""])
//    {
//        message = @"Please accept terms and conditions!";
//    }
    
    if (!message)
    {
        if ([[AppDelegate appDelegate] connected])
        {
            NSLog(@"yes");
            activity.hidden=NO;
            [activity startAnimating];
            [self updateCentreDetailWS];
            
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
-(void)updateCentreDetailWS
{
    activity.hidden=NO;
    [activity startAnimating];
    
    if ([p isEqualToString:@"T"])
    {
        
        
        NSString *image1 = [[NSString alloc] initWithFormat:@"%@/image1.png", [AppDelegate appDelegate].applicationDocumentsDirectory];
        imageData1 = [NSData dataWithContentsOfFile:image1];

       
    }

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
    [dict setValue:processorTF.text forKey:@"Firstprocessor"];
    [dict setValue:ramTF.text forKey:@"Firstram"];
    [dict setValue:hdTF.text forKey:@"Firsthd"];
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
    
    if ([checkSystem isEqualToString:@"T"])
    {
        
        [dict setValue:@"" forKey:@"SystemNo"];
        [dict setValue:@"" forKey:@"Processor"];
        [dict setValue:@"" forKey:@"Ram"];
        [dict setValue:@"" forKey:@"Hd"];
    }
    else
    {
        
        NSString *sytemNo =[NSString stringWithFormat:@"%@,%@,%@",noSysTF1.text,noSysTF2.text,noSysTF3.text];
        
        NSString *processorNo =[NSString stringWithFormat:@"%@,%@,%@",processorTF1.text,processorTF2.text,processorTF3.text];
        
        NSString *ramNo =[NSString stringWithFormat:@"%@,%@,%@",ramTF1.text,ramTF2.text,ramTF3.text];
        
        NSString *hdNo =[NSString stringWithFormat:@"%@,%@,%@",hd1.text,hd2.text,hd3.text];
        
        
        [dict setValue:sytemNo forKey:@"SystemNo"];
        [dict setValue:processorNo forKey:@"Processor"];
        [dict setValue:ramNo forKey:@"Ram"];
        [dict setValue:hdNo forKey:@"Hd"];
        
    }
    

    if ([p isEqualToString:@""])
    {
        [dict setValue:@"" forKey:@"primaryimg"];
    }
    
    if ([s isEqualToString:@""])
    {
        [dict setValue:@"" forKey:@"secondaryimg[]"];
    }
    
    if ([d isEqualToString:@""])
    {
        [dict setValue:@"" forKey:@"document[]"];
    }
    
//    if ([checkAddress isEqualToString:@"T"])
//    {
//        [dict setValue:@"yes" forKey:@"Term"];
//    }
    
    [manager POST:@"http://culinkservices.com/api/example/updatecenterdetailed/" parameters:dict
constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         
       if ([p isEqualToString:@"T"])
         {
            
       [formData appendPartWithFileData:imageData1 name:@"primaryimg" fileName:@"NewImage.jpg" mimeType:@"image/jpeg"];
             
         }
    
        if ([s isEqualToString:@"T"])
         {
             int m = 0;
             for(UIImage *eachImage in images)
             {
                 NSData *imageData = UIImageJPEGRepresentation(eachImage,0.5);
                 
                 [formData appendPartWithFileData:imageData name:@"secondaryimg[]" fileName:[NSString stringWithFormat:@"file%d.jpg",m] mimeType:@"image/jpeg"];
                 m++;
             }

             
         }
        if ([d isEqualToString:@"T"])
         {
             
             int m = 0;
             for(UIImage *eachImage in imagesDocs)
             {
                 NSData *imageData = UIImageJPEGRepresentation(eachImage,0.5);
                 
                 [formData appendPartWithFileData:imageData name:@"document[]" fileName:[NSString stringWithFormat:@"file%d.jpg",m] mimeType:@"image/jpeg"];
                 m++;
             }

         }
         
     } success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         [activity stopAnimating];
         activity.hidden=YES;
         NSLog(@"Response Object%@",responseObject);

         NSString *responseCode =[responseObject valueForKey:@"responseCode"];
         
         if ([responseCode isEqualToString:@"success"])
         {
             BankViewController *loginvc =[[BankViewController alloc] initWithNibName:@"BankViewController" bundle:nil];
             
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
        upspowerunitTF.text=@"";
        upsbackupTimeTF.text=@"";
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
        genpowerunitTF.text=@"";
        genFuelChargeTF.text=@"";
    }
    if (radioBtn==4)
    {
        self.scrollView.contentSize =CGSizeMake(320,1700);
       // termsView.frame=CGRectMake(9,1640,307,53);
        
        systemView.hidden=NO;
        _systemYes.selected=YES;
        _systemNO.selected=NO;
        
    }
    if (radioBtn==5)
    {
       // termsView.frame=CGRectMake(42,1490,240,70);
        self.scrollView.contentSize =CGSizeMake(320,1500);
        
        systemView.hidden=YES;
        _systemYes.selected=NO;
        _systemNO.selected=YES;
        checkSystem=@"T";
        
        
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
        printerTF.text=@"";
        
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
        cctvTF.text=@"";
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
        acTF.text=@"";
    }
    
    if (radioBtn==12)
    {
        fstIntSpeedTF.hidden=NO;
        _fisYes.selected=YES;
        _fisNo.selected=NO;
    }
    if (radioBtn==13)
    {
        fstIntSpeedTF.hidden=YES;
        _fisYes.selected=NO;
        _fisNo.selected=YES;
        fstIntSpeedTF.text=@"";
    }
    
    if (radioBtn==14)
    {
        secIntSpeedTF.hidden=NO;
        _secYes.selected=YES;
        _secNo.selected=NO;
    }
    if (radioBtn==15)
    {
        secIntSpeedTF.hidden=YES;
        _secYes.selected=NO;
        _secNo.selected=YES;
        secIntSpeedTF.text=@"";
    }

}
- (IBAction)cameraBtnAction:(id)sender
{
    
    UIButton *button = (UIButton *)sender;
    NSLog(@"%d", (int)[button tag]);
    
    camMatch=(int)[button tag];
    
    
    if (camMatch==1)
    {
        p=@"T";
        
        UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"choose" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Gallery",nil];
        
        popupQuery.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        [popupQuery setTag:10];
        [popupQuery showInView:self.view];

        
    }
    if (camMatch==2)
    {
        s=@"T";
        [self launchController];
        
    }
    if (camMatch==3)
    {
        d=@"T";

       [self launchController];
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
         NSString *documentName = [NSString stringWithFormat:@"%@/image1.png", [AppDelegate appDelegate].applicationDocumentsDirectory];
        _image1.image=image;
       
            
            _primImgLbl.text =[NSString stringWithFormat:@"%@ File Selected", @"1"];
       
        NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(image)];
        [imageData writeToFile:documentName atomically:YES];
        
        [imagePicker dismissViewControllerAnimated:YES completion:nil];
    }
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)imagePicker
{
    
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
}



//Using generated synthesizers

- (IBAction)launchController
{
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    
    elcPicker.maximumImagesCount = 100; //Set the maximum number of images to select to 100
    elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
    elcPicker.onOrder = YES; //For multiple image selection, display and return order of selected images
    elcPicker.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie]; //Supports image and movie types
    
    elcPicker.imagePickerDelegate = self;
    
    [self presentViewController:elcPicker animated:YES completion:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return YES;
    } else
    {
        return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
    }
}

#pragma mark ELCImagePickerControllerDelegate Methods

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (camMatch==2)
    {
        images = [NSMutableArray arrayWithCapacity:[info count]];
        
    }
    
    if (camMatch==3)
    {
        imagesDocs = [NSMutableArray arrayWithCapacity:[info count]];
        
    }
    
    
    for (NSDictionary *dict in info)
    {
        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto)
        {
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                               [imagesDocs addObject:image];
                
                if (camMatch==2)
                {
                    
                    [images addObject:image];

                    NSLog(@"new ARRAY count is%lu",(unsigned long)[images count]);
                    
                    _secImgLbl.text =[NSString stringWithFormat:@"%@ File Selected", @(images.count)];
                }
                
                if (camMatch==3)
                {
                    
                    NSLog(@"new ARRAY count is%lu",(unsigned long)[imagesDocs count]);
                    
                    _docImgLbl.text =[NSString stringWithFormat:@"%@ File Selected", @(imagesDocs.count)];
                }
               
            } else
            {
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        }
        else if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypeVideo)
        {
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                              
                if (camMatch==2)
                {
                    [images addObject:image];

                    NSLog(@"new ARRAY count is%lu",(unsigned long)[images count]);
                    
                    _secImgLbl.text =[NSString stringWithFormat:@"%@ File Selected", @(images.count)];
                }
                
                if (camMatch==3)
                {
                    [imagesDocs addObject:image];

                    NSLog(@"new ARRAY count is%lu",(unsigned long)[imagesDocs count]);
                    
                    _docImgLbl.text =[NSString stringWithFormat:@"%@ File Selected", @(imagesDocs.count)];
                }

              
            } else {
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        } else {
            NSLog(@"Uknown asset type");
        }
    }
    
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)checkBtnAction:(id)sender;
{
    if ([checkAddress isEqualToString:@""])
    {
        _checkBtn.selected=YES;
        checkAddress=@"T";
    }
    else
    {
        _checkBtn.selected=NO;
        checkAddress=@"";
    }
    
}


- (IBAction)backBtnAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
