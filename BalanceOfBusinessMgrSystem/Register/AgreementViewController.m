//
//  AgreementViewController.m
//  jxtuanuser
//
//  Created by fengxiaoguang on 13-11-15.
//  Copyright (c) 2013年 fengxiaoguang. All rights reserved.
//

#import "AgreementViewController.h"

@interface AgreementViewController ()

@end

@implementation AgreementViewController
@synthesize transferDict;
@synthesize type;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        transferDict=[[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initUI];
    [self getAgreement];
}

-(void) initUI
{
    self.navigationController.navigationBar.hidden=YES;
    
    self.view.backgroundColor=[HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight)];
    [bgView setBackgroundColor:[HP_UIColorUtils colorWithHexString:@"ffffff"]];
    [self.view addSubview:bgView];
    
    HP_UIView *topBarView = [[HP_UIView alloc] init];
    [topBarView setFrame:CGRectMake(0, 0, MainWidth, 64)];
    [topBarView setBackgroundColor:[HP_UIColorUtils colorWithHexString:TOPBAR_COLOR]];
    //topBarView.layer.shadowColor = [[UIColor blackColor] CGColor];
    //topBarView.layer.shadowOpacity = .5;
    //topBarView.layer.shadowOffset = CGSizeMake(0,3);
    [bgView addSubview:topBarView];
    
    UILabel *topBarTextLable = [[UILabel alloc] initWithFrame:CGRectMake((MainWidth-240)/2, 20, 240, 40)];
    if (type==0)
    {
        topBarTextLable.text = @"众信平台服务协议";
    }
    else if (type==1)
    {
        topBarTextLable.text = @"支付通用户注册协议";
    }
    else if (type==2)
    {
        topBarTextLable.text = @"支付通资金存管服务开通协议";
    }
    else if (type==3)
    {
        topBarTextLable.text = @"充值代扣授权委托书";
    }
    else if (type==4)
    {
        topBarTextLable.text = @"个人借款及担保协议";
    }
    else if (type==5)
    {
        topBarTextLable.text = @"投资人风险提示书";
    }
    else if (type==6)
    {
        topBarTextLable.text = @"出借人委托协议";
    }
    else if (type==7)
    {
        topBarTextLable.text = @"债权转让协议";
    }
    else if (type==8)
    {
        topBarTextLable.text = @"债权转让风险提示书";
    }
    else if (type==9)
    {
        topBarTextLable.text = @"债权低价转让协议";
    }
    else if (type==10)
    {
        topBarTextLable.text = @"债权转让风险提示书";
    }
    else if (type==11)
    {
        topBarTextLable.text = @"转让协议";
    }
    
    topBarTextLable.textAlignment = NSTextAlignmentCenter;
    topBarTextLable.backgroundColor = [UIColor clearColor];
    topBarTextLable.textColor = [UIColor whiteColor];
    topBarTextLable.font = [UIFont systemFontOfSize:18];
    //   topBarTextLable.font = [UIFont fontWithName:@"Arial-BoldMT" size:25];
    //topBarTextLable.shadowOffset=CGSizeMake(1, 1);
    //topBarTextLable.shadowColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    [topBarView addSubview:topBarTextLable];
    
    
    HP_UIButton *backButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0, 17, 45, 44)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"button_back_normal"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"button_back_highlight"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(goToBackView) forControlEvents:UIControlEventTouchUpInside];
    [topBarView addSubview:backButton];
    
    
    
    webView = [[UIWebView alloc] init];
    [webView setFrame:CGRectMake(10, 64+10, MainWidth-20, MainHeight-64-20)];
    [webView.scrollView setScrollEnabled:YES];
    [webView.scrollView setShowsHorizontalScrollIndicator:NO];
    [webView.scrollView setBounces:NO];
    [bgView addSubview:webView];
    
    
}
-(void)goToBackView
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)getAgreement
{
    
    if (![HP_NetWorkUtils isNetWorkEnable])
    {
        [self showSimpleAlertViewWithTitle:nil alertMessage:@"网络不可用，请检查您的网络后重试" cancelButtonTitle:queding otherButtonTitles:nil];
        return;
    }
    
    [self touchesBegan:nil withEvent:nil];
    
    //网络请求
    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    [connDictionary setObject:@"APP" forKey:@"source"];
    
    
    if (type==0)
    {
        [connDictionary setObject:@"REGISTER" forKey:@"type"];
    }
    else if (type==1)
    {
        [connDictionary setObject:@"REGISTER" forKey:@"type"];
    }
    else if (type==2)//CUSTODY:资金托管服务开通协议
    {
        [connDictionary setObject:@"CUSTODY" forKey:@"type"];
    }
    else if (type==3)//出借人充值代扣委托书
    {
        [connDictionary setObject:@"RECHARGE" forKey:@"type"];
    }
    else if (type==4)
    {
        [connDictionary setObject:@"ORIG" forKey:@"type"];
    }
    else if (type==5)
    {
        [connDictionary setObject:@"INVESTOR" forKey:@"type"];
    }
    else if (type==6)
    {
        [connDictionary setObject:@"LENDERS" forKey:@"type"];
    }
    else if (type==7)
    {
        [connDictionary setObject:@"GENERALTRANS" forKey:@"type"];
    }
    else if (type==8)
    {
        [connDictionary setObject:@"TRANSFERINVESTOR" forKey:@"type"];
    }
    else if (type==9)
    {
        [connDictionary setObject:@"FASTTRANSFER" forKey:@"type"];
    }
    else if (type==10)
    {
        [connDictionary setObject:@"TRANSFERINVESTOR" forKey:@"type"];
    }
    else if (type==11)
    {
        [connDictionary setObject:@"LOW" forKey:@"type"];
    }
    
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"sign"];
    
    
    NSLog(@"connDictionary:%@",connDictionary);
    
    NSString *url =[NSString stringWithFormat:@"%@%@",HostURL,getserviceURL];
    
    
    //[self showProgressViewWithMessage:@""];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"responseJSONDictionary:%@,\n ret:%@ \n msg:%@",responseJSONDictionary,ret,msg);
         [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
         if([ret isEqualToString:@"100"])
         {
             
             if (type==0)
             {
                 
                 [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self delStringNull:[responseJSONDictionary objectForKey:@"content"]]]]];
             }
             else if (type==1)
             {
                 [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self delStringNull:[responseJSONDictionary objectForKey:@"registerurl"]]]]];
                 
             }
             else if (type==2)//支付通用户注册协议
             {
                 [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self delStringNull:[responseJSONDictionary objectForKey:@"registerurl"]]]]];
                 
             }
             else if (type==3)//出借人充值代扣委托书
             {
                 NSLog(@"%@",transferDict);
                 NSMutableArray* array=[[NSMutableArray alloc]initWithCapacity:0];
                 NSDictionary * dictionary=[[NSDictionary alloc]initWithObjectsAndKeys:[[[NSUserDefaults standardUserDefaults]objectForKey:USERINFO] objectForKey:USER_ID],@"userid",[transferDict objectForKey:@"money"],@"money", nil];
                 for (NSString * key in dictionary)
                 {
                     [array addObject:[[key stringByAppendingString:@"="] stringByAppendingString:[NSString stringWithFormat:@"%@",[dictionary objectForKey:key]]]];
                 }
                 NSString* allURLString=[[[self delStringNull:[responseJSONDictionary objectForKey:@"registerurl"]] stringByAppendingString:@"&"] stringByAppendingString:[array componentsJoinedByString:@"&"]];
                 
                 NSLog(@"allURLString =%@",allURLString);
                 [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:allURLString]]];
                 
             }
             else if (type==4)//借贷及担保服务协议(userid,bidno,money)
             {
                 NSLog(@"%@",transferDict);
                 NSMutableArray* array=[[NSMutableArray alloc]initWithCapacity:0];
                 NSDictionary * dictionary=[[NSDictionary alloc]initWithObjectsAndKeys:[[[NSUserDefaults standardUserDefaults]objectForKey:USERINFO] objectForKey:USER_ID],@"userid",[transferDict objectForKey:@"bidno"],@"bidno",[transferDict objectForKey:@"money"],@"money", nil];
                 for (NSString * key in dictionary)
                 {
                     [array addObject:[[key stringByAppendingString:@"="] stringByAppendingString:[NSString stringWithFormat:@"%@",[dictionary objectForKey:key]]]];
                 }
                 NSString* allURLString=[[[self delStringNull:[responseJSONDictionary objectForKey:@"registerurl"]] stringByAppendingString:@"&"] stringByAppendingString:[array componentsJoinedByString:@"&"]];
                 
                 NSLog(@"allURLString =%@",allURLString);
                 [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:allURLString]]];
                 
             }
             else if (type==5)//投资人风险揭示书
             {
                 [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self delStringNull:[responseJSONDictionary objectForKey:@"registerurl"]]]]];
                 
             }
             else if (type==6)//出借人委托协议（userid,bidno）
             {
                 NSLog(@"%@",transferDict);
                 NSMutableArray* array=[[NSMutableArray alloc]initWithCapacity:0];
                 NSDictionary * dictionary=[[NSDictionary alloc]initWithObjectsAndKeys:[[[NSUserDefaults standardUserDefaults]objectForKey:USERINFO] objectForKey:USER_ID],@"userid",[transferDict objectForKey:@"bidno"],@"bidno", nil];
                 for (NSString * key in dictionary)
                 {
                     [array addObject:[[key stringByAppendingString:@"="] stringByAppendingString:[NSString stringWithFormat:@"%@",[dictionary objectForKey:key]]]];
                 }
                 NSString* allURLString=[[[self delStringNull:[responseJSONDictionary objectForKey:@"registerurl"]] stringByAppendingString:@"&"] stringByAppendingString:[array componentsJoinedByString:@"&"]];
                 
                 NSLog(@"allURLString =%@",allURLString);
                 [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:allURLString]]];
                 
             }
             
             else if (type==7)//债权转让协议
             {
                 NSLog(@"transferDict=%@",transferDict);
                 NSMutableArray* array=[[NSMutableArray alloc]initWithCapacity:0];
                 NSDictionary * dictionary=[[NSDictionary alloc]initWithObjectsAndKeys:[[[NSUserDefaults standardUserDefaults]objectForKey:USERINFO] objectForKey:USER_ID],@"userid",[transferDict objectForKey:@"bidno"],@"bidno",[transferDict objectForKey:@"type"],@"type", nil];
                 for (NSString * key in dictionary)
                 {
                     [array addObject:[[key stringByAppendingString:@"="] stringByAppendingString:[NSString stringWithFormat:@"%@",[dictionary objectForKey:key]]]];
                 }
                 NSString* allURLString=[[[self delStringNull:[responseJSONDictionary objectForKey:@"registerurl"]] stringByAppendingString:@"&"] stringByAppendingString:[array componentsJoinedByString:@"&"]];
                 
                 NSLog(@"allURLString =%@",allURLString);
                 [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:allURLString]]];
                 
             }
             else if (type==8)//债权转让风险揭示书
             {
                 [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self delStringNull:[responseJSONDictionary objectForKey:@"registerurl"]]]]];
                 
             }
             else if (type==9)//@"债权低价转让协议"FASTTRANSFER：快速转让协议(userid,bidno)
             {
                 NSLog(@"%@",transferDict);
                 NSMutableArray* array=[[NSMutableArray alloc]initWithCapacity:0];
                 NSDictionary * dictionary=[[NSDictionary alloc]initWithObjectsAndKeys:[[[NSUserDefaults standardUserDefaults]objectForKey:USERINFO] objectForKey:USER_ID],@"userid",[transferDict objectForKey:@"bidno"],@"bidno", nil];
                 for (NSString * key in dictionary)
                 {
                     [array addObject:[[key stringByAppendingString:@"="] stringByAppendingString:[NSString stringWithFormat:@"%@",[dictionary objectForKey:key]]]];
                 }
                 NSString* allURLString=[[[self delStringNull:[responseJSONDictionary objectForKey:@"registerurl"]] stringByAppendingString:@"&"] stringByAppendingString:[array componentsJoinedByString:@"&"]];
                 
                 NSLog(@"allURLString =%@",allURLString);
                 [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:allURLString]]];
                 
             }
             else if (type==10)//债权转让风险揭示书
             {
                 [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self delStringNull:[responseJSONDictionary objectForKey:@"registerurl"]]]]];
                 
             }
             else if (type==11)// 债权转让通知书
             {
                 [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self delStringNull:[responseJSONDictionary objectForKey:@"registerurl"]]]]];
                 
             }
             
             
         }
         else
         {
             
             // [self showSimpleAlertViewWithTitle:nil alertMessage:msg cancelButtonTitle:queding otherButtonTitles:nil];
         }
     } RequestFailureBlock:^(ASIFormDataRequest *request, NSError *error, NSString * msg) {
         
         [[self progressView] dismissWithClickedButtonIndex:0 animated:NO];
         UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:queding otherButtonTitles:nil];
         alertView.tag = 999;
         //[alertView show];
     }];
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
