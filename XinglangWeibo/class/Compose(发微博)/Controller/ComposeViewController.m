//
//  ComposeViewController.m
//  XinglangWeibo
//
//  Created by admin on 14-11-6.
//  Copyright (c) 2014年 xl. All rights reserved.
//

#import "ComposeViewController.h"
#import "TextView.h"
#import "Account.h"
#import "IWAccountTool.h"
#import "AFNetworking.h"
#import "TextToolView.h"
@interface ComposeViewController () <UITextViewDelegate ,TextToolViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) TextView *textView;
@property (nonatomic, strong) TextToolView *toolbar;


@end

@implementation ComposeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置导航栏属性
    [self setupNavBar];
    
    // 添加textView
    [self setupTextView];
    
    // 添加textToolView
    [self setupTextToolView];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.textView becomeFirstResponder];
}

- (void)setupNavBar
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleBordered target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;

}
- (void)setupTextView
{
    TextView *textView = [[TextView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:textView];
    textView.font = [UIFont systemFontOfSize:16];
    // 获取滚动视图代理
    textView.delegate = self;
    // 垂直方向永远可以拖拽
    textView.alwaysBounceVertical = YES;

    [self.view addSubview:textView];
    self.textView = textView;
    textView.labelString = @"哈哈哈";
    textView.color = [UIColor grayColor];

    // 监听textView文字改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    // 监听键盘的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)setupTextToolView
{
    TextToolView *toolbar = [[TextToolView alloc] init];
    toolbar.textToolViewDelegate = self;
    CGFloat toolbarH = 44;
    CGFloat toolbarW = self.view.frame.size.width;
    CGFloat toolbarX = 0;
    CGFloat toolbarY = self.view.frame.size.height - toolbarH;
    toolbar.frame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
}

// 监听文字改变
- (void)textDidChange
{
    if (self.textView.text) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}

// 监听键盘的通知
- (void)keyboardChange:(NSNotification *)info
{
//    Log(@"info==%@",info);
    // 获取frame
    CGRect keyboardF = [info.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 获取动画时间
    CGFloat duration = [info.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if (keyboardF.origin.y < self.view.frame.size.height) {
        [UIView animateWithDuration:duration animations:^{
            self.toolbar.transform = CGAffineTransformMakeTranslation(0, -keyboardF.size.height);
        }];
    }else{
        [UIView animateWithDuration:duration animations:^{
            self.toolbar.transform = CGAffineTransformIdentity;
        }];
    }

    
}

// 移除通知 
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)send
{
    if (self.textView.image) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        // 数据封装请求
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        Account *account = [IWAccountTool account];
        dict[@"access_token"] = account.access_token;
        dict[@"status"] = self.textView.text;
        NSData *data  = UIImageJPEGRepresentation(self.textView.image, 0.3);
        [manager POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileData:data name:@"pic" fileName:@"随便" mimeType:@"image/jpeg"];
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            Log(@"error");
        }];
    }else{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        // 数据封装请求
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        Account *account = [IWAccountTool account];
        dict[@"access_token"] = account.access_token;
        dict[@"status"] = self.textView.text;
        [manager POST:@"https://api.weibo.com/2/statuses/update.json" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            Log(@"error");
        }];
    }

    // 关闭控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.textView endEditing:YES];
}

// textToolView 的代理方法
- (void)textToolView:(TextToolView *)toolView didClickButtonTag:(IWComposeToolbarButtonType)tag
{
    switch (tag) {
        case IWComposeToolbarButtonTypeCamera:
            [self openCamera];
            break;
        case IWComposeToolbarButtonTypeEmotion:
  
            break;
        case IWComposeToolbarButtonTypeMention:
            
            break;
        case IWComposeToolbarButtonTypePicture:
            [self openPicture];
            break;
        case IWComposeToolbarButtonTypeTrend:
            
            break;
        default:
            break;
    }
}
- (void)openCamera
{

}
- (void)openPicture
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 2.去的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.textView.image = image;

    [picker dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
