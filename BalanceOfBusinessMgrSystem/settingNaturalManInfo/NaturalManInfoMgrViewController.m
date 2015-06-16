//
//  NaturalManInfoMgrViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/11.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "NaturalManInfoMgrViewController.h"
#import "NaturalManInfoTableViewCell.h"
#import "ModifySingleNaturalManInfoViewController.h"
#import "settingNaturalManInfoViewController.h"
#import "Globle.h"

@interface NaturalManInfoMgrViewController (){
    UITableView *tableView;
    NSMutableArray *group;//cell数组
}

@end

@implementation NaturalManInfoMgrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigation.title = @"自然人信息";
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon_new"];
    self.navigation.rightImage = [UIImage imageNamed:@"addperson"];
    
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_OUTLET_HEIGHT ,MainWidth, MainHeight - 44.0f) style:UITableViewStyleGrouped];
    tableView.delegate =self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:tableView];
    
    [self loadData];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NatureManListChange:) name:@"NatureManListChange" object:nil];
    
}



- (void)NatureManListChange:(NSNotification *)text{
    NSLog(@"－－－－－接收到通知--NatureManListChange----");
    if ([text.userInfo[@"type"] isEqualToString:@"0"]) {
        //NSLog(@"%@,%@",text.userInfo[@"personName"],text.userInfo[@"idCard"]);
        NaturalManInfoTableViewCell *cell = [tableView cellForRowAtIndexPath:[Globle shareGloble].index];
        cell.model.identifyNumber = text.userInfo[@"idCard"];
        cell.model.manName = text.userInfo[@"personName"];
        cell.model = cell.model;
    }
    else if ([text.userInfo[@"type"] isEqualToString:@"1"]){
        [self loadData];
        [tableView reloadData];
    }
}

-(void)loadData{
    if (group == nil) {
        group = [NSMutableArray new];
    }
    ///[[NSUserDefaults standardUserDefaults] setObject:[responseJSONDictionary objectForKey:@"assetData"] forKey:@"assetData"];
    //NSArray *results = [responseJSONDictionary objectForKey:@"assetData"];
    NSArray *results = [[[NSUserDefaults standardUserDefaults] objectForKey:SUPPLYER_INFO] objectForKey:@"natureInfo"];
    
    [group removeAllObjects];
    //数据部
    uint nCount = 0;
    for (NSDictionary * sub in results) {
        NSLog(@"%@",sub);
        
        NaturalManItemModel *item = [NaturalManItemModel new];
        item.nPosition = ++nCount;
        item.personID = [NSString stringWithFormat:@"%@",[sub objectForKey:@"personId"]];
        item.telephoneNumber = [NSString stringWithFormat:@"%@",[sub objectForKey:@"phoneNum"]];
        item.manName = [NSString stringWithFormat:@"%@",[[sub objectForKey:@"personName"] URLDecodedString]];
        item.identifyNumber = [NSString stringWithFormat:@"%@",[sub objectForKey:@"idCard"]];
        item.status = [NSString stringWithFormat:@"%@",[[sub objectForKey:@"status"] URLDecodedString]];
        NSLog(@"the modify:%@",sub);
        
        //NSNumber * huayq = [sub objectForKey:@"updateAccFlag"];
        item.bCanModify = [[sub objectForKey:@"updateAccFlag"] boolValue];
        
        [group addObject:item];
    }
    
    //[_tableView reloadData];

}

-(void)rightButtonClickEvent{
    
     //商户网点账号登陆后添加新的自然人业务逻辑
     //methods若为true，需要添加可不可以继续添加自然人的请求
     //methods若为false，并且自然人数目为o的时候，可以添加。若为1，则不允许继续添加
    NSString *methods = [[NSUserDefaults standardUserDefaults] objectForKey:@"methods"];
    if ([methods isEqualToString:@"TRUE"]) {
        [self requestNetInfo];
    }
    else{
        if (group.count > 0) {
            [self showSimpleAlertViewWithTitle:nil alertMessage:@"当前商户不可以添加多个自然人" cancelButtonTitle:queding otherButtonTitles:nil];
            return;
        }
        else{
            settingNaturalManInfoViewController *info = [[settingNaturalManInfoViewController alloc] init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:info
                                                 animated:NO];
        }
    }

}

