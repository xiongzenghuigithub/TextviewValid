//
//  ZHTableViewController.m
//  ZHpickView
//
//  Created by liudianling on 14-11-18.
//  Copyright (c) 2014年 赵恒志. All rights reserved.
//

#import "ZHTableViewController.h"
#import "XZHPickerView.h"
@interface ZHTableViewController ()<XZHPickerViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property(nonatomic,strong)XZHPickerView *pickview;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong) NSArray *dataList;
@end
@implementation ZHTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataList = @[@"City",@"时间",@"一维数组",@"多维数组",@"动态创建的数组"];

    self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    [self hideExcessLine:self.tableView];
}

//去掉多余的空cell
-(void)hideExcessLine:(UITableView *)tableView{
    
    UIView *view=[[UIView alloc] init];
    view.backgroundColor=[UIColor clearColor];
    [tableView setTableFooterView:view];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.detailTextLabel.text = _dataList[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //先移除pickerView
    [_pickview remove];
    
    _indexPath=indexPath;
    UITableViewCell * cell=[self.tableView cellForRowAtIndexPath:indexPath];

    //2.
    switch ([indexPath row]) {
        case 0: {
            //城市
            _pickview = [[XZHPickerView alloc] initPickviewWithPlistName:@"city" isHaveNavControler:YES];
        }
            
            break;
        
        case 1: {
            //时间
            NSDate *date= [NSDate dateWithTimeIntervalSinceNow:9000000];
            _pickview = [[XZHPickerView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
        }
            
            break;
    
        case 2: {
            //Plist给定的一维数组
            _pickview = [[XZHPickerView alloc] initPickviewWithPlistName:@"一组数据" isHaveNavControler:YES];
        }
            
            break;
            
        case 3: {
            //Plist给定的多维数组
            _pickview = [[XZHPickerView alloc] initPickviewWithPlistName:@"多组数据" isHaveNavControler:YES];
        }
            
            break;
            
        case 4: {
            //代码创建给定多维数组
            NSArray *array = @[@[@"1",@"小明",@"aa"],@[@"2",@"大黄",@"bb"],@[@"3",@"企鹅",@"cc"], @[@"wdw",@"dawd"]];
            _pickview = [[XZHPickerView alloc] initPickviewWithArray:array isHaveNavControler:NO];
        }
    
            break;
            
        default:
            break;
    }
    
    
    //3. delegate
    _pickview.delegate = self;
    
    //4. 显示pickerView
    [_pickview show];   //是在当前UIWindow层弹出PickerView
}



#pragma mark ZhpickVIewDelegate

-(void)toobarDonBtnHaveClick:(XZHPickerView *)pickView resultString:(NSString *)resultString{

    UITableViewCell * cell=[self.tableView cellForRowAtIndexPath:_indexPath];
    cell.detailTextLabel.text=resultString;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0f;
}
@end

