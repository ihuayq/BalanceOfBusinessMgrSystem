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
#import "BankAccountTableViewCell.h"
#import "BMAccountCellInfo.h"
#import "bindNetworkPointAccountViewController.h"
#import "bindSuccessSwitchViewController.h"
#import "ItemButton.h"
#import "BankAccountItem.h"

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
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon_new"];
    
    [self requestNetWork];
}

-(void)initUI{
    [self initGroup];
    
    //自然人姓名
    UILabel * manTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, NAVIGATION_OUTLET_HEIGHT + 15, MainWidth - 2*20, 20)];
    manTitleLabel.text = [NSString stringWithFormat:@"姓名:%@",[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:@"personName"]];
    manTitleLabel.textAlignment = NSTextAlignmentCenter;
    manTitleLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    manTitleLabel.font = [UIFont systemFontOfSize:14];
    manTitleLabel.backgroundColor = [UIColor clearColor];
    manTitleLabel.numberOfLines = 0;
    [self.view addSubview:manTitleLabel];
    
//    manNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, manTitleLabel.frame.size.height + manTitleLabel.frame.origin.y + 10, 50, 20)];
//    manNameLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"personName"];
//    manNameLabel.textAlignment = NSTextAlignmentCenter;
//    manNameLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
//    manNameLabel.font = [UIFont systemFontOfSize:14];
//    manNameLabel.backgroundColor = [UIColor clearColor];
//    manNameLabel.numberOfLines = 0;
//    [self.view addSubview:manNameLabel];
    
    //身份证号码
    UILabel * identifyTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake( 20 , manTitleLabel.frame.size.height + manTitleLabel.frame.origin.y + 15, MainWidth - 2*20, 20)];
    identifyTitleLabel.text = [NSString stringWithFormat:@"身份证号码:%@",[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:@"identifyno"]];
    identifyTitleLabel.textAlignment = NSTextAlignmentCenter;
    identifyTitleLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    identifyTitleLabel.font = [UIFont systemFontOfSize:14];
    identifyTitleLabel.backgroundColor = [UIColor clearColor];
    identifyTitleLabel.numberOfLines = 0;
    [self.view addSubview:identifyTitleLabel];
    
//    identifyLabel = [[UILabel alloc] initWithFrame:CGRectMake(identifyTitleLabel.frame.size.width + identifyTitleLabel.frame.origin.x, NAVIGATION_OUTLET_HEIGHT + 15,180, 20)];
//    identifyLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"identifyno"];
//    identifyLabel.textAlignment = NSTextAlignmentLeft;
//    identifyLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
//    identifyLabel.font = [UIFont systemFontOfSize:14];
//    identifyLabel.backgroundColor = [UIColor clearColor];
//    identifyLabel.numberOfLines = 0;
//    [self.view addSubview:identifyLabel];
    
    //手机号码
    UILabel * telephoneTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, identifyTitleLabel.frame.size.height + identifyTitleLabel.frame.origin.y + 15, MainWidth - 2*20, 20)];
    telephoneTitleLabel.text = [NSString stringWithFormat:@"手机号码:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"phoneNum"]];
    telephoneTitleLabel.textAlignment = NSTextAlignmentCenter;
    telephoneTitleLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    telephoneTitleLabel.font = [UIFont systemFontOfSize:14];
    telephoneTitleLabel.backgroundColor = [UIColor clearColor];
    telephoneTitleLabel.numberOfLines = 0;
    [self.view addSubview:telephoneTitleLabel];
    
//    telephoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(telephoneTitleLabel.frame.size.width + telephoneTitleLabel.frame.origin.x, manTitleLabel.frame.size.height + manTitleLabel.frame.origin.y + 10, 100,20)];
//    telephoneLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"phoneNum"];
//    telephoneLabel.textAlignment = NSTextAlignmentCenter;
//    telephoneLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
//    telephoneLabel.font = [UIFont systemFontOfSize:14];
//    telephoneLabel.backgroundColor = [UIColor clearColor];
//    telephoneLabel.numberOfLines = 0;
//    [self.view addSubview:telephoneLabel];
    
    UIView *seporatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, telephoneTitleLabel.frame.size.height + telephoneTitleLabel.frame.origin.y + 9.5f , MainWidth, 0.5f)];
    seporatorLine.backgroundColor = [UIColor blackColor];
    [self.view addSubview:seporatorLine];
    
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, telephoneTitleLabel.frame.size.height + telephoneTitleLabel.frame.origin.y + 10 ,MainWidth, MainHeight-48.5f - 64.0f - 230.0f)];
    tableView.delegate =self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:tableView];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"allowUpdateFlag"] isEqualToString:@"1"] ){
        //确定
        UIButton *avestButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
        [avestButton setBackgroundImage:[UIImage imageNamed:@"redbn"] forState:UIControlStateNormal];
        [avestButton setBackgroundImage:[UIImage imageNamed:@"redbndj"] forState:UIControlStateHighlighted];
        [avestButton setBackgroundColor:[UIColor greenColor]];
        [avestButton setFrame:CGRectMake(40, tableView.frame.origin.y + tableView.frame.size.height + 10 , MainWidth - 80, 40)];
        [avestButton addTarget:self action:@selector(touchOkButton) forControlEvents:UIControlEventTouchUpInside];
        [avestButton setTitle:@"修改账号" forState:UIControlStateNormal];
        [avestButton.layer setMasksToBounds:YES];
        [avestButton.layer setCornerRadius:avestButton.frame.size.height/2.0f]; //设置矩形四个圆角半径
        [self.view addSubview:avestButton];
        
    }
}

