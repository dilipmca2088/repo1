//
//  AddPhotoViewController.m
//  FirstCut
//
//  Created by Charu Khosla on 28/09/2015.
//  Copyright © 2015 FirstCut. All rights reserved.
//                      

#import "AddPhotoViewController.h"
#import "AppDelegate.h"

@interface AddPhotoViewController ()
{
    
    NSString *btn1STR;
    NSString *btn2STR;
    NSString *btn3STR;
    NSString *btn4STR;

}

@end

@implementation AddPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    image1Changed=FALSE;
    image2Changed=FALSE;
    image3Changed=FALSE;
    image4Changed=FALSE;
    
    _photo1.layer.cornerRadius=1.0f;
    _photo1.layer.masksToBounds=YES;
    _photo1.layer.borderColor =[[UIColor whiteColor] CGColor];
     _photo1.layer.borderWidth= 2.0f;
    
    _photo2.layer.cornerRadius=1.0f;
    _photo2.layer.masksToBounds=YES;
    _photo2.layer.borderColor =[[UIColor whiteColor] CGColor];
    _photo2.layer.borderWidth= 2.0f;

    _photo3.layer.cornerRadius=1.0f;
    _photo3.layer.masksToBounds=YES;
    _photo3.layer.borderColor =[[UIColor whiteColor] CGColor];
    _photo3.layer.borderWidth= 2.0f;

    
    _photo4.layer.cornerRadius=1.0f;
    _photo4.layer.masksToBounds=YES;
    _photo4.layer.borderColor =[[UIColor whiteColor] CGColor];
    _photo4.layer.borderWidth= 2.0f;
    
    if ([[UIScreen mainScreen] bounds].size.height == 480)
    {
        [backBtn setFrame:CGRectMake(110,420,102,46)];
        
    }
    else
    {
        
        
    }
    
    NSLog(@"areeeee...%@",_addOrderingArr);
    
    NSLog(@"_urlImageArr count...%lu",(unsigned long)[_urlImageArr count]);
    
    _addImageArr =[[NSMutableArray alloc]init];
    
    
    if ([_checkForEdit isEqualToString:@"T"])
    {
        
    }
    
    else
    {
    
    if ([_urlImageArr count]==1)
    {
        
    }
    
    else
    {
    
        
        for (int i=0; i<[_addOrderingArr count]; i++)
        {
            
            
            if ([[_addOrderingArr objectAtIndex:i]intValue]==1)
           {
               
                   
                   NSString *path=[@URLAvatar stringByAppendingString:[_urlImageArr objectAtIndex:i]];
                   
                   UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:path]]];
                   
                   _photo1.image =image;
                   [btn1 setBackgroundImage:[UIImage imageNamed:@"cross_btn.png"] forState:UIControlStateNormal];
               
               [btn1 setBackgroundColor:[UIColor clearColor]];
                   
                   //[btn1 setBackgroundImage:[UIImage imageNamed:@"originalCross.png"] forState:UIControlStateNormal];
               
            }
            
            
            
            
            if ([[_addOrderingArr objectAtIndex:i]intValue]==2)
            {
                
               
                    
                    NSString *path=[@URLAvatar stringByAppendingString:[_urlImageArr objectAtIndex:i]];
                    
                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:path]]];
                    
                    _photo2.image =image;
                    [btn2 setBackgroundImage:[UIImage imageNamed:@"cross_btn.png"] forState:UIControlStateNormal];
                 [btn2 setBackgroundColor:[UIColor clearColor]];
                    
                

            }
            
        
            
        if ([[_addOrderingArr objectAtIndex:i]intValue]==3)
            {
             
                    
                    NSString *path=[@URLAvatar stringByAppendingString:[_urlImageArr objectAtIndex:i]];
                    
                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:path]]];
                    
                    _photo3.image =image;
                    
                    [btn3 setBackgroundImage:[UIImage imageNamed:@"cross_btn.png"] forState:UIControlStateNormal];
                 [btn3 setBackgroundColor:[UIColor clearColor]];
                    
                
            }
            
            
            
            if ([[_addOrderingArr objectAtIndex:i]intValue]==4)
            {
               
               
                    
                    NSString *path=[@URLAvatar stringByAppendingString:[_urlImageArr objectAtIndex:i]];
                    
                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:path]]];
                    
                    _photo4.image =image;
                    [btn4 setBackgroundImage:[UIImage imageNamed:@"cross_btn.png"] forState:UIControlStateNormal];
                 [btn4 setBackgroundColor:[UIColor clearColor]];
                    
               
            }
            
            
            
        }
        
    }
    }

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)BackBtnAction:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)backBtnTapped:(id)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)uploadPicBtnAction:(UIButton *)btn
{
    
    NSLog(@"Btn Tag:  %ld",(long)btn.tag);
    
    if (btn.tag == 1)
    {
        selectedButton = 1;
        
        if ([btn1.backgroundColor isEqual:[UIColor clearColor]])
        {
            _photo1.image=nil;
            
            [btn1 setBackgroundImage:[UIImage imageNamed:@"PLUS.png"] forState:UIControlStateNormal];
            
            image1Changed=FALSE;
            
            [btn1 setBackgroundColor:[UIColor blackColor]];
            
            
        }
        
        else{
            
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsImageEditing = YES;
            
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self presentModalViewController:imagePicker animated:YES];
            
            
        }
        
        
        
    }
    else if (btn.tag == 2)
    {
        selectedButton = 2;
        
         if ([btn2.backgroundColor isEqual:[UIColor clearColor]])
        {
            _photo2.image=nil;
            
            [btn2 setBackgroundImage:[UIImage imageNamed:@"PLUS.png"] forState:UIControlStateNormal];
            
            image2Changed=FALSE;
               [btn2 setBackgroundColor:[UIColor blackColor]];
        }
else
{
    
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsImageEditing = YES;
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentModalViewController:imagePicker animated:YES];
}
    
        
        
    }else if (btn.tag == 3)
    {
        selectedButton = 3;
        
        if ([btn3.backgroundColor isEqual:[UIColor clearColor]])
        {
            _photo3.image=nil;
            [btn3 setBackgroundImage:[UIImage imageNamed:@"PLUS.png"] forState:UIControlStateNormal];
            
            image3Changed=FALSE;
            
               [btn3 setBackgroundColor:[UIColor blackColor]];
        }
        else
        {
            
            
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsImageEditing = YES;
            
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self presentModalViewController:imagePicker animated:YES];
        }

        
        
    }
    else if (btn.tag == 4)
    {
        selectedButton = 4;
        
        
         if ([btn4.backgroundColor isEqual:[UIColor clearColor]])
        {
            _photo4.image=nil;
            
            [btn4 setBackgroundImage:[UIImage imageNamed:@"PLUS.png"] forState:UIControlStateNormal];
            
            image4Changed=FALSE;
               [btn4 setBackgroundColor:[UIColor blackColor]];
        }
        
        else
        {
            
            
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsImageEditing = YES;
            
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self presentModalViewController:imagePicker animated:YES];
        }

    }
    
  }



