//
//  LoginViewController.h
//  INDIA CME
//
//  Created by DILIP KUMAR on 17/05/17.
//  Copyright © 2017 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JVFloatLabeledTextField.h"
@interface ChatViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    IBOutlet UIButton *menuBtn;

    IBOutlet JVFloatLabeledTextField *emailTF;
    IBOutlet UIActivityIndicatorView *activity;

}
@property(strong,nonatomic)IBOutlet UITableView *tableView;

- (IBAction)signinBtnTpd:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lbl1;
@property (weak, nonatomic) IBOutlet UILabel *lbl2;
- (IBAction)forgotPasBtnTpd:(id)sender;
- (IBAction)registerBtnTpd:(id)sender;
- (IBAction)backBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *signinBtn;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property(nonatomic,strong)NSMutableArray *chatArray;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) NSString* fromHome;
@property (strong, nonatomic) NSString* idExam;

@property (weak, nonatomic) IBOutlet UIView *chatTextView;

- (IBAction)backBtnAction:(id)sender;


@end
