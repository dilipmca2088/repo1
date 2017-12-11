//
//  AddPhotoViewController.h
//  FirstCut
//
//  Created by Charu Khosla on 28/09/2015.
//  Copyright © 2015 FirstCut. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPhotoViewController : UIViewController

{
    NSUInteger selectedButton;
    BOOL image1Changed;
    BOOL image2Changed;
    BOOL image3Changed;
    BOOL image4Changed;
    __weak IBOutlet UIButton *btn1;
    
    __weak IBOutlet UIButton *btn4;
    __weak IBOutlet UIButton *btn3;
    __weak IBOutlet UIButton *btn2;
    __weak IBOutlet UIButton *backBtn;
    
}
@property(nonatomic,strong)NSString *checkForEdit;
@property(nonatomic,strong)NSMutableArray *addImageArr;
@property(nonatomic,strong)NSMutableArray *addOrderingArr;
@property(nonatomic,strong)NSMutableArray *urlImageArr;
@property (retain, nonatomic) IBOutlet UIImageView *photo1;
@property (retain, nonatomic) IBOutlet UIImageView *photo2;
@property (retain, nonatomic) IBOutlet UIImageView *photo3;
- (IBAction)BackBtnAction:(id)sender;
@property (retain, nonatomic) IBOutlet UIImageView *photo4;
- (IBAction)backBtnTapped:(id)sender;
- (IBAction)uploadPicBtnAction:(id)sender;
- (IBAction)privacyBtnAction:(id)sender;

@end
