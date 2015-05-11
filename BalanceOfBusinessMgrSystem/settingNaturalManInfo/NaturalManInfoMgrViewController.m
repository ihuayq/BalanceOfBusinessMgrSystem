//
//  NaturalManInfoMgrViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/11.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "NaturalManInfoMgrViewController.h"
#import "NaturalManInfoTableViewCell.h"

@interface NaturalManInfoMgrViewController (){
    UITableView *tableView;
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
    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSLog(@"计算每组(组%i)行数",(int)section);
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * dentifier = @"cell";
    //NSIndexPath是一个结构体，记录了组和行信息
    NSLog(@"生成单元格(组：%d,行%d)",(int)indexPath.section,(int)indexPath.row);
    
    NaturalManInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dentifier];
    if (cell == nil) {
        cell = [[NaturalManInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:dentifier];
    }
    
    NaturalManItemModel *item = [NaturalManItemModel new];
    item.telephoneNumber = @"17701315969";
    item.manName = @"huayq";
    item.identifyNumber = @"30421188809871234";
    item.status = @"正常";
    item.bCanModify = YES;
    
    cell.model = item;
    
    return cell;
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