-(void)requestNetWork{
    
    if (![HP_NetWorkUtils isNetWorkEnable])
    {
        [self showSimpleAlertViewWithTitle:nil alertMessage:@"网络不可用，请检查您的网络后重试" cancelButtonTitle:queding otherButtonTitles:nil];
        return;
    }
    [self touchesBegan:nil withEvent:nil];
    
    //http://192.168.1.115:8080/superMoney-core/appInterface/getPersonInfo 参数 commercialId
    
    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:2];
    [connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:USER_ID] forKey:USER_ID];
    //[connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:SUPPLYER_INFO] objectForKey:SUPPLYER_ID]forKey:SUPPLYER_ID];
    
    NSString *url =[NSString stringWithFormat:@"%@%@",IP,bindBankAccountURL];
    
    //[connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:@"curNatureMenInfo"] objectForKey:@"no"] forKey:@"personId"];
    
    
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    
    [connDictionary setObject:Default_Phone_UUID_MD5 forKey:@"deviceId"];//设备id
    
    NSLog(@"connDictionary:%@",connDictionary);
    [self showProgressViewWithMessage:@"正在请求账号数据..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"ret:%@,msg:%@,response:%@",ret,msg,responseJSONDictionary);
         [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
         if([ret isEqualToString:@"100"])
         {
             responseJSONDictionary=[self delStringNullOfDictionary:responseJSONDictionary];
             
//             accountBankname = "\U5de5\U5546\U94f6\U884c";
//             allowUpdateFlag = 0;
//             balanceCardNo = "22****22";
//             flag = 100;
//             idCard = "130203****200322";
//             msg = "\U4e2a\U4eba\U4fe1\U606f";
//             netAccountInfo =     (
//                                   {
//                                       balanceAccount = 2222222222;
//                                       pubAccountName = sdfasdfsaf;
//                                       websiteMark = "\U5de5\U5546\U94f6\U884c";
//                                   }
//                                   );
//             personName = "*\U946b";
//             phonenum = "18****658";
//             recName = sdfasdfsaf;
             //个人银行卡信息
             [[NSUserDefaults standardUserDefaults] setObject:[responseJSONDictionary objectForKey:@"netAccountInfo"] forKey:@"netAccountInfo"];
             

             [[NSUserDefaults standardUserDefaults] setObject:[responseJSONDictionary objectForKey:@"balanceCardNo"] forKey:@"balanceCardNo" ];
             [[NSUserDefaults standardUserDefaults] setObject:[responseJSONDictionary objectForKey:@"accountBankname"] forKey:@"balanceCardBankName" ];
             [[NSUserDefaults standardUserDefaults] setObject:[responseJSONDictionary objectForKey:@"recName"] forKey:@"balanceCardAccountName" ];
             
             //个人信息，身份证，姓名，手机号
             [[NSUserDefaults standardUserDefaults] setObject:[responseJSONDictionary objectForKey:@"personName"]  forKey:@"personName"];
             [[NSUserDefaults standardUserDefaults] setObject:[responseJSONDictionary objectForKey:@"phonenum"] forKey:@"phoneNum"];
             [[NSUserDefaults standardUserDefaults] setObject:[responseJSONDictionary objectForKey:@"idCard"] forKey:@"identifyno"];
             
             //是否允许修改标记
             [[NSUserDefaults standardUserDefaults] setObject:[responseJSONDictionary objectForKey:@"allowUpdateFlag"] forKey:@"allowUpdateFlag"];
             
             [self loadData];
             
             [self initUI];
             
             
         }
         //相同账号同时登陆，返回错误
         else if([ret isEqualToString:reLoginOutFlag])
         {
             [self showSimpleAlertViewWithTitle:nil tag:(int)LoginOutViewTag alertMessage:msg cancelButtonTitle:queding otherButtonTitles:nil];
         }
         else
         {
             [self showSimpleAlertViewWithTitle:nil alertMessage:msg cancelButtonTitle:queding otherButtonTitles:nil];
         }
     } RequestFailureBlock:^(ASIFormDataRequest *request, NSError *error,NSString * msg) {
         NSLog(@"error:%@",error.debugDescription);
         if (![request isCancelled])
         {
             [request cancel];
         }
         [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
         UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:queding otherButtonTitles:nil];
         alertView.tag = 999;
         [alertView show];
     }];
}

