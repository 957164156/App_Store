//
//  ViewController.m
//  AppStore
//
//  Created by 孙明卿 on 2016/12/9.
//  Copyright © 2016年 爱书人. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topMargin;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.tableView.contentInset = UIEdgeInsetsMake(150, 0, 0, 0);
    
    //self.tableView.estimatedRowHeight = 240;
    //self.tableView.rowHeight = UITableViewAutomaticDimension;
    //self.tableView.rowHeight = 240;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma tableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < 3) {
        return 240;
    }else {
        return 150;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = nil;
    UITableViewCell *cell = nil;
    if (indexPath.section < 3) {
       identifier = @"tableViewCell1";
    }else {
       identifier = @"tableViewCell2";
    }
    cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    switch (scrollView.tag) {
        case 200:
            if (-scrollView.contentOffset.y < 150) {
                self.topMargin.constant = -scrollView.contentOffset.y - scrollView.contentInset.top;
            }else {
                //防止它跳过临界值,固定住
                self.topMargin.constant = 0;
            }
            
            break;
            
        default:
            break;
        
    }
   
}




@end

@interface InTableView()

@end

@implementation InTableView



@end

@interface InTableViewCell()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UICollectionView *collectVIewCell2;
@end

@implementation InTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectVIewCell2.decelerationRate = 0.5;
    self.collectionView.decelerationRate = 0.5;
}

#pragma collectView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 6;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = nil;
    if (collectionView.tag == 101) {
       identifier = @"collectViewCell1";
    }else {
       identifier = @"collectViewCell2";
    }
    
    InCollectViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (collectionView.tag == 101) {
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",indexPath.row + 1]];
    }else {
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"0%ld",indexPath.row]];
    }
    return cell;
}


@end

@implementation InCollectViewCell



@end

