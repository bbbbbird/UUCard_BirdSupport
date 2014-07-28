//
//  BBFamilyStickerViewController.m
//  UUCard_BirdSupport
//
//  Created by Bird on 2014/7/28.
//  Copyright (c) 2014年 iOSTeam. All rights reserved.
//
#define CELL_ID_ARRAY @[ @"FamilyTitle", @"SpeerateLine", @"ActivityTitle", @"ActivityContent",@"stickers" , @"gap10",@"ActivityBtn",@"gap10",@"gap10",@"ActivityBtn", @"ActivityDescriptionTitle", @"ActivityDescriptionContent", @"ActivityDurationTitle", @"ActivityDurationContent", @"ExchangeTimeTitle" ,@"ExchangeTimeContent" , @"ExchangeMethodTitle", @"ExchangeMethodContent", @"URLTitle", @"URLContent" ]
#import "BBFamilyStickerViewController.h"
#import "FamilyCollectionCell.h"
@interface BBFamilyStickerViewController ()
{
    NSArray *cellIDs;
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
    if (_dataObject.isPointAccord) {//符合貼紙條件
         cellIDs = CELL_ID_ARRAY;
    }else{
        cellIDs = [NSArray arrayWithObjects:CELL_ID_ARRAY[0], CELL_ID_ARRAY[1], CELL_ID_ARRAY[2], CELL_ID_ARRAY[3],CELL_ID_ARRAY[10], CELL_ID_ARRAY[11],CELL_ID_ARRAY[12], CELL_ID_ARRAY[13],CELL_ID_ARRAY[CELL_ID_ARRAY.count - 2], CELL_ID_ARRAY[CELL_ID_ARRAY.count - 1], nil];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)prefersStatusBarHidden{
    return YES;
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
