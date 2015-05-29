//
//  NatureManAccountInfoViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/29.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "NatureManAccountInfoViewController.h"
#import "BMAccountCellInfo.h"
#import "BankAccountItem.h"
#import "BankAccountTableViewCell.h"
#import "BMAccountCellInfo.h"
#import "bindBalanceAccountViewController.h"
#import "bindSuccessSwitchViewController.h"
#import "ItemButton.h"
#import "BankAccountItem.h"
#import "Globle.h"
#import "DXAlertView.h"
#import "ModifyNaturalmanSuccessViewController.h"

@interface NatureManAccountInfoViewController (){
    UITableView * tableView;
    NSMutableArray *group;//cell数组
    
    UILabel * manNameLabel;
    UILabel * identifyLabel;
    UILabel * telephoneLabel;
    
    NSMutableArray *balanceAccountSelected;
    NSMutableArray *networkAccountSelected;
}

@end

@implementation NatureManAccountInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigation.title = @"我的信息";
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon.png"];
    
    [self initGroup];
    
    //自然人姓名
    UILabel * manTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, NAVIGATION_OUTLET_HEIGHT + 15, 70, 20)];
    manTitleLabel.text = [NSString stringWithFormat:@"自然人%@",[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:USER_ID]];
    manTitleLabel.textAlignment = NSTextAlignmentCenter;
    manTitleLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    manTitleLabel.font = [UIFont systemFontOfSize:14];
    manTitleLabel.backgroundColor = [UIColor clearColor];
    manTitleLabel.numberOfLines = 0;
    [self.view addSubview:manTitleLabel];
    
    manNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, manTitleLabel.frame.size.height + manTitleLabel.frame.origin.y + 10, 50, 20)];
    manNameLabel.text = [[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:@"personName"];
    manNameLabel.textAlignment = NSTextAlignmentCenter;
    manNameLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    manNameLabel.font = [UIFont systemFontOfSize:14];
    manNameLabel.backgroundColor = [UIColor clearColor];
    manNameLabel.numberOfLines = 0;
    [self.view addSubview:manNameLabel];
    
    //身份证号码
    UILabel * identifyTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(manTitleLabel.frame.size.width + manTitleLabel.frame.origin.x + 5 , NAVIGATION_OUTLET_HEIGHT + 15, 90, 20)];
    identifyTitleLabel.text = @"身份证号码:";
    identifyTitleLabel.textAlignment = NSTextAlignmentCenter;
    identifyTitleLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    identifyTitleLabel.font = [UIFont systemFontOfSize:14];
    identifyTitleLabel.backgroundColor = [UIColor clearColor];
    identifyTitleLabel.numberOfLines = 0;
    [self.view addSubview:identifyTitleLabel];
    
    identifyLabel = [[UILabel alloc] initWithFrame:CGRectMake(identifyTitleLabel.frame.size.width + identifyTitleLabel.frame.origin.x, NAVIGATION_OUTLET_HEIGHT + 15,180, 20)];
    identifyLabel.text = [[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:@"identifyno"];
    identifyLabel.textAlignment = NSTextAlignmentLeft;
    identifyLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    identifyLabel.font = [UIFont systemFontOfSize:14];
    identifyLabel.backgroundColor = [UIColor clearColor];
    identifyLabel.numberOfLines = 0;
    [self.view addSubview:identifyLabel];
    
    //手机号码
    UILabel * telephoneTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(manTitleLabel.frame.size.width + manTitleLabel.frame.origin.x +30, manTitleLabel.frame.size.height + manTitleLabel.frame.origin.y + 10, 70, 20)];
    telephoneTitleLabel.text = @"手机号码:";
    telephoneTitleLabel.textAlignment = NSTextAlignmentCenter;
    telephoneTitleLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    telephoneTitleLabel.font = [UIFont systemFontOfSize:14];
    telephoneTitleLabel.backgroundColor = [UIColor clearColor];
    telephoneTitleLabel.numberOfLines = 0;
    [self.view addSubview:telephoneTitleLabel];
    
    telephoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(telephoneTitleLabel.frame.size.width + telephoneTitleLabel.frame.origin.x, manTitleLabel.frame.size.height + manTitleLabel.frame.origin.y + 10, 100,20)];
    telephoneLabel.text = [[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:@"phoneNum"];
    telephoneLabel.textAlignment = NSTextAlignmentCenter;
    telephoneLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    telephoneLabel.font = [UIFont systemFontOfSize:14];
    telephoneLabel.backgroundColor = [UIColor clearColor];
    telephoneLabel.numberOfLines = 0;
    [self.view addSubview:telephoneLabel];
    
    UIView *seporatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, telephoneLabel.frame.size.height + telephoneLabel.frame.origin.y + 9.5f , MainWidth, 0.5f)];
    seporatorLine.backgroundColor = [UIColor blackColor];
    [self.view addSubview:seporatorLine];
    
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, telephoneLabel.frame.size.height + telephoneLabel.frame.origin.y + 10 ,MainWidth, MainHeight-48.5f - 44.0f - 130.0f)];
    tableView.delegate =self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:tableView];
    
    //确定
    UIButton *avestButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [avestButton setBackgroundImage:[UIImage imageNamed:@"redbn"] forState:UIControlStateNormal];
    [avestButton setBackgroundImage:[UIImage imageNamed:@"redbndj"] forState:UIControlStateHighlighted];
    [avestButton setBackgroundColor:[UIColor greenColor]];
    [avestButton setFrame:CGRectMake(40, tableView.frame.origin.y + tableView.frame.size.height + 10 , MainWidth - 80, 40)];
    [avestButton addTarget:self action:@selector(touchOkButton) forControlEvents:UIControlEventTouchUpInside];
    [avestButton setTitle:@"确认" forState:UIControlStateNormal];
    [avestButton.layer setMasksToBounds:YES];
    [avestButton.layer setCornerRadius:avestButton.frame.size.height/2.0f]; //设置矩形四个圆角半径
    [self.view addSubview:avestButton];
}

