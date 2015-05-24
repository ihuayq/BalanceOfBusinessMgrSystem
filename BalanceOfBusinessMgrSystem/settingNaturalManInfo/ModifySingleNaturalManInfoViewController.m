//
//  ModifySingleNaturalManInfoViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/13.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "ModifySingleNaturalManInfoViewController.h"
#import "BankAccountTableViewCell.h"
#import "ModifyNaturalManIdentifyInfoViewController.h"
#import "BankAccountItem.h"
#import "ItemButton.h"
#import "NaturalManItemModel.h"
#import "bindBalanceAccountViewController.h"
#import "bindAccountConfirmViewController.h"


@interface ModifySingleNaturalManInfoViewController ()
{
    UILabel *manNameLabel;
    UILabel *identifyNumberLabel;
    UILabel *telephoneNumberLabel;
    UILabel *statusLabel;
    UILabel *noteModifyLabel;
    
    UITableView *tableView;
    
    NSMutableArray *group;//cell数组
    BOOL isHasNetwork;
    BOOL isSelectBtnEnable;
    NSMutableArray *groupBalance;
}

@end


@implementation ModifySingleNaturalManInfoViewController
@synthesize model = _model;
-(void)setModel:(NaturalManItemModel *)model_{
    _model = model_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigation.title = @"修改自然人信息";
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon.png"];
    
    group=[[NSMutableArray alloc]init];
    //groupBalance = [[NSMutableArray alloc]init];
    
    UILabel *manHeadLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,NAVIGATION_OUTLET_HEIGHT + 20, 72, 20)];
    manHeadLabel.textAlignment = NSTextAlignmentLeft;
    manHeadLabel.backgroundColor = [UIColor clearColor];
    manHeadLabel.textColor = [UIColor blackColor];
    manHeadLabel.font = [UIFont systemFontOfSize:16.0f];
    manHeadLabel.text = [NSString stringWithFormat:@"自然人%d:",self.model.nPosition];
    [self.view addSubview:manHeadLabel];
    
    manNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(manHeadLabel.frame.origin.x + manHeadLabel.frame.size.width, NAVIGATION_OUTLET_HEIGHT + 20 , 120, 20)];
    manNameLabel.textAlignment = NSTextAlignmentLeft;
    manNameLabel.backgroundColor = [UIColor clearColor];
    manNameLabel.textColor = [UIColor lightGrayColor];
    manNameLabel.font = [UIFont systemFontOfSize:16.0f];
    manNameLabel.text = self.model.manName;
    [self.view addSubview:manNameLabel];
    
    //身份证号码
    UILabel *identifyHeadLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, manHeadLabel.frame.origin.y + manHeadLabel.frame.size.height + 5, 100, 20)];
    identifyHeadLabel.textAlignment = NSTextAlignmentLeft;
    identifyHeadLabel.backgroundColor = [UIColor clearColor];
    identifyHeadLabel.textColor = [UIColor blackColor];
    identifyHeadLabel.font = [UIFont systemFontOfSize:16.0f];
    identifyHeadLabel.text = @"身份证号码:";
    [self.view addSubview:identifyHeadLabel];
    
    identifyNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(identifyHeadLabel.frame.origin.x + identifyHeadLabel.frame.size.width, manNameLabel.frame.origin.y + manNameLabel.frame.size.height + 5, 160, 20)];
    identifyNumberLabel.textAlignment = NSTextAlignmentLeft;
    identifyNumberLabel.backgroundColor = [UIColor clearColor];
    identifyNumberLabel.textColor = [UIColor lightGrayColor];
    identifyNumberLabel.font = [UIFont systemFontOfSize:16.0f];
    identifyNumberLabel.text = self.model.identifyNumber;
    [self.view addSubview:identifyNumberLabel];
    
    //修改身份证信息
    UIButton *modifyButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [modifyButton setBackgroundImage:[UIImage imageNamed:@"modify"] forState:UIControlStateNormal];
    [modifyButton setBackgroundImage:[UIImage imageNamed:@"modify"] forState:UIControlStateHighlighted];
    [modifyButton setFrame:CGRectMake(identifyNumberLabel.frame.origin.x + identifyNumberLabel.frame.size.width +5, manNameLabel.frame.origin.y + manNameLabel.frame.size.height + 5, 20, 20)];
    [modifyButton addTarget:self action:@selector(touchModifyIdentifyButton) forControlEvents:UIControlEventTouchUpInside];
    [modifyButton setTitle:@"修改" forState:UIControlStateNormal];
    [self.view addSubview:modifyButton];
    
    //手机号码
    UILabel *teleHeadLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, identifyHeadLabel.frame.origin.y + identifyHeadLabel.frame.size.height + 5, 80, 20)];
    teleHeadLabel.textAlignment = NSTextAlignmentLeft;
    teleHeadLabel.backgroundColor = [UIColor clearColor];
    teleHeadLabel.textColor = [UIColor blackColor];
    teleHeadLabel.font = [UIFont systemFontOfSize:16.0f];
    teleHeadLabel.text = @"手机号码:";
    [self.view addSubview:teleHeadLabel];
    
    telephoneNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(teleHeadLabel.frame.origin.x + teleHeadLabel.frame.size.width, identifyNumberLabel.frame.origin.y + identifyNumberLabel.frame.size.height + 5, 140, 20)];
    telephoneNumberLabel.textAlignment = NSTextAlignmentLeft;
    telephoneNumberLabel.backgroundColor = [UIColor clearColor];
    telephoneNumberLabel.textColor = [UIColor lightGrayColor];
    telephoneNumberLabel.font = [UIFont systemFontOfSize:16.0f];
    telephoneNumberLabel.text = self.model.telephoneNumber;
    [self.view addSubview:telephoneNumberLabel];
    

    UIView *seporatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, teleHeadLabel.frame.size.height + teleHeadLabel.frame.origin.y + 9.5f , MainWidth, 0.5f)];
    seporatorLine.backgroundColor = [UIColor blackColor];
    [self.view addSubview:seporatorLine];
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, teleHeadLabel.frame.size.height + teleHeadLabel.frame.origin.y + 10 ,MainWidth, MainHeight-48.5f - 44.0f - 150.0f) style:UITableViewStyleGrouped];
    tableView.delegate =self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:tableView];
    
    //确定
    UIButton *avestButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [avestButton setBackgroundImage:[UIImage imageNamed:@"lanbn"] forState:UIControlStateNormal];
    [avestButton setBackgroundImage:[UIImage imageNamed:@"lanbndj"] forState:UIControlStateHighlighted];
    [avestButton setBackgroundColor:[UIColor greenColor]];
    [avestButton setFrame:CGRectMake(40, MainHeight -48.5 - 44.0f - 60 , MainWidth - 80, 40)];
    [avestButton addTarget:self action:@selector(touchCommitButton) forControlEvents:UIControlEventTouchUpInside];
    [avestButton setTitle:@"提交" forState:UIControlStateNormal];
    [avestButton.layer setMasksToBounds:YES];
    [avestButton.layer setCornerRadius:avestButton.frame.size.height/2.0f]; //设置矩形四个圆角半径
    [self.view addSubview:avestButton];
    
    //[self testLoadingFile];
    [self requestNetWork];
}

