//
//  JDFourLostViewController.m
//  eTaxi-iOS
//
//  Created by jeader on 16/4/8.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDFourLostViewController.h"

#import "HeadFile.pch"
#import "JDThirdLostCell.h"
#import "JDFourLostAndRoadView.h"
#import "JDAuditStatusView.h"
#import "JDLostData.h"
#import "JDLostDataTool.h"
#import "JDLostNetTool.h"
#import "UIImageView+WebCache.h"
#import "JDDetailLostController.h"
#import "JDIsNetwork.h"
#import "UIImageView+photoBrowser.h"
#import "JDLostButton.h"

#import "JDToCarmeView.h"
#import "JDNoMessageView.h"

#define CellHeaderHeight 25  //cell的头视图高度
#define TopTextFont [UIFont systemFontOfSize:13] //顶部label的文字大小
#define STATUSHEIGHT 44 //申报记录下面的审核状态栏的高度
#define ROW indexPath.section-2 //第几组
#define NoMessCellH JDScreenSize.height-64-CellHeaderHeight*2-STATUSHEIGHT-LostAndRoadBtnViewH //没有消息的时候的视图的高度

@interface JDFourLostViewController ()<UITableViewDataSource,UITableViewDelegate,JDDetailLostDelegate,JDFourLostViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,JDAuditStatusViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) JDFourLostAndRoadView *fourView;

/**
 *  从相机选择的图片
 */
@property (strong, nonatomic) UIImage *image;

/**
 *  物品类型图片名字数组
 */
@property (nonatomic, strong) NSMutableArray *imageNameArr;
/**
 *  物品类型高亮图片名字数组
 */
@property (nonatomic, strong) NSMutableArray *imageHighlightArr;
/**
 *  物品类型名字数组
 */
@property (nonatomic, strong) NSArray *nameArr;

/**
 *  审核状态按钮数组
 */
@property (nonatomic, strong) NSArray *statusBtnArr;

// 物品审核状态栏
@property (nonatomic, weak) JDAuditStatusView *statusView;
@property (weak, nonatomic) JDAuditStatusView *statusViewInSelf;

/**
 *  存放失物 信息的数组
 */
@property (nonatomic, strong) NSMutableArray *lostDataArr;

@property (nonatomic, assign) NSInteger index;

/**
 *  物品详情
 */
@property (nonatomic, copy) NSString *describe;

/**
 *  选择的物品
 */
@property (nonatomic, copy) NSString *statusStr;
/**
 *  当前选中的状态
 */
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation JDFourLostViewController

-(NSMutableArray *)imageNameArr
{
    if (_imageNameArr == nil) {

        // 正常图片的数组
        _imageNameArr = [NSMutableArray array];
        
        for (int i=0; i<9; i++) {
            
            NSString *imageNameStr = [NSString stringWithFormat:@"lost1_%d",i];
            [_imageNameArr addObject:imageNameStr];
            
        }
        
    }
    return _imageNameArr;
}

-(NSMutableArray *)imageHighlightArr
{
    if (_imageHighlightArr == nil) {
        
        // 正常图片的数组
        _imageHighlightArr = [NSMutableArray array];
        
        for (int i=0; i<9; i++) {
            
            NSString *imageNameStr = [NSString stringWithFormat:@"lost_highlight_1_%d",i];
            [_imageHighlightArr addObject:imageNameStr];
            
        }
        
    }
    return _imageHighlightArr;
}

-(NSArray *)nameArr
{
    if (_nameArr == nil) {
        
        // 名字的数组
        _nameArr = @[@"钱包",@"手提包",@"文件",@"钥匙",@"衣服",@"电子物品",@"手机",@"耳机",@"其他"];
        
    }
    return _nameArr;
}

-(NSArray *)statusBtnArr
{
    if (_statusBtnArr == nil) {
        
        _statusBtnArr = @[@"审核中",@"未通过",@"已通过",@"已被领取"];
        
    }
    return _statusBtnArr;
}

-(NSMutableArray *)lostDataArr
{
    if (_lostDataArr == nil) {
        
        _lostDataArr = [NSMutableArray array];
        
    }
    return _lostDataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _currentIndex = 0;
    
    [self setUptableView];
    
    [self addStoreView];
    
    [self getDataWithStatus:0];
    
    [self addNavigationBar:@"失物招领"];
    
}

-(void)setUptableView
{
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //自动布局，自动根据cell的内容计算cell的高度，对应的有MVVM 代码版
    self.tableView.estimatedRowHeight = 150; //需要设置预估的高度，否则无效
    //    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    
}

