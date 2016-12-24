//
//  BookScannerViewController.m
//  StudyPrivateCollection
//
//  Created by 车车 on 16/12/16.
//  Copyright © 2016年 pengyiwei. All rights reserved.
//

#import "BookScannerViewController.h"
#import "BookEntity.h"
#import "BookDetailViewController.h"

@interface BookScannerViewController ()

@property (nonatomic, strong) BookScannerView *scanView;

@property (nonatomic, strong) AVCaptureSession *captureSession;

@end

@implementation BookScannerViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initNavigation];
    [self initSubviews];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.captureSession stopRunning];
    [self.scanView stopAnimation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (AVCaptureSession *)captureSession {
    if (!_captureSession) {
        _captureSession = [[AVCaptureSession alloc] init];
    }
    return _captureSession;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (void)initNavigation {
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back-button"] forState:UIControlStateNormal];
    [backBtn sizeToFit];
    
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    UIButton *flashBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [flashBtn setImage:[UIImage imageNamed:@"light-off"] forState:UIControlStateNormal];
    [flashBtn setImage:[UIImage imageNamed:@"light-on"] forState:UIControlStateSelected];
    [flashBtn sizeToFit];
    
    [flashBtn addTarget:self action:@selector(clickFlash:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:flashBtn];
    
}

- (BOOL)shouldShadowImage {
    return NO;
}

- (UIImage *)navigationBarBackgroundImage {
    return [UIImage new];
}

- (void)clickBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickFlash:(UIButton *)button {
    button.selected = !button.selected;
    //开启和关闭手电筒
    
}

#pragma mark - initSubViews

- (void)initSubviews {
    
    [self initCamear];
    [self initScannerView];
    [self initTip];
    
}

- (void)initCamear {
    
    [self.captureSession beginConfiguration];
    
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 输入
    NSError *error = nil;
    AVCaptureDeviceInput *captureInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!error) {
        if ([self.captureSession canAddInput:captureInput]) {
            [self.captureSession addInput:captureInput];
        }
    }else {
        NSLog(@"Input Error : %@", error);
    }
    
    // 输出
    AVCaptureMetadataOutput *caputeOutput = [[AVCaptureMetadataOutput alloc] init];
    [caputeOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    if ([self.captureSession canAddOutput:caputeOutput]) {
        [self.captureSession addOutput:caputeOutput];
        caputeOutput.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code];
    }
    
    // 添加预览画面
    CALayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    layer.frame = self.view.layer.frame;
    [self.view.layer addSublayer:layer];
    
    [self.captureSession commitConfiguration];

    [self.captureSession startRunning];
    
}

- (void)initScannerView {
    
    self.scanView = [[BookScannerView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) rectSize:CGSizeMake(230.0, 230.0) offsetY:-43.0];
    self.scanView.backgroundColor = [UIColor clearColor];
    self.scanView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.scanView];
    
    [self.scanView startAnimation];
    
}

- (void)initTip {
    
}

#pragma mark -- ISBN 识别

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    NSString *ISBN = nil;
    
    for (AVMetadataObject *metadata in metadataObjects) {
        ISBN = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
        break;
    }
    
    if (ISBN != nil) {
        NSLog(@"ISBN : %@", ISBN);
        [self.captureSession stopRunning];
        [self.scanView stopAnimation];
        [self fetchBookWithISBN:ISBN];
    }
    
}

- (void)checkAVAuthorizationStatus {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    NSString *tips = NSLocalizedString(@"AVAuthorization", @"你没有权限访问相机");
    if (status == AVAuthorizationStatusAuthorized) {
        [self initCamear];
    }else {
        NSLog(@"%@", tips);
    }
}

- (void)fetchBookWithISBN:(NSString *)ISBN {
    
//    https://api.douban.com/v2/book/search
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.douban.com/v2/book/isbn/%@", ISBN]]];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error != nil) {
            NSLog(@"error : %@", error);
        }else {
            NSLog(@"response : %@, responseObject : %@", response, responseObject);
            
            NSString *title = [responseObject objectForKey:@"title"];
            NSString *author = [[responseObject objectForKey:@"author"] firstObject];
            
            UIAlertController *alerController = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"%@\n%@\n%@", title, ISBN, author] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *detailAction = [UIAlertAction actionWithTitle:@"查看详情" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                BookEntity *bookEntity = [[BookEntity alloc] initWithDictionary:responseObject];
                
                BookDetailViewController *bookDetail = [BookDetailViewController new];
                [bookDetail setBookEntity:bookEntity];
                [self.navigationController pushViewController:bookDetail animated:YES];
                
            }];
            
            UIAlertAction *nextAction = [UIAlertAction actionWithTitle:@"收藏并继续扫描" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.captureSession startRunning];
                [self.scanView startAnimation];
            }];
            
            [alerController addAction:detailAction];
            [alerController addAction:nextAction];
            
            [self presentViewController:alerController animated:YES completion:nil];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
    [dataTask resume];
    
}

- (void)dealloc {
    [self.captureSession stopRunning];
    [self.scanView stopAnimation];
}
















@end
