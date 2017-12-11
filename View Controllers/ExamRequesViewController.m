//
//  HomePageViewController.m
//  UInterestMe
//
//  Created by Sushil on 05/08/13.
//  Copyright (c) 2013 Vikas Kumar. All rights reserved.
//

#import "ExamRequesViewController.h"
#import "ExamRequestViewCell.h"
#import "AppDelegate.h"
#import "ChangePasswordViewController.h"
#import "ProfileViewController.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "ChatViewController.h"

static CGFloat const kWindowHeight = 205.0f;

static NSString * const kCellIdentify = @"cell";
//#import "GpEventsViewController.h"
@interface ExamRequesViewController ()
{
    NSString *inter;
    NSString *near;
    
    NSURL *url1;
    NSString *badgeValue;
   
    NSString *examId;
    NSString *examStatus;


}

@end

@implementation ExamRequesViewController

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
    if ([_fromHome isEqualToString:@"T"])
    {
        _titleLbl.text=@"UPCOMING EXAM SCHEDULE";
    }
    
    _tableView.layer.cornerRadius=4.0f;
    _tableView.layer.borderWidth=2.0f;
    _tableView.clipsToBounds=YES;
    _tableView.layer.borderColor=[[UIColor whiteColor] CGColor];
    self.navigationController.navigationBar.hidden=YES;
    _examArray =[[NSMutableArray alloc] init];
    
    if ([[AppDelegate appDelegate] connected])
    {
        NSLog(@"yes");
        activity.hidden=NO;
        [activity startAnimating];
        [self getExamRequestWS];
        
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

-(void)getExamRequestWS
{
    activity.hidden=NO;
    [activity startAnimating];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:[AppDelegate appDelegate].venderId forKey:@"Id"];
    [dict setValue:@XKEY forKey:@"X-API-KEY"];
   // approveexamlist
    
    if ([_fromHome isEqualToString:@"T"])
    {
        [dict setValue:@"1" forKey:@""];

        
        [manager POST:[NSString stringWithFormat:@"%sapproveexamlist/",URLBase] parameters:dict
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
                 
                 _examArray =[responseObject valueForKey:@"data"];
                 
                 if (_examArray.count==0)
                 {
                     
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"There are no Exams Scheduled at your Centre Right Now"
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
    
    else
    {
    
    [manager POST:[NSString stringWithFormat:@"%sgetexam/",URLBase] parameters:dict
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
             
             _examArray =[responseObject valueForKey:@"data"];
             
             if (_examArray.count==0)
             {
                 
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Be right there. We are trying to schedule new Exams for your Centre"
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
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_examArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
      static NSString * cellIdentifier = @"Cell";
 
    ExamRequestViewCell *cell = (ExamRequestViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier] ;
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ExamRequestViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.messageBtn.tag=indexPath.row;
    
    [cell.messageBtn addTarget:self action:@selector(messageMethod:) forControlEvents:UIControlEventTouchUpInside];
    
    
    cell.acceptBtn.tag=indexPath.row;
    
    [cell.acceptBtn addTarget:self action:@selector(acceptMethod:) forControlEvents:UIControlEventTouchUpInside];
    
    
    cell.rejectBtn.tag=indexPath.row;
    
    [cell.rejectBtn addTarget:self action:@selector(rejectMethod:) forControlEvents:UIControlEventTouchUpInside];
     NSDictionary *dict=[_examArray objectAtIndex:indexPath.row];
  
    if ([_fromHome isEqualToString:@"T"])
    {
        cell.rejectBtn.hidden=YES;
        cell.acceptBtn.hidden=YES;
         cell.Lbl2.hidden=YES;
    }
    else
    {
        cell.Lbl1.hidden=YES;
 
    }
    cell.titleLbl.text =[dict valueForKey:@"title"] ;
    cell.starttimeLbl.text = [dict valueForKey:@"starttime"] ;
    cell.endtimeLbl.text = [dict valueForKey:@"endtime"] ;
    cell.totalseatLbl.text = [dict valueForKey:@"seat"] ;
    cell.percandLbl.text = [dict valueForKey:@"percandidate"] ;
    cell.systemcostLbl.text = [dict valueForKey:@"systemcost"] ;
    cell.mancostLbl.text = [dict valueForKey:@"mainpowercost"] ;
    cell.othercostLbl.text = [dict valueForKey:@"othercost"] ;
    
    cell.msgCountLbl.text =[NSString stringWithFormat:@"(%@)",[dict valueForKey:@"counter"]];

    cell.totalsyscostLbl.text = [dict valueForKey:@"totalsystemcost"] ;
    cell.totalmanpowerLbl.text = [dict valueForKey:@"totalmainpowercost"] ;
    cell.totalOtherLbl.text = [dict valueForKey:@"totalothercost"] ;
    cell.daywisecostLbl.text = [dict valueForKey:@"daycost"] ;
    cell.stLbl.text = [dict valueForKey:@"st"] ;
    cell.sbcLbl.text = [dict valueForKey:@"sbc"] ;
    cell.kktLbl.text = [dict valueForKey:@"kkt"] ;
    cell.totalAmtLbl.text = [dict valueForKey:@"totamamount"] ;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor =[UIColor clearColor];
        return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"didSelect");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0)
    {
       // [[AppDelegate appDelegate] showSideMenu];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_fromHome isEqualToString:@"T"])
    {
    return 370;
    }
    else
    {
        
    return 395;
  
    }
}

-(void)messageMethod:(UIButton *)btn
{
    NSLog(@"tag is%ld",(long)btn.tag);
    
    examId=[[self.examArray objectAtIndex:btn.tag]valueForKey:@"id"];
    
    examStatus=[[self.examArray objectAtIndex:btn.tag]valueForKey:@"status"];
    
    ChatViewController *chatVC =[[ChatViewController alloc] initWithNibName:@"ChatViewController" bundle:nil];
    [chatVC setIdExam:examId];
    [chatVC setFromHome:@"T"];
    [self presentViewController:chatVC animated:YES completion:nil];

}


-(void)acceptMethod:(UIButton *)btn
{
    NSLog(@"tag is%ld",(long)btn.tag);
    
    examId=[[self.examArray objectAtIndex:btn.tag]valueForKey:@"id"];
    
      examStatus=[[self.examArray objectAtIndex:btn.tag]valueForKey:@"status"];
    [self acceptExamRequestWS];
    
}

-(void)rejectMethod:(UIButton *)btn
{
    NSLog(@"tag is%ld",(long)btn.tag);
    
     examId=[[self.examArray objectAtIndex:btn.tag]valueForKey:@"id"];
    [self rejectExamRequestWS];

    
    
}
- (IBAction)backBtnAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)acceptExamRequestWS
{
    activity.hidden=NO;
    [activity startAnimating];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSMutableDictionary *dict1 = [[NSMutableDictionary alloc]init];
    [dict1 setValue:examId forKey:@"Id"];
    [dict1 setValue:@"1" forKey:@"examstatus"];
    [dict1 setValue:@XKEY forKey:@"X-API-KEY"];
    
    [manager POST:[NSString stringWithFormat:@"%ssendexamrequest/",URLBase] parameters:dict1
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
                 
                 [self getExamRequestWS];
                 
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

-(void)rejectExamRequestWS
{
    activity.hidden=NO;
    [activity startAnimating];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSMutableDictionary *dict1 = [[NSMutableDictionary alloc]init];
    [dict1 setValue:examId forKey:@"Id"];
    [dict1 setValue:@XKEY forKey:@"X-API-KEY"];
    [manager POST:[NSString stringWithFormat:@"%srejectsendexam/",URLBase] parameters:dict1
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
             
             [self getExamRequestWS];
             
             
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


@end
