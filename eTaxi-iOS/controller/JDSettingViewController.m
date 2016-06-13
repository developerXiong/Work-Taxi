//
//  JDSettingViewController.m
//  eTaxi-iOS
//
//  Created by jeader on 16/6/7.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDSettingViewController.h"

#import "JDSettingSwitchCell.h"
#import "JDSettingTimeCell.h"
#import "SetView.h"

#import "JDShareInstance.h"

#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height

static NSArray *_rows;
static NSArray *_sections;
static NSArray *_keys;
static NSArray *_classes;
static NSString *ID = @"myCell";
@interface JDSettingViewController () <SetViewDelegate>

/**
 *  时间选择视图
 */
@property (nonatomic, strong) SetView *timeView;

/**
 *  存放选择器 时间字符串
 */
@property (nonatomic, strong) NSString *dateStr;
/**
 *  时间选择器所在cell的indexPath
 */
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation JDSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 配置cell的数组 sections 和 rows
    _sections = @[@"营收统计",@"违章",@"召车接单"];
    _rows = @[@[@"语音开关",@"每日发送时间"],@[@"语音开关"],@[@"语音开关",@"浮窗开关"]];
    _keys = [[JDShareInstance shareInstance] settingKeys];
    _classes = @[@[@"JDSettingSwitchCell",@"JDSettingTimeCell"],@[@"JDSettingSwitchCell"],@[@"JDSettingSwitchCell",@"JDSettingSwitchCell"]];
    
    // 添加时间选择视图
    [self addTimeView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    NSInteger index = [[NSUserDefaults standardUserDefaults] integerForKey:kFirstComeInSettingView];
    NSLog(@"%ld",(long)index);
    index++;
    [[NSUserDefaults standardUserDefaults] setInteger:index forKey:kFirstComeInSettingView];
    
}

+(BOOL)isFirstComingIn
{
    NSInteger index = [[NSUserDefaults standardUserDefaults] integerForKey:kFirstComeInSettingView];
    if (index) {
        return NO;
    }
    return YES;
}

#pragma mark 添加时间选择视图
-(void)addTimeView
{
    self.timeView=[[SetView alloc]init];
    self.timeView.delegate = self;
    [self.view addSubview:self.timeView];
}

#pragma mark - set view delegate
// 点击取消按钮
-(void)cancelBtnClick
{
    [UIView animateWithDuration:.3 animations:^{
        self.timeView.frame=CGRectMake(0, Height, Width, 300);
    }];
}
// 点击确定按钮
-(void)containBtnClick
{
    JDSettingTimeCell *cell = [self.tableView cellForRowAtIndexPath:self.indexPath];
    
    if ([self.dateStr length]) {
        cell.timeLabel.text = self.dateStr;
        [[NSUserDefaults standardUserDefaults] setValue:self.dateStr forKey:_keys[self.indexPath.section][self.indexPath.row]];
    }else{
        
    }
    
    [UIView animateWithDuration:.3 animations:^{
        self.timeView.frame=CGRectMake(0, Height, Width, 300);
    }];
}
// datePicker 的值改变的时候调用
-(void)datePickerValueChange:(NSString *)date
{
    self.dateStr = date;
}

#pragma mark table view delegate & datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_rows[section] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sections.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = _keys[indexPath.section][indexPath.row]; // 每一行对应的key值，存储到系统偏好设置的时候对应的key
    NSString *row = _rows[indexPath.section][indexPath.row]; // 每一行显示的内容
    Class class = NSClassFromString([_classes[indexPath.section][indexPath.row] description]);
    
    JDSettingSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell){
        cell = [[class alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID withKey:key];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.label.text = row;
    
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _sections[section];
}

// 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
// 头视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
// 脚视图高du
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000001;
}
// 选中某一行的时候调用
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0&&indexPath.row==1) {
        self.indexPath = indexPath;
        [UIView animateWithDuration:.3 animations:^
         {
             self.timeView.frame=CGRectMake(0, Height-300, Width, 300);
         }];
    }
    
}

@end
