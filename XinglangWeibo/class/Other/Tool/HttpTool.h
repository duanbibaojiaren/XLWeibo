//
//  HttpTool.h
//  XinglangWeibo
//
//  Created by admin on 14-11-7.
//  Copyright (c) 2014年 xl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTool : NSObject
+ (void)postWithUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure;
+ (void)getWithUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure;
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure;
@end

/**
 *  用来封装文件数据的模型
 */
@interface IWFormData : NSObject
/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *data;

/**
 *  参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *filename;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;
@end