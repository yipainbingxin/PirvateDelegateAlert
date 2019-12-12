//
//  ViewController.m
//  PirvateDelegateAlert
//
//  Created by bing on 2019/12/12.
//  Copyright © 2019 youshu. All rights reserved.
//

#import "ViewController.h"
#import "ProtocolAlerView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)btnCLick:(id)sender {
    ProtocolAlerView *alert = [ProtocolAlerView new];
      alert.strContent = @"感谢您信任并使用书旗小说，本服务互联、申请通知权限用于您提供书籍更新，优惠活动等信息服务，点击“同意”表示您同意上述内容及《隐私政策》及《用户协议》";
    
    [alert showAlert:self cancelAction:^(id  _Nullable object) {
        
    } privateAction:^(id  _Nullable object) {
        
    } delegateAction:^(id  _Nullable object) {
        
    }];
}

@end
