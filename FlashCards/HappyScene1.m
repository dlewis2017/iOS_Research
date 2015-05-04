//  HappyScene.m
//  FlashCardGame
//
//  Created by C Poellabauer on 3/7/15.
//  Copyright (c) 2015 C Poellabauer. All rights reserved.
//

#import "HappyScene1.h"
#import "SadScene2.h"
#import "AngryScene3.h"
#import "SadScene4.h"
#import "AngryScene5.h"
#import "HappyScene6.h"
#import "CowScene.h"
#import "PigScene.h"
#import "RosterScene.h"
#import "CookieScene.h"
#import "PizzaScene.h"
#import "PillowScene.h"
#import "GameViewController.h"
#import "GameScene.h"
#include <stdlib.h>
#include <stdio.h>
#import "Rain.h"
#import "Sun.h"
#import "Lightning.h"
#import "Basketball.h"
#import "Tennis.h"
#import "Soccer.h"
#import "Happy.h"
#import "Sad.h"
#import "Angry.h"

#import "Exit.h"

@interface HappyScene1 ()
@property BOOL contentCreated;

@property UIImageView* img;
@property NSString* resultString;
@property double secTimer;
@property double secTimer2;
@property SKLabelNode* timer;

@end

@implementation HappyScene1

-(void) createSceneContent{
    self.backgroundColor = [SKColor greenColor];
    self.scaleMode = SKSceneScaleModeAspectFill;
    
}


