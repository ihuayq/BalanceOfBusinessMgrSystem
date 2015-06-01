//
//  bindBalanceAccountViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by 华永奇 on 15/5/10.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "bindBalanceAccountViewController.h"
#import "BankAccountTableViewCell.h"
#import "BMAccountCellInfo.h"
#import "bindAccountConfirmViewController.h"
#import "BankAccountItem.h"
#import "ItemButton.h"
#import "Globle.h"

@interface bindBalanceAccountViewController (){
    UITableView * tableView;
    
    
    UILabel * manNameLabel;
    UILabel * identifyLabel;
    UILabel * telephoneLabel;
    
    BOOL isSelectedButtonEnable;
    
    UIButton *avestButton;
}

@end

@implementation bindBalanceAccountViewController
//@synthesize group = group;
//@synthesize balanceAccountSelect = balanceAccountSelect;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigation.title = @"绑定结算账户";
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon.png"];
    
    //test group
    //group=[[NSMutableArray alloc]init];
    
    //自然人姓名
    UILabel * manTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, NAVIGATION_OUTLET_HEIGHT + 15, 70, 20)];
    manTitleLabel.text = [NSString stringWithFormat:@"自然人%@",[[[NSUserDefaults standardUserDefaults] objectForKey:@"curNatureMenInfo"] objectForKey:@"no"]];
    manTitleLabel.textAlignment = NSTextAlignmentCenter;
    manTitleLabel.textColor = [HP_UIColorUtils colorWithHexString:TEXT_COLOR];
    manTitleLabel.font = [UIFont systemFontOfSize:14];
    manTitleLabel.backgroundColor = [UIColor clearColor];
    manTitleLabel.numberOfLines = 0;
    [self.view addSubview:manTitleLabel];
    
    manNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, manTitleLabel.frame.size.height + manTitleLabel.frame.origin.y + 10, 50, 20)];
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
    
    identifyLabel = [[UILabel alloc] initWithFrame:CGRectMake(identifyTitleLabel.frame.size.width + identifyTitleLabel.frame.origin.x, NAVIGATION_OUTLET_HEIGHT + 15,180, 20)];
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
    telephoneLabel.text = [[[NSUserDefaults standardUserDefaults] objectForKey:@"curNatureMenInfo"] objectForKey:@"phonenum"];;
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
    avestButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [avestButton setBackgroundImage:[UIImage imageNamed:@"redbn"] forState:UIControlStateNormal];
    [avestButton setBackgroundImage:[UIImage imageNamed:@"redbndj"] forState:UIControlStateHighlighted];
    [avestButton setBackgroundColor:[UIColor greenColor]];
    [avestButton setFrame:CGRectMake(40, tableView.frame.origin.y + tableView.frame.size.height + 10 , MainWidth - 80, 40)];
    [avestButton addTarget:self action:@selector(touchOkButton) forControlEvents:UIControlEventTouchUpInside];
    [avestButton setTitle:@"确定" forState:UIControlStateNormal];
    [avestButton.layer setMasksToBounds:YES];
    [avestButton.layer setCornerRadius:avestButton.frame.size.height/2.0f]; //设置矩形四个圆角半径
    avestButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:avestButton];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"methods"] isEqualToString:@"FALSE"]) {
        isSelectedButtonEnable =  NO;
    }
    else{
        //选定结算账户的接口是否可用状态
        if ( [Globle shareGloble].whichBalanceAccountEntranceType == MODIFY_NATUREMAN_ENTRANCE) {
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"modifyAccFlag"] isEqualToString:@"1"]) {
                isSelectedButtonEnable = TRUE;
            }
            else{
                isSelectedButtonEnable =  NO;
            }
        }
        else{
            isSelectedButtonEnable = TRUE;
        }
    }
   
}

