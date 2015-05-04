//
//  GameScene.m
//  FlashCardGame
//
//  Created by C Poellabauer on 3/7/15.
//  Copyright (c) 2015 C Poellabauer. All rights reserved.
//

#import "GameScene.h"
#import "HappyScene1.h"

@interface GameScene()
@property BOOL contentCreated;
@end

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    self.backgroundColor = [SKColor blueColor];
    self.scaleMode = SKSceneScaleModeAspectFill;
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    SKLabelNode *instruction = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    
    instruction.text = @"(click anywhere to begin)";
    instruction.name = @"instruction";
    instruction.fontSize = 12;
    instruction.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)+50);
    myLabel.text = @"Welcome to the Flash Card Game!";
    myLabel.name = @"helloNode";
    myLabel.fontSize = 24;
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
            SKScene *happyScene1= [[HappyScene1 alloc] initWithSize:self.size];
            SKTransition *doors = [SKTransition doorsOpenVerticalWithDuration:0.5];
            [self.view presentScene:happyScene1 transition:doors];
        }];
    }
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
