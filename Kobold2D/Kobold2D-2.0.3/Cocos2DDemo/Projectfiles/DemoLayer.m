//
//  DemoLayer.m
//  Cocos2DDemo
//
//  Created by Jon DeJong on 1/9/13.
//
//

#import "CocosDemo.h"

@implementation DemoLayer {
@private
    BOOL _animating;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialize
        _animating = NO;
        
        // Screen size for future calculations
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
        // Add background from the tilemap
        [self addChild:[CCTMXTiledMap tiledMapWithTMXFile:@"hexabump.tmx"] z:0];
        
        // Add a label for Hoopy's X position
        NSString * labelString = [NSString stringWithFormat:@"Hoopy X: %i", (int)screenSize.width/2];
		CCLabelBMFont *positionTextLabel = [CCLabelBMFont labelWithString:labelString fntFile:@"hdfont-full-small.fnt"];
		positionTextLabel.position =  ccp(screenSize.width/2.0, screenSize.height/8 * 7);
        
        // Add a menu item to go to another scene
        CCMenuItemFont* loadNewScene = [CCMenuItemFont itemWithString:@"Go To Another Scene" target:self selector:@selector(handleGoToSecondScene)];
        
        [loadNewScene setFontSize:20];
        [loadNewScene setFontName:@"Marker Felt"];
        
        CCMenu* newSceneMenu = [CCMenu menuWithItems:loadNewScene, nil];
        newSceneMenu.position = ccp(screenSize.width/2, screenSize.height/5);
        
        [self addChild:newSceneMenu];
		
		[self addChild: positionTextLabel z:1 tag:kPositionTextLabelTag];
        
        // Load a cache with our sprites
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"sprites.plist"];
        CCSpriteBatchNode* sprites = [CCSpriteBatchNode batchNodeWithFile:@"sprites.png"];
        
        [self addChild:sprites z:1 tag:kBatchSpritesTag];
        
        // Place Hoopy at the start point
        CCSprite *hoopy = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"hoopy.png"]];
        
        hoopy.batchNode = sprites;
        hoopy.position = ccp(screenSize.width/2, screenSize.height/2);
        hoopy.anchorPoint = ccp(.5, .5);
        
        [sprites addChild:hoopy z:1 tag:kHoopySpriteTag];
        
        // Place the left button
        CCSprite *leftButton = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"backward.png"]];
        
        leftButton.batchNode = sprites;
        leftButton.position = ccp(screenSize.width/7, screenSize.height/5);
        leftButton.anchorPoint = ccp(.5, .5);
        
        [sprites addChild:leftButton z:1 tag:kLeftButtonSpriteTag];
        
        // Place the right button
        CCSprite *rightButton = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"forward.png"]];
        
        rightButton.batchNode = sprites;
        rightButton.position = ccp(screenSize.width/7 * 6, screenSize.height/5);
        rightButton.anchorPoint = ccp(.5, .5);
        
        [sprites addChild:rightButton z:1 tag:kRightButtonSpriteTag];
        
        // Make sure touch is enabled (it is by default)
        [self setIsTouchEnabled:YES];
        
        // Kick of an update loop
        [self scheduleUpdate];
    }
    return self;
}

-(void) handleGoToSecondScene {
    CCScene* scene = [SecondDemoScene node];
    [[CCDirector sharedDirector] pushScene: scene];
}

-(void) update:(ccTime)delta
{
    if(_animating) {
        return;
    }
    
    KKInput* input = [KKInput sharedInput];
    if ([input isAnyTouchOnNode:[[self getChildByTag:kBatchSpritesTag] getChildByTag:kLeftButtonSpriteTag] touchPhase:KKTouchPhaseEnded]) {
        [self moveHoopyLeft];
    } else if ([input isAnyTouchOnNode:[[self getChildByTag:kBatchSpritesTag] getChildByTag:kRightButtonSpriteTag] touchPhase:KKTouchPhaseEnded]) {
        [self moveHoopyRight];
    }
    
}

-(void) moveHoopyLeft {
    _animating = YES;
    
    CCSprite* hoopy = (CCSprite*)[[self getChildByTag:kBatchSpritesTag] getChildByTag:kHoopySpriteTag];
    
    //    Action to move Hoopy 20 pixels to the left over 1 second
    int newX = hoopy.position.x - 100;
    CCFiniteTimeAction* moveAction = [CCMoveTo actionWithDuration: .5 position: ccp(newX, [CCDirector sharedDirector].winSize.height/2)];
    
    //    Removing the animating flag
    CCCallFunc* doneHandler = [CCCallFunc actionWithTarget:self selector:@selector(endAnimation)];
    
    [hoopy runAction:[CCSequence actions:moveAction, doneHandler, nil]];
}

-(void) moveHoopyRight {
    _animating =  YES;
    
    CCSprite* hoopy = (CCSprite*)[[self getChildByTag:kBatchSpritesTag] getChildByTag:kHoopySpriteTag];
    
    //    Action to fade out Hoopy by lowering his opacity to 0 over the 1 second
    CCFadeTo *fadeOut = [CCFadeTo actionWithDuration:1.0 opacity:50];
    
    //    Action to move Hoopy 60 pixels to the right over 1/2 second
    int newX = hoopy.position.x + 60;
    CCFiniteTimeAction* moveAction = [CCMoveTo actionWithDuration: .5 position: ccp(newX, [CCDirector sharedDirector].winSize.height/2)];
    
    //    Action to fade Hoopy back in by raising his opacity to 255 over the course of 1 second
    CCFadeTo *fadeIn = [CCFadeTo actionWithDuration:1.0 opacity:255];
    
    //    Removing the animating flag
    CCCallFunc* doneHandler = [CCCallFunc actionWithTarget:self selector:@selector(endAnimation)];
    
    [hoopy runAction:[CCSequence actions:fadeOut, moveAction, fadeIn, doneHandler, nil]];
}

-(void) endAnimation {
    _animating = NO;
    
    //    Get Hoopy's position
    CCSprite* hoopy = (CCSprite*)[[self getChildByTag:kBatchSpritesTag] getChildByTag:kHoopySpriteTag];
    int hoopyX = hoopy.position.x;
    
    //    Update the label
    CCLabelBMFont *positionTextLabel = (CCLabelBMFont *)[self getChildByTag:kPositionTextLabelTag];
    [positionTextLabel setString:[NSString stringWithFormat:@"Hoopy X: %i", hoopyX]];
}

@end
