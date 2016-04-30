//
//  JDFourRoadViewController.m
//  eTaxi-iOS
//
//  Created by jeader on 16/3/3.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDFourRoadViewController.h"

#import "HeadFile.pch"
#import "JDFourLostAndRoadView.h"
#import "JDRoadCell.h"
#import "UIImageView+WebCache.h"
#import "UIView+UIView_CYChangeFrame.h"
#import "JDThirdLostCell.h"
#import "JDAuditStatusView.h"
#import <CoreLocation/CoreLocation.h>

#import "JDRoadDataTool.h"
#import "JDRoadData.h"
#import "JDRoadNetTool.h"
#import "JDLostButton.h"
#import "JDToCarmeView.h"
#import "JDNoMessageView.h"

#define TopTextFont [UIFont systemFontOfSize:13] //顶部label的文字大小
#define STATUSHEIGHT 44 //申报记录下面的审核状态栏的高度
#define CellHeaderHeight 25  //cell的头视图高度
#define ROW indexPath.section-2 //第几组
#define NoMessCellH JDScreenSize.height-64-CellHeaderHeight*2-STATUSHEIGHT-LostAndRoadBtnViewH //没有消息的时候的视图的高度

@interface JDFourRoadViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CLLocationManagerDelegate,JDFourLostViewDelegate,JDAuditStatusViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/**
 *  物品类型名字数组
 */
@property (nonatomic, strong) NSArray *nameArr;
@property (nonatomic, strong) NSArray * imageArr;

/**
 *  路况信息的数组
 */
@property (nonatomic, strong) NSMutableArray *roadRecord;

@property (nonatomic, copy) NSString *topStr; //选中的失物的状态

@property (nonatomic, strong) UIImage *image; //相机或者相册取出的照片

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

/**
 *  失物和路况公共的按钮视图
 */
@property (nonatomic, strong) JDFourLostAndRoadView *fourView;

/**
 *  审核状态按钮数组
 */
@property (nonatomic, strong) NSArray *statusBtnArr;
// 物品审核状态栏
@property (nonatomic, strong) JDAuditStatusView *statusView;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, weak) JDAuditStatusView *statusViewInSelf;

/**
 *  选择的路况
 */
@property (nonatomic, copy) NSString *statusStr;

@end

@implementation JDFourRoadViewController

-(NSArray *)statusBtnArr
{
    if (_statusBtnArr == nil) {
        
        _statusBtnArr = @[@"审核中",@"未通过",@"已通过"];
        
    }
    return _statusBtnArr;
}

-(NSMutableArray *)roadRecord
{
    if (_roadRecord == nil) {
        _roadRecord = [NSMutableArray array];
    }
    return _roadRecord;
}

-(NSArray *)nameArr
{
    if (_nameArr == nil) {
        _nameArr = @[@"拥堵",@"故障",@"车祸",@"积水",@"警察",@"施工",@"封路",@"其他",@""];
    }
    return _nameArr;
}
-(NSArray *)imageArr
{
    if (_imageArr == nil) {
        _imageArr = @[@"road_拥堵",@"road_故障",@"road_车祸",@"road_积水",@"road_警察",@"road_施工",@"road_封路",@"road_其他",@""];
    }
    return _imageArr;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self startLoction];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     *  取消tableview的分割线
     */
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    _currentIndex = 0;
    
    //进入页面获取 审核中的数据信息
    [self getRoadDataWithStatus:0];
    
    [self addStoreView];
    
    [self addCleaerNavigationBar:@"路况申报"];
    
}

