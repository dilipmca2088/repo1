


#import "ChatViewController.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "AppDelegate.h"
#import "RegisterViewController.h"
#import "ChatViewCell.h"

@interface ChatViewController ()
{
    int cells_count;
    int sections_count;
}

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    cells_count=0;
    
    sections_count=0;
    
    NSLog(@"exam id%@",_idExam);
    
     [emailTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
   
    activity.hidden=YES;
    
    
    _textView.layer.cornerRadius=5.0f;
    _textView.layer.borderWidth=1.0f;
    _textView.clipsToBounds=YES;
   // _textView.layer.borderColor=[[UIColor clearColor] CGColor];
    
     [menuBtn addTarget:self.viewDeckController action:@selector(toggleLeftView) forControlEvents:UIControlEventTouchUpInside];
    _chatArray =[[NSMutableArray alloc] init];
    
    if ([_fromHome isEqualToString:@"T"])
    {
        
        
        if ([[AppDelegate appDelegate] connected])
        {
            NSLog(@"yes");
            activity.hidden=NO;
            [activity startAnimating];
            [self loadChatWS];
            
        }
        else
        {
            NSLog(@"no");
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please Check your Internet Connection"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
            
            
        }
        _backBtn.hidden=NO;
        menuBtn.hidden=YES;
        

    }
    if ([_fromHome isEqualToString:@"C"])

    {
        _backBtn.hidden=NO;
        menuBtn.hidden=YES;
        
        if ([[AppDelegate appDelegate] connected])
        {
            NSLog(@"yes");
            activity.hidden=NO;
            [activity startAnimating];
            [self getVenderMsgWS];
            
        }
        else
        {
            NSLog(@"no");
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please Check your Internet Connection"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
            
            
        }

        
    }
    
    if ([_fromHome isEqualToString:@"M"])
        
    {
        _backBtn.hidden=YES;
        menuBtn.hidden=NO;
        
        if ([[AppDelegate appDelegate] connected])
        {
            NSLog(@"yes");
            activity.hidden=NO;
            [activity startAnimating];
            [self getVenderMsgWS];
            
        }
        else
        {
            NSLog(@"no");
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please Check your Internet Connection"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
            
            
        }

        
        
    }

}

-(void)goToBottom
{
    NSIndexPath *lastIndexPath = [self lastIndexPath];
    
    [_tableView scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
-(NSIndexPath *)lastIndexPath
{
    NSInteger lastSectionIndex = MAX(0, [_tableView numberOfSections] - 1);
    NSInteger lastRowIndex = MAX(0, [_tableView numberOfRowsInSection:lastSectionIndex] - 1);
    return [NSIndexPath indexPathForRow:lastRowIndex inSection:lastSectionIndex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.viewDeckController setLeftLedge:70];

    [self.navigationController setNavigationBarHidden:YES];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)signinBtnTpd:(id)sender
{
    
    NSString *message=nil;
    
    
     if([_textView.text isEqualToString:@""])
    {
        message = @"Please enter your text!";
    }
    
    
    if (message)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
  
    }
    else
    {
        activity.hidden=NO;
        [activity startAnimating];
        
        
        if ([_fromHome isEqualToString:@"C"]||[_fromHome isEqualToString:@"M"])
        {
            
            
            if ([[AppDelegate appDelegate] connected])
            {
                NSLog(@"yes");
                activity.hidden=NO;
                [activity startAnimating];
                [self VenderSendMessageWS];
                
            }
            else
            {
                NSLog(@"no");
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please Check your Internet Connection"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                
                
                
            }

            

        }
        else
        {
            
            if ([[AppDelegate appDelegate] connected])
            {
                NSLog(@"yes");
                activity.hidden=NO;
                [activity startAnimating];
                [self sendMessageWS];
                
            }
            else
            {
                NSLog(@"no");
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please Check your Internet Connection"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                
                
                
            }

        }
    }
}

-(void)sendMessageWS
{
    activity.hidden=NO;
    [activity startAnimating];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    [dict setValue:[AppDelegate appDelegate].venderId forKey:@"Sender_Id"];
    [dict setValue:@"1" forKey:@"Receiver_Id"];
    [dict setValue:_idExam forKey:@"Exam_Id"];
    [dict setValue:@"examupcome" forKey:@"chat_type"];
    [dict setValue:_textView.text forKey:@"message"];
    [dict setValue:@XKEY forKey:@"X-API-KEY"];
    [manager POST:[NSString stringWithFormat:@"%smsginsert/",URLBase] parameters:dict
constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     
     {
         
     } success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         [activity stopAnimating];
         activity.hidden=YES;
         NSLog(@"Response Object%@",responseObject);
         
         NSString *responseCode =[responseObject valueForKey:@"responseCode"];
          NSString *responseMsg =[responseObject valueForKey:@"message"];
         if ([responseCode isEqualToString:@"success "])
         {
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:responseMsg
                                                            delegate:self
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
             [alert show];
             
             _textView.text=@"";
             _chatArray =[[NSMutableArray alloc] init];
             [self loadChatWS];
             
         }
         
        }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
         [activity stopAnimating];
         activity.hidden=YES;
         
     }];
}

