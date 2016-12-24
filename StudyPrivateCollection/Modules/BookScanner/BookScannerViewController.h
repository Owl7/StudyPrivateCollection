//
//  BookScannerViewController.h
//  StudyPrivateCollection
//
//  Created by 车车 on 16/12/16.
//  Copyright © 2016年 pengyiwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookScannerView.h"

#import <AVFoundation/AVCaptureSession.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AVFoundation/AVCaptureInput.h>
#import <AVFoundation/AVCaptureOutput.h>
#import <AVFoundation/AVCaptureVideoPreviewLayer.h>
#import <AVFoundation/AVMetadataObject.h>

@interface BookScannerViewController : BaseViewController<AVCaptureMetadataOutputObjectsDelegate>


@end
