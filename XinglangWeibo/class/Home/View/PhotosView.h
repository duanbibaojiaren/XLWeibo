//
//  PhotosView.h
//  xinlangweibo
//
//  Created by admin on 14-11-3.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Status;
@interface PhotosView : UIImageView
@property (nonatomic, strong)Status *status;

+ (CGSize)photosViewSizeWithPhotosCount:(int)count;
@end
