//
//  CLLockVC.m
//  CoreLock
//
//  Created by 成林 on 15/4/21.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "CLLockVC.h"
#import "CoreLockConst.h"
#import "CoreArchive.h"
#import "CLLockLabel.h"
#import "CLLockNavVC.h"
#import "CLLockView.h"
#import "BaseASIDataConnection.h"
#import "CLLockInfoView.h"



@interface CLLockVC ()

/** 操作成功：密码设置成功、密码验证成功 */
@property (nonatomic,copy) void (^successBlock)(CLLockVC *lockVC,NSString *pwd);

@property (nonatomic,copy) void (^forgetPwdBlock)();

@property (weak, nonatomic) IBOutlet CLLockLabel *label;
//@property (strong, nonatomic) IBOutlet CLLockLabel *label;

@property (nonatomic,copy) NSString *msg;

@property (weak, nonatomic) IBOutlet CLLockView *lockView;
//@property (strong, nonatomic) IBOutlet CLLockView *lockView;

@property (nonatomic,weak) UIViewController *vc;

@property (nonatomic,strong) UIBarButtonItem *resetItem;


@property (nonatomic,copy) NSString *modifyCurrentTitle;


@property (weak, nonatomic) IBOutlet UIView *actionView;

@property (weak, nonatomic) IBOutlet UIButton *modifyBtn;

@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;



/** 直接进入修改页面的 */
@property (nonatomic,assign) BOOL isDirectModify;



@end

@implementation CLLockVC

- (void)viewDidLoad {
    
    [super viewDidLoad];

    //控制器准备
    [self vcPrepare];
    
    //数据传输
    [self dataTransfer];
    
    //事件
    [self event];
    
    [self initViewPos];
}

-(void) initViewPos{
//    CGRect lockFrame= _actionView.frame;
//    lockFrame.origin.y = 0;//self.label.frame.size.height + self.label.frame.origin.y  + 10;
//    [_actionView setFrame:lockFrame];
    
    UILabel * telLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, MainHeight - 40, MainWidth, 20)];
    //手机号码
    telLabel.text = @"注意：请防止未授权人员查看";
    telLabel.textAlignment = NSTextAlignmentCenter;
    telLabel.textColor = UISTYLECOLOR;
    telLabel.font = [UIFont systemFontOfSize:16];
    //telLabel.backgroundColor = [UIColor clearColor];
    telLabel.numberOfLines = 0;
    [self.view addSubview:telLabel];
    
//    [_modifyBtn setFrame:CGRectMake(0, MainHeight - 160, MainWidth, 20)];
//    [_forgetBtn setFrame:CGRectMake(0, MainHeight - 80, MainWidth, 20)];
    
//    CLLockInfoView *infoView =[[CLLockInfoView alloc] initWithFrame:CGRectMake(MainWidth/2-20, NAVIGATION_OUTLET_HEIGHT + 20,40, 40)];
//    [self.view addSubview:infoView];
//
//    
//    self.label = [[CLLockLabel alloc] initWithFrame:CGRectMake(20, infoView.frame.origin.y + infoView.frame.size.height + 10,MainWidth -40, 40)];
//    [self.view addSubview:self.label];
//    
//    
//    self.lockView = [[CLLockView alloc] initWithFrame:CGRectMake(20, self.label.frame.origin.y + self.label.frame.size.height  ,MainWidth-40, MainWidth-40)];
//    [self.view addSubview:self.lockView];
}


/*
 *  事件
 */
