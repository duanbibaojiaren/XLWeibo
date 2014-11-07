//
//  TextToolView.h
//  XinglangWeibo
//
//  Created by admin on 14-11-7.
//  Copyright (c) 2014年 xl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TextToolView;
typedef enum {
    IWComposeToolbarButtonTypeCamera,
    IWComposeToolbarButtonTypePicture,
    IWComposeToolbarButtonTypeMention,
    IWComposeToolbarButtonTypeTrend,
    IWComposeToolbarButtonTypeEmotion
} IWComposeToolbarButtonType;

@protocol TextToolViewDelegate <NSObject>
- (void)textToolView:(TextToolView *)toolView didClickButtonTag:(IWComposeToolbarButtonType)tag;
@end
@interface TextToolView : UIView
@property (nonatomic, weak) id <TextToolViewDelegate> textToolViewDelegate;
@end
