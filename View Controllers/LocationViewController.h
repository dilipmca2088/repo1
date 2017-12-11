//
//  LoginViewController.h
//  INDIA CME
//
//  Created by DILIP KUMAR on 17/05/17.
//  Copyright © 2017 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JVFloatLabeledTextField.h"
@interface LocationViewController : UIViewController<UITextFieldDelegate>
{
    
    IBOutlet JVFloatLabeledTextField *emailTF;
    IBOutlet UIActivityIndicatorView *activity;

}
- (IBAction)signinBtnTpd:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lbl1;
@property (weak, nonatomic) IBOutlet UILabel *lbl2;
- (IBAction)forgotPasBtnTpd:(id)sender;
- (IBAction)registerBtnTpd:(id)sender;
- (IBAction)backBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *signinBtn;


@end
