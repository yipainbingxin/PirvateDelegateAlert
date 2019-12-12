//
//  ProtocolAlerView.m
//  PirvateDelegateAlert
//
//  Created by bing on 2019/12/12.
//  Copyright © 2019 youshu. All rights reserved.
//

#import "ProtocolAlerView.h"
#define leftMargin (50 *kScale)
#define topMargin (108 *kScale)
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScale (kScreenWidth) / 375.0

@interface ProtocolAlerView ()<UITextViewDelegate>
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UIButton *agreeBtn;
@property (nonatomic, strong) UIButton *diagreeBtn;
@property (copy, nonatomic) void (^disagreeActionBlock)(void);
@property (copy, nonatomic) void (^privateActionBlock)(void);
@property (copy, nonatomic) void (^delegateDisagreeActionBlock)(void);

@end

@implementation ProtocolAlerView

- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.8];
        self.alpha = 0;
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.titleL];
        [self.contentView addSubview:self.textView];
        [self.contentView addSubview:self.agreeBtn];
        [self.contentView addSubview:self.diagreeBtn];

        [self setFrame];
    }
    return self;
}

- (void)setFrame
{
    CGFloat width = self.contentView.bounds.size.width;
    CGFloat height = self.contentView.bounds.size.height;
    CGFloat margin = 20 *kScale;
    self.titleL.frame = CGRectMake(margin, margin *0.7, width -margin *2, 20 *kScale);
    self.textView.frame = CGRectMake(margin, CGRectGetMaxY(self.titleL.frame) +margin *0.7, width -margin *2, height - margin *5);
    self.agreeBtn.frame =
    CGRectMake(margin+width/2, height - margin *3, width/2 - margin *2, margin *2);
    self.diagreeBtn.frame = CGRectMake(margin, height - margin *3, width/2 - margin *2, margin *2);

}

- (void)setStrContent:(NSString *)strContent{
    _strContent = strContent;
    NSString *agreeStr = [NSString stringWithFormat:@"%@", strContent];/// @"我已阅读并同意《隐私政策》《用户协议》";
    NSMutableAttributedString *diffString = [[NSMutableAttributedString alloc] initWithString:agreeStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5 *kScale;

    [diffString addAttribute:NSForegroundColorAttributeName value:UIColor.blueColor range:[[diffString string] rangeOfString:strContent]];
    
    [diffString addAttribute:NSLinkAttributeName
                           value:@"privacy://"
                           range:[[diffString string] rangeOfString:[NSString stringWithFormat:@"《隐私政策》"]]];/// 《隐私政策》
    [diffString addAttribute:NSLinkAttributeName
                       value:@"delegate://"
                       range:[[diffString string] rangeOfString:[NSString stringWithFormat:@"《用户协议》"]]];/// 《用户协议》
    [diffString addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle,
                                      NSFontAttributeName:[UIFont systemFontOfSize:13]
                                      } range:NSMakeRange(0, strContent.length)];
     self.textView.linkTextAttributes = @{NSForegroundColorAttributeName: UIColor.redColor};
     self.textView.attributedText = diffString;

}
- (UITextView *)textView
{
    if (_textView == nil) {
        _textView = [[UITextView alloc] init];
        _textView.scrollEnabled = NO;
        _textView.delegate = self;
        _textView.showsHorizontalScrollIndicator = NO;
        _textView.showsVerticalScrollIndicator = NO;
        _textView.textColor = UIColor.grayColor;
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.editable = NO;
    }
    return _textView;
}
- (UIView *)contentView
{
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.frame = CGRectMake(leftMargin, topMargin*1.5, kScreenWidth - leftMargin *2, kScreenHeight - topMargin *4);
        _contentView.layer.cornerRadius = 10 *kScale;
    }
    return _contentView;
}
- (UILabel *)titleL
{
    if (_titleL == nil) {
        _titleL = [[UILabel alloc] init];
        _titleL.textColor = [UIColor blackColor];
        _titleL.font = [UIFont systemFontOfSize:17 *kScale weight:UIFontWeightHeavy];
        _titleL.textAlignment = 1;
        _titleL.text = @"欢迎使用";
    }
    return _titleL;
}

- (UIButton *)agreeBtn
{
    if (_agreeBtn == nil) {
        _agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _agreeBtn.tag = 1 ;

        [_agreeBtn setTitle:@"同意并继续" forState:UIControlStateNormal];
        [_agreeBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [_agreeBtn setTitleColor:[UIColor colorWithRed:47/255.0 green:142/255.0 blue:209/255.0 alpha:1] forState:UIControlStateNormal];
        [_agreeBtn addTarget:self action:@selector(dismissAlertView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _agreeBtn;
}
- (UIButton *)diagreeBtn
{
    if (_diagreeBtn == nil) {
        _diagreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _diagreeBtn.tag = 2;
        [_diagreeBtn setTitle:@"不同意" forState:UIControlStateNormal];
        [_diagreeBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [_diagreeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_diagreeBtn addTarget:self action:@selector(dismissAlertView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _diagreeBtn;
}
- (void)showAlert:(UIViewController *)vc cancelAction:(void (^ _Nullable)(id _Nullable object))cancelAction  privateAction:(void (^ _Nullable)(id _Nullable object))privateAction delegateAction:
(void (^ _Nullable)(id _Nullable object))delegateAction
{
    [vc.view addSubview:self];
    [UIView animateWithDuration:1 animations:^{
        self.alpha = 1.0;
    }];
    
    self.disagreeActionBlock = ^{
        cancelAction(nil);
    };
    
    
    self.privateActionBlock = ^{
        privateAction(nil);
    };
    
    self.delegateDisagreeActionBlock = ^{
        delegateAction(nil);
    };
    
    
    
    
}

- (void)dismissAlertView:(UIButton *)btn
{
    if (btn.tag == 1) {
            [UIView animateWithDuration:1 animations:^{
        //        self.transform = CGAffineTransformMakeScale(0.1, 0.1)
                self.alpha = 0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
    }else{
        self.disagreeActionBlock();
        
    }
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
    /// 隐私
    if ([[URL scheme] isEqualToString:@"privacy"]){
        /// 跳转隐私政策界面
        self.privateActionBlock();
    }
    /// 协议
    else if ([[URL scheme] isEqualToString:@"delegate"]) {
        /// 跳转用户协议界面
        self.delegateDisagreeActionBlock();
    }
    return YES;
}

@end
