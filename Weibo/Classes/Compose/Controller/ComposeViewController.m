//
//  ComposeViewController.m
//  Weibo
//
//  Created by 宿莽 on 16/2/27.
//  Copyright © 2016年 宿莽. All rights reserved.
//

#import "ComposeViewController.h"
#import "ComposeTV.h"
#import "AFNetworking.h"
#import "Account.h"
#import "AccountTool.h"
#import "MBProgressHUD+MJ.h"
#import "ComposeToolBar.h"
#import "ComposeMuImages.h"
@interface ComposeViewController ()<UITextViewDelegate,ComposeToolBarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic, weak)ComposeTV *composeView;
@property(nonatomic, weak)ComposeToolBar *toolbar;
@property(nonatomic, weak)UIImageView *imageview;
@property(nonatomic, weak)ComposeMuImages *imagesView;
@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self setupNav];
    //设置textView
    [self setupTextView];
    //添加toolbar
    [self setupToolBar];
    //添加选图框
    [self setupImageView];
}

-(void)setupImageView{
    ComposeMuImages *imageView = [[ComposeMuImages alloc]init];
    CGFloat imagesW = self.composeView.frame.size.width;
    CGFloat imagesY = 80;
    CGFloat imagesH = self.composeView.frame.size.height;
    imageView.frame = CGRectMake(0, imagesY, imagesW, imagesH);
    [self.composeView addSubview:imageView];
//    imageView.backgroundColor = [UIColor redColor];
    self.imagesView = imageView;
}

-(void)setupToolBar{
    ComposeToolBar *toolbar = [[ComposeToolBar alloc]init];
    toolbar.delegate = self;
    CGFloat toolbarH = 44;
    CGFloat toolbarW = self.view.frame.size.width;
    CGFloat toolbarX = 0;
    CGFloat toolbarY = self.view.frame.size.height - toolbarH;
    toolbar.frame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
}

-(void)setupNav{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.title = @"发微博";
}
/**
 *  toolbar的代理方法
 *
 */
-(void)composeToolbar:(ComposeToolBar *)toolbar didClickButton:(ComposeToolBarButtonType)ComposeToolBarButtonType{
    switch (ComposeToolBarButtonType) {
        case ComposeToolBarButtonTypeCamera://相机
            NSLog(@"相机");
            [self openCamera];
            break;
        case ComposeToolBarButtonTypePicture://相册
            NSLog(@"相册");
            [self openPhoneLibrary];
            break;
        default:
            break;
    }
}

-(void)openCamera{
    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

-(void)openPhoneLibrary{
    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  图片选择控制器的代理方法
 */
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //NSLog(@"%@",info);
    //销毁picker控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    //取得图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.imageview.image = image;
    [self.imagesView addImage:image];
}

-(void)setupTextView{
    //添加textView
    ComposeTV *composeView = [[ComposeTV alloc]init];
    composeView.font = [UIFont systemFontOfSize:15];
    composeView.alwaysBounceVertical = YES;//垂直方向永远可以拖拽
    composeView.delegate = self;
    composeView.frame = self.view.bounds;//这样设置，输入光标应该在左上角，实则不是，why，textview继承自scrollview，contentInset有额外的长度为64的区域
    composeView.placeholder = @"分享新鲜事……";
    [self.view addSubview:composeView];
    
    self.composeView = composeView;
    //添加监听textview文字的改变
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:composeView];
    //监听键盘的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(KeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(KeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)KeyboardWillShow:(NSNotification *)note{
    //1.取出键盘的frame
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    //2/取出键盘弹出的动画时间长度
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    //3.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, -keyboardF.size.height);
    }];
}

-(void)KeyboardWillHide:(NSNotification *)note{
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;
    }];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.composeView becomeFirstResponder];
}

-(void)textDidChange{
//    self.navigationItem.rightBarButtonItem.enabled = YES;
    self.navigationItem.rightBarButtonItem.enabled = self.composeView.text.length;
}

-(void)cancel{
//    self.composeView.placeholder = @"欢迎再来";
//    self.composeView.placeholdercolor = [UIColor redColor];
//    self.composeView.font = [UIFont systemFontOfSize:30];
    [self.composeView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)send{
    if (self.imagesView.totalImages.count) {
        [self sendWithImage];
    }else{
        [self sendWithoutImage];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)sendWithImage{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = self.composeView.text;
    params[@"access_token"] = [AccountTool Account].access_token;
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        for (UIImage *image in self.imagesView.subviews) {
//            NSData *data = UIImageJPEGRepresentation(image, 0.5);
//            [formData appendPartWithFileData:data name:@"pic" fileName:@"" mimeType:@"image/png"];
//        }
        NSArray *images = [self.imagesView totalImages];
        for (UIImage *image in images) {
            NSData *data = UIImageJPEGRepresentation(image, 0.5);
            [formData appendPartWithFileData:data name:@"pic" fileName:@"" mimeType:@"image/jpeg"];
            NSLog(@"%@",image);
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showError:@"发送失败"];
        
    }];
//    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {//发送请求之前就会调用这个block
//        //说明这里要上传哪些文件
//        NSData *data = UIImageJPEGRepresentation(self.imageview.image, 1.0);
//        [formData appendPartWithFileData:data name:@"pic" fileName:@"" mimeType:@"image/png"];
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [MBProgressHUD showSuccess:@"发送成功"];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD showError:@"发送失败"];
//    }];
}

-(void)sendWithoutImage{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = self.composeView.text;
    params[@"access_token"] = [AccountTool Account].access_token;
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showError:@"发送失败"];

    }];
//    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [MBProgressHUD showSuccess:@"发送成功"];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [MBProgressHUD showError:@"发送失败"];
//    }];
    //关闭控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

@end
