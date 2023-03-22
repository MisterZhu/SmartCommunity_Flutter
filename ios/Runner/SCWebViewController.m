//
//  SCWebViewController.m
//  Runner
//
//  Created by mjl on 2023/1/13.
//

#import "SCWebViewController.h"
#import <WebKit/WebKit.h>

@interface SCWebViewController ()

// webview
@property (nonatomic, strong) WKWebView *wkWebView;

@end

@implementation SCWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupView];
    [self setupData];
    // Do any additional setup after loading the view.
}

- (void)setupView {
    self.wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    self.wkWebView.backgroundColor = [UIColor whiteColor];
    self.wkWebView.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.wkWebView];
}

- (void)setupData {
    NSString *baseUrlString = @"https://www.baidu.com";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:baseUrlString] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    [self.wkWebView loadRequest:request];
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
