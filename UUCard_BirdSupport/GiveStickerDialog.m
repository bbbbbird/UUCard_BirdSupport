//
//  GiveStickerDialog.m
//  UUCard_BirdSupport
//
//  Created by Bird on 2014/7/29.
//  Copyright (c) 2014年 iOSTeam. All rights reserved.
//
#define TEXTFIELD_COLOR [UIColor colorWithRed:204.0/255.0 green:247.0/255.0 blue:153.0/255.0 alpha:1.0]
#import "GiveStickerDialog.h"
#import <QuartzCore/QuartzCore.h>
@interface GiveStickerDialog (){
    
    __weak IBOutlet UITextField *sendStickerCountTextField;
    __weak IBOutlet UITextField *sendStickerTargetField;
}
@end
@implementation GiveStickerDialog

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)initAlert{
    //設定TextField color
    sendStickerCountTextField.layer.borderColor = [TEXTFIELD_COLOR CGColor];
    sendStickerCountTextField.layer.borderWidth= 1.0f;
    sendStickerTargetField.layer.borderColor = [TEXTFIELD_COLOR CGColor];
    sendStickerTargetField.layer.borderWidth= 1.0f;
}
#pragma mark - buttons
- (IBAction)cancelBtnClicked:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GiveStickerDialogCancelClicked" object:nil];
}
- (IBAction)confirmBtnClicked:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GiveStickerDialogConfirmClicked" object:nil];
}

#pragma mark - textField delegation
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == sendStickerCountTextField) {//pop uipicker
        [[NSNotificationCenter defaultCenter] postNotificationName:@"popUpStickerNumberPicker" object:nil];
    }else if (textField == sendStickerTargetField){
        NSLog(@"pop keyboard");        
    }
    return NO;
}
#pragma mark - 外部支援
- (void)setTargetSendStickerNumber:(NSString *)value{
    [sendStickerCountTextField setText:value];
}
- (void)setTargetSendStickerTarget:(NSString *)value{
    [sendStickerCountTextField setText:value];
}
@end
