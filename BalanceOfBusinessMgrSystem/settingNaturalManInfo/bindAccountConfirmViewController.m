//
//  bindAccountConfirmViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by 华永奇 on 15/5/11.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "bindAccountConfirmViewController.h"
#import "BankAccountTableViewCell.h"
#import "BMAccountCellInfo.h"
#import "bindBalanceAccountViewController.h"
#import "bindSuccessSwitchViewController.h"
#import "ItemButton.h"
#import "BankAccountItem.h"
#import "Globle.h"
#import "DXAlertView.h"
#import "ModifyNaturalmanSuccessViewController.h"

@interface bindAccountConfirmViewController (){
    UITableView * tableView;
    NSMutableArray *group;//cell数组
    
//    UILabel * manNameLabel;
//    UILabel * identifyLabel;
//    UILabel * telephoneLabel;
    UILabel * identifyLabel;
    UILabel * nameLabel;
    
    NSString *drawCashCardNo;
}

@end

@implementation bindAccountConfirmViewController

- (void) initGroup{
    group = [[NSMutableArray alloc]init];
    
    if (self.networkAccountSelected.count > 0) {
        BMAccountCellGroup *group0=[BMAccountCellGroup initWithName:@"网点账户信息" andDetail:@"With names beginning with C" andContacts:self.networkAccountSelected];
        [group addObject:group0];
    }
    
    if (self.balanceAccountSelected.count > 0 ) {
        BMAccountCellGroup *group1=[BMAccountCellGroup initWithName:@"结算账户信息" andDetail:@"With names beginning with C" andContacts:self.balanceAccountSelected];
        [group addObject:group1];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigation.title = @"确认信息";
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon_new"];
    
    [self initGroup];
    
    //商户编号
    UILabel * identifyTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30 , NAVIGATION_OUTLET_HEIGHT + 15, 90, 20)];
    identifyTitleLabel.text = @"商户编号:";
    identifyTitleLabel.textAlignment = NSTextAlignmentCenter;
    identifyTitleLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    identifyTitleLabel.font = [UIFont systemFontOfSize:14];
    identifyTitleLabel.backgroundColor = [UIColor clearColor];
    identifyTitleLabel.numberOfLines = 0;
    [self.view addSubview:identifyTitleLabel];
    
    identifyLabel = [[UILabel alloc] initWithFrame:CGRectMake(identifyTitleLabel.frame.size.width + identifyTitleLabel.frame.origin.x, NAVIGATION_OUTLET_HEIGHT + 15,180, 20)];
    identifyLabel.text = [[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:USER_ID];
    identifyLabel.textAlignment = NSTextAlignmentLeft;
    identifyLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    identifyLabel.font = [UIFont systemFontOfSize:14];
    identifyLabel.backgroundColor = [UIColor clearColor];
    identifyLabel.numberOfLines = 0;
    [self.view addSubview:identifyLabel];
    
    //商户名称
    UILabel *nameTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, identifyLabel.frame.size.height + identifyLabel.frame.origin.y + 10, 70, 20)];
    nameTitleLabel.text = @"商户名称:";
    nameTitleLabel.textAlignment = NSTextAlignmentCenter;
    nameTitleLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    nameTitleLabel.font = [UIFont systemFontOfSize:14];
    nameTitleLabel.backgroundColor = [UIColor clearColor];
    nameTitleLabel.numberOfLines = 0;
    [self.view addSubview:nameTitleLabel];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameTitleLabel.frame.size.width + nameTitleLabel.frame.origin.x, identifyLabel.frame.size.height + identifyLabel.frame.origin.y + 10, 160,20)];
    nameLabel.text = [[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:USER_NAME];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.numberOfLines = 0;
    [self.view addSubview:nameLabel];
    
    UIView *seporatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, nameLabel.frame.size.height + nameLabel.frame.origin.y + 9.5f , MainWidth, 0.5f)];
    seporatorLine.backgroundColor = [UIColor blackColor];
    [self.view addSubview:seporatorLine];
    
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, nameLabel.frame.size.height + nameLabel.frame.origin.y + 10 ,MainWidth, MainHeight-48.5f - 44.0f - 150.0f) style:UITableViewStyleGrouped];
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


-(void)touchOkButton{
    //商户为false的情况下是后台自动绑定的
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"methods"] isEqualToString:@"FALSE"]){
        if ( [Globle shareGloble].whichBalanceAccountEntranceType == MODIFY_NATUREMAN_ENTRANCE){
            ModifyNaturalmanSuccessViewController*vc = [[ModifyNaturalmanSuccessViewController alloc] init];
            [self.navigationController pushViewController:vc animated:NO];
        }
        else{
            bindSuccessSwitchViewController *vc = [[bindSuccessSwitchViewController alloc] init];
            [self.navigationController pushViewController:vc animated:NO];
        }
    }
    else{
        [self requestNetWork];
    }
    
}

