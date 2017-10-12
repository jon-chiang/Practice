//
//  PIXWebAPIManager.m
//  JCPTableTrain
//
//  Created by jon on 2017/10/12.
//  Copyright © 2017年 pixnet. All rights reserved.
//

#import "PIXWebAPIManager.h"

@implementation PIXWebAPIManager

+ (instancetype)sharedInstance {
    static PIXWebAPIManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[PIXWebAPIManager alloc] init];
    });
    return instance;
}


@end
