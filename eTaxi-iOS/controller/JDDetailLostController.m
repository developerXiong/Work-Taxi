//
//  JDDetailLostController.m
//  eTaxi-iOS
//
//  Created by jeader on 16/2/27.
//  Copyright © 2016年 jeader. All rights reserved.
//

#import "JDDetailLostController.h"
#import "HeadFile.pch"
#import "GetData.h"
#import "NSString+StringForUrl.h"
#import "UIImageView+WebCache.h"
#import "JDLostData.h"

#import "JDLostNetTool.h"


@interface JDDetailLostController ()<UITextViewDelegate>

@end

@implementation JDDetailLostController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    /**
     *  让textView成为第一响应者
     */
    [self.textView becomeFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (JDScreenSize.width==320&&JDScreenSize.height==480) {
        self.viewH.constant -= 55;
        self.textViewH.constant -= 55;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addNavigationBar:@"补充详情"];
    self.view.backgroundColor = ViewBackgroundColor;
    
    [self setUpChildViews];
    
    [self setUpPlaceHolder];
}

-(void)setUpChildViews
{
    [self.imageV sd_setImageWithURL:_dataDict.lostImage];
    [self.imageV showBiggerPhotoInview:self.view];
    self.goodsType.text = [NSString stringWithFormat:@"物品详情: %@",_dataDict.lostType];;
    
    /**
     *  失物招领时间
     */
    self.relTime.text = [JDLostData setUpTimeWithTime:_dataDict.lostTime];
    
    if ([_dataDict.describe length]) {
        self.textView.text = _dataDict.describe;
    }
}

/**
 *  textView编辑结束的时候调用
 */
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([self.textView.text isEqualToString:@""]) {
        
        self.addDetail.hidden = NO;
        
    }else{
        
        self.addDetail.hidden = YES;
        
    }
}
//开始编辑的时候
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.strLength.text = [NSString stringWithFormat:@"%lu",(unsigned long)[textView.text length]];
    
    [self setUpPlaceHolder];
}

-(void)setUpPlaceHolder
{
    if ([self.textView.text isEqualToString:@""]) {
        
        self.addDetail.hidden = NO;
        
    }else{
        
        self.addDetail.hidden = YES;
        
    }
}

-(void)textViewDidChange:(UITextView *)textView
{
    self.addDetail.hidden = YES;
    
    self.strLength.text = [NSString stringWithFormat:@"%lu",(unsigned long)[textView.text length]];
    self.addDetail.hidden = YES;
    if ([[textView text] length]>69) {
        self.strLength.text = @"70";
        textView.text = [textView.text substringToIndex:70];
    }else if([[textView text] length] == 0){
        
        self.addDetail.hidden = NO;
        
    }
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{

    /**
     *  点击return的时候隐藏键盘
     */
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
    }
    
    if ([text length]) {
        self.addDetail.hidden = YES;
    }
    
    //如果超过70字，就会禁止输入
    NSInteger loc =  range.location;
    
    if (loc>69) {
        return NO;
    }else{
        return YES;
    }
    
    return YES;
}



/**
 *  点击确认按钮调用
 */
- (IBAction)clickSure:(id)sender {
    
    
    /**
     *  详情textView有内容并且returnID有值
     */
    if ([_dataDict.lostId intValue]) {
        
        [self getdata];
        
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}

-(void)getdata
{
    
    [JDLostNetTool sendLostDataInVC:self Describe:self.textView.text returnID:_dataDict.lostId Success:^{
        
        [self.navigationController popViewControllerAnimated:YES];
        if ([_delegate respondsToSelector:@selector(getGoodsDecribe:)]) {
            
            [_delegate getGoodsDecribe:self.textView.text];
            
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
