//
//  ChaoebaoInfoViewController.m
//  BalanceOfBusinessMgrSystem_1.1.0
//
//  Created by huayq on 15/7/13.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "ChaoebaoInfoViewController.h"
#import "BMAccountCellInfo.h"
#import "AdviseInfoViewController.h"

@interface ChaoebaoInfoViewController ()
{
    NSMutableArray *_group;//cell数组
    UIButton *avestButton;
}
@property(strong,nonatomic) UITableView * tableView;
@end

@implementation ChaoebaoInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initGroup];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon_new"];
    self.navigation.title = @"关于超额宝";
    
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(30, NAVIGATION_OUTLET_HEIGHT + 10,MainWidth - 60,40)];
    labelTitle.text = @"介 绍";
    labelTitle.font = [UIFont systemFontOfSize:24];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelTitle];
    
    
    //初始化label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
    //设置自动行数与字符换行
    [label setNumberOfLines:0];
    // 字串
    NSString *s = @"超额宝是海科融通旗下针对于海科已有商户量身定做的一款理财产品，具有收益高、安全性高、灵活等特性！";
    UIFont *font = [UIFont systemFontOfSize:18];
    //设置一个行高上限
    CGSize size = CGSizeMake(MainWidth - 20,400);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:(UILineBreakMode)UILineBreakModeWordWrap];
    [label setFrame:CGRectMake(10, labelTitle.frame.size.height + labelTitle.frame.origin.y  + 10, MainWidth - 10, labelsize.height)];
    label.text = s;
    [self.view addSubview:label];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, label.frame.size.height + label.frame.origin.y + 10 ,MainWidth, 180) style:UITableViewStyleGrouped];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
}

- (void) initGroup{
    _group=[[NSMutableArray alloc]init];
    
    BMAccountCellInfo *contact1=[BMAccountCellInfo initWithFirstName:@"意见反馈"];
    BMAccountCellInfo *contact2=[BMAccountCellInfo initWithFirstName:@"致电客服电话"];
    BMAccountCellInfo *contact3=[BMAccountCellInfo initWithFirstName:@"检查更新"];
    BMAccountCellGroup *group1=[BMAccountCellGroup initWithName:@"C" andDetail:@"With names beginning with C" andContacts:[NSMutableArray arrayWithObjects:contact1,contact2,contact3, nil]];
    [_group addObject:group1];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _group.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BMAccountCellGroup *group1=_group[section];
    return group1.groups.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * dentifier = @"cell";
    BMAccountCellGroup *group=_group[indexPath.section];
    BMAccountCellInfo *contact=group.groups[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:dentifier];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    cell.textLabel.text=contact.title;
    

    if (indexPath.row == 1) {
        cell.detailTextLabel.text=@"400-6668-888";
    }
    else if ( indexPath.row == 2 ){
        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"V%@",version];
    }
    
    
    return cell;
}

-(void)setAccount:(UITableViewCell *)cell{


}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if( indexPath.row == 0  )
    {
        AdviseInfoViewController*vc = [[AdviseInfoViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if( indexPath.row == 1  )
    {
        UIWebView*callWebview =[[UIWebView alloc] init];
        NSURL *telURL =[NSURL URLWithString:@"tel:4006668888"];// 貌似tel:// 或者 tel: 都行
        [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
        //记得添加到view上
        [self.view addSubview:callWebview];
    }
    else if (indexPath.row == 2)
    {
        //关于超额宝
//        ProjectReferViewController *vc = [[ProjectReferViewController alloc] init];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
        [self checkAPPUpdate];
    }
    
}

-(void)checkAPPUpdate
{
    if (![HP_NetWorkUtils isNetWorkEnable])
    {
        return;
    }
    
    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:2];
    
    [connDictionary setObject:@"IOS" forKey:@"osType"];
    [connDictionary setObject:[HP_NSBundleUtils getMainBundleAPPVersion] forKey:@"currentVersion"];
    
    
    NSString *url =[NSString stringWithFormat:@"%@%@",IP,AppVersionURL];
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary] stringByAppendingString:ORIGINAL_KEY]] forKey:@"signature"];
    [connDictionary setObject:Default_Phone_UUID_MD5 forKey:@"deviceId"];//设备id
    
    NSLog(@"connDictionary:%@",connDictionary);
    [self showMBProgressHUDWithMessage:@"登录中..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"检查更新ret:%@,msg:%@,response:%@",ret,msg,responseJSONDictionary);
          [self hidMBProgressHUD];
         if ([ret isEqualToString:@"100"])
         {
             NSString* newVersion=[responseJSONDictionary objectForKey:@"version"];
             NSArray* newVersionArray=[[responseJSONDictionary objectForKey:@"version"] componentsSeparatedByString:@"."];
             
             NSArray *currentVersionArray = [NNString splitString: [HP_NSBundleUtils getMainBundleAPPVersion] withStr:@"."];
             
             NSLog(@"newVersionArray=%@ currentVersionArray=%@",newVersionArray,currentVersionArray);
             
             BOOL isHaveNewVervion = NO;
             for (int i=0; i<[newVersionArray count]; i++)
             {
                 if ([[newVersionArray objectAtIndex:i] intValue]>[[currentVersionArray objectAtIndex:i] intValue])
                 {
                     NSLog(@"有新版");
                     isHaveNewVervion = YES;
                     break;
                 }
                 if ([[newVersionArray objectAtIndex:i] intValue]<[[currentVersionArray objectAtIndex:i] intValue])
                 {
                     NSLog(@"线上是旧版");
                     break;
                 }
             }
             
             if (isHaveNewVervion)
             {
                 NSLog(@"\n\n\n真的有新版本啦\n\n\n");

                UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"发现新版本:v%@",newVersion] delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles:nil, nil];
                     alert.tag = 111;
                     [alert show];
             }
             else
             {
                 UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"已经是最新版本"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                 alert.tag = 100;
                 [alert show];
             }
             
         }
         
     } RequestFailureBlock:^(ASIFormDataRequest *request, NSError *error ,NSString * msg)
     {
         if (![request isCancelled])
         {
             [request cancel];
         }
          [self hidMBProgressHUD];
         
     }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 111)
    {
        NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/chao-e-bao/id1006544360?mt=8"];
        //NSURL *url = [NSURL URLWithString:@"https://www.baidu.com/"];
        [[UIApplication sharedApplication]openURL:url];
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


@end
