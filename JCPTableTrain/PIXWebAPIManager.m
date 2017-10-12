//
//  PIXWebAPIManager.m
//  JCPTableTrain
//
//  Created by jon on 2017/10/12.
//  Copyright © 2017年 pixnet. All rights reserved.
//

#import "PIXWebAPIManager.h"
#import <AFNetworking.h>
#import "Post.h"

@interface PIXWebAPIManager()

@property (strong ,nonatomic) AFURLSessionManager *manager;

@end

@implementation PIXWebAPIManager

+ (instancetype)sharedInstance {
    static PIXWebAPIManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[PIXWebAPIManager alloc] init];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        instance.manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    });
    return instance;
}

- (void)fetchFromURL:(NSString * _Nonnull)urlString parameters:(NSDictionary *)parameters completion:(void(^_Nullable)(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error))block {
    
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:urlString parameters:parameters error:nil];
    NSURLSessionDataTask *dataTask = [self.manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSArray *recommendArray = dict[@"hot"];
        
        NSMutableArray *finalArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in recommendArray) {
            Post *post = [[Post alloc] init];
            post.name = dict[@"name"];
            post.summary = dict[@"summary"];
            NSURL *url = [NSURL URLWithString:dict[@"thumb"]];
            post.URL = url;
            [finalArray addObject:post];
        }
        block(response, finalArray, error);
    }];
    [dataTask resume];
}


@end
