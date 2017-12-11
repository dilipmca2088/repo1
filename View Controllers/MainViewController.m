//
//  UpdateDetailsViewController.m
//  INDIA CME
//
//  Created by DILIP KUMAR on 11/06/17.
//  Copyright © 2017 Apple. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import "ExamRequesViewController.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "PaymentViewController.h"
#import "ChatViewController.h"
#import "CaptureSignatureViewController.h"
#import "ViewController.h"
#import "LoginViewController.h"
#import "CentreProfileViewController.h"
#import "NewUpdateViewController.h"

@interface MainViewController ()
{
    
 int index;
 int count;
    UITextField* text;
    NSArray *fieldsArr;
    NSArray *descArr;
    NSArray *fieldsTypeArr;

    NSMutableArray *valueArr;
    NSMutableDictionary *myDict;

}
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
    
    _reqCounterLbl.layer.cornerRadius=10.0f;
   // _reqCounterLbl.layer.borderWidth=1.0f;
    _reqCounterLbl.clipsToBounds=YES;
    
    _approveCounterLbl.layer.cornerRadius=10.0f;
//_approveCounterLbl.layer.borderWidth=1.0f;
    _approveCounterLbl.clipsToBounds=YES;
    
    _eventCountLbl.layer.cornerRadius=10.0f;
   // _eventCountLbl.layer.borderWidth=1.0f;
    _eventCountLbl.clipsToBounds=YES;
    
    _paymentCountLbl.layer.cornerRadius=10.0f;
   // _paymentCountLbl.layer.borderWidth=1.0f;
    _paymentCountLbl.clipsToBounds=YES;

    
    _welcomeLbl.text =[NSString stringWithFormat:@"Welcome %@",[AppDelegate appDelegate].welcomeStr];
    
    if ([[AppDelegate appDelegate].checkForm isEqualToString:@"T"])
    {
        [_signFieldsView setHidden:NO];
        [_welcomeView setHidden:YES];

    }
    
   else if ([[AppDelegate appDelegate].checkForm isEqualToString:@"F"])
    {
        [_signFieldsView setHidden:YES];
        [_welcomeView setHidden:NO];
        
    }
    else
    {
        [_signFieldsView setHidden:YES];
        [_welcomeView setHidden:YES];

    }
    
    count=20;
    
    [menuBtn addTarget:self.viewDeckController action:@selector(toggleLeftView) forControlEvents:UIControlEventTouchUpInside];
    [self getSignatureFormWS];

}
-(void)viewDidAppear:(BOOL)animated
{
    
 [self.navigationController setNavigationBarHidden:YES];
    
 [self.viewDeckController closeLeftViewAnimated:YES];
   
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.viewDeckController setLeftLedge:70];
    
    
    if ([[AppDelegate appDelegate] connected])
    {
        NSLog(@"yes");
        
        valueArr=[[NSMutableArray alloc] init];
        myDict=[[NSMutableDictionary alloc] init];
        fieldsArr=[[NSArray alloc] init];
        descArr=[[NSArray alloc] init];
        fieldsTypeArr=[[NSArray alloc] init];

        [self getCounterRequestWS];
       
    }
    else
    {
        NSLog(@"no");
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please Check your Internet Connection" delegate:nil cancelButtonTitle:@"OK"
        otherButtonTitles:nil];
        [alert show];
        
    }
}