-(void)testLoadingFile{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"bankcard" ofType:@"plist"];
    //NSDictionary *drinkDictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSArray *array = [[NSArray alloc] initWithContentsOfFile:path];
    
    for ( NSDictionary *dic in array) {
        //NSDictionary *dic=[array objectAtIndex:0];
        BankAccountItem *item = [BankAccountItem new];
        item.accountName = [dic objectForKey:@"accoutname"];
        item.bankName = [dic objectForKey:@"bankname"];
        item.bankCardNumber = [dic objectForKey:@"bankcardno"];
        item.bSelected = NO;
        [group addObject:item];
    }
}

-(void)requestNetWork{
    
    if (![HP_NetWorkUtils isNetWorkEnable])
    {
        [self showSimpleAlertViewWithTitle:nil alertMessage:@"网络不可用，请检查您的网络后重试" cancelButtonTitle:queding otherButtonTitles:nil];
        return;
    }
    [self touchesBegan:nil withEvent:nil];
    

    //http://192.168.1.102:8080/superMoney-core/commercia/getUpdateNaturalPersonInfo?personId=7&commercialId=M0060013
    
    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:2];
    
    [connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:SUPPLYER_INFO] objectForKey:SUPPLYER_ID]forKey:SUPPLYER_ID];
    NSString *url =[NSString stringWithFormat:@"%@%@",CommercialIP,ModifyNatureMenURL];
    
    //[connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:@"curNatureMenInfo"] objectForKey:@"no"] forKey:@"personId"];
    [connDictionary setObject:self.model.personID forKey:@"personId"];
