//
//  SinaWeiboManager.h
//  Date
//
//  Created by lixiaoyu on 12-11-12.
//  Copyright (c) 2012年 Liu&Mao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SinaWeibo.h"

@interface SinaWeiboManager : NSObject <SinaWeiboDelegate,SinaWeiboRequestDelegate>

@property (readonly, nonatomic) SinaWeibo * sinaWeibo;

+ (SinaWeiboManager *)defaultManager;

- (void)initSinaWeibo;
- (void)requestUserInfo;
- (void)requestBilateralFriends;

@end
