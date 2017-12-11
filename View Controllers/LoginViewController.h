//
//  LoginViewController.h
//  INDIA CME
//
//  Created by DILIP KUMAR on 17/05/17.
//  Copyright © 2017 Apple. All rights reserved.
//"vend_id" = 100019;

#import <UIKit/UIKit.h>
#import "JVFloatLabeledTextField.h"
@interface LoginViewController : UIViewController<UITextFieldDelegate>
{
    
    IBOutlet JVFloatLabeledTextField *passwordTF;
    IBOutlet JVFloatLabeledTextField *emailTF;
    IBOutlet UIActivityIndicatorView *activity;

}
- (IBAction)signinBtnTpd:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lbl1;
@property (weak, nonatomic) IBOutlet UILabel *lbl2;
- (IBAction)forgotPasBtnTpd:(id)sender;
- (IBAction)registerBtnTpd:(id)sender;
- (IBAction)eyeBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *signinBtn;


@end
