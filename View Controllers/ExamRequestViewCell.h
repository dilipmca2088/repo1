//
//  HomeViewCell.h
//  IndiansInUK
//
//  Created by Apple on 09/08/14.
//
//

#import <UIKit/UIKit.h>

@interface ExamRequestViewCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIImageView *image;
@property (retain, nonatomic) IBOutlet UILabel *titleLbl;
@property (retain, nonatomic) IBOutlet UILabel *starttimeLbl;
@property (retain, nonatomic) IBOutlet UILabel *endtimeLbl;
@property (retain, nonatomic) IBOutlet UILabel *totalseatLbl;
@property (retain, nonatomic) IBOutlet UILabel *percandLbl;
@property (retain, nonatomic) IBOutlet UILabel *systemcostLbl;
@property (retain, nonatomic) IBOutlet UILabel *mancostLbl;
@property (retain, nonatomic) IBOutlet UILabel *othercostLbl;
@property (retain, nonatomic) IBOutlet UILabel *totalsyscostLbl;
@property (retain, nonatomic) IBOutlet UILabel *totalmanpowerLbl;
@property (retain, nonatomic) IBOutlet UILabel *totalOtherLbl;
@property (retain, nonatomic) IBOutlet UILabel *daywisecostLbl;
@property (retain, nonatomic) IBOutlet UILabel *stLbl;
@property (retain, nonatomic) IBOutlet UILabel *sbcLbl;
@property (retain, nonatomic) IBOutlet UILabel *kktLbl;
@property (retain, nonatomic) IBOutlet UILabel *totalAmtLbl;
@property (retain, nonatomic) IBOutlet UILabel *msgCountLbl;

@property (retain, nonatomic) IBOutlet UIImageView *inboxImage;
@property (retain, nonatomic) IBOutlet UIButton *acceptBtn;
@property (retain, nonatomic) IBOutlet UIButton *rejectBtn;
@property (retain, nonatomic) IBOutlet UIButton *messageBtn;

@property (retain, nonatomic) IBOutlet UILabel *Lbl1;
@property (retain, nonatomic) IBOutlet UILabel *Lbl2;

@end