-(void)requestNetInfo{
    
    if (![HP_NetWorkUtils isNetWorkEnable])
    {
        [self showSimpleAlertViewWithTitle:nil alertMessage:@"网络不可用，请检查您的网络后重试" cancelButtonTitle:queding otherButtonTitles:nil];
        return;
    }
    
    [self touchesBegan:nil withEvent:nil];
    
    //网络请求
    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    [connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:SUPPLYER_INFO] objectForKey:SUPPLYER_ID]forKey:SUPPLYER_ID];
    
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    NSLog(@"connDictionary:%@",connDictionary);

    NSString *url =[NSString stringWithFormat:@"%@%@",CommercialIP,preSettingNatureMenURL];
    [connDictionary setObject:Default_Phone_UUID_MD5 forKey:@"deviceId"];//设备id
    
    [self showProgressViewWithMessage:@"请求添加自然人..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"responseJSONDictionary:%@,\n ret:%@ \n msg:%@",responseJSONDictionary,ret,msg);
         [[self progressView] dismissWithClickedButtonIndex:0 animated:YES];
         if([ret isEqualToString:@"100"])
         {
             //returnCodeSTring=[self delStringNull:[responseJSONDictionary objectForKey:@"code"]];
             settingNaturalManInfoViewController *info = [[settingNaturalManInfoViewController alloc] init];
             self.hidesBottomBarWhenPushed = YES;
             [self.navigationController pushViewController:info
                                                  animated:NO];

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
     } RequestFailureBlock:^(ASIFormDataRequest *request, NSError *error, NSString * msg) {
         [[self progressView] dismissWithClickedButtonIndex:0 animated:NO];
         UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:queding otherButtonTitles:nil];
         alertView.tag = 999;
         [alertView show];
     }];
}



#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSLog(@"计算每组(组%i)行数%d",(int)section,group.count);
    return group.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * dentifier = @"cell";
    //NSIndexPath是一个结构体，记录了组和行信息
    NSLog(@"生成单元格(组：%d,行%d)",(int)indexPath.section,(int)indexPath.row);
    NaturalManItemModel *item = group[indexPath.row];
    
    NaturalManInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dentifier];
    if (cell == nil) {
        cell = [[NaturalManInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:dentifier];
        //确定
        UIButton *modifyButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
        [modifyButton setBackgroundImage:[UIImage imageNamed:@"modify"] forState:UIControlStateNormal];
        [modifyButton setBackgroundImage:[UIImage imageNamed:@"modify"] forState:UIControlStateHighlighted];
        //[modifyButton setBackgroundColor:[UIColor greenColor]];
        [modifyButton setFrame:CGRectMake(0,0,20,20)];
        [modifyButton addTarget:self action:@selector(touchModifyButton:event:) forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryView =  modifyButton;
        
        if (!item.bCanModify) {
            modifyButton.enabled = NO;
        }
        else{
            modifyButton.enabled = YES;
        }
    }
    
    cell.model = item;
    
    return cell;
}

- (void)touchModifyButton:(id)sender event:(id)event
{
    UIButton *button = (UIButton *)sender;
    
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:tableView];
    
    NSIndexPath *indexPath = [tableView indexPathForRowAtPoint:currentTouchPosition];
    if (indexPath != nil)
    {
        [Globle shareGloble].index = indexPath;
        //纪录从修改自然人入口进入
        [Globle shareGloble].whichBalanceAccountEntranceType = MODIFY_NATUREMAN_ENTRANCE;
        ModifySingleNaturalManInfoViewController *vc = [[ModifySingleNaturalManInfoViewController alloc]init];
        //NSLog(@"当前model ％@",cell.model);
        
        vc.model = group[indexPath.row];
        [self.navigationController pushViewController:vc
                                             animated:NO];
    }
}


//-(void)touchModifyButton:(id)sender
//{
//    UIButton *button = (UIButton *)sender;
//    NaturalManInfoTableViewCell* cell = (NaturalManInfoTableViewCell*)[button superview];
//    //NSInteger row = [tableView indexPathForCell:cell].row;
//    NSIndexPath *indexPath = [tableView indexPathForCell:cell];
//    [Globle shareGloble].index = [tableView indexPathForCell:cell];
//    //纪录从修改自然人入口进入
//    [Globle shareGloble].whichBalanceAccountEntranceType = MODIFY_NATUREMAN_ENTRANCE;
//    ModifySingleNaturalManInfoViewController *vc = [[ModifySingleNaturalManInfoViewController alloc]init];
//    //NSLog(@"当前model ％@",cell.model);
//    
//    vc.model = group[indexPath.row];
//    [self.navigationController pushViewController:vc
//                                         animated:NO];
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
//    if (indexPath != nil)
//    {
//        [Globle shareGloble].index = indexPath;
//        //纪录从修改自然人入口进入
//        [Globle shareGloble].whichBalanceAccountEntranceType = MODIFY_NATUREMAN_ENTRANCE;
//        ModifySingleNaturalManInfoViewController *vc = [[ModifySingleNaturalManInfoViewController alloc]init];
//        //NSLog(@"当前model ％@",cell.model);
//        
//        vc.model = group[indexPath.row];
//        [self.navigationController pushViewController:vc
//                                             animated:NO];
//    }
}

#pragma mark - 代理方法
#pragma mark 设置分组标题内容高度
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