-(void)getSignatureFormWS
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:[AppDelegate appDelegate].venderId forKey:@"Id"];
    [dict setValue:@XKEY forKey:@"X-API-KEY"];
    [manager POST:[NSString stringWithFormat:@"%sget_online_form/",URLBase] parameters:dict
constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     
     {
         
     } success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         NSLog(@"Response Object%@",responseObject);
         
         NSString *responseCode =[responseObject valueForKey:@"responseCode"];
         // NSString *responseMsg =[responseObject valueForKey:@"message"];
         
         if ([responseCode isEqualToString:@"success"])
         {
             
             NSArray *countArray =[responseObject valueForKey:@"data"];
             
             if (countArray.count==0)
             {
             }
             else
             {
                 

             
             
              _titleLbl.text =[[responseObject valueForKey:@"data"] valueForKey:@"title"];
             
             fieldsArr =[[responseObject valueForKey:@"data"] valueForKey:@"subject"];
             
               fieldsTypeArr =[[responseObject valueForKey:@"data"] valueForKey:@"type"];
             
             descArr =[[responseObject valueForKey:@"data"] valueForKey:@"desc"] ;
             
             [AppDelegate appDelegate].formId =[[responseObject valueForKey:@"data"] valueForKey:@"id"];
                 
            [AppDelegate appDelegate].createdDate =[[responseObject valueForKey:@"data"] valueForKey:@"create_date"];
             
             NSLog(@"%@",fieldsArr);
             
             UIScrollView *scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(10, 50, 300, 330)];
             scrollview.showsVerticalScrollIndicator=YES;
             scrollview.scrollEnabled=YES;
             scrollview.userInteractionEnabled=YES;
             scrollview.backgroundColor = [UIColor clearColor];
             [_signFieldsView addSubview:scrollview];
            
             scrollview.contentSize= CGSizeMake(280 ,500);//(width,height)
             
              for (int i=0; i<=[fieldsArr count]-1; i++)
             {
                 CGRect someRect = CGRectMake(130.0, count, 150.0, 30.0);
                  text = [[UITextField alloc] initWithFrame:someRect];
                  text.tag=i;
                  text.delegate=self;
                 [text setTextColor:[UIColor blueColor]];
                 [text setBorderStyle:UITextBorderStyleRoundedRect];
                 
                 text.layer.cornerRadius=1.0f;
                 text.layer.masksToBounds=YES;
                 text.layer.borderColor =[[UIColor redColor] CGColor];
                 text.layer.borderWidth= 2.50f;
                 [scrollview addSubview:text];
                 
                 
                 CGRect someRect1 = CGRectMake(20.0, count, 260.0, 30.0);
                 UILabel* label = [[UILabel alloc] initWithFrame:someRect1];
                 label.text=[fieldsArr objectAtIndex:i];
                  [label setFont:[UIFont fontWithName:@"Arial" size:16]];
                 [label setTextColor:[UIColor whiteColor]];
                 [scrollview addSubview:label];
                 
                 
                 CGRect someRect12 = CGRectMake(20.0, count+20, 260.0, 30.0);
                 UILabel* label1 = [[UILabel alloc] initWithFrame:someRect12];
                 [label1 setFont:[UIFont fontWithName:@"Arial" size:12]];
                 label1.text=[NSString stringWithFormat:@"(%@)",[descArr objectAtIndex:i]];
                 [label1 setTextColor:[UIColor whiteColor]];
                 [scrollview addSubview:label1];
                 
             UIImageView *signImg =[[UIImageView alloc] initWithFrame:CGRectMake(4,count+10,10,10)];
                 signImg.image=[UIImage imageNamed:@"whiteForm.png"];
                 [scrollview addSubview:signImg];
                 
                 count= count+50;
             }

         }
         }
         else
         {
             [AppDelegate appDelegate].checkForm=@"F";
             
             
         }
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
         
     }];
    
}

-(void)getCounterRequestWS
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:[AppDelegate appDelegate].venderId forKey:@"vend_id"];
    [dict setValue:@XKEY forKey:@"X-API-KEY"];
    [manager POST:[NSString stringWithFormat:@"%scounter/",URLBase] parameters:dict
constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
         
         {
             
         } success:^(AFHTTPRequestOperation *operation, id responseObject)
         
         {
             NSLog(@"Response Object%@",responseObject);
             
             NSString *responseCode =[responseObject valueForKey:@"responseCode"];
             
            
             
             if ([responseCode isEqualToString:@"success"])
             {
                 
                 
                 
    _reqCounterLbl.text=[NSString stringWithFormat:@"%@",[[responseObject valueForKey:@"data"] valueForKey:@"examrequest"]];
                 
    _approveCounterLbl.text=[NSString stringWithFormat:@"%@",[[responseObject valueForKey:@"data"] valueForKey:@"examapprove"]];
                 
    _msgCountLbl.text=[NSString stringWithFormat:@"%@",[[responseObject valueForKey:@"data"] valueForKey:@"message"]];
                 
                //[AppDelegate appDelegate].rating=[NSString stringWithFormat:@"%@",[[responseObject valueForKey:@"data"] valueForKey:@"ratting"]];
                 
                 }
             
             else
             {
                 
                 
             }
             
             
         }
              failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"Error: %@", error);
            
         }];
        
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)examRequestBtn:(id)sender
{

    ExamRequesViewController *loginvc =[[ExamRequesViewController alloc] initWithNibName:@"ExamRequesViewController" bundle:nil];
    
    [self presentViewController:loginvc animated:YES completion:nil];
    
}