-(void)event{
    
    
    /*
     *  设置密码
     */
    
    /** 开始输入：第一次 */
    self.lockView.setPWBeginBlock = ^(){
        
        [self.label showNormalMsg:CoreLockPWDTitleFirst];
    };
    
    /** 开始输入：确认 */
    self.lockView.setPWConfirmlock = ^(){
        
        [self.label showNormalMsg:CoreLockPWDTitleConfirm];
    };
    
    
    /** 密码长度不够 */
    self.lockView.setPWSErrorLengthTooShortBlock = ^(NSUInteger currentCount){
      
        [self.label showWarnMsg:[NSString stringWithFormat:@"请连接至少%@个点",@(CoreLockMinItemCount)]];
    };
    
    /** 两次密码不一致 */
    self.lockView.setPWSErrorTwiceDiffBlock = ^(NSString *pwd1,NSString *pwdNow){
        
        [self.label showWarnMsg:CoreLockPWDDiffTitle];
        
        self.navigationItem.leftBarButtonItem = self.resetItem;
    };
    
    /** 第一次输入密码：正确 */
    self.lockView.setPWFirstRightBlock = ^(){
      
        [self.label showNormalMsg:CoreLockPWDTitleConfirm];
    };
    
    /** 再次输入密码一致 */
    self.lockView.setPWTwiceSameBlock = ^(NSString *pwd){
      
        [self.label showNormalMsg:CoreLockPWSuccessTitle];
        
        //存储密码
        [CoreArchive setStr:pwd key:CoreLockPWDKey];
        
        //禁用交互
        self.view.userInteractionEnabled = NO;
        
        if(_successBlock != nil) _successBlock(self,pwd);
        
        if(CoreLockTypeModifyPwd == _type){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
    };
    
    
    
    /*
     *  验证密码
     */
    
    /** 开始 */
    self.lockView.verifyPWBeginBlock = ^(){

        NSString *strName = [[NSUserDefaults standardUserDefaults] objectForKey:LAST_LOGIN_NAME];
        if (strName == nil || strName.length == 0) {
            [self.label showNormalMsg:CoreLockVerifyNormalTitle];
        }
        else{
            [self.label showNormalMsg:[NSString stringWithFormat:@"账号:%@",strName]];
        }
    };
    
    /** 验证 */
    self.lockView.verifyPwdBlock = ^(NSString *pwd){
    
        //取出本地密码
        NSString *pwdLocal = [CoreArchive strForKey:CoreLockPWDKey];
        
        BOOL res = [pwdLocal isEqualToString:pwd];
        
        if(res){//密码一致
            
            [self.label showNormalMsg:CoreLockVerifySuccesslTitle];
            
            if(CoreLockTypeVeryfiPwd == _type){
                
                //禁用交互
                self.view.userInteractionEnabled = NO;
                
            }else if (CoreLockTypeModifyPwd == _type){//修改密码
                
                [self.label showNormalMsg:CoreLockPWDTitleFirst];
                
                self.modifyCurrentTitle = CoreLockPWDTitleFirst;
            }
            
            if(CoreLockTypeVeryfiPwd == _type) {
                if(_successBlock != nil) _successBlock(self,pwd);
            }
            
        }else{//密码不一致
            
            [self.label showWarnMsg:CoreLockVerifyErrorPwdTitle];

        }
        
        return res;
    };
    
    
    
    /*
     *  修改
     */
    
    /** 开始 */
    self.lockView.modifyPwdBlock =^(){
      
        //[self.label showNormalMsg:self.modifyCurrentTitle];
    };
}


/*
 *  数据传输
 */
-(void)dataTransfer{
    
    [self.label showNormalMsg:self.msg];
    
    //传递类型
    self.lockView.type = self.type;
}

/*
 *  控制器准备
 */
-(void)vcPrepare{
    self.navigation.hidden = YES;

    //设置背景色
    self.view.backgroundColor = CoreLockViewBgColor;
    
    //初始情况隐藏
    self.navigationItem.rightBarButtonItem = nil;
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    //默认标题
    self.modifyCurrentTitle = CoreLockModifyNormalTitle;
    
    if(CoreLockTypeModifyPwd == _type) {
        
        _actionView.hidden = YES;
        
        [_actionView removeFromSuperview];

        if(_isDirectModify) return;
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    }
    else if (CoreLockTypeSetPwd == _type){
        _actionView.hidden = YES;
        
        [_actionView removeFromSuperview];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"跳过" style:UIBarButtonItemStylePlain target:self action:@selector(skip)];
    }
    
    
    if(![self.class hasPwd]){
        [_modifyBtn removeFromSuperview];
    }
}

-(void)dismiss{
    [self dismiss:0];
}

-(void)skip{
    //进入主界面
//    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"0",@"login", nil];
//    NSNotification *notification =[NSNotification notificationWithName:@"LoginInitMainwidow" object:nil userInfo:dict];
//    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [self dataRequestSearch];
}

