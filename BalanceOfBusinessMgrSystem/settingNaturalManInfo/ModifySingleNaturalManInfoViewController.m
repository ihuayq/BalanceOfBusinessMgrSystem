//
//  ModifySingleNaturalManInfoViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/13.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "ModifySingleNaturalManInfoViewController.h"
#import "BankAccountTableViewCell.h"

@interface ModifySingleNaturalManInfoViewController ()
{
    UILabel *manNameLabel;
    UILabel *identifyNumberLabel;
    UILabel *telephoneNumberLabel;
    UILabel *statusLabel;
    UILabel *noteModifyLabel;
    
    UITableView *tableView;
}

@end

@implementation ModifySingleNaturalManInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *manHeadLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 2, 72, 20)];
    manHeadLabel.textAlignment = NSTextAlignmentCenter;
    manHeadLabel.backgroundColor = [UIColor clearColor];
    manHeadLabel.textColor = [UIColor blackColor];
    manHeadLabel.font = [UIFont systemFontOfSize:16.0f];
    manHeadLabel.text = [NSString stringWithFormat:@"自然人%d:",1];
    [self.view addSubview:manHeadLabel];
    
    manNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(manHeadLabel.frame.origin.x + manHeadLabel.frame.size.width, 2, 120, 20)];
    manNameLabel.textAlignment = NSTextAlignmentLeft;
    manNameLabel.backgroundColor = [UIColor clearColor];
    manNameLabel.textColor = [UIColor blackColor];
    manNameLabel.font = [UIFont systemFontOfSize:16.0f];
    [self.view addSubview:manNameLabel];
    
    //身份证号码
    UILabel *identifyHeadLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, manNameLabel.frame.origin.y + manNameLabel.frame.size.height + 5, 100, 20)];
    identifyHeadLabel.textAlignment = NSTextAlignmentCenter;
    identifyHeadLabel.backgroundColor = [UIColor clearColor];
    identifyHeadLabel.textColor = [UIColor blackColor];
    identifyHeadLabel.font = [UIFont systemFontOfSize:16.0f];
    identifyHeadLabel.text = @"身份证号码:";
    [self.view addSubview:identifyHeadLabel];
    
    identifyNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(identifyHeadLabel.frame.origin.x + identifyHeadLabel.frame.size.width, manNameLabel.frame.origin.y + manNameLabel.frame.size.height + 5, 120, 20)];
    identifyNumberLabel.textAlignment = NSTextAlignmentLeft;
    identifyNumberLabel.backgroundColor = [UIColor clearColor];
    identifyNumberLabel.textColor = [UIColor blackColor];
    identifyNumberLabel.font = [UIFont systemFontOfSize:16.0f];
    [self.view addSubview:identifyNumberLabel];
    
    //手机号码
    UILabel *teleHeadLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, identifyNumberLabel.frame.origin.y + identifyNumberLabel.frame.size.height + 5, 80, 20)];
    teleHeadLabel.textAlignment = NSTextAlignmentCenter;
    teleHeadLabel.backgroundColor = [UIColor clearColor];
    teleHeadLabel.textColor = [UIColor blackColor];
    teleHeadLabel.font = [UIFont systemFontOfSize:16.0f];
    teleHeadLabel.text = @"手机号码:";
    [self.view addSubview:teleHeadLabel];
    
    telephoneNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(teleHeadLabel.frame.origin.x + teleHeadLabel.frame.size.width, identifyNumberLabel.frame.origin.y + identifyNumberLabel.frame.size.height + 5, 140, 20)];
    telephoneNumberLabel.textAlignment = NSTextAlignmentLeft;
    telephoneNumberLabel.backgroundColor = [UIColor clearColor];
    telephoneNumberLabel.textColor = [UIColor blackColor];
    telephoneNumberLabel.font = [UIFont systemFontOfSize:16.0f];
    [self.view addSubview:telephoneNumberLabel];
    
    //修改
    UIButton *modifyButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [modifyButton setBackgroundImage:[UIImage imageNamed:@"modify"] forState:UIControlStateNormal];
    [modifyButton setBackgroundImage:[UIImage imageNamed:@"modify"] forState:UIControlStateHighlighted];
    [modifyButton setBackgroundColor:[UIColor greenColor]];
    [modifyButton setFrame:CGRectMake(self.view.frame.size.width -80, self.view.frame.size.height, 20, 20)];
    [modifyButton addTarget:self action:@selector(touchModifyButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:modifyButton];
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,  telephoneNumberLabel.frame.origin.y + telephoneNumberLabel.frame.size.height + 20 ,MainWidth, MainHeight-48.5f - 44.0f)];
    tableView.delegate =self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:tableView];
    
    
}


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
    
    BankAccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dentifier];
    if (cell == nil) {
        //cell = [[BankAccountTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:dentifier];
        
        cell = [[BankAccountTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:dentifier];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    cell.title=@"张三";
    cell.bankName = @"建行";
    cell.bankCardNumber = @"12334456";
    return cell;
    
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
