//
//  CocosDemo.h
//  Cocos2DDemo
//
//  Created by Jon DeJong on 1/6/13.
//
//

#import "CCLayer.h"

#ifndef COCOS_2D_DEMO_H
#define COCOS_2D_DEMO_H

enum {
    kBatchSpritesTag,
    kHoopySpriteTag,
    kLeftButtonSpriteTag,
    kRightButtonSpriteTag,
    kPositionTextLabelTag,
};

@interface DemoScene : CCScene @end
@interface DemoLayer : CCLayer @end
@interface SecondDemoScene : CCScene @end

#endif