-(void)dataRequestSearch{
    
    if (![HP_NetWorkUtils isNetWorkEnable])
    {
        [self showSimpleAlertViewWithTitle:nil alertMessage:@"网络不可用，请检查您的网络后重试" cancelButtonTitle:queding otherButtonTitles:nil];
        return;
    }
    [self touchesBegan:nil withEvent:nil];
    
    NSMutableDictionary *connDictionary = [[NSMutableDictionary alloc] initWithCapacity:2];
    [connDictionary setObject:[[[NSUserDefaults standardUserDefaults] objectForKey:USERINFO] objectForKey:USER_ID]forKey:USER_ID];
    [connDictionary setObject:[MD5Utils md5:[[NNString getRightString_BysortArray_dic:connDictionary]stringByAppendingString: ORIGINAL_KEY]] forKey:@"signature"];
    
    [connDictionary setObject:Default_Phone_UUID_MD5 forKey:@"deviceId"];//设备id
    NSString *url =[NSString stringWithFormat:@"%@%@",IP,MInfoURL];
    
    [self showMBProgressHUDWithMessage:@"加载中..."];
    [BaseASIDataConnection PostDictionaryConnectionByURL:url ConnDictionary:connDictionary RequestSuccessBlock:^(ASIFormDataRequest *request, NSString *ret, NSString *msg, NSMutableDictionary *responseJSONDictionary)
     {
         NSLog(@"ret:%@,msg:%@,response:%@",ret,msg,responseJSONDictionary);
         [self hidMBProgressHUD];
         if([ret isEqualToString:@"100"])
         {
             responseJSONDictionary=[self delStringNullOfDictionary:responseJSONDictionary];
             
             NSMutableDictionary* Dict=[[NSMutableDictionary alloc] initWithCapacity:0];
             if ([responseJSONDictionary objectForKey:@"idCard"]) {
                 [Dict setObject:[responseJSONDictionary objectForKey:@"idCard"] forKey:@"identifyno"];
             }
             [Dict setObject:[responseJSONDictionary objectForKey:USER_ID] forKey:USER_ID];
             [Dict setObject:[responseJSONDictionary objectForKey:@"commercialName"] forKey:USER_NAME];
             [Dict setObject:[responseJSONDictionary objectForKey:@"personName"] forKey:@"personName"];
             [Dict setObject:[responseJSONDictionary objectForKey:@"precipitationMarke"] forKey:@"appointment"];//是否设置沉淀
             [Dict setObject:[responseJSONDictionary objectForKey:@"addnpflag"] forKey:@"addNaturalMark"];//是否添加自然人标记,1代表添加，0不添加
             [Dict setObject:[responseJSONDictionary objectForKey:@"addwebsiteFlag"] forKey:@"addwebsiteFlag"];//是否添加卡号信息,1代表添加，0不添加
             [[NSUserDefaults standardUserDefaults] setObject:Dict forKey:USERINFO];
             
             //商户类型
             [[NSUserDefaults standardUserDefaults]setObject:[responseJSONDictionary objectForKey:@"methods"] forKey:@"methods"];
             [[NSUserDefaults standardUserDefaults] setObject:[responseJSONDictionary objectForKey:@"balanceInfo"] forKey:@"balanceInfo"];//绑定卡号信息
             [[NSUserDefaults standardUserDefaults] setObject:[responseJSONDictionary objectForKey:@"payMark"] forKey:@"payMark"];//交易密码
             [[NSUserDefaults standardUserDefaults] setObject:[responseJSONDictionary objectForKey:@"rate"] forKey:@"rate"];//利率
             //很显然，交易密码的设置需要使用到手机号码，而手机号码是在绑定设置过后
             //如下操作需要先设置自然人信息：交易密码的修改，提现，查看我的信息
             [[NSUserDefaults standardUserDefaults] setObject:[responseJSONDictionary objectForKey:@"phoneNum"] forKey:@"phoneNum"];//手机号
             [[NSUserDefaults standardUserDefaults] setObject:[responseJSONDictionary objectForKey:@"accountId"] forKey:@"drawCardNo"];    //提现卡号码
             
             
            NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"0",@"login", nil];
            NSNotification *notification =[NSNotification notificationWithName:@"LoginInitMainwidow" object:nil userInfo:dict];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
             
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
         
         
     } RequestFailureBlock:^(ASIFormDataRequest *request, NSError *error,NSString * msg) {
         NSLog(@"error:%@",error.debugDescription);
         if (![request isCancelled])
         {
             [request cancel];
         }
         [self hidMBProgressHUD];
         UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:queding otherButtonTitles:nil];
         alertView.tag = 999;
         [alertView show];
     }];
}


/*
 *  密码重设
 */
-(void)setPwdReset{
    
    [self.label showNormalMsg:CoreLockPWDTitleFirst];
    
    //隐藏
    self.navigationItem.rightBarButtonItem = nil;
    
    //通知视图重设
    [self.lockView resetPwd];
}


/*
 *  忘记密码
 */
