//
//  FinalFormViewController.h
//  CuLinks
//
//  Created by DILIP KUMAR on 27/11/17.
//  Copyright © 2017 CuLinks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaptureSignatureViewController.h"
#import <Foundation/Foundation.h>

@interface FinalFormViewController : UIViewController<CaptureSignatureViewDelegate>
@property(nonatomic,strong)NSMutableDictionary *newdataDict;
@property(nonatomic,strong)NSArray *newdataArray;
@property(nonatomic,strong)NSArray *valueArr;
@property (strong, nonatomic)UIImage *signImg;
@property(nonatomic,strong)NSData *ndta;
@property(nonatomic,strong)NSString *mainTitle;
@property (weak, nonatomic) IBOutlet UIImageView *signImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *centreName;
@property (weak, nonatomic) IBOutlet UILabel *formId;
@property (weak, nonatomic) IBOutlet UILabel *dateLbl;
- (IBAction)proceedBtnAction:(id)sender;


@end