//     [connDictionary setObject:self.model.identifyNumber forKey:@"personId"];
//     [connDictionary setObject:self.model.manName forKey:@"personId"];
    
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    
    
    NSLog(@"connDictionary:%@",connDictionary);
    [self showProgressViewWithMessage:@"正在请求账号数据..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"ret:%@,msg:%@,response:%@",ret,msg,responseJSONDictionary);
         [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
         if([ret isEqualToString:@"100"])
         {
             responseJSONDictionary=[self delStringNullOfDictionary:responseJSONDictionary];
             
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
                 [group addObject:item];
             }
             
             [[NSUserDefaults standardUserDefaults] setObject:[responseJSONDictionary objectForKey:@"methods"] forKey:@"methods"];
             if ([[responseJSONDictionary objectForKey:@"methods"] isEqualToString:@"TRUE"]) {
                 id flag = [responseJSONDictionary objectForKey:@"modifyAccFlag"];
                 [[NSUserDefaults standardUserDefaults]setObject:flag forKey:@"modifyAccFlag"];
                 isHasNetwork = YES;
                 isSelectBtnEnable = YES;
                 groupBalance=[[NSMutableArray alloc]init];
                 groupBalance = group ;
             }
             //为false的情况
             else{
                 isSelectBtnEnable = NO;
                 
                 groupBalance=[[NSMutableArray alloc]init];
                 BankAccountItem *item = [BankAccountItem new];
                 item.accountName = [responseJSONDictionary objectForKey:@"cpubAccName"];
                 item.bankName = [responseJSONDictionary objectForKey:@"cpubBankNameDet"];
                 item.bankCardNumber = [responseJSONDictionary objectForKey:@"cbalanceAccount"];
                 item.bSelected = YES;
                 [groupBalance addObject:item];
                 
                 if (group.count > 0) {
                     isHasNetwork = YES;
                 }
                 else{
                     //此时group表示结算账号
                     group = groupBalance;
                     isHasNetwork = NO;
                 }
             }

             
             [tableView reloadData];
             
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


-(void)touchCommitButton{
    
    if (group.count > 0 && isHasNetwork == YES) {
        bindBalanceAccountViewController *info = [[bindBalanceAccountViewController alloc] init];
        info.groupNetWork = group;
        info.groupBalance = groupBalance;
        [self.navigationController pushViewController:info animated:NO];
    }
    else{
        bindAccountConfirmViewController *vc = [[bindAccountConfirmViewController alloc] init];
        vc.networkAccountSelected = nil;
        vc.balanceAccountSelected = groupBalance;
        [self.navigationController pushViewController:vc animated:NO];
    }
}


-(void)touchModifyIdentifyButton{
    ModifyNaturalManIdentifyInfoViewController *vc = [[ModifyNaturalManIdentifyInfoViewController alloc] init];
    vc.model = self.model;
    [vc returnText:^(NSString *nameText, NSString *identifyText) {
        manNameLabel.text  = nameText;
        identifyNumberLabel.text = identifyText;
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSLog(@"计算每组(组%i)行数",section);
    return group.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * dentifier = @"cell";
    //NSIndexPath是一个结构体，记录了组和行信息
    NSLog(@"生成单元格(组：%i,行%i)",indexPath.section,indexPath.row);
    BankAccountItem *item=group[indexPath.row];
    
    BankAccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dentifier];
    if (cell == nil) {
        cell = [[BankAccountTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:dentifier hasSelectBtn:NO];
        ItemButton *button = [[ItemButton alloc] initWithFrame:CGRectMake(0.0,0.0,30.0,30.0) withSelect:item.bSelected];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(buttonPressedAction:)  forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryView = button;
        button.enabled = isSelectBtnEnable;
    }
    cell.title= item.accountName;
    cell.bankName = item.bankName;
    cell.bankCardNumber = item.bankCardNumber;

    return cell;
}

- (void)buttonPressedAction:(id)sender
{
    ItemButton *button = (ItemButton *)sender;
    [button switchStatus];
    
    UITableViewCell* cell = (UITableViewCell*)[button superview];
    NSInteger row = [tableView indexPathForCell:cell].row;
    
    BankAccountItem *item=group[row];
    if (button.selected == YES) {
        item.bNetworkSelected = YES;
    }else{
        item.bNetworkSelected = NO;
    }
}

//- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    UITableViewCell *Cell = [tableView cellForRowAtIndexPath:indexPath];
//    [Cell setSelected:NO animated:NO];
////    [(UIButton *)Cell.accessoryView setHighlighted:NO];
//    return indexPath;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


//#pragma mark 设置分组标题内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

#pragma mark 设置尾部说明内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
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

@end
