//
//  ViewController.h
//  tableview联动
//
//  Created by 左忠飞 on 16/6/2.
//  Copyright © 2016年 zzf.con. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

{
    NSArray *_dataArray;
    BOOL _isRelate;
}

@property(nonatomic,strong)UITableView *leftTableview;
@property(nonatomic,strong)UITableView *rightTableview;
@property(nonatomic,strong)UIView *lineView;


@end

