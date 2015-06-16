//
//  BMWithDrawsCashSuccessViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/12.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "BMWithDrawsCashSuccessViewController.h"
#import "BTLabel.h"

@interface BMWithDrawsCashSuccessViewController ()
@end

@implementation BMWithDrawsCashSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigation.title = @"提现";
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon_new"];
    
    HP_UIImageView *noticeImg = [[HP_UIImageView alloc] initWithFrame:CGRectMake(MainWidth/2-15, NAVIGATION_OUTLET_HEIGHT + 16,30, 30)];
    [noticeImg setImage:[UIImage imageNamed:@"成功"]];
    [self.view addSubview:noticeImg];
    
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
    [drawCashLabel setFrame:CGRectMake(40 ,NAVIGATION_OUTLET_HEIGHT + 60, labelsize.width, labelsize.height)];
    drawCashLabel.text = s;
//   drawCashLabel.backgroundColor =  [UIColor clearColor];
    [drawCashLabel setTextColor:[UIColor lightGrayColor]];
    [self.view addSubview:drawCashLabel];
    
    
    UILabel * drawCashNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(drawCashLabel.frame.origin.x + labelsize.width,NAVIGATION_OUTLET_HEIGHT + 60, 200,20)];
    drawCashNumberLabel.textAlignment = NSTextAlignmentLeft;
    drawCashNumberLabel.text = self.money;
    drawCashNumberLabel.textColor = UISTYLECOLOR;
    drawCashNumberLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:drawCashNumberLabel];
    
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
    //NSMutableString *modifyStr= [[NSMutableString alloc] initWithString:self.cardNum];
    NSMutableString *modifyStr= [[NSMutableString alloc] initWithString:@"HHH"];
    if (modifyStr.length > 10) {
        [modifyStr replaceCharactersInRange:NSMakeRange(4, modifyStr.length-8) withString:@"******"];
    }
    cardNumberLabel.text = modifyStr;
    
    
    UILabel * noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,cardNumberLabel.frame.size.height + cardNumberLabel.frame.origin.y + 20 , MainWidth- 20*2,20)];
    noteLabel.textAlignment = NSTextAlignmentCenter;
    noteLabel.text = @"提现金额将会转入商户账户,自动结算,t+1日到账!";
    noteLabel.font = [UIFont systemFontOfSize:18];
    [noteLabel setTextColor:[UIColor lightGrayColor]];
    [self.view addSubview:noteLabel];
    
//    BTLabel *label;
//    
//    CGFloat fontSize = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad ? 13 : 8;
//    //UIFont *font = [UIFont systemFontOfSize:18];
//    CGColorRef color = [UIColor colorWithHue:0 saturation:0 brightness:0.8 alpha:1].CGColor;
//    NSDictionary *attributes = @{
//                                 NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Thin" size:28],
//                                 NSForegroundColorAttributeName: [UIColor orangeColor]
//                                 };
//    
//    label = [[BTLabel alloc] initWithFrame:CGRectMake(20,cardNumberLabel.frame.size.height + cardNumberLabel.frame.origin.y + 20 , MainWidth- 20*2,40) edgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
//    label.font = [UIFont systemFontOfSize:18];
//    label.text = [NSString stringWithFormat:@"提现金额将会转入商户账户,自动结算,t+1日到账!"];
//    label.verticalAlignment = BTVerticalAlignmentCenter;
//    label.textAlignment = NSTextAlignmentCenter;
//    label.numberOfLines = 4;
//    [self.view addSubview:label];

    
    //确定
    HP_UIButton *okButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [okButton setBackgroundImage:[UIImage imageNamed:@"redbn"] forState:UIControlStateNormal];
    [okButton setBackgroundImage:[UIImage imageNamed:@"redbndj"] forState:UIControlStateHighlighted];
    [okButton setBackgroundColor:[UIColor redColor]];
    [okButton setFrame:CGRectMake(40,MainHeight -200, MainWidth-2*40, 40)];
    [okButton addTarget:self action:@selector(touchOkButton) forControlEvents:UIControlEventTouchUpInside];
    [okButton setTitle:@"确认" forState:UIControlStateNormal];
    [okButton.layer setMasksToBounds:YES];
    [okButton.layer setCornerRadius:okButton.frame.size.height/2.0f]; //设置矩形四个圆角半径
    
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