-(void) didMoveToView:(SKView *)view{
    if(!self.contentCreated){
        [self createSceneContent];
        self.contentCreated = YES;
    }

    //display image
    _img = [[UIImageView alloc] initWithFrame:CGRectMake(175,450, 400, 400)];
    _img.image = [UIImage imageNamed:@"HappyFace.png"];
    _img.hidden = NO;
    [self.view addSubview:_img];
    
    //start timer
    _secTimer = [[NSDate date] timeIntervalSince1970];

    //create timer nodelabel
    _timer = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
    _timer.text = @"Seconds Taken...";
    _timer.name = @"timerNode";
    _timer.fontSize = 20;
    _timer.position = CGPointMake(CGRectGetMidX(self.frame),750);
    //cerate restart
    SKLabelNode *restart = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    restart.text = @"Restart?";
    restart.name = @"restartNode";
    restart.fontSize = 20;
    restart.position = CGPointMake(275,750);
    //Create title
    SKLabelNode *question = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    question.text = @"How are they feeling?";
    question.name = @"questionNode";
    question.fontSize = 30;
    question.position = CGPointMake(CGRectGetMidX(self.frame),700);
    //Create happy, sad, and angry Nodes
    SKLabelNode *happyNode = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    happyNode.text = @"Happy";
    happyNode.name = @"happyNode";
    happyNode.fontSize = 18;
    happyNode.position = CGPointMake(300, 50);
    SKLabelNode *sadNode = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    sadNode.text = @"Sad";
    sadNode.name = @"sadNode";
    sadNode.fontSize = 18;
    sadNode.position = CGPointMake(CGRectGetMidX(self.frame), 50);
    SKLabelNode *angryNode = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    angryNode.text = @"Angry";
    angryNode.name = @"angryNode";
    angryNode.fontSize = 18;
    angryNode.position = CGPointMake(700, 50);
    
    //end Game node
    SKLabelNode *exitNode = [SKLabelNode labelNodeWithFontNamed:@"ChalkDuster"];
    exitNode.text = @"Exit?";
    exitNode.name = @"exitNode";
    exitNode.fontSize = 20;
    exitNode.position = CGPointMake(750, 750);
    
    [self addChild:exitNode];
    [self addChild:restart];
    [self addChild:_timer];
    [self addChild:question];
    [self addChild:happyNode];
    [self addChild:sadNode];
    [self addChild:angryNode];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event { //if happy Node pressed (matches scene, move onto next scene
    //Nodes
    SKNode *happyNode = [self childNodeWithName:@"happyNode"];
    SKNode *sadNode = [self childNodeWithName:@"sadNode"];
    SKNode *angryNode = [self childNodeWithName:@"angryNode"];
    SKNode *restartNode = [self childNodeWithName:@"restartNode"];
    SKNode *exitNode = [self childNodeWithName:@"exitNode"];
    
    //random number generator for presenting different scenes
    int randNum = arc4random_uniform(20)+1; //1-20

    //create flip transition and scene allocations
    SKTransition *flip = [SKTransition flipVerticalWithDuration:0.5];

    SKScene *sadScene2= [[SadScene2 alloc] initWithSize:self.size];
    SKScene *angryScene3= [[AngryScene3 alloc] initWithSize:self.size];
    SKScene *sadScene4= [[SadScene4 alloc] initWithSize:self.size];
    SKScene *angryScene5= [[AngryScene5 alloc] initWithSize:self.size];
    SKScene *happyScene6= [[HappyScene6 alloc] initWithSize:self.size];
    SKScene *cowScene= [[CowScene alloc] initWithSize:self.size];
    SKScene *pigScene = [[PigScene alloc] initWithSize:self.size];
    SKScene *rosterScene = [[RosterScene alloc] initWithSize:self.size];
    SKScene *cookieScene = [[CookieScene alloc] initWithSize:self.size];
    SKScene *pizzaScene = [[PizzaScene alloc] initWithSize:self.size];
    SKScene *pillowScene = [[PillowScene alloc] initWithSize:self.size];
    SKScene *gameScene = [[GameScene alloc] initWithSize:self.size];
    SKScene *sunScene = [[Sun alloc] initWithSize:self.size];
    SKScene *rainScene = [[Rain alloc] initWithSize:self.size];
    SKScene *lightningScene = [[Lightning alloc] initWithSize:self.size];
    SKScene *basketballScene = [[Basketball alloc] initWithSize:self.size];
    SKScene *tennisScene = [[Tennis alloc] initWithSize:self.size];
    SKScene *soccerScene = [[Soccer alloc] initWithSize:self.size];
    SKScene *happyScene = [[Happy alloc] initWithSize:self.size];
    SKScene *sadScene = [[Sad alloc] initWithSize:self.size];
    SKScene *angryScene = [[Angry alloc] initWithSize:self.size];
    SKScene *exitScene = [[Exit alloc] initWithSize:self.size];
    
    for(UITouch *touch in touches){
        CGPoint happyLocation = [touch locationInNode:self];
        CGPoint sadLocation = [touch locationInNode:self];
        CGPoint angryLocation = [touch locationInNode:self];
        CGPoint restartLocation = [touch locationInNode:self];
        CGPoint exitLocation = [touch locationInNode:self];
        
        if([happyNode containsPoint:happyLocation]){
            //create actions
            SKAction *zoom = [SKAction scaleTo:2.0 duration:0.05];
            SKAction *pause = [SKAction waitForDuration:0.25];
            SKAction *fadeAway = [SKAction fadeOutWithDuration:0.10];
            SKAction *remove = [SKAction removeFromParent];
            
            //put in order
            SKAction *moveSequence = [SKAction sequence:@[zoom,pause,fadeAway,remove]];
        
            //get time in seconds, subtract from start time to get how long it took to answer question
            _secTimer2 = [[NSDate date] timeIntervalSince1970];
            double TimeTaken = _secTimer2-_secTimer;
            int intValue = (int)(TimeTaken + (TimeTaken>0 ? 0.5 : -0.5));
            _resultString = [NSString stringWithFormat:@"%d seconds", intValue]; //convert to int and display as sring
            
            //updated timer string
            _timer.text = _resultString;

            //get rid of subView
            [UIImageView animateWithDuration:0.5f
                                  animations:^{
                                      [UIImageView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.img cache:false];
                                      _img.hidden = YES;
                                  }
                                  completion:^(BOOL finished) {
                                      [NSThread sleepForTimeInterval:2.5f]; //wait to display time long enough
                                      //continue to choose next scene
                                

            //after completion of actions, move to random next scene
            [happyNode runAction:moveSequence completion:^{
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
                        [self.view presentScene:pigScene transition:flip];
                        break;
                    case 8:
                        [self.view presentScene:rosterScene transition:flip];
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
                    case 12:
                        [self.view presentScene:sunScene transition:flip];
                        break;
                    case 13:
                        [self.view presentScene:rainScene transition:flip];
                        break;
                    case 14:
                        [self.view presentScene:lightningScene transition:flip];
                        break;
                    case 15:
                        [self.view presentScene:basketballScene transition:flip];
                        break;
                    case 16:
                        [self.view presentScene:soccerScene transition:flip];
                        break;
                    case 17:
                        [self.view presentScene:tennisScene transition:flip];
                        break;
                    case 18:
                        [self.view presentScene:happyScene transition:flip];
                        break;
                    case 19:
                        [self.view presentScene:sadScene transition:flip];
                        break;
                    case 20:
                        [self.view presentScene:angryScene transition:flip];
                        break;
                    default:
                        break;
                }
                
            }];
        }];
        }
        if ([sadNode containsPoint:sadLocation]){ //wrong location
            //create actions
            SKAction *shrink = [SKAction scaleTo:0.5 duration:0.05];
            [sadNode runAction:shrink];
        }
        if ([angryNode containsPoint:angryLocation]){ //wrong location
            SKAction *shrink = [SKAction scaleTo:0.5 duration:0.05];
            //run action
            [angryNode runAction:shrink];
        }
        if([restartNode containsPoint:restartLocation]){ //restart pressed
            _img.hidden = YES;
            [self.view presentScene:gameScene transition:flip];
        }
        if ([exitNode containsPoint:exitLocation]) {
            _img.hidden = YES;
            [self.view presentScene:exitScene transition:flip];
        }
            
    }
}

@end
