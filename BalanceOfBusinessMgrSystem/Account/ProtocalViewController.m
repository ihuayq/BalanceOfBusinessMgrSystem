//
//  ProtocalViewController.m
//  BalanceOfBusinessMgrSystem
//
//  Created by huayq on 15/6/5.
//  Copyright (c) 2015年 hkrt. All rights reserved.
//

#import "ProtocalViewController.h"

@interface ProtocalViewController ()<UIWebViewDelegate>{
    UIActivityIndicatorView *activityIndicatorView;
}

@end

@implementation ProtocalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigation.title = self.viewTitle;
    self.navigation.leftImage = [UIImage imageNamed:@"back_icon_new"];
    
    //超额宝介绍
    self.productWebView =[[UIWebView alloc] initWithFrame:CGRectMake(0, NAVIGATION_OUTLET_HEIGHT, MainWidth, MainHeight - NAVIGATION_OUTLET_HEIGHT)];

//    CGRect frame = self.productWebView.frame;
//    CGSize fittingSize = [self.productWebView sizeThatFits:CGSizeZero];
//    frame.size = fittingSize;
//    self.productWebView.frame = frame;
    
//    CGFloat webViewHeight=[self.productWebView.scrollView contentSize].height;
//    CGRect newFrame = self.productWebView.frame;
//    newFrame.size.height = webViewHeight;
//    self.productWebView.frame = newFrame;
    
    
    [self.productWebView.layer setBorderColor:[[UIColor colorWithWhite:0.821 alpha:1.000] CGColor]];
    [self.productWebView.layer setBorderWidth:0.5f];
    [self.view addSubview:self.productWebView];
    
    NSURL *url =[NSURL URLWithString:self.urlPath];
    NSLog(@"the url is:%@",self.urlPath);
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [self.productWebView loadRequest:request];
    
    //self.productWebView.scalesPageToFit = YES;
    self.productWebView.delegate =self;
    activityIndicatorView = [[UIActivityIndicatorView alloc]
                             initWithFrame:CGRectMake(0.0f, 0.0f, 132.0f, 132.0f)] ;
    [activityIndicatorView setCenter: self.view.center] ;
    [activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray] ;
    [self.view addSubview:activityIndicatorView];
}

-(void)previousToViewController
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [activityIndicatorView startAnimating];
}

//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    [activityIndicatorView stopAnimating];
//}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    CGRect frame = webView.frame;
//    frame.size.height = 1;
//    webView.frame = frame;
//    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
//    frame.size = fittingSize;
//    webView.frame = frame;
    CGFloat webViewHeight=[self.productWebView.scrollView contentSize].height;
    CGRect newFrame = self.productWebView.frame;
    newFrame.size.height = webViewHeight;
    self.productWebView.frame = newFrame;
    
    [activityIndicatorView stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alterview = [[UIAlertView alloc] initWithTitle:@"" message:[error localizedDescription]  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alterview show];
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
