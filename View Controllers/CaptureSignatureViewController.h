//
//  CaptureSignatureViewController.h
//  signature
//
//  Created by Vignesh on 2/10/16.
//  Copyright © 2016 vigneshuvi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UviSignatureView.h"


// Protocol definition starts here
@protocol CaptureSignatureViewDelegate <NSObject>
@required
- (void)processCompleted:(UIImage*)signImage;
@end


@interface CaptureSignatureViewController : UIViewController {
    // Delegate to respond back
    id <CaptureSignatureViewDelegate> _delegate;
    NSString *userName, *signedDate;
}

@property (nonatomic,strong) id delegate;
-(void)startSampleProcess:(NSString*)text;
// Instance method
@property(nonatomic,strong)NSArray *formFieldsArr;
@property(nonatomic,strong)NSArray *dataValArr;
@property(nonatomic,strong)NSMutableDictionary *dataDict;
@property(nonatomic,strong)NSString *examTitle;
@property(nonatomic,strong)NSString *examId;
@property(nonatomic,strong)NSString *examDate;

@property (strong, nonatomic) IBOutlet UviSignatureView *signatureView;
- (IBAction)captureSign:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *captureButton;
@end
