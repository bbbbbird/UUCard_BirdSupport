//
//  GiveStickerDialog.h
//  UUCard_BirdSupport
//
//  Created by Bird on 2014/7/29.
//  Copyright (c) 2014年 iOSTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GiveStickerDialog : UIView
- (void)initAlert;
- (void)setTargetSendStickerNumber:(NSString *)value;//設定要送幾張
- (void)setTargetSendStickerTarget:(NSString *)value;//設定要送給誰
@end
