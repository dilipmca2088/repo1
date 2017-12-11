//
//  NewUpdateViewController.m
//  IMA FARIDABAD
//
//  Created by DILIP KUMAR on 21/10/17.
//  Copyright © 2017 CuLinks. All rights reserved.
//

#import "NewUpdateViewController.h"
#import "AppDelegate.h"
#import "NewUpdateViewCell.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"

@interface NewUpdateViewController ()

@end

@implementation NewUpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [activity startAnimating];
    [self getDoctorsListWS];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getDoctorsListWS
{
  
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
         NSLog(@"Response Object%@",responseObject);
         
         
         //NSString *responseCode =[responseObject valueForKey:@"responseCode"];
         
        // NSString *responseMsg =[responseObject valueForKey:@"message"];
//         
//         if ([responseCode isEqualToString:@"success"])
//         {
//             
//             
//             
//         }
         
         _updateArray =[[responseObject valueForKey:@"data"] valueForKey:@"faq"];
         _updateListTableView.delegate=self;
         _updateListTableView.dataSource=self;
         
         [_updateListTableView reloadData];
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
         
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please check internet connection" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
         [alert show];
         
     }];
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_updateArray count];
    //return 5;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellIdentifier = @"Cell";
    
    NewUpdateViewCell *cell = (NewUpdateViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier] ;
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NewUpdateViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSDictionary *dict=[_updateArray objectAtIndex:indexPath.row];
    cell.titleLbl.text =[dict valueForKey:@"title"] ;
    
    cell.descTxtVW.text =[dict valueForKey:@"description"] ;
   
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

- (IBAction)backbtn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