#pragma mark - 定位
-(void)startLoction
{
    //定位管理器
    _locationManager=[[CLLocationManager alloc]init];
    
    if (![CLLocationManager locationServicesEnabled]) {
        //            NSLog(@"定位服务当前可能尚未打开，请设置打开！");
        [GetData addAlertViewInView:self title:@"温馨提示" message:@"定位功能可能未打开，请到‘设置-隐私-定位服务’中打开！" count:0 doWhat:^{
            
        }];
        //            return;
    }
    
    //如果没有授权则请求用户授权
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
        [_locationManager requestWhenInUseAuthorization];
    }else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse){
        //设置代理
        _locationManager.delegate=self;
        //设置定位精度
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        //定位频率,每隔多少米定位一次
        CLLocationDistance distance=10.0;//十米定位一次
        _locationManager.distanceFilter=distance;
        //启动跟踪定位
        [_locationManager startUpdatingLocation];
    }
    

}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    _coordinate = newLocation.coordinate;
    
}

-(void)locationManager:(CLLocationManager *)manager didFinishDeferredUpdatesWithError:(NSError *)error
{
    
    [GetData addAlertViewInView:self title:@"温馨提示" message:[NSString stringWithFormat:@"%@",error] count:0 doWhat:^{
        
    }];
}

#pragma mark - 添加浮动的视图
-(void)addStoreView
{
    JDAuditStatusView *statusViewInSelf = [[JDAuditStatusView alloc] initWithFrame:CGRectMake(0, 64, JDScreenSize.width, STATUSHEIGHT)];
    statusViewInSelf.delegate = self;
    _statusViewInSelf = statusViewInSelf;
    statusViewInSelf.statusBtnArr = self.statusBtnArr;
    statusViewInSelf.currentIndex = _currentIndex;
    statusViewInSelf.hidden = YES;
    [self.view addSubview:statusViewInSelf];
}

#pragma mark - 浮动视图的delegate
-(void)auditStatusBtnClick:(NSInteger)index
{
    
    _currentIndex = index;
    _statusView.currentIndex = index;
    _statusViewInSelf.currentIndex = index;
    
    [self getRoadDataWithStatus:index];
    
}

#pragma mark - 请求数据：申报记录
-(void)getRoadDataWithStatus:(NSInteger)index
{
    [JDRoadNetTool roadDataInVC:self Success:^(NSMutableArray *dataArr) {
       
        [self.roadRecord removeAllObjects];
        
        
        for (int i = 0; i < dataArr.count; i++) {
            
            JDRoadData *roadData = dataArr[i];
            
            if (roadData.roadStatus==index) {
                
                [self.roadRecord addObject:roadData];
            }
        }
        
        [self.tableView reloadData];

        
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark - 按钮视图的delegate 进入相机界面
-(void)clickBtnDidAnimation:(UIView *)sender btnName:(NSString *)str
{
    _statusStr = str;
    UIImagePickerController *picker = [JDToCarmeView presentToCarmeaViewInVC:self];
    picker.delegate = self;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        //将图片存入系统相册中
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    _image = [JDToCarmeView imageWithImageSimple:image scaledToSize:CGSizeMake(568, 375)];
    
    /**
     *  上传信息
     */
    [self clickCommitRoadInfo];
    
}

#pragma mark - 上传路况信息（带图）
-(void)clickCommitRoadInfo
{
    NSArray *textArr = self.nameArr;
    
    int style = 0;
    for (int i = 0; i < textArr.count; i ++) {
        if ([self.statusStr isEqualToString:textArr[i]]) {
            
            style = i;
            
        }
    }
    
    NSString *styleStr = [NSString stringWithFormat:@"%d",style]; //失物类型字符串
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
    
    [JDRoadNetTool sendRoadDataInVC:self RoadType:styleStr image:self.image location:location Success:^{
        
        _currentIndex = 0;
        //上传成功之后刷新数据
        [self getRoadDataWithStatus:0];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - tableView滚动的时候调用
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    for (JDLostButton *btn in _fourView.btnArr) {
        btn.enble = NO;
    }
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY>=CellHeaderHeight+LostAndRoadBtnViewH) {
        self.statusViewInSelf.hidden = NO;
    }else{
        self.statusViewInSelf.hidden = YES;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    for (JDLostButton *btn in _fourView.btnArr) {
        btn.enble = YES;
    }
}

#pragma mark - tableView delegate & datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.roadRecord.count==0) {
        return 3;
    }
    return self.roadRecord.count+2;
    return 10;
}

//cell的头视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return CellHeaderHeight;
    }
    if (section==2) {
        return 0.000001;
    }
    return 0.001;
}

//cell的脚视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.000001;
}

//cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) { // 选择物品类型按钮视图的高度
        return LostAndRoadBtnViewH;
    }else if(indexPath.section==1){ // 物品审核状态栏的高度
        return STATUSHEIGHT;
    }
    
    if (!self.roadRecord.count && indexPath.section==2) {
        return NoMessCellH;
    }
    
    return 125;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JDRoadCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell = [[NSBundle mainBundle]loadNibNamed:@"JDRoadCell" owner:nil options:nil][1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    /**
     *  第一栏
     */
    if (indexPath.section==0) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"JDRoadCell" owner:nil options:nil][1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //创建物品类型按钮视图
        JDFourLostAndRoadView *fourView = [[JDFourLostAndRoadView alloc] initWithFrame:CGRectMake(0, 0, JDScreenSize.width, LostAndRoadBtnViewH)];
        fourView.delegate = self;
        _fourView = fourView;
        [fourView setNameArr:self.nameArr];
        [fourView setImageNameArr:self.imageArr];
        [cell.contentView addSubview:fourView];
        
    }else if (indexPath.section==1){ //第二栏
        
        cell = [[NSBundle mainBundle]loadNibNamed:@"JDRoadCell" owner:nil options:nil][1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        // 物品审核状态栏
        JDAuditStatusView *statusView = [[JDAuditStatusView alloc] initWithFrame:CGRectMake(0, 0, JDScreenSize.width, STATUSHEIGHT)];
        statusView.delegate = self;
        _statusView = statusView;
        statusView.currentIndex = _currentIndex;
        statusView.statusBtnArr = self.statusBtnArr;
        [cell.contentView addSubview:statusView];
        
    }else if(indexPath.section>=2){
        
        cell = [[NSBundle mainBundle]loadNibNamed:@"JDRoadCell" owner:nil options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (self.roadRecord.count) {
            
            JDRoadData *roadData = self.roadRecord[ROW];
            //图片
            [cell.roadImageV sd_setImageWithURL:roadData.roadImage placeholderImage:[UIImage imageNamed:@"站位图92"]];
            [cell.roadImageV showBiggerPhotoInview:self.view];
            
            //类型
            cell.roadType.text = [NSString stringWithFormat:@"路况类型: %@",roadData.roadType];
            
            //时间
            cell.roadTime.text = [NSString stringWithFormat:@"发布时间: %@",roadData.roadTime];
            
            //地址
            cell.roadAdd.text = [NSString stringWithFormat:@"申报地址: %@",roadData.roadAddress];
            
        }else{ //如果没有数据
            
            for (int i = 0; i < cell.contentView.subviews.count; i ++) {
                
                //移除所有子控件
                [cell.contentView.subviews[i] removeFromSuperview];
                
            }
            [cell.roadAdd removeFromSuperview];
            //没有申报记录
            CGFloat height = CellHeaderHeight,y = 50;
            if (JDScreenSize.width==320&&JDScreenSize.height==480) {
                height = 150;
                y=10;
            }
            JDNoMessageView *noMessage = [[JDNoMessageView alloc] initWithFrame:CGRectMake(0, y, JDScreenSize.width, height)];
            noMessage.message = @"当前没有申报记录";
            [cell.contentView addSubview:noMessage];
            
        }
        
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}


//返回顶部视图的样式
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        NSString *str = @"请选择路况类型";
        //顶部空白label
        UILabel *full = [[UILabel alloc] initWithFrame:CGRectMake((JDScreenSize.width-150)/2, 0, 150, CellHeaderHeight)];
        full.textColor = [UIColor whiteColor];
        full.font = TopTextFont;
        full.text = str;
        full.textAlignment = NSTextAlignmentCenter;
        
        return full;
    }
    return nil;
    
}

@end
