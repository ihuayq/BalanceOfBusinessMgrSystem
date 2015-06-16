//
//  BMAccountMainViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/7.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "BMAccountMainViewController.h"
#import "BMAccountCellInfo.h"
#import "BMSettingTransactionpPasswordViewController.h"
#import "ModifyLoginPasswordViewController.h"
#import "ProjectReferViewController.h"
#import "NatureManAccountInfoViewController.h"

@interface BMAccountMainViewController (){
    NSMutableArray *_group;//cell数组
    UIButton *avestButton;
}
@property(strong,nonatomic) UITableView * tableView;
@end

@implementation BMAccountMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initGroup];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigation.title = @"账号";
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_OUTLET_HEIGHT,MainWidth, MainHeight-48.5f - 44.0f) style:UITableViewStyleGrouped];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
    
    //确定
    avestButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [avestButton setBackgroundImage:[UIImage imageNamed:@"redbn"] forState:UIControlStateNormal];
    [avestButton setBackgroundImage:[UIImage imageNamed:@"redbndj"] forState:UIControlStateHighlighted];
    [avestButton setBackgroundColor:[UIColor greenColor]];
    //[avestButton setFrame:CGRectMake(40, MainHeight -48.5 - 100 , MainWidth - 80, 40)];
    [avestButton setFrame:CGRectMake(40, 10 , MainWidth - 80, 40)];
    [avestButton addTarget:self action:@selector(touchExitButton) forControlEvents:UIControlEventTouchUpInside];
    [avestButton setTitle:@"退出当前账号" forState:UIControlStateNormal ];
    [avestButton.layer setMasksToBounds:YES];
    [avestButton.layer setCornerRadius:avestButton.frame.size.height/2.0f]; //设置矩形四个圆角半径
    //[self.view addSubview:avestButton];
}

-(void)touchExitButton{
    [self requestNetwork];
}

-(void)requestNetwork{
    NSString *strLoginName = @"";
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_TYPE] isEqualToString:@"0"]) {
        strLoginName = [[NSUserDefaults standardUserDefaults] objectForKey:LAST_LOGIN_NAME];
    }
    else{
        strLoginName = [[NSUserDefaults standardUserDefaults] objectForKey:LAST_LOGIN_SUPPLYER_NAME];
    }
    
    if (![HP_NetWorkUtils isNetWorkEnable])
    {
        [self showSimpleAlertViewWithTitle:nil alertMessage:@"网络不可用，请检查您的网络后重试" cancelButtonTitle:queding otherButtonTitles:nil];
        return;
    }
    [self touchesBegan:nil withEvent:nil];
    
    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:2];
    [connDictionary setObject:strLoginName forKey:@"loginName"];
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    
    NSString *url =[NSString stringWithFormat:@"%@%@",IP,loginOutUrl];
    
    [connDictionary setObject:Default_Phone_UUID_MD5 forKey:@"deviceId"];//设备id
    
    [self showProgressViewWithMessage:@"取消登录..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"responseJSONDictionary:%@,\n ret:%@ \n msg:%@",responseJSONDictionary,ret,msg);
         [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
         if([ret isEqualToString:@"100"])
         {
             [[NSUserDefaults standardUserDefaults]setObject:nil forKey:USERINFO];
             [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:LOGIN_STATUS];//0未登录、1的登录
             
             NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"2",@"login",@"0",@"isSupplyer", nil];
             NSNotification *notification =[NSNotification notificationWithName:@"LoginInitMainwidow" object:nil userInfo:dict];
             [[NSNotificationCenter defaultCenter] postNotification:notification];
         }
         else
         {
             [self showSimpleAlertViewWithTitle:nil alertMessage:msg cancelButtonTitle:queding otherButtonTitles:nil];
         }
     } RequestFailureBlock:^(ASIFormDataRequest *request, NSError *error, NSString * msg) {
         [[self progressView] dismissWithClickedButtonIndex:0 animated:NO];
         UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:queding otherButtonTitles:nil];
         alertView.tag = 999;
         [alertView show];
     }];
}

