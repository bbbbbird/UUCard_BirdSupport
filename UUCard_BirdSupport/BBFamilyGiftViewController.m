//
//  BBFamilyGiftViewController.m
//  UUCard_BirdSupport
//
//  Created by Bird on 2014/7/25.
//  Copyright (c) 2014年 iOSTeam. All rights reserved.
//
#define CELL_ID_ARRAY @[ @"FamilyTitle", @"SpeerateLine", @"ActivityTitle", @"ActivityContent",@"gap10",@"gap10", @"ActivityBtn", @"ActivityDescriptionTitle", @"ActivityDescriptionContent", @"ActivityDurationTitle", @"ActivityDurationContent", @"ExchangeTimeTitle" ,@"ExchangeTimeContent" , @"ExchangeMethodTitle", @"ExchangeMethodContent", @"URLTitle", @"URLContent" ]
#import "BBFamilyGiftViewController.h"
#import "FamilyCollectionCell.h"
@interface BBFamilyGiftViewController ()
{
    NSArray *cellIDs;
    __weak IBOutlet UIImageView *bgImageView;
    __weak IBOutlet UICollectionView *m_collectionView;
}
@end

@implementation BBFamilyGiftViewController

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
    //監聽中間那顆(和URL)按鈕有沒有被按倒
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(whenSearchBtnClicked) name:@"getOrSearchBtnClicked" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(whenURLClicked) name:@"URL_TAPED" object:nil];
    //設定背景圖
    if (bgImageView && _bgImage) {
        [bgImageView setImage:_bgImage];
    }
    //依據物件，建立cell id array
    if (_dataObject.isSerialAccord) {//符合條件
        cellIDs = CELL_ID_ARRAY;
    }else{//不符合條件
        cellIDs = [NSArray arrayWithObjects:CELL_ID_ARRAY[0], CELL_ID_ARRAY[1], CELL_ID_ARRAY[2], CELL_ID_ARRAY[3],CELL_ID_ARRAY[7], CELL_ID_ARRAY[8],CELL_ID_ARRAY[9], CELL_ID_ARRAY[10],CELL_ID_ARRAY[CELL_ID_ARRAY.count - 2], CELL_ID_ARRAY[CELL_ID_ARRAY.count - 1], nil];
    }
    [m_collectionView reloadData];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"getOrSearchBtnClicked" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"URL_TAPED" object:nil];
}
- (BOOL)prefersStatusBarHidden{
    return YES;
}
#pragma mark - Button methods
- (void)whenSearchBtnClicked{
    NSLog(@"middle Btn clicked!");
}
- (void)whenURLClicked{
    NSLog(@"URL clicked!");
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
@end
