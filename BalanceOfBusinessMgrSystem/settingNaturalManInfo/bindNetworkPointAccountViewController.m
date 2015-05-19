//
//  bindNetworkPointAccountViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by 华永奇 on 15/5/10.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "bindNetworkPointAccountViewController.h"
#import "BankAccountTableViewCell.h"
#import "BMAccountCellInfo.h"
#import "bindBalanceAccountViewController.h"
#import "BankAccountItem.h"
#import "ItemButton.h"

@interface bindNetworkPointAccountViewController (){
    UITableView * tableView;
    
    UILabel * manTitleLabel;
    UILabel * manNameLabel;
    UILabel * identifyLabel;
    UILabel * telephoneLabel;
    
    NSMutableArray *group;//cell数组
    NSMutableArray *groupSelected;
}

@end

@implementation bindNetworkPointAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigation.title = @"绑定网点账户";
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon.png"];
    
    //test group
    group=[[NSMutableArray alloc]init];
    groupSelected = [[NSMutableArray alloc]init];
    
    //自然人姓名
    manTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, NAVIGATION_OUTLET_HEIGHT + 15, 50, 20)];
    manTitleLabel.text = [NSString stringWithFormat:@"自然人%@",[[[NSUserDefaults standardUserDefaults] objectForKey:@"curNatureMenInfo"] objectForKey:@"no"]];
    manTitleLabel.textAlignment = NSTextAlignmentCenter;
    manTitleLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    manTitleLabel.font = [UIFont systemFontOfSize:14];
    manTitleLabel.backgroundColor = [UIColor clearColor];
    manTitleLabel.numberOfLines = 0;
    [self.view addSubview:manTitleLabel];
    
    manNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, manTitleLabel.frame.size.height + manTitleLabel.frame.origin.y + 10, 50, 20)];
    manNameLabel.text = [[[NSUserDefaults standardUserDefaults] objectForKey:@"curNatureMenInfo"] objectForKey:@"name"];
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
    
    identifyLabel = [[UILabel alloc] initWithFrame:CGRectMake(identifyTitleLabel.frame.size.width + identifyTitleLabel.frame.origin.x, NAVIGATION_OUTLET_HEIGHT + 15,150, 20)];
    identifyLabel.text = [[[NSUserDefaults standardUserDefaults] objectForKey:@"curNatureMenInfo"] objectForKey:@"identifyno"];
    identifyLabel.textAlignment = NSTextAlignmentCenter;
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
    telephoneLabel.text = [[[NSUserDefaults standardUserDefaults] objectForKey:@"curNatureMenInfo"] objectForKey:@"phonenum"];
    telephoneLabel.textAlignment = NSTextAlignmentCenter;
    telephoneLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    telephoneLabel.font = [UIFont systemFontOfSize:14];
    telephoneLabel.backgroundColor = [UIColor clearColor];
    telephoneLabel.numberOfLines = 0;
    [self.view addSubview:telephoneLabel];
    
    UIView *seporatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, telephoneLabel.frame.size.height + telephoneLabel.frame.origin.y + 9.5f , MainWidth, 0.5f)];
    seporatorLine.backgroundColor = [UIColor blackColor];
    [self.view addSubview:seporatorLine];
    
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, telephoneLabel.frame.size.height + telephoneLabel.frame.origin.y + 10 ,MainWidth, MainHeight-48.5f - 44.0f - 150.0f) style:UITableViewStyleGrouped];
    tableView.delegate =self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:tableView];
    
    //确定
    UIButton *avestButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [avestButton setBackgroundImage:[UIImage imageNamed:@"lanbn"] forState:UIControlStateNormal];
    [avestButton setBackgroundImage:[UIImage imageNamed:@"lanbndj"] forState:UIControlStateHighlighted];
    [avestButton setBackgroundColor:[UIColor greenColor]];
    [avestButton setFrame:CGRectMake(40, MainHeight -48.5 - 44.0f - 100 , MainWidth - 80, 40)];
    [avestButton addTarget:self action:@selector(touchOkButton) forControlEvents:UIControlEventTouchUpInside];
    [avestButton setTitle:@"确定" forState:UIControlStateNormal];
    [avestButton.layer setMasksToBounds:YES];
    [avestButton.layer setCornerRadius:avestButton.frame.size.height/2.0f]; //设置矩形四个圆角半径
    [self.view addSubview:avestButton];
    
    
    //开始网络加载网点和账号信息
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
    
    //http://192.168.1.107:8080/superMoney-core/commercia/getCommercialWebsiteInfo?commercialId=M0060013&personId=7
    
    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:2];
    
    [connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:SUPPLYER_INFO] objectForKey:SUPPLYER_ID]forKey:SUPPLYER_ID];

    NSString *url =[NSString stringWithFormat:@"%@%@",CommercialIP,AccountURL];
    
    [connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:@"curNatureMenInfo"] objectForKey:@"no"] forKey:@"personId"];
    //[connDictionary setObject:@"7" forKey:@"personId"];
    
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
//             NSMutableDictionary* info = [[NSUserDefaults standardUserDefaults] objectForKey:SUPPLYER_INFO];
//             id hi = [responseJSONDictionary objectForKey:SUPPLYER_ID];
//             [info setObject:[responseJSONDictionary objectForKey:SUPPLYER_ID]  forKey:SUPPLYER_ID];
//             [info setObject:[NSString stringWithFormat:@"%@",[responseJSONDictionary objectForKey:SUPPLYER_ID]]  forKey:@"huayq"];
//             [info setObject:[NSString stringWithFormat:@"%@",[responseJSONDictionary objectForKey:SUPPLYER_ID]]  forKey:SUPPLYER_ID];
             //[info objectForKey:SUPPLYER_ID] = [NSString stringWithFormat:@"%@",[responseJSONDictionary objectForKey:SUPPLYER_ID]];
                                          
             //服务器需要返回自然人姓名，身份证，手机号码信息，当前自然人是第几个
             NSMutableDictionary* Dict=[[NSMutableDictionary alloc]initWithCapacity:0];
             
             [Dict setObject:[responseJSONDictionary objectForKey:USER_ID] forKey:USER_ID];
             [Dict setObject:[NSString stringWithFormat:@"%@",[responseJSONDictionary objectForKey:@"personId"]] forKey:@"no"];
             [Dict setObject:[responseJSONDictionary objectForKey:@"personName"] forKey:@"name"];
             [Dict setObject:[responseJSONDictionary objectForKey:@"phoneNum"] forKey:@"phonenum"];
             [Dict setObject:[responseJSONDictionary objectForKey:@"idCard"] forKey:@"identifyno"];
             [Dict setObject:[responseJSONDictionary objectForKey:@"websiteList"] forKey:@"accountinfo"];
             [[NSUserDefaults standardUserDefaults]setObject:Dict forKey:@"curNatureMenInfo"];
             
             NSArray *array = [responseJSONDictionary objectForKey:@"websiteList"];
             for ( NSDictionary *dic in array) {
                 //NSDictionary *dic=[array objectAtIndex:0];
                 BankAccountItem *item = [BankAccountItem new];
                 item.accountName = [dic objectForKey:@"pubAccName"];
                 item.bankName = [dic objectForKey:@"pubBankNameDet"];
                 item.bankCardNumber = [dic objectForKey:@"balanceAccount"];
                 item.siteNum = [dic objectForKey:@"siteNum"];
                 item.bSelected = NO;
                 [group addObject:item];
             }
             [self refreshData];
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

