//
//  HelpViewController.m
//  BestSelfiy
//
//  Created by Vaibhav Awasthi on 19/11/16.
//  Copyright © 2016 Vaibhav Awasthi. All rights reserved.
//

#import "How2UseViewController.h"
#import "IIViewDeckController.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "AppDelegate.h"
@interface How2UseViewController ()

@end

@implementation How2UseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _txtView.layer.borderWidth=1;
    _txtView.layer.cornerRadius=4;
    _txtView.layer.borderColor=[UIColor grayColor].CGColor;

    [self webService];
}

-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)webService
{
    [_activityView setHidden:NO];
    [_activityView startAnimating];

    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    [dict setValue:@XKEY forKey:@"X-API-KEY"];
    [manager POST:[NSString stringWithFormat:@"%sfaq/",URLBase] parameters:dict
constructingBodyWithBlock:^(id<AFMultipartFormData> formData)

     {
         
     }
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Response Object%@",[responseObject valueForKey:@"data"]);
         
         
         NSString *responseCode =[responseObject valueForKey:@"responseCode"];
         
         NSString *responseMsg =[responseObject valueForKey:@"message"];
         
         if ([responseCode isEqualToString:@"success"])
         {
             
             
             
         }
         
         
       
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
         
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please check internet connection" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
         [alert show];
         [_activityView setHidden:YES];

     }];

}
-(void)viewDidAppear:(BOOL)animated
{
    [self.viewDeckController closeLeftViewAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*if([[[[responseObject valueForKey:@"data"]objectAtIndex:0]valueForKey:@"status"]isEqualToString:@"true"])
{
    NSString *htmlString;
    if([_match isEqualToString:@"FAQ"])
    {
        htmlString = [[[[[responseObject valueForKey:@"data"]objectAtIndex:0]valueForKey:@"cms_pages"]objectAtIndex:3]valueForKey:@"cms_description"];
    }
    else if([_match isEqualToString:@"HELP"])
    {
        htmlString = [[[[[responseObject valueForKey:@"data"]objectAtIndex:0]valueForKey:@"cms_pages"]objectAtIndex:4]valueForKey:@"cms_description"];
    }
    else if([_match isEqualToString:@"ABOUT"])
    {
        htmlString = [[[[[responseObject valueForKey:@"data"]objectAtIndex:0]valueForKey:@"cms_pages"]objectAtIndex:2]valueForKey:@"cms_description"];
        
    }
    else if([_match isEqualToString:@"Terms"])
    {
        htmlString = [[[[[responseObject valueForKey:@"data"]objectAtIndex:0]valueForKey:@"cms_pages"]objectAtIndex:1]valueForKey:@"cms_description"];
        
    }
    else
    {
        htmlString = [[[[[responseObject valueForKey:@"data"]objectAtIndex:0]valueForKey:@"cms_pages"]objectAtIndex:0]valueForKey:@"cms_description"];
    }
    
    NSAttributedString *attributedString = [[NSAttributedString alloc]initWithData: [htmlString dataUsingEncoding:NSUnicodeStringEncoding]options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }documentAttributes: nil error: nil];
    _txtView.attributedText = attributedString;
    
}
else
{
    
    
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please try again" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
    [alertView show];
    
    
}
[_activityView setHidden:YES];*/


@end
