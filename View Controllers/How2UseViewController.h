//
//  HelpViewController.h
//  BestSelfiy
//
//  Created by Vaibhav Awasthi on 19/11/16.
//  Copyright © 2016 Vaibhav Awasthi. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface How2UseViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (strong, nonatomic) IBOutlet UITextView *txtView;
@property (strong, nonatomic) IBOutlet UIButton *menuBtn;
@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, strong)NSString*match;
@property (nonatomic, strong)NSString*checkView;

@end
