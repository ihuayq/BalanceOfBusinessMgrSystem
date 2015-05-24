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
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon.png"];
    self.navigation.rightImage = [UIImage imageNamed:@"addNaturalMan"];
    
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_OUTLET_HEIGHT ,MainWidth, MainHeight-48.5f - 44.0f)];
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
        settingNaturalManInfoViewController *info = [[settingNaturalManInfoViewController alloc] init];
        [self.navigationController pushViewController:info
                                             animated:NO];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSLog(@"计算每组(组%i)行数",(int)section);
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
        [modifyButton addTarget:self action:@selector(touchModifyButton:) forControlEvents:UIControlEventTouchUpInside];
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

-(void)touchModifyButton:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NaturalManInfoTableViewCell* cell = (NaturalManInfoTableViewCell*)[button superview];
    //NSInteger row = [tableView indexPathForCell:cell].row;
    [Globle shareGloble].index = [tableView indexPathForCell:cell];
    //纪录从修改自然人入口进入
    [Globle shareGloble].whichBalanceAccountEntranceType = MODIFY_NATUREMAN_ENTRANCE;
    ModifySingleNaturalManInfoViewController *vc = [[ModifySingleNaturalManInfoViewController alloc]init];
    vc.model = cell.model;
    [self.navigationController pushViewController:vc
                                         animated:NO];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
