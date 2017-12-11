//
//  NewUpdateViewController.h
//  IMA FARIDABAD
//
//  Created by DILIP KUMAR on 21/10/17.
//  Copyright © 2017 CuLinks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewUpdateViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UIActivityIndicatorView *activity;

}
@property (weak, nonatomic) IBOutlet UITableView *updateListTableView;
@property(nonatomic,strong)NSMutableArray *updateArray;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UITextView *descTxtVW;
- (IBAction)backbtn:(id)sender;
@end