-(void)requestModifyData{
    
    if (![HP_NetWorkUtils isNetWorkEnable])
    {
        [self showSimpleAlertViewWithTitle:nil alertMessage:@"网络不可用，请检查您的网络后重试" cancelButtonTitle:queding otherButtonTitles:nil];
        return;
    }
    [self touchesBegan:nil withEvent:nil];
    
    //http://192.168.1.107:8080/superMoney-core/commercia/getCommercialWebsiteInfo?commercialId=M0060013&personId=7
    
    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:2];
    [connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:USER_ID] forKey:USER_ID];
    //[connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:SUPPLYER_INFO] objectForKey:SUPPLYER_ID]forKey:SUPPLYER_ID];
    
    NSString *url =[NSString stringWithFormat:@"%@%@",IP,AccountURL];
    
    //[connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:@"curNatureMenInfo"] objectForKey:@"no"] forKey:@"personId"];
    
    
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    
    [connDictionary setObject:Default_Phone_UUID_MD5 forKey:@"deviceId"];//设备id
    
    NSLog(@"connDictionary:%@",connDictionary);
    [self showProgressViewWithMessage:@"正在请求账号数据..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"ret:%@,msg:%@,response:%@",ret,msg,responseJSONDictionary);
         [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
         if([ret isEqualToString:@"100"])
         {
             responseJSONDictionary=[self delStringNullOfDictionary:responseJSONDictionary];
             
             //设定当前自然人信息
             //服务器需要返回自然人姓名，身份证，手机号码信息，当前自然人是第几个
             //             NSMutableDictionary* Dict=[[NSMutableDictionary alloc]initWithCapacity:0];
             //             [Dict setObject:[responseJSONDictionary objectForKey:USER_ID] forKey:USER_ID];
             //             [Dict setObject:[NSString stringWithFormat:@"%@",[responseJSONDictionary objectForKey:@"personId"]] forKey:@"no"];
             //             [Dict setObject:[responseJSONDictionary objectForKey:@"personName"] forKey:@"name"];
             //             [Dict setObject:[responseJSONDictionary objectForKey:@"phoneNum"] forKey:@"phonenum"];
             //             [Dict setObject:[responseJSONDictionary objectForKey:@"idCard"] forKey:@"identifyno"];
             //             [Dict setObject:[responseJSONDictionary objectForKey:@"websiteList"] forKey:@"accountinfo"];
             //             [[NSUserDefaults standardUserDefaults]setObject:Dict forKey:@"curNatureMenInfo"];
             //保存完毕，注意在修改自然人的入口需要重新设定curNatureMenInfo信息
             
             NSMutableArray *groupNet=[[NSMutableArray alloc]init];
             NSArray *array = [responseJSONDictionary objectForKey:@"websiteList"];
             for ( NSDictionary *dic in array) {
                 //NSDictionary *dic=[array objectAtIndex:0];
                 BankAccountItem *item = [BankAccountItem new];
                 item.accountName = [dic objectForKey:@"pubAccName"];
                 item.bankName = [dic objectForKey:@"pubBankNameDet"];
                 item.bankCardNumber = [dic objectForKey:@"balanceAccount"];
                 item.siteNum = [dic objectForKey:@"siteNum"];
                 item.bSelected = [[dic objectForKey:@"selectedAccFlag"]  boolValue] ;//结算账号选定标记
                 item.bNetworkSelected = [[dic objectForKey:@"selectedFlag"] boolValue];//网点账号选定标记
                 [groupNet addObject:item];
             }
             //methods为true的时候，即按照网点来结算业务，表示返回网点和结算账户都有，且两者相同
             //methods为false的时候，按照商户结算，结算账户必有且只有一个，但是商户账户可能有也可能没有，即websiteList可能为空
             [[NSUserDefaults standardUserDefaults]setObject:[responseJSONDictionary objectForKey:@"methods"] forKey:@"methods"];
             
             // 网点情况
             if ([[responseJSONDictionary objectForKey:@"methods"] isEqualToString:@"TRUE"]) {
                 bindNetworkPointAccountViewController *info = [[bindNetworkPointAccountViewController alloc] init];
                 info.groupBalance = nil;
                 info.groupNetWork = groupNet;
                 [self.navigationController pushViewController:info
                                                      animated:NO];
             }
             //为false的情况，商户情况,含有网点和没有网点的情况，
             else{
                 
                 NSMutableArray *groupBalance=[[NSMutableArray alloc]init];
                 
                 BankAccountItem *item = [BankAccountItem new];
                 item.accountName = [responseJSONDictionary objectForKey:@"cpubAccName"];
                 item.bankName = [responseJSONDictionary objectForKey:@"cpubBankNameDet"];
                 item.bankCardNumber = [responseJSONDictionary objectForKey:@"cbalanceAccount"];
                 item.bSelected = YES;
                 [groupBalance addObject:item];
                 //含有网点，进入网点，不可以选择
                 if (groupNet.count > 0) {
                     bindNetworkPointAccountViewController *info = [[bindNetworkPointAccountViewController alloc] init];
                     info.groupBalance = groupBalance;
                     info.groupNetWork = groupNet;
                     [self.navigationController pushViewController:info
                                                          animated:NO];
                 }
                 //直接跳过网点选择界面
                 else{
                     bindBalanceAccountViewController *info = [[bindBalanceAccountViewController alloc] init];
                     info.groupNetWork = groupNet;
                     info.groupBalance = groupBalance;
                     [self.navigationController pushViewController:info
                                                          animated:NO];
                 }
             }
         }
         //相同账号同时登陆，返回错误
         else if([ret isEqualToString:reLoginOutFlag])
         {
             [self showSimpleAlertViewWithTitle:nil tag:(int)LoginOutViewTag alertMessage:msg cancelButtonTitle:queding otherButtonTitles:nil];
         }
         else
         {
             [self showSimpleAlertViewWithTitle:nil alertMessage:msg cancelButtonTitle:queding otherButtonTitles:nil];
         }
     } RequestFailureBlock:^(ASIFormDataRequest *request, NSError *error,NSString * msg) {
         NSLog(@"error:%@",error.debugDescription);
         if (![request isCancelled])
         {
             [request cancel];
         }
         [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
         UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:queding otherButtonTitles:nil];
         alertView.tag = 999;
         [alertView show];
     }];
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
    itemBalance.bankCardNumber = [[NSUserDefaults standardUserDefaults]  objectForKey:@"balanceCardNo" ];
    itemBalance.bankName = [[NSUserDefaults standardUserDefaults]  objectForKey:@"balanceCardBankName" ];
    itemBalance.accountName = [[NSUserDefaults standardUserDefaults]  objectForKey:@"balanceCardAccountName" ];
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
    [self requestModifyData];
    //[self.navigationController popViewControllerAnimated:YES];
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
