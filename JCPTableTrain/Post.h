//
//  Post.h
//  JCPTableTrain
//
//  Created by jon on 2017/10/12.
//  Copyright © 2017年 pixnet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *summary;
@property (strong, nonatomic) NSURL *URL;

@end
