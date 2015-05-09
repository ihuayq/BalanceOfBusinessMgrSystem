//
//  AccRechDetailVC.m
//  ipaycard
//
//  Created by RenLongfei on 13-12-18.
//  Copyright (c) 2013年 Davidsph. All rights reserved.
//

#import "AccRechDetailVC.h"

#import "DAccData.h"

@interface AccRechDetailVC (){
    DAccData *detailAccR;
}
@property (strong, nonatomic) IBOutlet UILabel *timeAccR;
@property (strong, nonatomic) IBOutlet UILabel *reqIdAccR;
@property (strong, nonatomic) IBOutlet UILabel *nameAccR;
@property (strong, nonatomic) IBOutlet UILabel *chargeVAccR;

@end

@implementation AccRechDetailVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setBarTitle:@"账户充值详情"];

    UIImage *imageS=[UIImage imageNamed:@"返回.png"];
    UIButton *leftBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, imageS.size.width/2, imageS.size.height/2);
    
    [leftBtn setBackgroundImage:imageS forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"返回_d.png"] forState:UIControlStateSelected];
    [leftBtn addTarget:self action:@selector(leftbt:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftB=[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    [self.navigationItem setLeftBarButtonItem:leftB];
    
    detailAccR = [DAccData newInstance];
    _timeAccR.text = detailAccR.dealtime;
    _reqIdAccR.text = detailAccR.ordNum;
    _nameAccR.text = Default_UserMobile_Value;
    
    _chargeVAccR.text= [NSString stringWithFormat:@"¥%@", detailAccR.accChargeValue];
    
}

- (void)leftbt:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