-(void)touchOkButton{
    BOOL bHasSelect =  NO;
    for (BankAccountItem *item in self.groupBalance) {
        if (item.bSelected == YES) {
            bHasSelect = YES;
        }
    }
    if ( bHasSelect == NO ) {
        //提示框
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择至少一个账号绑定" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alertView.tag = 999;
        [alertView show];
        return;
    }
    
    bindAccountConfirmViewController *vc = [[bindAccountConfirmViewController alloc] init];
    NSMutableArray *networkAccountGroup = [NSMutableArray new];
    for (BankAccountItem *item in self.groupNetWork) {
        if (item.bNetworkSelected == YES) {
            [networkAccountGroup addObject:item];
        }
    }
    vc.networkAccountSelected = networkAccountGroup;
    
    //遍历选中的数据
    NSMutableArray *selectGroup = [NSMutableArray new];
    for (BankAccountItem *item in self.groupBalance) {
        if (item.bSelected == YES) {
            [selectGroup addObject:item];
            break;
        }
    }
    vc.balanceAccountSelected = selectGroup;
    [self.navigationController pushViewController:vc animated:NO];
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
    //NSLog(@"计算每组(组%i)行数",section);
    return self.groupBalance.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * dentifier = @"cell";
    //NSIndexPath是一个结构体，记录了组和行信息
    //NSLog(@"生成单元格(组：%i,行%i)",indexPath.section,indexPath.row);
//    if (self.groupNetWork.count > 0) {
//        avestButton.hidden = NO;
//    }
    
    BankAccountItem *item=self.groupBalance[indexPath.row];
    
    //在修改自然人的时候会共用此界面
    BankAccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dentifier];
    if (cell == nil) {
        cell = [[BankAccountTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:dentifier hasSelectBtn:NO];
        ItemButton *button = [ [ItemButton alloc] initWithFrame:CGRectMake(0.0,0.0,30.0,30.0) withSelect:item.bSelected];
        button.backgroundColor = [UIColor clearColor ];
        [button addTarget:self action:@selector(buttonPressedAction:event:)  forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryView = button;
        //button.isSelected = item.bSelected;
        //是否可用
        button.enabled = isSelectedButtonEnable;
    }
    cell.title= item.accountName;
    cell.bankName = item.bankName;
    cell.bankCardNumber = item.bankCardNumber;
    ItemButton* curBtn = (ItemButton*)[cell accessoryView];
    curBtn.isSelected = item.bSelected;
//    //是否可用
//    curBtn.enabled = isSelectedButtonEnable;
    return cell;
}

- (void)buttonPressedAction:(id)sender event:(id)event
{
    ItemButton *button = (ItemButton *)sender;
    [button switchStatus];
    
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:tableView];
    
    NSIndexPath *indexPath = [tableView indexPathForRowAtPoint:currentTouchPosition];
    if (indexPath != nil)
    {
        for (int i = 0 ;i < self.groupBalance.count ;i++) {
            BankAccountItem *item=self.groupBalance[i];
            if (i == indexPath.row) {
                item.bSelected = button.isSelected;
                
            }else{
                item.bSelected = NO;
            }
            
        }
        [tableView reloadData];
    }
}

//- (void)buttonPressedAction:(id)sender forEvent:(UIEvent*)event
//{
//    ItemButton *button = (ItemButton *)sender;
//    [button switchStatus];
//    
//    UITableViewCell* cell = (UITableViewCell*)[button superview];
//    NSInteger row = [tableView indexPathForCell:cell].row;
//    //NSNumber *num = [NSNumber numberWithInteger:row];
////    if (button.selected == YES) {
////        [balanceAccountSelect addObject:num];
////    }else{
////        [balanceAccountSelect removeObject:num];
////    }
//    
//    for (int i = 0 ;i < self.groupBalance.count ;i++) {
//        BankAccountItem *item=self.groupBalance[i];
//        if (i == row) {
//            item.bSelected = button.isSelected;
//
//        }else{
//            item.bSelected = NO;
//        }
//
//    }
//    [tableView reloadData];
//    //NSLog(@"the selected group is:%@",balanceAccountSelect);
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    Checkbox *targetCheckbox = (Checkbox*)[targetCell accessoryView];
    //    targetCheckbox.checked = !targetCheckbox.checked;
}

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
