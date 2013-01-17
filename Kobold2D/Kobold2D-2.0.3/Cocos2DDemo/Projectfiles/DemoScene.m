//
//  DemoLayer.m
//  Cocos2DDemo
//
//  Created by Jon DeJong on 1/6/13.
//
//

#import "CocosDemo.h"


@implementation DemoScene {

}

- (id)init
{
    self = [super init];
    if (self) {
        [self addChild:[DemoLayer node]];
    }
    return self;
}

@end