-(void)refreshData{
    manTitleLabel.text = [NSString stringWithFormat:@"自然人%@",[[[NSUserDefaults standardUserDefaults] objectForKey:@"curNatureMenInfo"] objectForKey:@"no"]];
    manNameLabel.text = [[[NSUserDefaults standardUserDefaults] objectForKey:@"curNatureMenInfo"] objectForKey:@"name"];
    identifyLabel.text = [[[NSUserDefaults standardUserDefaults] objectForKey:@"curNatureMenInfo"] objectForKey:@"identifyno"];
    telephoneLabel.text = [[[NSUserDefaults standardUserDefaults] objectForKey:@"curNatureMenInfo"] objectForKey:@"phonenum"];;
}

-(void)touchOkButton{
//    if ( groupSelected.count == 0 ) {
//        //提示框
//        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择至少一个账号绑定" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        alertView.tag = 999;
//        [alertView show];
//        return;
//    }
    
    bindBalanceAccountViewController *info = [[bindBalanceAccountViewController alloc] init];
    //info.networkAccountSelect = groupSelected;
    info.group = group;
    [self.navigationController pushViewController:info
                                         animated:NO];
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
        ItemButton *button = [ [ItemButton alloc] initWithFrame:CGRectMake(0.0,0.0,30.0,30.0) withSelect:NO];
        button.backgroundColor = [UIColor clearColor ];
        [button addTarget:self action:@selector(buttonPressedAction:)  forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryView = button;
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
    
    
//    ItemButton *button = (ItemButton *)sender;
//    [button switchStatus];
//    
//    UITableViewCell* cell = (UITableViewCell*)[button superview];
//    NSInteger row = [tableView indexPathForCell:cell].row;
//    //NSNumber *num = [NSNumber numberWithInteger:row];
//    if (button.selected == YES) {
//        
//        [groupSelected addObject:group[row]];
//    }else{
//        [groupSelected removeObject:group[row]];
//    }
//    NSLog(@"the selected group is:%@",groupSelected);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
