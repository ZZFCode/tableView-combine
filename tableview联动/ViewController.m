//
//  ViewController.m
//  tableview联动
//
//  Created by 左忠飞 on 16/6/2.
//  Copyright © 2016年 zzf.con. All rights reserved.
//
//  测试修改

#import "ViewController.h"

#define RGBACOLOR(r,g,b,a)  [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"二级联动";
    
    [self loadData];
    [self leftTableview];
    [self rightTableview];
    [self lineView];
    _isRelate = YES;
}

-(void)loadData{
    _dataArray = @[@{@"title":@"第一组",@"list":@[@"1",@"one",@"two",@"three",@"foue",@"five"]},
                   @{@"title":@"第二组",@"list":@[@"2",@"one",@"two",@"three",@"foue",@"five"]},
                   @{@"title":@"第三组",@"list":@[@"3",@"one",@"two",@"three",@"foue",@"five"]},
                   @{@"title":@"第四组",@"list":@[@"4",@"one",@"two",@"three",@"foue",@"five"]},
                   @{@"title":@"第五组",@"list":@[@"5",@"one",@"two",@"three",@"foue",@"five"]},
                   @{@"title":@"第六组",@"list":@[@"6",@"one",@"two",@"three",@"foue",@"five"]},
                   @{@"title":@"第七组",@"list":@[@"7",@"one",@"two",@"three",@"foue",@"five"]},
                   @{@"title":@"第八组",@"list":@[@"8",@"one",@"two",@"three",@"foue",@"five"]},
                   @{@"title":@"第九组",@"list":@[@"9",@"one",@"two",@"three",@"foue",@"five"]},
                   @{@"title":@"第十组",@"list":@[@"10",@"one",@"two",@"three",@"foue",@"five"]},
                   @{@"title":@"第十一",@"list":@[@"11",@"one",@"two",@"three",@"foue",@"five"]},

                   ];
}

-(UITableView *)leftTableview
{
    if (nil == _leftTableview) {
        _leftTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,100, self.view.frame.size.height)];
        _leftTableview.backgroundColor = [UIColor whiteColor];
        _leftTableview.delegate = self;
        _leftTableview.dataSource = self;
        [self.view addSubview:_leftTableview];
    }
    return _leftTableview;
}

-(UITableView *)rightTableview{
    if (nil == _rightTableview) {
        _rightTableview = [[UITableView alloc]initWithFrame:CGRectMake(100, 0, self.view.frame.size.width - 100, self.view.frame.size.height)];
        _rightTableview.backgroundColor = [UIColor whiteColor];
        _rightTableview.delegate = self;
        _rightTableview.dataSource = self;
        [self.view addSubview:_rightTableview];
    }
    return _rightTableview;
}

-(UIView *)lineView{
    if (nil == _lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(100, 0, 0.5, self.view.frame.size.height)];
        _lineView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:_lineView];
    }
    return _lineView;
}

#pragma mark - 数据源方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.leftTableview) {
        return 1;
    }else{
        return _dataArray.count;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *item = [_dataArray objectAtIndex:section];
    if (tableView == self.leftTableview) {
        return _dataArray.count;
    }else{
        return [[item objectForKey:@"list"]count];
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"cell";
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIndentifier];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if (tableView == self.leftTableview) {
        UIView *selectedBackGroundView = [[UIView alloc]initWithFrame:cell.frame];
        
        selectedBackGroundView.backgroundColor = RGBACOLOR(217, 217, 217, 0.5);
        cell.selectedBackgroundView = selectedBackGroundView;
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5,80)];
        line.backgroundColor = [UIColor orangeColor];
        
        [selectedBackGroundView addSubview:line];
        
        cell.textLabel.text = [_dataArray[indexPath.row]objectForKey:@"title"];
    }else{
        NSDictionary *item = [_dataArray objectAtIndex:indexPath.section];
        cell.textLabel.text = [item objectForKey:@"list"][indexPath.row];
    }
    return cell;
}

#pragma mark - 代理方法

//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableview) {
        return 80;
    }else{
        return 130;
    }
}

//头部高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.leftTableview) {
        return 0;
    }else{
        return 30;
    }
}

//底部视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView == self.leftTableview) {
        return 0;
    }else{
        return CGFLOAT_MIN;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.rightTableview) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
        view.backgroundColor = RGBACOLOR(217, 217, 217, 0.7);
        UILabel *label = [[UILabel alloc]initWithFrame:view.bounds];
        NSDictionary *item = [_dataArray objectAtIndex:section];
        NSString *title = [item objectForKey:@"title"];
        label.text = [NSString stringWithFormat:@"    %@",title];
        [view addSubview:label];
        return view;
    }else{
        return nil;
    }
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    if (_isRelate) {
        NSInteger topCellSection = [[[tableView indexPathsForVisibleRows]firstObject]section];
        
        if (tableView == self.rightTableview) {
            [self.leftTableview selectRowAtIndexPath:[NSIndexPath indexPathForItem:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}

-(void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section{
    if (_isRelate) {
        NSInteger topCellSection = [[[tableView indexPathsForVisibleRows]firstObject]section];
        if (tableView == self.rightTableview) {
            [self.leftTableview selectRowAtIndexPath:[NSIndexPath indexPathForItem:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableview) {
        _isRelate = NO;
        [self.leftTableview selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
        
        [self.rightTableview scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }else{
        [self.rightTableview deselectRowAtIndexPath:indexPath animated:NO];
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    _isRelate = YES;
}
@end