- (IBAction)examSheduleBtnAction:(id)sender
{
    ExamRequesViewController *loginvc =[[ExamRequesViewController alloc] initWithNibName:@"ExamRequesViewController" bundle:nil];
      [loginvc setFromHome:@"T"];
    [self presentViewController:loginvc animated:YES completion:nil];
}

- (IBAction)compleEventBtn:(id)sender
{
    
}

- (IBAction)viewPaymentBtn:(id)sender
{
    
    PaymentViewController *loginvc =[[PaymentViewController alloc] initWithNibName:@"PaymentViewController" bundle:nil];
    [self presentViewController:loginvc animated:YES completion:nil];
}
- (IBAction)msgCounterBtn:(id)sender
{
    ChatViewController *chatView =[[ChatViewController alloc]initWithNibName:@"ChatViewController" bundle:nil];
    [chatView setFromHome:@"C"];
    
     [self presentViewController:chatView animated:YES completion:nil];
}
- (IBAction)openFormBtnAction:(id)sender
{
    if ([[AppDelegate appDelegate].checkForm isEqualToString:@"F"])
    {
        [_welcomeView setHidden:NO];
 
    }
    else
    {
    [_signFieldsView setHidden:NO];
    }
}

- (IBAction)closeFormBtnAction:(id)sender
{
    [_signFieldsView setHidden:YES];
}

- (IBAction)submitBtnAction:(id)sender
{
    if (valueArr.count==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter all fields"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        

    }
    else
    {
    for (int i=0; i<[fieldsArr count]; i++)
    {
        NSLog(@"valueArr%@",valueArr);
        NSLog(@"fieldsArr%@",fieldsArr);
        
        [myDict setValue:[valueArr objectAtIndex:i] forKey:[fieldsArr objectAtIndex:i]];
        
        NSLog(@"MyDict%@",myDict);
        
    }
        
    [myDict setValue:[AppDelegate appDelegate].formId forKey:@"formid"];
    
    CaptureSignatureViewController *capVC =[[CaptureSignatureViewController alloc] initWithNibName:@"CaptureSignatureViewController" bundle:nil];
        [capVC setDataDict:myDict];
        [capVC setFormFieldsArr:fieldsArr];
        [capVC setExamTitle:_titleLbl.text];
        [capVC setDataValArr:valueArr];

    [self.navigationController pushViewController:capVC animated:YES];
        
    }
    
}

- (IBAction)editBtnTpd:(id)sender
{
    
    CentreProfileViewController *nearView =[[CentreProfileViewController alloc]initWithNibName:@"CentreProfileViewController" bundle:nil];    
    [self presentViewController:nearView animated:YES completion:nil];
}

- (IBAction)how2UseBtn:(id)sender
{
    NewUpdateViewController *nearView =[[NewUpdateViewController alloc]initWithNibName:@"NewUpdateViewController" bundle:nil];
    
    [self presentViewController:nearView animated:YES completion:nil];
    
}

- (IBAction)logoutBtn:(id)sender
{
    [AppDelegate appDelegate].checkForm=@"";
    LoginViewController *nearView =[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    
    [self presentViewController:nearView animated:YES completion:nil];
   // [self.viewDeckController rightViewPushViewControllerOverCenterController:nearView];
}

- (IBAction)homeBtn:(id)sender
{
    //[[AppDelegate appDelegate] showSideMenu];
    [_welcomeView setHidden:YES];
    [_signFieldsView setHidden:YES];


}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    int index = textField.tag;
    // Now save text using that index
    NSLog(@"Dic: %@",textField.text);
    [valueArr addObject:textField.text];
    NSLog(@"valueArr: %@",valueArr);

}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    /*for (int i=0; i<=[fieldsTypeArr count]-1; i++)
    {
        if ([[fieldsTypeArr objectAtIndex:i] isEqualToString:@"number"])
        {
             [textField setKeyboardType:UIKeyboardTypeNumberPad];
        }
        
        if ([[fieldsTypeArr objectAtIndex:i] isEqualToString:@"text"])
        {
            [textField setKeyboardType:UIKeyboardTypeDefault];

        }
}*/
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [textField reloadInputViews];
    [textField resignFirstResponder];
    return YES;
    
}
@end