-(void)loadData{

    
//    NSMutableArray *balanceAccountSelected;
//    NSMutableArray *networkAccountSelected;
    //网点账号
    networkAccountSelected=[[NSMutableArray alloc]init];
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"netAccountInfo"];
    for ( NSDictionary *dic in array) {
        //NSDictionary *dic=[array objectAtIndex:0];
        BankAccountItem *item = [BankAccountItem new];
        item.accountName = [dic objectForKey:@"pubAccountName"];
        item.bankName = [dic objectForKey:@"websiteMark"];
        item.bankCardNumber = [dic objectForKey:@"balanceAccount"];

        [networkAccountSelected addObject:item];
    }
    
    balanceAccountSelected=[[NSMutableArray alloc]init];
    BankAccountItem *itemBalance = [BankAccountItem new];
    itemBalance.bankCardNumber = [[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO ] objectForKey:@"balanceCardNo" ];
    itemBalance.bankName = [[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO ] objectForKey:@"balanceCardBankName" ];
    itemBalance.accountName = [[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO ] objectForKey:@"balanceCardAccountName" ];
    [balanceAccountSelected addObject:itemBalance];

}

- (void) initGroup{
    [self loadData];
    
    if (group == nil) {
        group = [NSMutableArray new];
    }
    [group removeAllObjects];
    
    if (networkAccountSelected.count > 0) {
        BMAccountCellGroup *group0=[BMAccountCellGroup initWithName:@"网点账户信息" andDetail:@"W" andContacts:networkAccountSelected];
        [group addObject:group0];
    }
    
    if (balanceAccountSelected.count > 0 ) {
        BMAccountCellGroup *group1=[BMAccountCellGroup initWithName:@"结算账户信息" andDetail:@"W" andContacts:balanceAccountSelected];
        [group addObject:group1];
    }
}

-(void)touchOkButton{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    
    return group.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSLog(@"计算每组(组%i)行数",section);
    BMAccountCellGroup *sec=group[section];
    
    return sec.groups.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * dentifier = @"cell";
    //NSIndexPath是一个结构体，记录了组和行信息
    NSLog(@"生成单元格(组：%i,行%i)",indexPath.section,indexPath.row);
    BMAccountCellGroup *contact=group[indexPath.section];
    BankAccountItem *item=contact.groups[indexPath.row];
    
    BankAccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dentifier];
    if (cell == nil) {
        cell = [[BankAccountTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:dentifier hasSelectBtn:NO];
    }
    cell.title= item.accountName;
    cell.bankName = item.bankName;
    cell.bankCardNumber = item.bankCardNumber;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark 返回每组头标题名称
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSLog(@"生成组（组%i）名称",section);
    BMAccountCellGroup *accountGroup=group[section];
    return accountGroup.name;
    
}

#pragma mark 返回每组尾部说明
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    NSLog(@"生成尾部（组%i）详情",section);
    return @"";
}


#pragma mark - 代理方法
#pragma mark 设置分组标题内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0){
        return 30.0f;
    }
    return 20;
}

#pragma mark 设置尾部说明内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
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
