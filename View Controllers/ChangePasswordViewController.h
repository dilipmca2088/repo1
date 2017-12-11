//
//  ForgotPasswordViewController.h
//  INDIA CME
//
//  Created by DILIP KUMAR on 17/05/17.
//  Copyright © 2017 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JVFloatLabeledTextField.h"
@interface ChangePasswordViewController : UIViewController

{
    
    IBOutlet JVFloatLabeledTextField *mobiledTF;
    IBOutlet UIButton *menuBtn;

   }
- (IBAction)continueBtnTpd:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *mobilelbl;
- (IBAction)verifyBtnTpd:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *oldTF;
@property (weak, nonatomic) IBOutlet UITextField *newwTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmTF;

- (IBAction)closebtnTpd:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *otpView;
@property(strong,nonatomic)NSString *otpStr;
@property (weak, nonatomic) IBOutlet UILabel *counterLbl;
- (IBAction)backBtnTpd:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lbl1;
@property (weak, nonatomic) IBOutlet UILabel *lbl2;
@property (weak, nonatomic) IBOutlet UILabel *lbl3;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityInd;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end
