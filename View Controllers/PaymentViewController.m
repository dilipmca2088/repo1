//
//  HomePageViewController.m
//  UInterestMe
//
//  Created by Sushil on 05/08/13.
//  Copyright (c) 2013 Vikas Kumar. All rights reserved.
//

#import "PaymentViewController.h"
#import "ViewPaymentCell.h"
#import "AppDelegate.h"
#import "ChangePasswordViewController.h"
#import "ProfileViewController.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"

static CGFloat const kWindowHeight = 205.0f;

static NSString * const kCellIdentify = @"cell";
//#import "GpEventsViewController.h"
@interface PaymentViewController ()
{
    NSString *inter;
    NSString *near;
    
    NSURL *url1;
    NSString *badgeValue;
   
    NSString *examId;
    NSString *examStatus;


}

@end

@implementation PaymentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    // Do any additional setup after loading the view from its nib.
    
    _tableView.layer.cornerRadius=4.0f;
    _tableView.layer.borderWidth=2.0f;
    _tableView.clipsToBounds=YES;
    _tableView.layer.borderColor=[[UIColor whiteColor] CGColor];
    self.navigationController.navigationBar.hidden=YES;
    _paymentArray =[[NSMutableArray alloc] init];
    [activity startAnimating];
    
    
    if ([[AppDelegate appDelegate] connected])
    {
        NSLog(@"yes");
        activity.hidden=NO;
        [activity startAnimating];
        [self getPaymentWS];
        
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

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden=YES;
    [super viewWillAppear:animated];

}
-(void)getPaymentWS
{
    activity.hidden=NO;
    [activity startAnimating];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:[AppDelegate appDelegate].venderId forKey:@"Id"];    
    [dict setValue:@XKEY forKey:@"X-API-KEY"];
    
    [manager POST:[NSString stringWithFormat:@"%spaymentget/",URLBase] parameters:dict
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
                 _paymentArray =[responseObject valueForKey:@"data"];
                 
                 
                 
                 if (_paymentArray.count==0)
                 {
                     
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Be patient. We are as Excited as you to Conduct Exams and grow together"
                                                                    delegate:self
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil];
                     [alert show];
                     
                     
                 }
                 else
                 {
                 _tableView.delegate=self;
                 _tableView.dataSource=self;
                 [_tableView reloadData];
                 
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
    


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_paymentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
      static NSString * cellIdentifier = @"Cell";
 
    ViewPaymentCell *cell = (ViewPaymentCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier] ;
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ViewPaymentCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    
     NSDictionary *dict=[_paymentArray objectAtIndex:indexPath.row];
  
    cell.exmNameLbl.text =[dict valueForKey:@"examname"] ;
    cell.totalPaymentLbl.text = [dict valueForKey:@"payment"] ;
    cell.transactionIdLbl.text = [dict valueForKey:@"transactionid"] ;
    cell.transactiondateLbl.text = [dict valueForKey:@"transactiondate"] ;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor =[UIColor clearColor];
        return cell;
    
}


- (IBAction)backBtnAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
