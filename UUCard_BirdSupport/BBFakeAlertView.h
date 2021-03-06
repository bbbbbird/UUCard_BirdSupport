//
//  BBFakeAlertView.h
//  UUCard_BirdSupport
//
//  Created by Mac on 2014/7/29.
//  Copyright (c) 2014年 iOSTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBFakeAlertView : UIView
- (id)initWithNibName:(NSString*)targetNib;
- (void)show;
- (void)dismiss;
- (void)setTargetSendStickerNumber:(NSString *)value;//設定要送幾張
- (void)setTargetSendStickerTarget:(NSString *)value;//設定要送給誰
@end
