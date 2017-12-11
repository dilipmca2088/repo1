//
//  FinalFormViewController.m
//  CuLinks
//
//  Created by DILIP KUMAR on 27/11/17.
//  Copyright © 2017 CuLinks. All rights reserved.
//

#import "FinalFormViewController.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "AppDelegate.h"

@interface FinalFormViewController ()
{
    UITextField *text;
    
    int count;
    UIImageView *signImg;

}

@end

@implementation FinalFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.signImgView.image=_signImg;
    _titleLbl.text=_mainTitle;
    _centreName.text=[AppDelegate appDelegate].welcomeStr;
    _formId.text=[NSString stringWithFormat:@"(%@)",[AppDelegate appDelegate].formId];
    
    _dateLbl.text=[AppDelegate appDelegate].createdDate;


    count=20;
    
    NSLog(@"_newdataDict%@",_newdataDict);
    NSLog(@"_newdataArray%@",_newdataArray);

    UIScrollView *scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(10, 80, 300, 400)];
    scrollview.showsVerticalScrollIndicator=YES;
    scrollview.scrollEnabled=YES;
    scrollview.userInteractionEnabled=YES;
    scrollview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollview];
    
    scrollview.contentSize= CGSizeMake(280 ,500);//(width,height)
    
    for (int i=0; i<=[_newdataArray count]-1; i++)
    {
        CGRect someRect = CGRectMake(130.0, count, 300.0, 30.0);
        
        
        
        UILabel* vallabel = [[UILabel alloc] initWithFrame:someRect];
        vallabel.text=[_valueArr objectAtIndex:i];
        [vallabel setFont:[UIFont fontWithName:@"Arial" size:16]];
        [vallabel setTextAlignment:NSTextAlignmentLeft];
        [vallabel setTextColor:[UIColor redColor]];
        [scrollview addSubview:vallabel];
        
         CGRect someRect1 = CGRectMake(20.0, count, 260.0, 30.0);
        UILabel* label = [[UILabel alloc] initWithFrame:someRect1];
        label.text=[_newdataArray objectAtIndex:i];
        [label setFont:[UIFont fontWithName:@"Arial" size:16]];
        [label setTextColor:[UIColor darkGrayColor]];
        [scrollview addSubview:label];
        
        
        CGRect someRect12 = CGRectMake(20.0, count+20, 260.0, 30.0);
        UILabel* label1 = [[UILabel alloc] initWithFrame:someRect12];
        [label1 setFont:[UIFont fontWithName:@"Arial" size:12]];
        label1.text=[NSString stringWithFormat:@"(%@)",[_newdataArray objectAtIndex:i]];
        [label1 setTextColor:[UIColor lightGrayColor]];
        [scrollview addSubview:label1];
        
        
        UIImageView *dotImg =[[UIImageView alloc] initWithFrame:CGRectMake(4,count+10,12,12)];
        dotImg.image=[UIImage imageNamed:@"blackForm.png"];
        [scrollview addSubview:dotImg];
        
        
        count= count+50;
        
    }
    signImg =[[UIImageView alloc] initWithFrame:CGRectMake(130,count-50,200,100)];
    signImg.image=_signImg;
    [scrollview addSubview:signImg];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)submitSignWS
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:_newdataDict];
    
    [dict setValue:[AppDelegate appDelegate].venderId forKey:@"vendor_id"];
    [dict setValue:@XKEY forKey:@"X-API-KEY"];
    [manager POST:[NSString stringWithFormat:@"%sform_submit/",URLBase] parameters:dict
constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     
     {
         NSData *imageData = UIImageJPEGRepresentation(signImg.image,0.5);
         
         [formData appendPartWithFileData:imageData name:@"signatureImg" fileName:@"NewImage.png" mimeType:@"image/png"];
         
     } success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         NSLog(@"Response Object%@",responseObject);
         
         NSString *responseCode =[responseObject valueForKey:@"responseCode"];
         
         NSString *responseMsg =[responseObject valueForKey:@"message"];
         
         if ([responseCode isEqualToString:@"success"])
         {
             
             [self getSignatureFormWS];
         }
         
         else
         {
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:responseMsg
                                                            delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil];
             [alert show];
             
         }
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
         NSLog(@"Error: %@", error);
         
     }];
    
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
         
         NSString *responseMsg =[responseObject valueForKey:@"message"];
         
         if ([responseCode isEqualToString:@"success"])
         {
              [AppDelegate appDelegate].checkForm=@"T";
             [[AppDelegate appDelegate] showSideMenu];
            
             
         }
         else
         {
             [AppDelegate appDelegate].checkForm=@"F";
             [[AppDelegate appDelegate] showSideMenu];
             
         }
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
         
     }];
    
}

- (IBAction)proceedBtnAction:(id)sender
{
    [self submitSignWS];

}
@end
