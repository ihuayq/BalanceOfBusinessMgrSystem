//
//  BMWithDrawsCashSuccessViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/12.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "BMWithDrawsCashSuccessViewController.h"

@interface BMWithDrawsCashSuccessViewController ()
@end

@implementation BMWithDrawsCashSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigation.title = @"提现";
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon.png"];
    
//    self.money = @"134567.98";
//    self.cardNum = @"345608124553535";
//    self.time = @"1989:04:12";
    
    //
//    UILabel * drawCashLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 ,NAVIGATION_OUTLET_HEIGHT + 100, 200,20)];
//    drawCashLabel.textAlignment = NSTextAlignmentCenter;
//    drawCashLabel.text = @"提现金额（元）";
//    drawCashLabel.font = [UIFont systemFontOfSize:18];
//    [self.view addSubview:drawCashLabel];
    UIFont *font = [UIFont systemFontOfSize:18];
    
    UILabel *drawCashLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];//这个frame是初设的，没关系，后面还会重新设置其size。
    [drawCashLabel setNumberOfLines:0];
    NSString *s = @"提现金额（元）:";
    CGSize size = CGSizeMake(320,40);
    CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    [drawCashLabel setFrame:CGRectMake(40 ,NAVIGATION_OUTLET_HEIGHT + 100, labelsize.width, labelsize.height)];
    drawCashLabel.text = s;
//   drawCashLabel.backgroundColor =  [UIColor clearColor];
    [drawCashLabel setTextColor:[UIColor lightGrayColor]];
    [self.view addSubview:drawCashLabel];
    
    
    UILabel * drawCashNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(drawCashLabel.frame.origin.x + labelsize.width,NAVIGATION_OUTLET_HEIGHT + 100, 200,20)];
    drawCashNumberLabel.textAlignment = NSTextAlignmentLeft;
    drawCashNumberLabel.text = self.money;
    drawCashNumberLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:drawCashNumberLabel];
    
//    UILabel * timeNoteLabel = [[UILabel alloc] initWithFrame:CGRectMake( 5 ,drawCashLabel.frame.size.height + drawCashLabel.frame.origin.y + 10, 200,20)];
//    timeNoteLabel.textAlignment = NSTextAlignmentCenter;
//    timeNoteLabel.text = @"预计到账时间:";
//    timeNoteLabel.font = [UIFont systemFontOfSize:18];
//    [self.view addSubview:timeNoteLabel];
    UILabel *timeNoteLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];//这个frame是初设的，没关系，后面还会重新设置其size。
    [timeNoteLabel setNumberOfLines:0];
    NSString *strTimeNote =  @"预计到账时间:";
    //CGSize size = CGSizeMake(320,40);
    CGSize timelabelsize = [strTimeNote sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    [timeNoteLabel setFrame:CGRectMake( 40 ,drawCashLabel.frame.size.height + drawCashLabel.frame.origin.y + 10, timelabelsize.width, timelabelsize.height)];
    timeNoteLabel.text = strTimeNote;
    [timeNoteLabel setTextColor:[UIColor lightGrayColor]];
    [self.view addSubview:timeNoteLabel];
    
    
    UILabel * timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeNoteLabel.frame.origin.x + timelabelsize.width,drawCashLabel.frame.size.height + drawCashLabel.frame.origin.y + 10, 200,20)];
    timeLabel.textAlignment = NSTextAlignmentLeft;
    timeLabel.text = self.time;
    timeLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:timeLabel];
    
    //
//    UILabel * cardNoteLabel = [[UILabel alloc] initWithFrame:CGRectMake( 5 ,timeNoteLabel.frame.size.height + timeNoteLabel.frame.origin.y + 10, 200,20)];
//    cardNoteLabel.textAlignment = NSTextAlignmentCenter;
//    cardNoteLabel.text = @"银行卡号:";
//    cardNoteLabel.font = [UIFont systemFontOfSize:18];
//    [self.view addSubview:cardNoteLabel];
    UILabel *cardNoteLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];//这个frame是初设的，没关系，后面还会重新设置其size。
    [cardNoteLabel setNumberOfLines:0];
    NSString *strCardNote =  @"银行卡号:";
    CGSize cardlabelsize = [strCardNote sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    [cardNoteLabel setFrame:CGRectMake( 40 ,timeNoteLabel.frame.size.height + timeNoteLabel.frame.origin.y + 10, cardlabelsize.width, cardlabelsize.height)];
    cardNoteLabel.text = strCardNote;
    [cardNoteLabel setTextColor:[UIColor lightGrayColor]];
    [self.view addSubview:cardNoteLabel];
    
    UILabel * cardNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(cardNoteLabel.frame.origin.x +cardlabelsize.width,timeNoteLabel.frame.size.height + timeNoteLabel.frame.origin.y +10, 200,20)];
    cardNumberLabel.textAlignment = NSTextAlignmentLeft;
    cardNumberLabel.text = self.cardNum;
    cardNumberLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:cardNumberLabel];
    
    UILabel * noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,cardNumberLabel.frame.size.height + cardNumberLabel.frame.origin.y + 20 , MainWidth- 20*2,20)];
    noteLabel.textAlignment = NSTextAlignmentCenter;
    noteLabel.text = @"提现金额将会转入商户账户,自动结算,t+1日到账!";
    noteLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:noteLabel];
    
//    UILabel *noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,cardNumberLabel.frame.size.height + cardNumberLabel.frame.origin.y + 20 ,0,0)];//这个frame是初设的，没关系，后面还会重新设置其size。
//    [noteLabel setNumberOfLines:0];
//    NSString *s2 = @",自动结算,t+1日到账！";
//    UIFont *font2 = [UIFont systemFontOfSize:10];
//    CGSize labelsize2 = [s2 sizeWithFont:font2 constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
//    [noteLabel setFrame:CGRectMake(20,cardNumberLabel.frame.size.height + cardNumberLabel.frame.origin.y + 20 , labelsize2.width, labelsize2.height)];
//    noteLabel.text =  s2;
//    [self.view addSubview:noteLabel];
    
    //确定
    HP_UIButton *okButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [okButton setBackgroundImage:[UIImage imageNamed:@"lanbn"] forState:UIControlStateNormal];
    [okButton setBackgroundImage:[UIImage imageNamed:@"lanbndj"] forState:UIControlStateHighlighted];
    [okButton setBackgroundColor:[UIColor redColor]];
    [okButton setFrame:CGRectMake(40,MainHeight -200, MainWidth-2*40, 40)];
    [okButton addTarget:self action:@selector(touchOkButton) forControlEvents:UIControlEventTouchUpInside];
    [okButton setTitle:@"确认" forState:UIControlStateNormal];
    [okButton.layer setMasksToBounds:YES];
    [okButton.layer setCornerRadius:okButton.frame.size.height/2.0f]; //设置矩形四个圆角半径
    
    //cancelButton.enabled = false;
    [self.view addSubview:okButton];
    
}

-(void)touchOkButton{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