-(void)VenderSendMessageWS
{
    activity.hidden=NO;
    [activity startAnimating];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    [dict setValue:[AppDelegate appDelegate].venderId forKey:@"Sender_Id"];
    [dict setValue:@"1" forKey:@"Receiver_Id"];
    [dict setValue:@"nrmlmsg" forKey:@"chat_type"];
    [dict setValue:_textView.text forKey:@"message"];
    [dict setValue:@XKEY forKey:@"X-API-KEY"];
    [manager POST:[NSString stringWithFormat:@"%smsginsert_normal",URLBase] parameters:dict
constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     
     {
         
     } success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         [activity stopAnimating];
         activity.hidden=YES;
         NSLog(@"Response Object%@",responseObject);
         
         NSString *responseCode =[responseObject valueForKey:@"responseCode"];
         NSString *responseMsg =[responseObject valueForKey:@"message"];
         if ([responseCode isEqualToString:@"success "])
         {
             
             
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:responseMsg
                                                            delegate:self
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
             [alert show];
             
             _textView.text=@"";
             _chatArray =[[NSMutableArray alloc] init];
             [self getVenderMsgWS];
             
         }
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
         [activity stopAnimating];
         activity.hidden=YES;
         
     }];
}

-(void)getVenderMsgWS
{
    activity.hidden=NO;
    [activity startAnimating];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    [dict setValue:[AppDelegate appDelegate].venderId forKey:@"Id"];
    [dict setValue:@"0" forKey:@"Task_Id"];

    [dict setValue:@XKEY forKey:@"X-API-KEY"];
    
    [manager POST:[NSString stringWithFormat:@"%smsgget/",URLBase] parameters:dict
constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     
     {
         
     } success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [activity stopAnimating];
         activity.hidden=YES;
         NSLog(@"Response Object%@",responseObject);
         
         NSString *responseCode =[responseObject valueForKey:@"responseCode"];
         NSString *data =[responseObject valueForKey:@"message"];
         
         if ([responseCode isEqualToString:@"success"])
         {
             _chatArray =[responseObject valueForKey:@"data"];
             
             if ([_chatArray count]==0)
             {
                 
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:data delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 [alert show];
             }
             
             else
             {
                 
                 _tableView.delegate=self;
                 _tableView.dataSource=self;
                 [_tableView reloadData];
                 [self goToBottom];
             }
           
             
         }
         
         else
         {
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Wrong credentials" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [alert show];
             
         }
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
         [activity stopAnimating];
         activity.hidden=YES;
         
     }];
}



-(void)loadChatWS
{
    activity.hidden=NO;
    [activity startAnimating];
        
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
        [dict setValue:[AppDelegate appDelegate].venderId forKey:@"Id"];
        [dict setValue:_idExam forKey:@"Task_Id"];
        [dict setValue:@XKEY forKey:@"X-API-KEY"];
    
    [manager POST:[NSString stringWithFormat:@"%srequest_read_msg/",URLBase] parameters:dict
constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     
     {
         
     } success:^(AFHTTPRequestOperation *operation, id responseObject)
     
     {
         [activity stopAnimating];
         activity.hidden=YES;
         NSLog(@"Response Object%@",responseObject);
         
         NSString *responseCode =[responseObject valueForKey:@"responseCode"];
         if ([responseCode isEqualToString:@"success"])
         {
             
             _chatArray =[responseObject valueForKey:@"data"];
             
             if ([_chatArray count]==0)
             {
                 
             }
             else
             {
             _tableView.delegate=self;
             _tableView.dataSource=self;
             [_tableView reloadData];
             [self goToBottom];
             }
         }
         
         else
         {
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Wrong credentials"
                                                            delegate:self
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
             [alert show];
             
         }
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);         
         [activity stopAnimating];
         activity.hidden=YES;
         
     }];
}

- (IBAction)backBtnAction:(id)sender;

{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.viewDeckController closeLeftViewAnimated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_chatArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * cellIdentifier = @"Cell";
    
    ChatViewCell *cell = (ChatViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier] ;
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ChatViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    
    NSDictionary *dict=[_chatArray objectAtIndex:indexPath.row];
    NSString *senderId =[dict valueForKey:@"sender_id"];
    
    if ([senderId isEqualToString:[AppDelegate appDelegate].venderId])
    {
        cell.msgLbl.text =[dict valueForKey:@"message"] ;
        cell.timetLbl.text = [dict valueForKey:@"msgdate"];
        
        cell.msgLbl1.hidden=YES;
        cell.timetLbl1.hidden=YES;

    }
    else
        
    {
        cell.msgLbl1.text =[dict valueForKey:@"message"] ;
        cell.timetLbl1.text = [dict valueForKey:@"msgdate"];
        
        cell.msgLbl.hidden=YES;
        cell.timetLbl.hidden=YES;
    }
    
   
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor =[UIColor clearColor];
    
    return cell;
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"])
    {
        
        [textView resignFirstResponder];
        // Return FALSE so that the final '\n' character doesn't get added
        return NO;
    }
    // For any other character return TRUE so that the text gets added to the view
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{

    _chatTextView.frame=CGRectMake(13,180,292,151);
    
    _tableView.frame=CGRectMake(8,-130,304,318);


    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    _chatTextView.frame=CGRectMake(13,380,292,151);
    _tableView.frame=CGRectMake(8,60,304,318);

    return YES;
  
}

@end
