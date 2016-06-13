//
//  ChangePersonInfoVC.m
//  eTaxi-iOS
//
//  Created by jeader on 16/1/6.
//  Copyright © 2016年 jeader. All rights reserved.
// 个人中心

#import "ChangePersonInfoVC.h"
#import "MyCell.h"
#import "OrderCell.h"
#import "UIImageView+AFNetworking.h"
#import "MyData.h"
#import "Serialize.h"
#import "HeadFile.pch"
#import "MyData.h"
#import "ZipArchive.h"
#import "MyTool.h"
#import "MBProgressHUD.h"
#import "PersonalVC.h"
#import "GetData.h"

#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)

@interface ChangePersonInfoVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{
    NSMutableArray * array;
    
}
@property (strong, nonatomic) MBProgressHUD * hud;

@property (nonatomic, strong) UIImage *image1;

@property (nonatomic, strong) UIImage *image2;

@property (nonatomic, strong) UIImage *image3;

@end

@implementation ChangePersonInfoVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"上传个人信息";
    [self setUpFooterView];
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [self.view addGestureRecognizer:tap];
    self.hud=[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hud];
}
- (void)setUpFooterView
{
    UIView * vi =[[UIView alloc] init];
    vi.userInteractionEnabled=YES;
    vi.frame=CGRectMake(0, 0, JDScreenSize.width, 100);
    vi.backgroundColor=[UIColor clearColor];
    UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake((JDScreenSize.width-303)/2, 10, 303, 51);
    [btn setBackgroundImage:[UIImage imageNamed:@"长按钮正常"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"长按钮高亮"] forState:UIControlStateSelected];
    [btn setTitle:@"确认上传" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont boldSystemFontOfSize:20];
    btn.tag=666;
    [btn addTarget:self action:@selector(commitBtn) forControlEvents:UIControlEventTouchUpInside];
    [vi addSubview:btn];
    self.editTable.tableFooterView=vi;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    UITextField * confirmTF =(UITextField *)[self.editTable viewWithTag:10086];
    if (textField==confirmTF)
    {
        NSInteger loc =range.location;
        if (loc < 18)
        {
            return YES;
        }
        else
        {
            return NO;
        }      
    }
    return YES;
}
#pragma mark- UITabel View DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 1;
    }
    else
    {
        return 2;
    }
}
- (UITableViewCell *)
tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID =@"cell2";
    OrderCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (indexPath.section==0)
    {
        if (!cell)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"OrderCell" owner:nil options:nil]objectAtIndex:1];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
        }
        cell.nameLab.text=@"身份证";
        cell.phoneBtn.tag=111;
        [cell.phoneBtn addTarget:self action:@selector(changeImage:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        if (!cell)
        {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"OrderCell" owner:nil options:nil]objectAtIndex:1];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
        }
        if (indexPath.row==0)
        {
            cell.nameLab.text=@"行车证";
            cell.lineLab.hidden=YES;
            cell.IDtf.hidden=YES;
            cell.IDtf.tag=10086;
            cell.phoneBtn.tag=222;
            [cell.phoneBtn addTarget:self action:@selector(changeImage:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            cell.nameLab.text=@"营运证";
            cell.lineLab.hidden=YES;
            cell.IDtf.hidden=YES;
            cell.phoneBtn.tag=333;
            [cell.phoneBtn addTarget:self action:@selector(changeImage:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    
    return cell;
}
#pragma mark- UITable View Delegate

//设置每个区头的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0) return @"请填写您的身份证号或上照片";
    else  return @"请上传您的驾驶证与营运证";
}
// 设置每一个单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
//按钮的点击事件
- (void)changeImage:(UIButton *)btn
{
    //把所点击的button的tag 传过去来区别是哪个button 被点击了
    self.tagStr =[NSString stringWithFormat:@"%ld",(long)btn.tag];
    if (IOS8)
    {
        UIAlertController * alertController =[UIAlertController alertControllerWithTitle:@"获取图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        //判断是否支持相机. 注:模拟器没有相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIAlertAction * defaultAction =[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //相机
                UIImagePickerController * imagePickerController =[[UIImagePickerController alloc]init];
                imagePickerController.delegate=self;
                imagePickerController.allowsEditing=YES;
                imagePickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:imagePickerController animated:YES completion:nil];
            }];
            [alertController addAction:defaultAction];
        }
        UIAlertAction * defaultAction1 =[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //相册
            UIImagePickerController * imagePickerController =[[UIImagePickerController alloc] init];
            imagePickerController.delegate=self;
            imagePickerController.allowsEditing=YES;
            imagePickerController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }];
        
        UIAlertAction * cancelAction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:defaultAction1];
        
        //弹出视图使用UIViewController的方法
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        UIActionSheet * sheet;
        //判断是否支持相机. 注:模拟器没有相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            sheet=[[UIActionSheet alloc] initWithTitle:@"获取图片" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册获取", nil];
        }
        else
        {
            sheet =[[UIActionSheet alloc] initWithTitle:@"获取图片" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册获取", nil];
        }
        [sheet showInView:self.view];
    }
}
#pragma mark - 调用UIActionSheet IOS7 调用
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSUInteger sourceType = 0;
    //判断是否支持相机 注:模拟器没有相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        switch (buttonIndex)
        {
            case 1: // 相机
                sourceType=UIImagePickerControllerSourceTypeCamera;
                break;
            case 2: // 相册
                sourceType=UIImagePickerControllerSourceTypePhotoLibrary;;
                break;
            default:
                break;
        }
    }
    else
    {
        if (buttonIndex== 1)
        {
            sourceType =UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
    }
    //跳转到相机或者相册界面
    UIImagePickerController * imagePickerController =[[UIImagePickerController alloc] init];
    imagePickerController.delegate=self;
    imagePickerController.allowsEditing=YES;
    imagePickerController.sourceType=sourceType;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark - 保存图片至沙盒
- (void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData * imageData =UIImagePNGRepresentation(currentImage);
    //获取沙盒目录
    NSString * fullPath =[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:imageName];
    //将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}

- (UIImage*)OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    CGSize newSize;
    if (image.size.height / image.size.width > 1)
    {
        newSize.height = size.height;
        newSize.width = size.height / image.size.height * image.size.width;
    }
    else if(image.size.height / image.size.width < 1)
    {
        newSize.height = size.width / image.size.width * image.size.height;
        newSize.width = size.width;
    }
    else
    {
        newSize = size;
    }
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context  568x375
    UIGraphicsBeginImageContextWithOptions(newSize, YES, 0);
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}
//图片选择的代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //设置image的尺寸
    CGSize imageSize =image.size;
    imageSize.height=160;
    imageSize.width=240;
    //对图片大小进行压缩
    image=[self OriginImage:image scaleToSize:imageSize];

    //设置图片显示
    UIButton * btn1 =(UIButton *)[self.editTable viewWithTag:111];
    UIButton * btn2 =(UIButton *)[self.editTable viewWithTag:222];
    UIButton * btn3 =(UIButton *)[self.editTable viewWithTag:333];
    switch ([self.tagStr integerValue]) {
        case 111:
        {
            [btn1 setImage:image forState:UIControlStateNormal];
            self.image1 = image;
            // 保存图片值本地 上传图片到服务器需要使用
            [self saveImage:image withName:@"identity.png"];
        }
            break;
        case 222:
        {
            [btn2 setImage:image forState:UIControlStateNormal];
            self.image2 = image;
            // 保存图片值本地 上传图片到服务器需要使用
            [self saveImage:image withName:@"drive.png"];
        }
            break;
        case 333:
        {
            [btn3 setImage:image forState:UIControlStateNormal];
            self.image3 = image;
            // 保存图片值本地 上传图片到服务器需要使用
            [self saveImage:image withName:@"running.png"];
        }
            break;
            
        default:
            break;
    }
}
//点击取消 然后让图片选择下降
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//导航右键完成按钮
- (void)commitBtn
{
//    NSString * fullPath1 =[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"identity.png"];
//    NSString * fullPath2 =[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"drive.png"];
//    NSString * fullPath3 =[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"running.png"];
//    UIImage * getImage1 =[[UIImage alloc] initWithContentsOfFile:fullPath1];
//    UIImage * getImage2 =[[UIImage alloc] initWithContentsOfFile:fullPath2];
//    UIImage * getImage3 =[[UIImage alloc] initWithContentsOfFile:fullPath3];
    if (self.image1==nil||self.image2==nil||self.image3==nil)
    {
        MyTool * tool =[[MyTool alloc]init];
        [self presentViewController:[tool showAlertControllerWithTitle:@"请上传照片" WithMessages:@"" WithCancelTitle:@"确定"] animated:YES completion:nil];
    }
    else
    {
        NSString * imagePath1 =[NSHomeDirectory()stringByAppendingPathComponent:@"Documents/identity.png"];
        NSString * imagePath2 =[NSHomeDirectory()stringByAppendingPathComponent:@"Documents/drive.png"];
        NSString * imagePath3 =[NSHomeDirectory()stringByAppendingPathComponent:@"Documents/running.png"];
        NSArray *inputPaths = [NSArray arrayWithObjects:
                               imagePath1,
                               imagePath2,imagePath3, nil];
        NSString * zipPath=[NSHomeDirectory()stringByAppendingPathComponent:@"Documents/pic.zip"];
        [SSZipArchive createZipFileAtPath:zipPath withFilesAtPaths:inputPaths];
        if ([[NSFileManager defaultManager]fileExistsAtPath:[NSHomeDirectory()stringByAppendingPathComponent:@"Documents/pic.zip"]])
        {
            [GetData addMBProgressWithView:self.view style:0];
            [GetData showMBWithTitle:@"正在上传中..."];
            [GetData hiddenMB];
            MyData * data =[MyData new];
            [data getEditPersonInfoWithCompletion:^(NSString *str, NSString *msg) {
                if ([str integerValue]==0)
                {
                    [GetData addMBProgressWithView:self.view style:1];
                    [GetData showMBWithTitle:@"上传成功"];
                    [GetData hiddenMB];
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else if ([str intValue]==1)
                {
                    [GetData addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                        
                    }];
                    [GetData hiddenMB];
                }
                else if ([str intValue]==2)
                {
                    [GetData addAlertViewInView:self title:@"温馨提示" message:msg count:0 doWhat:^{
                        PersonalVC * vc =[[PersonalVC alloc] init];
                        [vc removeFileAndInfo];
                    }];
                }
                else
                {
                    [GetData addMBProgressWithView:self.view style:1];
                    [GetData showMBWithTitle:@"上传失败,请在网络环境良好的情况下重试"];
                    [GetData hiddenMB];
                }
            }];
        }
    }
    
    
}
- (void)tapClick:(UITapGestureRecognizer *)recognizer
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
