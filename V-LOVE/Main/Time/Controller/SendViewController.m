//
//  SendViewController.m
//  V-LOVE
//
//  Created by mac on 15/10/23.
//  Copyright (c) 2015年 XXX. All rights reserved.
//

#define imageWidth KScreenWidth/4 - 12.5

#import "SendViewController.h"
#import "UIPlaceHolderTextView.h"
#import "PopView.h"

@interface SendViewController ()<UITextViewDelegate>
{
    
    IBOutlet UIPlaceHolderTextView *_textView;

    UIImageView *_imageView;
}
@end

@implementation SendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textView.placeholder = @"现在是什么心情？想记录些什么？";

    [self _createNavigationBar];
    
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:SAVEIMAGES];
    if (data != nil)
    {
        [self _createSubViews];
    }
   

}

- (void)reloadImageView
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:SAVEIMAGES];
    UIImage *image = [UIImage imageWithData:data];
    _sendImageView.image = image;
}
- (void)viewWillAppear:(BOOL)animated
{
    [self reloadImageView];
}


#pragma mark - 创建 子视图
- (void)_createSubViews
{
    _sendImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, _textView.bottom + 10, imageWidth, imageWidth)];
    _sendImageView.userInteractionEnabled = YES;
    _sendImageView.contentMode = UIViewContentModeScaleAspectFill;
    _sendImageView.clipsToBounds = YES;
    [self.view addSubview:_sendImageView];
    
//    _tipButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _tipButton.frame = CGRectMake(_sendImageView.right + 12.5, _sendImageView.top, imageWidth, imageWidth);
//    _tipButton.backgroundColor = [UIColor colorWithWhite:0.98 alpha:1];
//    [_tipButton setImage:[UIImage imageNamed:@"timeline_write_photo"] forState:UIControlStateNormal];
//    [self.view addSubview:_tipButton];
//    [_tipButton addTarget:self action:@selector(TipButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [_sendImageView addGestureRecognizer:tap];
}

#pragma mark - 点击图片动作
- (void)tapAction
{
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"发送照片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍摄照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self _openCamera];
//    }];
//    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self _selectPhoto];
//    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"清除图片" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {

        [[NSUserDefaults standardUserDefaults] removeObjectForKey:SAVEIMAGES];
        [self reloadImageView];
        
    }];
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    [alertCtrl addAction:action1];
//    [alertCtrl addAction:action2];
    [alertCtrl addAction:action3];
    [alertCtrl addAction:action4];
    
    
    [self presentViewController:alertCtrl animated:YES completion:nil];
}

/*
- (void)TipButtonAction:(UIButton *)sender {
    
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"发送照片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍摄照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self _openCamera];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self _selectPhoto];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertCtrl addAction:action1];
    [alertCtrl addAction:action2];
    [alertCtrl addAction:action3];


    [self presentViewController:alertCtrl animated:YES completion:nil];
    
}

#pragma mark - 打开相机
- (void)_openCamera
{
    //设置来源 为相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    if (!isCamera)
    {
        UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"提示" message:@"摄像头无法使用" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertCtrl addAction:action];

        [self presentViewController:alertCtrl animated:YES completion:nil];
        
        return;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = sourceType;
    picker.delegate = self;
    
    [self  presentViewController:picker animated:YES completion:nil];
}

#pragma mark - 选择照片
- (void)_selectPhoto
{
    //设置来源 为相册
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = sourceType;
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //弹出 相册
    [picker dismissViewControllerAnimated:NO completion:nil];
    
    //取照片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //如果 图片存在 则发送
    if (image != nil)
    {
        _imageView = [[UIImageView alloc] initWithFrame:_tipButton.frame];
        _imageView.image = image;
        [self.view addSubview:_imageView];
        
        //开启用户点击事件
        _imageView.userInteractionEnabled = YES;
        
        _tipButton.frame = CGRectMake(_imageView.right + 10, _imageView.top, imageWidth, imageWidth);
        
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction1)];

        [_imageView addGestureRecognizer:tap];
    }
}

- (void)tapAction1
{
    //创建 警示 控制器
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"发送照片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍摄照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self _openCamera];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self _selectPhoto];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"清除图片" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
      
        
    }];
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertCtrl addAction:action1];
    [alertCtrl addAction:action2];
    [alertCtrl addAction:action3];
    [alertCtrl addAction:action4];
    
    
    [self presentViewController:alertCtrl animated:YES completion:nil];
}
*/


#pragma mark - 导航栏
- (void)_createNavigationBar
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - 确定动作
- (void)buttonAction
{
    NSLog(@"%@",_sendImageView.image);

    
//    NSData *data = UIImageJPEGRepresentation([UIImage imageNamed:@"Life-scroll3.jpg"], 1);
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:SAVEIMAGES];
    _myblock(_textView.text,data);
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
