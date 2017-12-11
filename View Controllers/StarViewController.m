//
//  StarViewController.m
//  CuLinks
//
//  Created by DILIP KUMAR on 27/11/17.
//  Copyright © 2017 CuLinks. All rights reserved.
//

#import "StarViewController.h"
#import "AppDelegate.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
@interface StarViewController ()

@end

@implementation StarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
      [menuBtn addTarget:self.viewDeckController action:@selector(toggleLeftView) forControlEvents:UIControlEventTouchUpInside];
    [self getCounterRequestWS];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.viewDeckController setLeftLedge:70];
    
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
             
            
             [AppDelegate appDelegate].rating=[NSString stringWithFormat:@"%@",[[responseObject valueForKey:@"data"] valueForKey:@"ratting"]];
             
             
             
             
             if ([[AppDelegate appDelegate].rating isEqualToString:@"1"])
             {
                 _star1.selected=YES;
             }
             
             if ([[AppDelegate appDelegate].rating isEqualToString:@"2"])
             {
                 _star1.selected=YES;
                 _star2.selected=YES;
                 
             }
             
             if ([[AppDelegate appDelegate].rating isEqualToString:@"3"])
             {
                 _star1.selected=YES;
                 _star2.selected=YES;
                 
                 _star3.selected=YES;
                 
             }
             if ([[AppDelegate appDelegate].rating isEqualToString:@"4"])
             {
                 _star1.selected=YES;
                 _star2.selected=YES;
                 
                 _star3.selected=YES;
                 _star4.selected=YES;
                 
             }
             if ([[AppDelegate appDelegate].rating isEqualToString:@"5"])
             {
                 _star1.selected=YES;
                 _star2.selected=YES;
                 
                 _star3.selected=YES;
                 _star4.selected=YES;
                 _star5.selected=YES;
                 
             }
             

             
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
