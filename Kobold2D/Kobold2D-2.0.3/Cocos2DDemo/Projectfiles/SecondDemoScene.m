//
//  SecondDemoScene.m
//  Cocos2DDemo
//
//  Created by Jon DeJong on 1/9/13.
//
//

#import "CocosDemo.h"

@implementation SecondDemoScene

- (id)init
{
    self = [super init];
    if (self) {
//        Screen size for future calculations
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        
//        Add background from the tilemap
        [self addChild:[CCTMXTiledMap tiledMapWithTMXFile:@"hexabump.tmx"] z:0];
        
//        Add a TTF Label
        CCLabelTTF* label = [CCLabelTTF labelWithString:@"We have made it to another scene" fontName:@"Marker Felt" fontSize:24];
        label.position = ccp(screenSize.width/2, screenSize.height/2);
        
        [self addChild:label];
        
//        Add a menu item to go back
        CCMenuItemFont* goBackMenuItem = [CCMenuItemFont itemWithString:@"Go Back" target:self selector:@selector(handleGoBack)];
        
        [goBackMenuItem setFontSize:20];
        [goBackMenuItem setFontName:@"Marker Felt"];
        
        CCMenu* goHomeMenu = [CCMenu menuWithItems:goBackMenuItem, nil];
        goHomeMenu.position = ccp(screenSize.width/2, screenSize.height/5);
        
        [self addChild:goHomeMenu];
        
    }
    return self;
}

-(void) handleGoBack
{
    [[CCDirector sharedDirector] popScene];
}

@end
