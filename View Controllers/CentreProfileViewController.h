//
//  RegisterViewController.h
//  INDIA CME
//
//  Created by DILIP KUMAR on 17/05/17.
//  Copyright © 2017 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JVFloatLabeledTextField.h"
#import "ELCImagePickerHeader.h"

@interface CentreProfileViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource,ELCImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate>
{
    IBOutlet UIButton *menuBtn;

    IBOutlet JVFloatLabeledTextField *cityTF;
    IBOutlet JVFloatLabeledTextField *centreNameTF;
    IBOutlet JVFloatLabeledTextField *addressTF;
    IBOutlet JVFloatLabeledTextField *inchargeTF;
    IBOutlet JVFloatLabeledTextField *inchargeContTF;
    IBOutlet JVFloatLabeledTextField *inchargeEmailTF;
    IBOutlet JVFloatLabeledTextField *itPersonNameTF;
    IBOutlet JVFloatLabeledTextField *itPersonContactTF;
    IBOutlet JVFloatLabeledTextField *itPersonEmailTF;
    IBOutlet JVFloatLabeledTextField *systemAvailTF;
    IBOutlet JVFloatLabeledTextField *processorTF;
    IBOutlet JVFloatLabeledTextField *ramTF;
    IBOutlet JVFloatLabeledTextField *hdTF;
    IBOutlet JVFloatLabeledTextField *maleTF;
    IBOutlet JVFloatLabeledTextField *feMaleTF;
    IBOutlet JVFloatLabeledTextField *waitingTF;
    IBOutlet JVFloatLabeledTextField *parkingTF;
    IBOutlet JVFloatLabeledTextField *fstInternetTF;
    IBOutlet JVFloatLabeledTextField *fstIntSpeedTF;
    IBOutlet JVFloatLabeledTextField *secInternetTF;
    IBOutlet JVFloatLabeledTextField *secIntSpeedTF;
    IBOutlet JVFloatLabeledTextField *printerTF;
    IBOutlet JVFloatLabeledTextField *upspowerunitTF;
    IBOutlet JVFloatLabeledTextField *upsbackupTimeTF;
    IBOutlet JVFloatLabeledTextField *genpowerunitTF;
    IBOutlet JVFloatLabeledTextField *genFuelChargeTF;
    IBOutlet JVFloatLabeledTextField *noSysTF1;
    IBOutlet JVFloatLabeledTextField *processorTF1;
    IBOutlet JVFloatLabeledTextField *ramTF1;
    IBOutlet JVFloatLabeledTextField *hd1;
    IBOutlet JVFloatLabeledTextField *noSysTF2;
    IBOutlet JVFloatLabeledTextField *processorTF2;
    IBOutlet JVFloatLabeledTextField *ramTF2;
    IBOutlet JVFloatLabeledTextField *hd2;
    IBOutlet JVFloatLabeledTextField *noSysTF3;
    IBOutlet JVFloatLabeledTextField *processorTF3;
    IBOutlet JVFloatLabeledTextField *ramTF3;
    IBOutlet JVFloatLabeledTextField *hd3;
    IBOutlet JVFloatLabeledTextField *cctvTF;
    IBOutlet JVFloatLabeledTextField *acTF;

    IBOutlet UIView *cctvView;
    IBOutlet UIView *acView;
    IBOutlet UIView *printerView;
    IBOutlet UIView *powerView;
    IBOutlet UIView *gensetView;
    IBOutlet UIView *systemView;
    IBOutlet UIView *termsView;




    IBOutlet UIActivityIndicatorView *activity;
    
    UIToolbar* pickerToolbar;
    
    IBOutlet UIPickerView *picker1;
    int match;
    int camMatch;

}
@property (nonatomic, retain) UIActionSheet* pickerActionSheet;

@property(nonatomic,strong)NSMutableArray *arForIPs;
@property(nonatomic,strong)NSMutableArray *mainSpecArray;
@property(nonatomic,strong)NSMutableArray *finalImageArray;

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
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;

- (IBAction)radioBtnAction:(id)sender;
- (IBAction)cameraBtnAction:(id)sender;

@property (nonatomic, retain) NSString* selectedValueStr;

- (void)pickerDoneTapped;
- (IBAction)createActionSheet:(id)sender;
- (IBAction)disclosureBtnTapped:(UIButton *)button;

@property (weak, nonatomic) IBOutlet UIButton *fisYes;
@property (weak, nonatomic) IBOutlet UIButton *fisNo;

@property (weak, nonatomic) IBOutlet UIButton *secYes;
@property (weak, nonatomic) IBOutlet UIButton *secNo;

@property (weak, nonatomic) IBOutlet UIButton *ccYes;
@property (weak, nonatomic) IBOutlet UIButton *ccNo;
@property (weak, nonatomic) IBOutlet UIButton *acYes;
@property (weak, nonatomic) IBOutlet UIButton *acNo;
@property (weak, nonatomic) IBOutlet UIButton *printerYes;
@property (weak, nonatomic) IBOutlet UIButton *printerNo;

@property (weak, nonatomic) IBOutlet UIButton *backupYes;

@property (weak, nonatomic) IBOutlet UIButton *backupNO;

@property (weak, nonatomic) IBOutlet UIButton *genSetYes;
@property (weak, nonatomic) IBOutlet UIButton *genSetNO;

@property (weak, nonatomic) IBOutlet UIButton *systemYes;
@property (weak, nonatomic) IBOutlet UIButton *systemNO;
- (IBAction)cancelBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *secImgLbl;
@property (weak, nonatomic) IBOutlet UILabel *primImgLbl;
@property (weak, nonatomic) IBOutlet UILabel *docImgLbl;

- (IBAction)checkBtnAction:(id)sender;
////////////////////////////
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView11;
@property (nonatomic, copy) NSArray *chosenImages;

// the default picker controller
- (IBAction)launchController;

// a special picker controller that limits itself to a single album, and lets the user
// pick just one image from that album.
- (IBAction)launchSpecialController;
@property (weak, nonatomic) IBOutlet UIImageView *primaryImg;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
- (IBAction)backBtnAction:(id)sender;

@end
