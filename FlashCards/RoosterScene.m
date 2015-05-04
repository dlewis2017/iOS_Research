//
//  RosterScene.m
//  FlashCards
//
//  Created by C Poellabauer on 4/19/15.
//  Copyright (c) 2015 C Poellabauer. All rights reserved.
//

#import "RosterScene.h"
#import "HappyScene1.h"
#import "SadScene2.h"
#import "AngryScene3.h"
#import "SadScene4.h"
#import "AngryScene5.h"
#import "HappyScene6.h"
#import "PigScene.h"
#import "CowScene.h"
#import "CookieScene.h"
#import "PizzaScene.h"
#import "PillowScene.h"
#include <stdlib.h>
#include <stdio.h>

@interface RosterScene ()
@property BOOL contentCreated;

@end

@implementation RosterScene

-(void) createSceneContent{
    self.backgroundColor = [SKColor redColor];
    self.scaleMode = SKSceneScaleModeAspectFill;
    
}

-(void) didMoveToView:(SKView *)view{
    if(!self.contentCreated){
        [self createSceneContent];
        self.contentCreated = YES;
    }
    //display image
    UIImageView *img;
    img = [[UIImageView alloc] initWithFrame:CGRectMake(150,450, 400, 400)];
    img.image = [UIImage imageNamed:@"roster.png"];
    //img.contentMode = UIViewContentModeCenter;
    img.hidden = NO;
    [self.view addSubview:img];
    
    /*
     AVCaptureSession *captureSession = [[AVCaptureSession alloc] init];
     AVCaptureDevice *videoCaptureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
     NSError *error = nil;
     AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoCaptureDevice error:&error];
     if (videoInput) {
     [captureSession addInput:videoInput];
     }
     else {
     // Handle the failure.
     }
     
     CALayer *viewLayer = videoCaptureDevice;
     
     AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:captureSession];
     [viewLayer addSublayer:captureVideoPreviewLayer];
     
     [captureSession startRunning];
     */
    
    //Camera View
    /*UIImageView *camImg;
     camImg = [[UIImageView alloc] initWithFrame:CGRectMake(500, 450, 200, 200)];
     camImg.image = [UIImage viewLayer];
     camImg.hidden = NO;
     [self.view addSubview:camImg];
     */
    
    //Create title
    SKLabelNode *question = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    question.text = @"What farm animal is this?";
    question.name = @"questionNode";
    question.fontSize = 30;
    question.position = CGPointMake(CGRectGetMidX(self.frame),600);
    //Create happy, sad, and angry Nodes
    SKLabelNode *cowNode = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    cowNode.text = @"Cow";
    cowNode.name = @"cowNode";
    cowNode.fontSize = 18;
    cowNode.position = CGPointMake(300, 50);
    SKLabelNode *pigNode = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    pigNode.text = @"Pig";
    pigNode.name = @"pigNode";
    pigNode.fontSize = 18;
    pigNode.position = CGPointMake(CGRectGetMidX(self.frame), 50);
    SKLabelNode *rosterNode = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    rosterNode.text = @"Roster";
    rosterNode.name = @"rosterNode";
    rosterNode.fontSize = 18;
    rosterNode.position = CGPointMake(700, 50);
    
    
    [self addChild:question];
    [self addChild:cowNode];
    [self addChild:pigNode];
    [self addChild:rosterNode];
}
/*buttons to show/add image-(IBAction)show{
 img.hidden = NO;
 [self.view bringSubviewToFront:img];
 }
 -(IBAction)add{
 img.hidden = YES;
 }*/


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event { //if happy Node pressed (matches scene, move onto next scene
    //Nodes
    SKNode *cowNode = [self childNodeWithName:@"cowNode"];
    SKNode *pigNode = [self childNodeWithName:@"pigNode"];
    SKNode *rosterNode = [self childNodeWithName:@"rosterNode"];
    
    //random number generator for presenting different scenes
    int randNum = arc4random_uniform(10)+1; //1-11
    
    //create flip transition and scene allocations
    SKTransition *flip = [SKTransition flipVerticalWithDuration:0.5];
    
    SKScene *happyScene1 = [[HappyScene1 alloc] initWithSize:self.size];
    SKScene *sadScene2= [[SadScene2 alloc] initWithSize:self.size];
    SKScene *angryScene3= [[AngryScene3 alloc] initWithSize:self.size];
    SKScene *sadScene4= [[SadScene4 alloc] initWithSize:self.size];
    SKScene *angryScene5= [[AngryScene5 alloc] initWithSize:self.size];
    SKScene *happyScene6= [[HappyScene6 alloc] initWithSize:self.size];
    SKScene *cowScene= [[CowScene alloc] initWithSize:self.size];
    SKScene *pigScene = [[PigScene alloc] initWithSize:self.size];
    SKScene *pillowScene = [[PillowScene alloc] initWithSize:self.size];
    SKScene *cookieScene = [[CookieScene alloc] initWithSize:self.size];
    SKScene *pizzaScene = [[PizzaScene alloc] initWithSize:self.size];
    
    
    for(UITouch *touch in touches){
        CGPoint cowLocation = [touch locationInNode:self];
        CGPoint pigLocation = [touch locationInNode:self];
        CGPoint rosterLocation = [touch locationInNode:self];
        
        if([rosterNode containsPoint:rosterLocation]){
            //create actions
            SKAction *zoom = [SKAction scaleTo:2.0 duration:0.05];
            SKAction *pause = [SKAction waitForDuration:0.25];
            SKAction *fadeAway = [SKAction fadeOutWithDuration:0.10];
            SKAction *remove = [SKAction removeFromParent];
            
            //put in order
            SKAction *moveSequence = [SKAction sequence:@[zoom,pause,fadeAway,remove]];
            
            //after completion of actions, move to next scene
            [rosterNode runAction:moveSequence completion:^{
                switch (randNum) {
                    case 1:
                        [self.view presentScene:sadScene2 transition:flip];
                        break;
                    case 2:
                        [self.view presentScene:angryScene3 transition:flip];
                        break;
                    case 3:
                        [self.view presentScene:sadScene4 transition:flip];
                        break;
                    case 4:
                        [self.view presentScene:angryScene5 transition:flip];
                        break;
                    case 5:
                        [self.view presentScene:happyScene6 transition:flip];
                        break;
                    case 6:
                        [self.view presentScene:cowScene transition:flip];
                        break;
                    case 7:
                        [self.view presentScene:happyScene1 transition:flip];
                        break;
                    case 8:
                        [self.view presentScene:pigScene transition:flip];
                        break;
                    case 9:
                        [self.view presentScene:pillowScene transition:flip];
                        break;
                    case 10:
                        [self.view presentScene:cookieScene transition:flip];
                        break;
                    case 11:
                        [self.view presentScene:pizzaScene transition:flip];
                        break;
                    default:
                        break;
                }
                
                
            }];
        }
        if ([pigNode containsPoint:pigLocation]){
            //create actions
            //SKAction *red = [SKAction colorizeWithColor:[SKColor redColor] colorBlendFactor:1.0 duration:.5];
            SKAction *shrink = [SKAction scaleTo:0.5 duration:0.05];
            //run sequence
            //SKAction *moveSequence2 = [SKAction sequence:@[red,shrink]];
            [pigNode runAction:shrink];
        }
        if ([cowNode containsPoint:cowLocation]){
            SKAction *shrink = [SKAction scaleTo:0.5 duration:0.05];
            //run action
            [cowNode runAction:shrink];
        }
    }
}




@end
