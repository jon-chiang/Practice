//
//  PIXWebAPIManager.h
//  JCPTableTrain
//
//  Created by jon on 2017/10/12.
//  Copyright © 2017年 pixnet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PIXWebAPIManager : NSObject

+ (instancetype)sharedInstance;
- (void)fetchFromURL:(NSString * _Nonnull)urlString parameters:(NSDictionary *)parameters completion:(void(^_Nullable)(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error))block;


@end
