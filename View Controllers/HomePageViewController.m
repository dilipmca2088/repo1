//
//  HomePageViewController.m
//  UInterestMe
//
//  Created by Sushil on 05/08/13.
//  Copyright (c) 2013 Vikas Kumar. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomeViewCell.h"
#import "AppDelegate.h"
#import "ChangePasswordViewController.h"
#import "ProfileViewController.h"
#import "ChatViewController.h"
#import "LoginViewController.h"
#import "CentreProfileViewController.h"
#import "HelpViewController.h"
#import "StarViewController.h"
#import "AllProfileViewController.h"


static CGFloat const kWindowHeight = 205.0f;

static NSString * const kCellIdentify = @"cell";
//#import "GpEventsViewController.h"
@interface HomePageViewController ()
{
    NSString *inter;
    NSString *near;
    
    NSURL *url1;
    NSString *badgeValue;
}

@end

@implementation HomePageViewController

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
    self.navigationController.navigationBar.hidden=YES;
    
        
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden=YES;
    [super viewWillAppear:animated];

    taskArray = [[NSArray alloc]initWithObjects:@"HOME",@"MY PROFILE",@"CHANGE PASSWORD",@"CHAT WITH ADMIN",@"HELP & SUPPORT",@"MY CENTRE RATING",nil];
    
    taskImageArray = [[NSArray alloc]initWithObjects:@"home.png",@"name144.png",@"password144.png",@"chat144.png",@"help144.png",@"logout.png",nil];
 
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [taskArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
      static NSString * cellIdentifier = @"Cell";
 
    HomeViewCell *cell = (HomeViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier] ;
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HomeViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.image.image =[UIImage imageNamed:[taskImageArray objectAtIndex:indexPath.row]];
    
    //[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
      cell.label.text = [taskArray objectAtIndex:indexPath.row];
  
    cell.label.textColor = [UIColor whiteColor];
    cell.backgroundColor =[UIColor clearColor];
        return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"didSelect");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0)
        
    {
        [AppDelegate appDelegate].checkForm=@"";
        [[AppDelegate appDelegate] showSideMenu];
        
    }
    
    if (indexPath.row == 1)
    {
       // CentreProfileViewController *nearView =[[CentreProfileViewController alloc]initWithNibName:@"CentreProfileViewController" bundle:nil];
        
        AllProfileViewController *nearView =[[AllProfileViewController alloc]initWithNibName:@"AllProfileViewController" bundle:nil];
        
        [self.viewDeckController rightViewPushViewControllerOverCenterController:nearView];
        
    }
    
        if (indexPath.row == 2)
        
    {
        
        ChangePasswordViewController *nearView =[[ChangePasswordViewController alloc]initWithNibName:@"ChangePasswordViewController" bundle:nil];
        
        [self.viewDeckController rightViewPushViewControllerOverCenterController:nearView];
    }
    
    if (indexPath.row == 3)
        
    {
        
        ChatViewController *nearView =[[ChatViewController alloc]initWithNibName:@"ChatViewController" bundle:nil];
        
        [nearView setFromHome:@"M"];
        [self.viewDeckController rightViewPushViewControllerOverCenterController:nearView];
    }
    
    if (indexPath.row == 4)
        
    {
        
        HelpViewController *nearView =[[HelpViewController alloc]initWithNibName:@"HelpViewController" bundle:nil];
        [self.viewDeckController rightViewPushViewControllerOverCenterController:nearView];
    }
    if (indexPath.row == 5)
        
    {
        
        
        StarViewController *nearView =[[StarViewController alloc]initWithNibName:@"StarViewController" bundle:nil];
         [self.viewDeckController rightViewPushViewControllerOverCenterController:nearView];
    }


    
}

@end