- (void) initGroup{
    _group=[[NSMutableArray alloc]init];
    
    BMAccountCellInfo *contact0=[BMAccountCellInfo initWithFirstName:@"当前角色信息"];
    BMAccountCellGroup *group0=[BMAccountCellGroup initWithName:@"C" andDetail:@"With names beginning with C" andContacts:[NSMutableArray arrayWithObjects:contact0, nil]];
    [_group addObject:group0];
    
    
    BMAccountCellInfo *contact1=[BMAccountCellInfo initWithFirstName:@"我的信息"];
    BMAccountCellInfo *contact2=[BMAccountCellInfo initWithFirstName:@"登录密码"];
    BMAccountCellInfo *contact3=[BMAccountCellInfo initWithFirstName:@"交易密码"];
    BMAccountCellGroup *group1=[BMAccountCellGroup initWithName:@"C" andDetail:@"With names beginning with C" andContacts:[NSMutableArray arrayWithObjects:contact1,contact2,contact3, nil]];
    [_group addObject:group1];
    
    
    
    BMAccountCellInfo *contact4=[BMAccountCellInfo initWithFirstName:@"关于超额宝"];
    BMAccountCellGroup *group2=[BMAccountCellGroup initWithName:@"B" andDetail:@"With names beginning with B" andContacts:[NSMutableArray arrayWithObjects:contact4, nil]];
    [_group addObject:group2];
    
    BMAccountCellInfo *contact5=[BMAccountCellInfo initWithFirstName:@"退出当前账号"];
    BMAccountCellGroup *group3=[BMAccountCellGroup initWithName:@"B" andDetail:@"With names beginning with B" andContacts:[NSMutableArray arrayWithObjects:contact5, nil]];
    [_group addObject:group3];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    
    return _group.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    //NSLog(@"计算每组(组%i)行数",section);
    BMAccountCellGroup *group1=_group[section];
    return group1.groups.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * dentifier = @"cell";
    //NSIndexPath是一个结构体，记录了组和行信息
    //NSLog(@"生成单元格(组：%i,行%i)",indexPath.section,indexPath.row);
    BMAccountCellGroup *group=_group[indexPath.section];
    BMAccountCellInfo *contact=group.groups[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:dentifier];
        if(indexPath.section == 0 )
        {
            [self setAccount:cell];
        }
        else if (indexPath.section == 3 ){
            [cell addSubview:avestButton];
        }
        else {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    if (indexPath.section == 0 || indexPath.section == 3) {
        return cell;
    }
    
    cell.textLabel.text=contact.title;
    
    if( indexPath.section == 1 )
    {
        if (indexPath.row == 1 || indexPath.row == 2) {
            cell.detailTextLabel.text=@"修改";
        }
    }
//    else if (indexPath.section == 0)
//    {
//        
//        //cell.detailTextLabel.text= self.accountInfo;
//        cell.detailTextLabel.text=@"自然人";
//    }

    
    return cell;
}

-(void)setAccount:(UITableViewCell *)cell{
    //自然人姓名
    UILabel *TitleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
    TitleLabel1.text = [NSString stringWithFormat:@"当前账号"];
    TitleLabel1.textAlignment = NSTextAlignmentCenter;
    TitleLabel1.font = [UIFont systemFontOfSize:15];
    TitleLabel1.numberOfLines = 0;
    [cell addSubview:TitleLabel1];
    
    UILabel *accountLabel = [[UILabel alloc] initWithFrame:CGRectMake( MainWidth - 100, 10, 100, 20)];
    accountLabel.text =[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:@"phoneNum"];
    accountLabel.textAlignment = NSTextAlignmentCenter;
    accountLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    accountLabel.font = [UIFont systemFontOfSize:14];
    accountLabel.backgroundColor = [UIColor clearColor];
    accountLabel.numberOfLines = 0;
    [cell addSubview:accountLabel];
    
    //身份证号码
    UILabel * TitleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 100, 20)];
    TitleLabel2.text = @"角色";
    TitleLabel2.textAlignment = NSTextAlignmentCenter;
    TitleLabel2.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    TitleLabel2.font = [UIFont systemFontOfSize:14];
    TitleLabel2.backgroundColor = [UIColor clearColor];
    TitleLabel2.numberOfLines = 0;
    [cell addSubview:TitleLabel2];
    
    UILabel *manInfo = [[UILabel alloc] initWithFrame:CGRectMake(MainWidth - 80, 30, 50, 20)];
    manInfo.text = @"自然人";
    manInfo.textAlignment = NSTextAlignmentCenter;
    manInfo.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    manInfo.font = [UIFont systemFontOfSize:14];
    manInfo.backgroundColor = [UIColor clearColor];
    manInfo.numberOfLines = 0;
    [cell addSubview:manInfo];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if( indexPath.section == 1  )
    {
        if (indexPath.row == 0) {
            //我的信息
            NatureManAccountInfoViewController *vc = [[NatureManAccountInfoViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if( indexPath.row == 1)
        {
            ModifyLoginPasswordViewController *vc = [[ModifyLoginPasswordViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if( indexPath.row == 2)
        {
            BMSettingTransactionpPasswordViewController *vc = [[BMSettingTransactionpPasswordViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else if (indexPath.section == 2)
    {
        //关于超额宝
        
        ProjectReferViewController *vc = [[ProjectReferViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    

}


#pragma mark 返回每组头标题名称
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSLog(@"生成组（组%i）名称",section);
//    BMAccountCellGroup *group=_group[section];
//    return group.name;
    return @"";
}

#pragma mark 返回每组尾部说明
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    NSLog(@"生成尾部（组%i）详情",section);
    return @"";
//    BMAccountCellGroup *tgroup=_group[section];
//    return tgroup.detail;
}


#pragma mark - 代理方法
#pragma mark 设置分组标题内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0){
        return 0.1f;
    }
    return 10;
}

#pragma mark 设置尾部说明内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
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
