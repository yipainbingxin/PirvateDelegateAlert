//
//  ProtocolAlerView.h
//  PirvateDelegateAlert
//
//  Created by bing on 2019/12/12.
//  Copyright © 2019 youshu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProtocolAlerView : UIView
/**
 弹框内容文本
 */
@property (nonatomic, copy) NSString *strContent;

- (void)showAlert:(UIViewController *)vc cancelAction:(void (^ _Nullable)(id _Nullable object))cancelAction  privateAction:(void (^ _Nullable)(id _Nullable object))privateAction delegateAction:(void (^ _Nullable)(id _Nullable object))delegateAction;

@end

NS_ASSUME_NONNULL_END