-(void)requestNetWork{
    
    if (![HP_NetWorkUtils isNetWorkEnable])
    {
        [self showSimpleAlertViewWithTitle:nil alertMessage:@"网络不可用，请检查您的网络后重试" cancelButtonTitle:queding otherButtonTitles:nil];
        return;
    }
    [self touchesBegan:nil withEvent:nil];
    
    
    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:2];
    //[connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:SUPPLYER_INFO] objectForKey:SUPPLYER_ID]forKey:SUPPLYER_ID];
    //[connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:@"curNatureMenInfo"] objectForKey:@"no"] forKey:@"personId"];
    [connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:USER_ID] forKey:USER_ID];
    
    if (self.networkAccountSelected.count > 0) {
        NSString *strNetwork = @"";
        BMAccountCellGroup *networkGroup=group[0];
        for ( BankAccountItem *item in networkGroup.groups) {
            if (item.bNetworkSelected == YES) {
                
                strNetwork = [strNetwork stringByAppendingString: item.siteNum];
                strNetwork = [strNetwork stringByAppendingString: @"@"];
            }
        }
        if (strNetwork.length > 2) {
            strNetwork = [strNetwork substringToIndex:strNetwork.length-1];
            [connDictionary setObject:strNetwork forKey:@"siteNum"];
        }
    }


   if (self.balanceAccountSelected.count > 0) {
       NSString *strBalance= @"";
       NSString *strBalanceNet= @"";
       
       BMAccountCellGroup *balanceGroup=group[1];
       for ( BankAccountItem *item in balanceGroup.groups) {
           if (item.bSelected == YES) {
               strBalance = [strBalance stringByAppendingString: item.bankCardNumber];
               strBalance = [strBalance stringByAppendingString: @"@"];
               
               drawCashCardNo = item.bankCardNumber;
               
               strBalanceNet = [strBalanceNet stringByAppendingString: item.siteNum];
               strBalanceNet = [strBalanceNet stringByAppendingString: @"@"];
           }
       }
       if ( strBalance.length > 2 ) {
           strBalance = [strBalance substringToIndex:strBalance.length - 1];
           [connDictionary setObject:strBalance forKey:@"accountId"];
       }
       
       if (strBalanceNet.length > 2) {
           strBalanceNet = [strBalanceNet substringToIndex:strBalanceNet.length-1];
           [connDictionary setObject:strBalanceNet forKey:@"balanceSiteNum"];
       }
       
    }


    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    
    NSString *url =[NSString stringWithFormat:@"%@%@",IP,SavaAccountURL];
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
             
             //服务器需要返回自然人姓名，身份证，手机号码信息，当前自然人是第几个
//             NSMutableDictionary*data = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:SUPPLYER_INFO]];
//             NSMutableArray *results = [responseJSONDictionary objectForKey:@"maturalPersonList"];
//             [data setObject:results forKey:@"natureInfo"];
//             [[NSUserDefaults standardUserDefaults]setObject:data forKey:SUPPLYER_INFO];
             //[[[NSUserDefaults standardUserDefaults] objectForKey:SUPPLYER_INFO] setObject:results forKey:@"natureInfo"];

//             if ( [Globle shareGloble].whichBalanceAccountEntranceType == MODIFY_NATUREMAN_ENTRANCE){
//                 ModifyNaturalmanSuccessViewController*vc = [[ModifyNaturalmanSuccessViewController alloc] init];
//                 [self.navigationController pushViewController:vc animated:NO];
//             }
//             else{
//                 bindSuccessSwitchViewController *vc = [[bindSuccessSwitchViewController alloc] init];
//                 [self.navigationController pushViewController:vc animated:NO];
//             }
             NSMutableDictionary*data = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO]];
             [data setObject:@"1" forKey:@"addwebsiteFlag"];
             [[NSUserDefaults standardUserDefaults]setObject:data forKey:USERINFO];
             NSLog(@"the SUPPLYER_INFO is:%@",data);
             
             [[NSUserDefaults standardUserDefaults] setObject:drawCashCardNo forKey:@"drawCardNo"];
             
             
             [self showSimpleAlertViewWithTitle:nil tag:(int)LoginOutViewTag+10 alertMessage:@"账户信息设置成功!" cancelButtonTitle:queding otherButtonTitles:nil];
             
             
//             bindSuccessSwitchViewController *vc = [[bindSuccessSwitchViewController alloc] init];
//             [self.navigationController pushViewController:vc animated:NO];

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

// 在这里处理UIAlertView中的按钮被单击的事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"buttonIndex is : %i",(int)buttonIndex);
    if(alertView.tag == LoginOutViewTag){
        switch (buttonIndex) {
            case 0:{
                NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"4",@"login", nil];
                NSNotification *notification =[NSNotification notificationWithName:@"LoginInitMainwidow" object:nil userInfo:dict];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            }break;
            default:
                break;
        }
    }
    else if(alertView.tag == LoginOutViewTag+10){
        switch (buttonIndex) {
            case 0:{
                [self.navigationController popToRootViewControllerAnimated:YES];
            }break;
            default:
                break;
        }
    }
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
