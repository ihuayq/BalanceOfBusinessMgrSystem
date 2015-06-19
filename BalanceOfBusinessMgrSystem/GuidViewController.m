//
//  ViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/5/5.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "GuidViewController.h"

@interface GuidViewController (){
    UIPageControl* topPageControl;
    int currentPage;
    HP_UIImageView* bigSquareImageView;
    UIScrollView* topScrollView;
    
    int nPageNum;
    NSString *strGuidePicHead;
}

@end

@implementation GuidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    topScrollView=[[UIScrollView alloc]init];
    [topScrollView setFrame:CGRectMake(0, 0, MainWidth, MainHeight)];
    topScrollView.backgroundColor=[UIColor clearColor];
    [topScrollView setUserInteractionEnabled:YES];
    topScrollView.delegate=self;
    [self.view addSubview:topScrollView];
    
    NSLog(@"--------------------\n\n\n-----------\n\n----------");
    for ( int i = 0 ;  i < nPageNum; i++ )
    {
        bigSquareImageView=[[HP_UIImageView alloc]initWithFrame:CGRectMake(MainWidth*i,0,MainWidth,MainHeight)];
        bigSquareImageView.tag=2000+i;
        [bigSquareImageView setUserInteractionEnabled:YES];
        [bigSquareImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%d.jpg",strGuidePicHead,i+1]]];
        bigSquareImageView.backgroundColor=[UIColor clearColor];
        
        if ( i == nPageNum - 1 )
        {
            HP_UIButton* moreThingButton = [HP_UIButton buttonWithType:UIButtonTypeCustom];
            if (MainHeight>500)
            {
                moreThingButton.frame = CGRectMake((MainWidth-150)/2, MainHeight-110, 150, 40);
            }
            else
            {
                moreThingButton.frame = CGRectMake((MainWidth-150)/2, MainHeight-80, 150, 40);
            }
            
            [moreThingButton setBackgroundColor:[HP_UIColorUtils clearColor]];
            [moreThingButton addTarget:self action:@selector(changeCancleWelcomePage) forControlEvents:UIControlEventTouchUpInside];
            [bigSquareImageView addSubview:moreThingButton];
        }
        
        [topScrollView addSubview:bigSquareImageView];
    }
    
    [topScrollView setContentSize:CGSizeMake(MainWidth*nPageNum, MainHeight)];
    topScrollView.pagingEnabled=YES;
    topScrollView.showsHorizontalScrollIndicator=NO;
}

-(void)setType:(LoadingGuidType)type{
    _type = type;
    if (type == NATUREMAN_GUIDE) {
        nPageNum = 3;
        strGuidePicHead = @"natureman";
    }
    else if (type == SUPPLYER_GUIDE){
        nPageNum = 4;
        strGuidePicHead = @"supplyer";
    }
    else{
        nPageNum = 4;
        strGuidePicHead = @"navigation";
    }
}

-(void)changeToNextPage
{
    
}

-(void)changeCancleWelcomePage
{
    NSString* keystring=[NSString stringWithFormat:@"%@_GuidePage_%ld",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"],(long)self.type];
    [[NSUserDefaults standardUserDefaults] setObject:keystring forKey:keystring];
    
    NSMutableDictionary *dict =[[NSMutableDictionary alloc] init];
    if (self.type == NATUREMAN_GUIDE) {
        [dict setObject:@"0" forKey:@"login"];
    }
    else if( self.type == SUPPLYER_GUIDE ){
        [dict setObject:@"1" forKey:@"login"];
    }
    else if( self.type == GLOBE_GUIDE ){
        [dict setObject:@"2" forKey:@"login"];
        [dict setObject:@"1" forKey:@"isSupplyer"];
    }
//    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:@"2",@"login",@"0",@"isSupplyer", nil];
    NSNotification *notification =[NSNotification notificationWithName:@"LoginInitMainwidow" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView.contentOffset.x>MainWidth*4+50)
    {
        [self changeCancleWelcomePage];
    }
    
    currentPage=(scrollView.contentOffset.x+MainWidth/2)/MainWidth;
    topPageControl.currentPage=currentPage;
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    currentPage=scrollView.contentOffset.x/MainWidth;
    
    topPageControl.currentPage=currentPage;
    
    [UIView animateWithDuration:0.3 animations:^{
        [topScrollView setContentOffset:CGPointMake(MainWidth*currentPage, 0)];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
