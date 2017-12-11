//
//  HomePageViewController.h
//  UInterestMe
//
//  Created by Sushil on 05/08/13.
//  Copyright (c) 2013 Vikas Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PaymentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
    IBOutlet UIActivityIndicatorView *activity;

}

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic)IBOutlet UITableView *tableView;
@property (strong, nonatomic)NSString *loginUserGender;
@property (strong, nonatomic)NSString *loginUserAge;
@property (strong, nonatomic)NSDictionary* jsonDict;
@property (strong, nonatomic) NSString* avatar1Str;
@property(nonatomic,strong)NSArray *array;
@property(nonatomic,strong)NSMutableArray *paymentArray;
@property(nonatomic,strong)NSMutableArray *valueArray;
@property (strong, nonatomic) IBOutlet UIView *settingView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
- (IBAction)backBtnAction:(id)sender;
@property (strong, nonatomic) NSString* fromHome;


@end
