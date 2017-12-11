//
//  RegisterViewController.h
//  INDIA CME
//
//  Created by DILIP KUMAR on 17/05/17.
//  Copyright © 2017 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JVFloatLabeledTextField.h"

@interface UpdateBankViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    IBOutlet JVFloatLabeledTextField *actHolNameTF;
    IBOutlet JVFloatLabeledTextField *actNumberTF;
    IBOutlet JVFloatLabeledTextField *ifscCodeTF;
    IBOutlet JVFloatLabeledTextField *bankNameTF;
    IBOutlet JVFloatLabeledTextField *branchNameTF;
    IBOutlet JVFloatLabeledTextField *actTypeTF;
    IBOutlet JVFloatLabeledTextField *panNoTF;
   
    IBOutlet UIActivityIndicatorView *activity;
    
    UIToolbar* pickerToolbar;
    
    IBOutlet UIPickerView *picker1;
    int match;

}
@property (nonatomic, retain) UIActionSheet* pickerActionSheet;

@property(nonatomic,strong)NSMutableArray *arForIPs;
@property(nonatomic,strong)NSMutableArray *mainSpecArray;

- (IBAction)backBtnTpd:(id)sender;

- (IBAction)registerBtnTpd:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *firstNLbl;
@property (weak, nonatomic) IBOutlet UILabel *pwdbl;
@property (weak, nonatomic) IBOutlet UILabel *emailLbl;
@property (weak, nonatomic) IBOutlet UILabel *confpwdbl;
@property (weak, nonatomic) IBOutlet UILabel *sexLbl;
@property (weak, nonatomic) IBOutlet UILabel *stateLbl;
@property (weak, nonatomic) IBOutlet UILabel *cityLbl;
@property (weak, nonatomic) IBOutlet UILabel *countryLbl;
@property (weak, nonatomic) IBOutlet UILabel *pinLbl;
@property (weak, nonatomic) IBOutlet UILabel *postAddLbl;



- (IBAction)termsConditonBtnTpd:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *specLbl;
- (IBAction)closeBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *specView;
@property (weak, nonatomic) IBOutlet UIView *bottumView;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
- (IBAction)checkBtnTpd:(id)sender;
- (IBAction)verifyBtnTpd:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *otpTF;
- (IBAction)closebtnTpd:(id)sender;
@property(nonatomic,strong)NSString *base64;
@property(nonatomic,strong)NSString *cameraStr;

@property (weak, nonatomic) IBOutlet UILabel *counterLbl;
@property(strong,nonatomic)NSString *otpStr;
@property(nonatomic,strong)NSString *specializations;
- (IBAction)summitbtnTpd:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *certImageView;
@property (weak, nonatomic) IBOutlet UIButton *regiterBtn;

@property (nonatomic, retain) NSString* selectedValueStr;

- (void)pickerDoneTapped;
- (IBAction)createActionSheet:(id)sender;
- (IBAction)disclosureBtnTapped:(UIButton *)button;

@end
