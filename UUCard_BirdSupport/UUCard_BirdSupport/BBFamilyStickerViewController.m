//
//  BBFamilyStickerViewController.m
//  UUCard_BirdSupport
//
//  Created by Bird on 2014/7/28.
//  Copyright (c) 2014年 iOSTeam. All rights reserved.
//
#define ANIMATION_DURATION .5f
#define PICKERVIEW_HEIGHT 216
#import "BBFamilyStickerViewController.h"
#import "FamilyCollectionCell.h"
#import "BBFakeAlertView.h"
@interface BBFamilyStickerViewController ()
{
    NSArray *cellIDs;
    __weak IBOutlet UICollectionView *m_collectionView;
    __weak IBOutlet UIImageView *bgImageView;
}
@end

@implementation BBFamilyStickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uperBtnClicked) name:@"uperBtnClicked" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lowerBtnClicked) name:@"lowerBtnClicked" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(whenURLClicked) name:@"URL_TAPED" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popUpStickerNumberPicker) name:@"popUpStickerNumberPicker" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GiveStickerDialogCancelClicked) name:@"GiveStickerDialogCancelClicked" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GiveStickerDialogConfirmClicked) name:@"GiveStickerDialogConfirmClicked" object:nil];
    
    //設定背景圖
    if (bgImageView && _bgImage) {
        [bgImageView setImage:_bgImage];
    }
    
    //依據物件，建立cell id array
    NSString *finalPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"FamilyCell_List.plist"];
    NSDictionary *cellDic = [NSDictionary dictionaryWithContentsOfFile:finalPath];
    
    if (_dataObject.isPointAccord) {//符合貼紙條件
        cellIDs = [cellDic objectForKey:@"stickerViewType0"];
    }else{
        cellIDs = [cellDic objectForKey:@"stickerViewType1"];
    }
    
    [m_collectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"uperBtnClicked" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"lowerBtnClicked" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"URL_TAPED" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"popUpStickerNumberPicker" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GiveStickerDialogCancelClicked" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GiveStickerDialogConfirmClicked" object:nil];
}
- (BOOL)prefersStatusBarHidden{
    return YES;
}
#pragma mark - button actions
- (void)uperBtnClicked{
    NSLog(@"uper button clicked");
}
- (void)lowerBtnClicked{
    NSLog(@"lower button clicked");
    BBFakeAlertView *alert = [[BBFakeAlertView alloc] initWithNibName:@"GiveStickerDialog"];
    [self.view addSubview:alert];
    [alert show];
}
- (void)whenURLClicked{
    NSLog(@"url button clicked");
}
- (void)GiveStickerDialogConfirmClicked{//送幾張選擇頁面選到確定
    
}
- (void)GiveStickerDialogCancelClicked{//送幾張選擇頁面選到取消
    [self dismissPopUpPickerView];
}
#pragma mark - support methods
- (void)popUpStickerNumberPicker{//show選幾張picker
    BBFakeAlertView *targetView;
    //找到 FakeAlertView
    for (BBFakeAlertView *view in self.view.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"BBFakeAlertView")]) {
            //多個FakeAlertView，移除之前的
            if (targetView) {
                [targetView removeFromSuperview];
            }
            targetView = view;
        }
    }
    // 上移FakeAlertView
    if (targetView) {
        [UIView animateWithDuration:ANIMATION_DURATION animations:^{
            [targetView setFrame:CGRectMake(0, PICKERVIEW_HEIGHT * -.5f, targetView.frame.size.width, targetView.frame.size.height)];
        }];
    }
    // 若還有UIPicker在View上，先行移除
    for (UIPickerView *view in self.view.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UIPickerView")]) {
            [targetView removeFromSuperview];
        }
    }
    // 產出UIPicker
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, PICKERVIEW_HEIGHT)];
    picker.delegate = self;
    picker.dataSource = self;
    [picker setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:picker];
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        [picker setFrame:CGRectMake(0, self.view.frame.size.height - PICKERVIEW_HEIGHT, self.view.frame.size.width, PICKERVIEW_HEIGHT)];
    }];
}
- (void)dismissPopUpPickerView{
    //remove picker
    for (UIPickerView *view in self.view.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UIPickerView")]) {
            [UIView animateWithDuration:ANIMATION_DURATION animations:^{
                [view setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, PICKERVIEW_HEIGHT)];
            } completion:^(BOOL complete){
                [view removeFromSuperview];
            }];
        }
    }
    //remove FakeAlertView
    for (BBFakeAlertView *view in self.view.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"BBFakeAlertView")]) {
            [view dismiss];
        }
    }
}
#pragma mark - collection view
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [cellIDs count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = [cellIDs objectAtIndex:indexPath.row];
    FamilyCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    [cell setDataFromIdentifer:cellID andData:_dataObject];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = [cellIDs objectAtIndex:indexPath.row];
    CGSize cellSize = [FamilyCollectionCell getCellSizeFromIdentifer:cellID andData:_dataObject];
    return cellSize;
}
#pragma mark - UIPicker delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 30;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [NSString stringWithFormat:@"%i張",(int)row + 1];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    BBFakeAlertView *targetView;
    
    //找到 FakeAlertView
    for (BBFakeAlertView *view in self.view.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"BBFakeAlertView")]) {
            //多個FakeAlertView，移除之前的
            if (targetView) {
                [targetView removeFromSuperview];
            }
            targetView = view;
        }
    }
    if (targetView) {
        [targetView setTargetSendStickerNumber:[NSString stringWithFormat:@"%i張",(int)row + 1]];
    }
}
@end
