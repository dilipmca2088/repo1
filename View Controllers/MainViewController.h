//33667777
//  UpdateDetailsViewController.h
//  INDIA CME
//
//  Created by DILIP KUMAR on 11/06/17.
//  Copyright © 2017 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaptureSignatureViewController.h"
@interface MainViewController : UIViewController<UITextFieldDelegate,CaptureSignatureViewDelegate>
{
    IBOutlet UIButton *menuBtn;

}

- (IBAction)examRequestBtn:(id)sender;
- (IBAction)examSheduleBtnAction:(id)sender;
- (IBAction)compleEventBtn:(id)sender;
- (IBAction)viewPaymentBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *reqCounterLbl;
@property (weak, nonatomic) IBOutlet UILabel *approveCounterLbl;
@property (weak, nonatomic) IBOutlet UILabel *msgCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *paymentCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *eventCountLbl;
- (IBAction)msgCounterBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *signFieldsView;
@property (weak, nonatomic) IBOutlet UIView *welcomeView;

- (IBAction)openFormBtnAction:(id)sender;
- (IBAction)closeFormBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UITextView *titleText;
@property (weak, nonatomic) IBOutlet UILabel *welcomeLbl;

- (IBAction)submitBtnAction:(id)sender;
- (IBAction)editBtnTpd:(id)sender;
- (IBAction)how2UseBtn:(id)sender;
- (IBAction)logoutBtn:(id)sender;
- (IBAction)homeBtn:(id)sender;

@end
