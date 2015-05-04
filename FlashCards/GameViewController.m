//
//  GameViewController.m
//  FlashCards
//
//  Created by C Poellabauer on 3/21/15.
//  Copyright (c) 2015 C Poellabauer. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

@implementation SKScene (Unarchive)

+ (instancetype)unarchiveFromFile:(NSString *)file {
    /* Retrieve scene file path from the application bundle */
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
    /* Unarchive the file to an SKScene object */
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:self forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];
    
    return scene;
}

@end

@interface GameViewController ()

@property (nonatomic, strong) AVCaptureSession* videoCaptureSession;
@property (nonatomic, strong) AVCaptureDevice *videoCaptureDevice;
@property (strong, nonatomic) UIView *videoPreviewView;
@property (weak, nonatomic) IBOutlet UIImageView *testImageView;
@end

@implementation GameViewController

- (void) setupVideoCamera
{
    self.videoCaptureSession = [[AVCaptureSession alloc] init];
    self.videoCaptureSession.sessionPreset = AVCaptureSessionPresetHigh; //AVCaptureSessionPreset352x288;
    //instantiate the capture session
    
    _videoCaptureDevice = [self frontCamera];
    //instantiate the capture device

    NSError *error = nil;
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:self.videoCaptureDevice
                                                                        error:&error];
    if (!input) {
        NSLog(@"Error with camera: %@", error);
        return;
    }
    
    [self.videoCaptureSession addInput:input];
    //hook up the session and input
    
    AVCaptureVideoDataOutput *outputRGB = [[AVCaptureVideoDataOutput alloc] init];
    outputRGB.videoSettings = [NSDictionary dictionaryWithObject: [NSNumber numberWithInt: kCVPixelFormatType_32BGRA]
                                                          forKey: (id)kCVPixelBufferPixelFormatTypeKey];
    [self.videoCaptureSession addOutput:outputRGB];

    AVCaptureConnection *videoConnection = [outputRGB connectionWithMediaType:AVMediaTypeVideo];
    if ([videoConnection isVideoOrientationSupported])
    {
        [videoConnection setVideoOrientation:AVCaptureVideoOrientationPortrait];
    }
    
    
    AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.videoCaptureSession];
    
    [captureVideoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [captureVideoPreviewLayer setFrame:self.videoPreviewView.bounds];
    
    CALayer *rootLayer = [self.videoPreviewView layer];
    [rootLayer setBackgroundColor:[[UIColor blackColor] CGColor]];
    [rootLayer addSublayer:captureVideoPreviewLayer];
    
    [self.videoCaptureSession setSessionPreset:AVCaptureSessionPresetHigh];
}
- (AVCaptureDevice *)frontCamera {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == AVCaptureDevicePositionFront) {
            return device;
        }
    }
    return nil;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.videoCaptureSession startRunning];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.videoCaptureSession stopRunning];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [super viewDidLayoutSubviews];
    _videoPreviewView = [[UIView alloc] initWithFrame:CGRectMake(225, 125, 300, 300)];
    _videoPreviewView.hidden = NO;
    viewWillAppear:(YES);
    [self setupVideoCamera];
    //[self.videoCaptureSession startRunning];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    
    // Create and configure the scene.
    GameScene *scene = [GameScene unarchiveFromFile:@"GameScene"];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene and camera
    [self.view addSubview:_videoPreviewView];
    [skView presentScene:scene];
    
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