#pragma mark - 获取数据  、、、只有审核中的状态
-(void)getDataWithStatus:(NSInteger)index
{
    [JDLostNetTool lostDataInVC:self Success:^(NSMutableArray *dataArr) {
        
//        self.lostDataArr = [dataArr copy];
        // 清空数组
        [self.lostDataArr removeAllObjects];
        
        
        for (int i = 0; i < dataArr.count; i++) {
            
            JDLostData *lostData = dataArr[i];
            
            if (lostData.lostStatus==index) {
                
                [self.lostDataArr addObject:lostData];
            }
        }
        
        [self.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 失物详情delegate
-(void)getGoodsDecribe:(NSString *)describe
{
    _describe = describe;
    [self getDataWithStatus:0];
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
    
    _image = [JDToCarmeView imageWithImageSimple:image];
    
    /**
     *  上传信息
     */
    [self clickCommitLostInfo];
    
}

#pragma mark - 点击上传按钮调用 失物招领
-(void)clickCommitLostInfo
{
    
    NSArray *textArr = self.imageNameArr;
    
    int style = 0;
    for (int i = 0; i < textArr.count; i ++) {
        if ([self.statusStr isEqualToString:textArr[i]]) {
            
            style = i;
            
        }
    }
    
    NSString *styleStr = [NSString stringWithFormat:@"%d",style]; //失物类型字符串
    // 上传图片和信息
    [JDLostNetTool sendLostDataInVC:self lostType:styleStr image:self.image Success:^{
        
        _currentIndex = 0;
        [self getDataWithStatus:0];
        
    } failure:^(NSError *error) {
        
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

#pragma mark - 浮动视图的delegate 点击事件
-(void)auditStatusBtnClick:(NSInteger)index
{
    // 只有_currentIndex = index;会卡，，，加上下面两句之后，可以提前改变按钮的状态再去刷新数据，避免卡的现象
    _currentIndex = index;
    _statusView.currentIndex = index;
    _statusViewInSelf.currentIndex = index;
    
    [self getDataWithStatus:index];
    
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

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    for (JDLostButton *btn in _fourView.btnArr) {
        btn.enble = YES;
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
    if (self.lostDataArr.count==0) {
        return 3;
    }
    return self.lostDataArr.count+2;
}

//cell的头视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return CellHeaderHeight;
    }
    if (section==2||section==1) {
        return 0.000001;
    }
    return 10;
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
    
    if (!self.lostDataArr.count && indexPath.section==2) {
        return NoMessCellH;
    }
    return UITableViewAutomaticDimension; //自动布局
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JDThirdLostCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell = [[NSBundle mainBundle]loadNibNamed:@"JDThirdLostCell" owner:nil options:nil][1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.0f];
    
    /**
     *  第一栏
     */
    if (indexPath.section==0) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"JDThirdLostCell" owner:nil options:nil][1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //创建物品类型按钮视图
        JDFourLostAndRoadView *fourView = [[JDFourLostAndRoadView alloc] initWithFrame:CGRectMake(0, 0, JDScreenSize.width, LostAndRoadBtnViewH)];
        fourView.delegate = self;
        _fourView = fourView;
//        [fourView setNameArr:self.nameArr];
        [fourView setImageHighlightArr:self.imageHighlightArr];
        [fourView setImageNameArr:self.imageNameArr];
        
        [cell.contentView addSubview:fourView];
        
    }else if (indexPath.section==1){ //第二栏
        
        cell = [[NSBundle mainBundle]loadNibNamed:@"JDThirdLostCell" owner:nil options:nil][1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 物品审核状态栏
        JDAuditStatusView *statusView = [[JDAuditStatusView alloc] initWithFrame:CGRectMake(0, 0, JDScreenSize.width, STATUSHEIGHT)];
        statusView.delegate = self;
        _statusView = statusView;
        statusView.currentIndex = _currentIndex;
        statusView.statusBtnArr = self.statusBtnArr;
        [cell.contentView addSubview:statusView];
        
    }else if(indexPath.section>=2){
        
        cell = [[NSBundle mainBundle]loadNibNamed:@"JDThirdLostCell" owner:nil options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (self.lostDataArr.count) {
            JDLostData *lostData = self.lostDataArr[ROW];
           
            //设置左边的图片
            [cell.imageV sd_setImageWithURL:lostData.lostImage placeholderImage:[UIImage imageNamed:@"站位图92"]];
            [cell.imageV showBiggerPhotoInview:self.view];
            
            //设置物品类型
            cell.goodsType.text = [NSString stringWithFormat:@"物品类型: %@",lostData.lostType];
            
            //设置拾取时间
            cell.relTime.text = [JDLostData setUpTimeWithTime:lostData.lostTime];
            
            //设置物品详情
            if ([lostData.describe length]) {
                cell.detailInfo.text = [NSString stringWithFormat:@"物品详情: %@",lostData.describe];
                //设置补充详情按钮
                [cell.addDetail setTitle:@"修改详情" forState:UIControlStateNormal];
            }
            
            [cell.addDetail addTarget:self action:@selector(clickAddDetail:) forControlEvents:UIControlEventTouchUpInside];
            cell.addDetail.tag = ROW;
            
            
            /**
             *  如果是已被领取的，则隐藏点补充详情按钮
             */
            if (lostData.lostStatus==3) {
    
                cell.addDetail.hidden = YES;
                cell.addImage.hidden = YES;
                cell.boLinebo.hidden = YES;
                
            }

        }else{ //如果没有数据
            
            for (int i = 0; i < cell.contentView.subviews.count; i ++) {
                
                //移除所有子控件
                [cell.contentView.subviews[i] removeFromSuperview];
                
            }
            
            [cell.addDetail removeFromSuperview];
            [cell.addImage removeFromSuperview];
            [cell.boLine removeFromSuperview];
            
            // 没有消息的界面
            CGFloat height = CellHeaderHeight,y = 50;
            if (JDScreenSize.width==320&&JDScreenSize.height==480) {
                height = 150;
                y = 10;
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
        
        NSString *str = @"请选择物品类型";
        //顶部空白label
        UILabel *full = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, JDScreenSize.width-20, CellHeaderHeight)];
        full.textColor = [UIColor whiteColor];
        full.textAlignment = NSTextAlignmentCenter;
        full.font = TopTextFont;
        full.text = str;
        
        return full;
    }
    return nil;
    
}


#pragma mark - 补充详情按钮
-(void)clickAddDetail:(UIButton *)btn
{
    
    JDLostData *lostData = self.lostDataArr[btn.tag];
    
    JDDetailLostController *lostVC = [[JDDetailLostController alloc] init];
    
    lostVC.returnID = [lostData.lostId intValue];
    
    lostVC.dataDict = lostData;
    
    lostVC.delegate = self;
    
    [self.navigationController pushViewController:lostVC animated:YES];
    
    
}

@end