- (void)imagePickerController:(UIImagePickerController *)imagePicker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo {
    
    if (selectedButton == 1)
    {
        image1Changed=TRUE;
        _photo1.image = image;
        
        [btn1 setBackgroundImage:[UIImage imageNamed:@"cross_btn.png"] forState:UIControlStateNormal];
        [btn1 setBackgroundColor:[UIColor clearColor]];
        
        NSString *image1 = [[NSString alloc] initWithFormat:@"%@/image1.png", [AppDelegate appDelegate].applicationDocumentsDirectory];
        NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(image)];
        UIImage *imageNew =[UIImage imageWithData:imageData];
        
        [[NSUserDefaults standardUserDefaults]setValue:@"IMAGE11" forKey:@"IMG11"];
        [_addImageArr addObject:imageData];
        [imageData writeToFile:image1 atomically:YES];
        
    }
    else if (selectedButton == 2)
    {
        
        image2Changed=TRUE;
        _photo2.image = image;
        [btn2 setBackgroundImage:[UIImage imageNamed:@"cross_btn.png"] forState:UIControlStateNormal];
 [btn2 setBackgroundColor:[UIColor clearColor]];
       
        NSString *image2 = [[NSString alloc] initWithFormat:@"%@/image2.png", [AppDelegate appDelegate].applicationDocumentsDirectory];
        NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(image)];
        UIImage *imageNew =[UIImage imageWithData:imageData];
        [_addImageArr addObject:imageData];

        [[NSUserDefaults standardUserDefaults]setValue:@"IMAGE12" forKey:@"IMG12"];
     
        
        [imageData writeToFile:image2 atomically:YES];
        
    }
    else if (selectedButton == 3) {
        
        image3Changed=TRUE;
        _photo3.image = image;
        [btn3 setBackgroundImage:[UIImage imageNamed:@"cross_btn.png"] forState:UIControlStateNormal];
         [btn3 setBackgroundColor:[UIColor clearColor]];

        NSString *image3 = [[NSString alloc] initWithFormat:@"%@/image3.png", [AppDelegate appDelegate].applicationDocumentsDirectory];
        NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(image)];
        
        [_addImageArr addObject:imageData];

        UIImage *imageNew =[UIImage imageWithData:imageData];
        

        [[NSUserDefaults standardUserDefaults]setValue:@"IMAGE13" forKey:@"IMG13"];

        [imageData writeToFile:image3 atomically:YES];
    }
    
 
    
    else if (selectedButton == 4) {
        
        image4Changed=TRUE;
        _photo4.image = image;
        
        [btn4 setBackgroundImage:[UIImage imageNamed:@"cross_btn.png"] forState:UIControlStateNormal];
         [btn4 setBackgroundColor:[UIColor clearColor]];

        NSString *image3 = [[NSString alloc] initWithFormat:@"%@/image4.png", [AppDelegate appDelegate].applicationDocumentsDirectory];
        NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(image)];
        
        UIImage *imageNew =[UIImage imageWithData:imageData];
        
        [_addImageArr addObject:imageData];

        [[NSUserDefaults standardUserDefaults]setValue:@"IMAGE14" forKey:@"IMG14"];
        [imageData writeToFile:image3 atomically:YES];
    }
    
    [AppDelegate appDelegate].addImageArr=_addImageArr;
     [[NSUserDefaults standardUserDefaults]setValue:@"COMMON" forKey:@"COMMON"];    
    [imagePicker dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)imagePicker
{
    [imagePicker dismissModalViewControllerAnimated:YES];
}



@end
