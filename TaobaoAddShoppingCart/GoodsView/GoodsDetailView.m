//
//  GoodsDetailView.m
//  TaobaoAddShoppingCart
//
//  Created by Alex on 16/8/11.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "GoodsDetailView.h"

@interface GoodsDetailView ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation GoodsDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    _webView.delegate = self;
    [self loadWebView];
}

+ (instancetype)sharedView
{
    GoodsDetailView *view = [[[NSBundle mainBundle] loadNibNamed:@"GoodsDetailView" owner:self options:nil] firstObject];
    return view;
}

- (void)request
{
    NSLog(@"网络请求2");
}

- (void)loadWebView
{
    NSURL *url =[NSURL URLWithString:@"http://web.superisong.com/pageone/index/html/id/27.html"];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //[[SVProgressHUDHelper sharedInstance] sVProgressShow:REQUEST_TIPS];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //[SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //[SVProgressHUD dismiss];
}


@end
