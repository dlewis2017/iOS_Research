//
//  Exit.m
//  FlashCards
//
//  Created by C Poellabauer on 5/4/15.
//  Copyright (c) 2015 C Poellabauer. All rights reserved.
//

#import "Exit.h"
#include <stdio.h>

@interface Exit()
@property BOOL contentCreated;
@end

@implementation Exit
-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    self.backgroundColor = [SKColor blueColor];
    self.scaleMode = SKSceneScaleModeAspectFill;
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    SKLabelNode *instruction = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    
    instruction.text = @"(click anywhere to exit)";
    instruction.name = @"instruction";
    instruction.fontSize = 12;
    instruction.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)+50);
    myLabel.text = @"Thank you for playing the Flash Card Game!";
    myLabel.name = @"helloNode";
    myLabel.fontSize = 20;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    
    
    [self addChild:instruction];
    [self addChild:myLabel];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    SKNode *helloNode = [self childNodeWithName:@"helloNode"];
    if(helloNode != nil){
        helloNode.name = nil;
        //create actions
        SKAction *moveDown = [SKAction moveByX:0 y:-100 duration:0.5];
        SKAction *zoom = [SKAction scaleTo:2.0 duration:0.25];
        SKAction *pause = [SKAction waitForDuration:0.25];
        SKAction *fadeAWay = [SKAction fadeOutWithDuration:0.25];
        SKAction *remove = [SKAction removeFromParent];
        
        //put in order
        SKAction *moveSequence = [SKAction sequence:@[moveDown,zoom,pause,fadeAWay,remove]];
        
        //run action and transition to happy scene
        [helloNode runAction:moveSequence completion:^{
            exit(0);
        }];
    }
    
}

@end
