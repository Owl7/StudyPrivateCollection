//
//  BookScannerViewController.m
//  StudyPrivateCollection
//
//  Created by 车车 on 16/12/16.
//  Copyright © 2016年 pengyiwei. All rights reserved.
//

#import "BookScannerViewController.h"
#import "BookScannerView.h"

#import <AVFoundation/AVCaptureSession.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AVFoundation/AVCaptureInput.h>
#import <AVFoundation/AVCaptureOutput.h>
#import <AVFoundation/AVCaptureVideoPreviewLayer.h>
#import <AVFoundation/AVMetaDataObject.h>

@interface BookScannerViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) BookScannerView *scanView;

@property (nonatomic, strong) AVCaptureSession *captureSession;

@end

@implementation BookScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavigation];
    [self initSubviews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (void)initNavigation {
    
    //生成透明导航栏
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
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
    
    self.captureSession = [[AVCaptureSession alloc] init];
    
    [self.captureSession beginConfiguration];
    
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    
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
    
    if (!ISBN) {
        NSLog(@"ISBN : %@", ISBN);
        [self.captureSession stopRunning];
        [self.scanView stopAnimation];
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

@end