-(void)forgetPwd{
    
}

/*
 *  修改密码
 */
-(void)modiftyPwd{
    
}

/*
 *  是否有本地密码缓存？即用户是否设置过初始密码？
 */
+(BOOL)hasPwd{
    
    NSString *pwd = [CoreArchive strForKey:CoreLockPWDKey];
    
    return pwd !=nil;
}




/*
 *  展示设置密码控制器
 */
+(instancetype)showSettingLockVCInVC:(UIViewController *)vc successBlock:(void(^)(CLLockVC *lockVC,NSString *pwd))successBlock{
    
    CLLockVC *lockVC = [self lockVC:vc];
    
    lockVC.title = @"设置手势密码";
    
    //设置类型
    lockVC.type = CoreLockTypeSetPwd;
    
    //保存block
    lockVC.successBlock = successBlock;
    
    return lockVC;
}




/*
 *  展示验证密码输入框
 */
+(instancetype)showVerifyLockVCInVC:(UIViewController *)vc forgetPwdBlock:(void(^)())forgetPwdBlock successBlock:(void(^)(CLLockVC *lockVC, NSString *pwd))successBlock{
    
    
    CLLockVC *lockVC = [self lockVC:vc];
    
    lockVC.title = @"手势解锁";
    
    //设置类型
    lockVC.type = CoreLockTypeVeryfiPwd;
    
    //保存block
    lockVC.successBlock = successBlock;
    lockVC.forgetPwdBlock = forgetPwdBlock;
    
    return lockVC;
}




/*
 *  展示验证密码输入框
 */
+(instancetype)showModifyLockVCInVC:(UIViewController *)vc successBlock:(void(^)(CLLockVC *lockVC, NSString *pwd))successBlock{
    
    CLLockVC *lockVC = [self lockVC:vc];
    
    lockVC.title = @"修改密码";
    
    //设置类型
    lockVC.type = CoreLockTypeModifyPwd;
    
    //记录
    lockVC.successBlock = successBlock;
    
    return lockVC;
}





+(instancetype)lockVC:(UIViewController *)vc{
    
    CLLockVC *lockVC = [[CLLockVC alloc] init];

    lockVC.vc = vc;
    
    
//    CLLockNavVC *navVC = [[CLLockNavVC alloc] initWithRootViewController:lockVC];
//    
//    [vc presentViewController:navVC animated:YES completion:nil];

    
    return lockVC;
}



-(void)setType:(CoreLockType)type{
    
    _type = type;
    
    //根据type自动调整label文字
    [self labelWithType];
}



/*
 *  根据type自动调整label文字
 */
-(void)labelWithType{
    
    if(CoreLockTypeSetPwd == _type){//设置密码
        
        self.msg = CoreLockPWDTitleFirst;
        
    }else if (CoreLockTypeVeryfiPwd == _type){//验证密码
        
        //
        NSString *strName= [[NSUserDefaults standardUserDefaults] objectForKey:LAST_LOGIN_NAME];
        if (strName == nil || strName.length == 0) {
            self.msg = CoreLockVerifyNormalTitle;
        }
        else{
            self.msg = [NSString stringWithFormat:@"账号:%@",strName];
        }
        
        
    }else if (CoreLockTypeModifyPwd == _type){//修改密码
        
        self.msg = CoreLockModifyNormalTitle;
    }
}




/*
 *  消失
 */
-(void)dismiss:(NSTimeInterval)interval{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}


/*
 *  重置
 */
-(UIBarButtonItem *)resetItem{
    
    if(_resetItem == nil){
        //添加右按钮
        _resetItem= [[UIBarButtonItem alloc] initWithTitle:@"重设" style:UIBarButtonItemStylePlain target:self action:@selector(setPwdReset)];
    }
    
    return _resetItem;
}


- (IBAction)forgetPwdAction:(id)sender {

    //[self dismiss:0];
    if(_forgetPwdBlock != nil) _forgetPwdBlock();
}


- (IBAction)modifyPwdAction:(id)sender {
    
//    CLLockVC *lockVC = [[CLLockVC alloc] init];
//    
//    lockVC.title = @"修改密码";
//    
//    lockVC.isDirectModify = YES;
//    
//    //设置类型
//    lockVC.type = CoreLockTypeModifyPwd;
//    
//    [self.navigationController pushViewController:lockVC animated:YES];
    //进入主界面
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"4",@"login", nil];
    NSNotification *notification =[NSNotification notificationWithName:@"LoginInitMainwidow" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}












@end
