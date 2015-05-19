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

@interface BMAccountMainViewController (){
    NSMutableArray *_group;//cell数组
}
@property(strong,nonatomic) UITableView * tableView;
@end

@implementation BMAccountMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initGroup];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigation.navigaionBackColor =  [UIColor orangeColor];
    self.navigation.title = @"账号";
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_OUTLET_HEIGHT,MainWidth, MainHeight-48.5f - 44.0f - 130.0f) style:UITableViewStyleGrouped];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
    
    //确定
    UIButton *avestButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
    [avestButton setBackgroundImage:[UIImage imageNamed:@"lanbn"] forState:UIControlStateNormal];
    [avestButton setBackgroundImage:[UIImage imageNamed:@"lanbndj"] forState:UIControlStateHighlighted];
    [avestButton setBackgroundColor:[UIColor greenColor]];
    [avestButton setFrame:CGRectMake(40, MainHeight -48.5 - 100 , MainWidth - 80, 40)];
    [avestButton addTarget:self action:@selector(touchExitButton) forControlEvents:UIControlEventTouchUpInside];
    [avestButton setTitle:@"退出当前账号" forState:UIControlStateNormal ];
    [avestButton.layer setMasksToBounds:YES];
    [avestButton.layer setCornerRadius:avestButton.frame.size.height/2.0f]; //设置矩形四个圆角半径
    [self.view addSubview:avestButton];
    
//    UILabel * registerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MainWidth - 80, 40)];
//    registerLabel.textAlignment = NSTextAlignmentCenter;
//    registerLabel.backgroundColor = [UIColor clearColor];
//    registerLabel.text = @"退出当前账号";
//    registerLabel.textColor = [UIColor whiteColor];
//    registerLabel.font = [UIFont systemFontOfSize:15];
//    [avestButton addSubview:registerLabel];
}

-(void)touchExitButton{
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:USERINFO];
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:LOGIN_STATUS];//0未登陆、1的登陆
    
    [self.parentViewController.navigationController popToRootViewControllerAnimated:YES];
}

- (void) initGroup{
    _group=[[NSMutableArray alloc]init];
    
    BMAccountCellInfo *contact0=[BMAccountCellInfo initWithFirstName:@"当前角色信息"];
    BMAccountCellGroup *group0=[BMAccountCellGroup initWithName:@"C" andDetail:@"With names beginning with C" andContacts:[NSMutableArray arrayWithObjects:contact0, nil]];
    [_group addObject:group0];
    
    
    BMAccountCellInfo *contact1=[BMAccountCellInfo initWithFirstName:@"我的信息"];
    BMAccountCellGroup *group1=[BMAccountCellGroup initWithName:@"C" andDetail:@"With names beginning with C" andContacts:[NSMutableArray arrayWithObjects:contact1, nil]];
    [_group addObject:group1];
    
    
    
    BMAccountCellInfo *contact2=[BMAccountCellInfo initWithFirstName:@"登陆密码"];
    BMAccountCellGroup *group2=[BMAccountCellGroup initWithName:@"B" andDetail:@"With names beginning with B" andContacts:[NSMutableArray arrayWithObjects:contact2, nil]];
    [_group addObject:group2];
    
    BMAccountCellInfo *contact3=[BMAccountCellInfo initWithFirstName:@"交易密码"];
    BMAccountCellGroup *group3=[BMAccountCellGroup initWithName:@"B" andDetail:@"With names beginning with B" andContacts:[NSMutableArray arrayWithObjects:contact3, nil]];
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
    NSLog(@"计算每组(组%i)行数",section);
    BMAccountCellGroup *group1=_group[section];
    return group1.groups.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * dentifier = @"cell";
    //NSIndexPath是一个结构体，记录了组和行信息
    NSLog(@"生成单元格(组：%i,行%i)",indexPath.section,indexPath.row);
    BMAccountCellGroup *group=_group[indexPath.section];
    BMAccountCellInfo *contact=group.groups[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:dentifier];
        if(indexPath.section != 0 )
        {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        
    }
    
    cell.textLabel.text=contact.title;
    
    if( indexPath.section == 2 || indexPath.section == 3)
    {
         cell.detailTextLabel.text=@"修改";
    }
    else if (indexPath.section == 0)
    {
        
        //cell.detailTextLabel.text= self.accountInfo;
        cell.detailTextLabel.text=@"自然人";
    }

    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( indexPath.section == 2)
    {
        ModifyLoginPasswordViewController *vc = [[ModifyLoginPasswordViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    if( indexPath.section == 3)
    {
        BMSettingTransactionpPasswordViewController *vc = [[BMSettingTransactionpPasswordViewController alloc] init];
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
