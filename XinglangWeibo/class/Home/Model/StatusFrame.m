//
//  StatusFrame.m
//  xinlangweibo
//
//  Created by admin on 14-11-1.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "StatusFrame.h"
#import "User.h"
#import "Status.h"
#import "PhotosView.h"


@implementation StatusFrame

- (void)setStatus:(Status *)status
{
    _status = status;
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width - 20;
    
    // 1.topView
    CGFloat topViewW = cellW;
    CGFloat topViewH = 0;
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    
    // 2.头像
    CGFloat iconViewWH = 35;
    CGFloat iconViewX = IWStatusCellBorder;
    CGFloat iconViewY = IWStatusCellBorder;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    
    // 3.昵称
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF) + IWStatusCellBorder;
    CGFloat nameLabelY = iconViewY;
    CGSize nameLabelSize = [status.user.name sizeWithFont:IWStatusNameFont];
    _nameLabelF = (CGRect){{nameLabelX, nameLabelY}, nameLabelSize};
    
    // 4.会员图标
    if (status.user.isVip) {
        CGFloat vipViewW = 14;
        CGFloat vipViewH = nameLabelSize.height;
        CGFloat vipViewX = CGRectGetMaxX(_nameLabelF) + IWStatusCellBorder;
        CGFloat vipViewY = nameLabelY;
        _vipViewF = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    }
    
    // 5.时间
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = CGRectGetMaxY(_nameLabelF) + IWStatusCellBorder;
    CGSize timeLabelSize = [status.created_at sizeWithFont:IWStatusTimeFont];
    _timeLabelF = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    
    // 6.来源
    CGFloat sourceLabelX = CGRectGetMaxX(_timeLabelF) + IWStatusCellBorder + 20;
    CGFloat sourceLabelY = timeLabelY;
    CGSize sourceLabelSize = [status.source sizeWithFont:IWStatusSourceFont];
    _sourceLabelF = (CGRect){{sourceLabelX, sourceLabelY}, sourceLabelSize};
    
    // 7.微博正文内容
    CGFloat contentLabelX = iconViewX;
    CGFloat contentLabelY = MAX(CGRectGetMaxY(_timeLabelF), CGRectGetMaxY(_iconViewF)) + IWStatusCellBorder;
    CGFloat contentLabelMaxW = topViewW - 2 * IWStatusCellBorder;
    CGSize contentLabelSize = [status.text sizeWithFont:IWStatusContentFont constrainedToSize:CGSizeMake(contentLabelMaxW, MAXFLOAT)];
    _contentLabelF = (CGRect){{contentLabelX, contentLabelY}, contentLabelSize};
    
    // 8.配图
    if (status.pic_urls.count) {
        CGSize photoViewSize = [PhotosView photosViewSizeWithPhotosCount:status.pic_urls.count];
        CGFloat photoViewX = contentLabelX;
        CGFloat photoViewY = CGRectGetMaxY(_contentLabelF) + IWStatusCellBorder;
        _photoViewF = CGRectMake(photoViewX, photoViewY, photoViewSize.width, photoViewSize.height);
    }
    
    // 9.被转发微博
    if (status.retweeted_status) {
        CGFloat retweetViewW = contentLabelMaxW;
        CGFloat retweetViewX = contentLabelX;
        CGFloat retweetViewY = CGRectGetMaxY(_contentLabelF) + IWStatusCellBorder;
        CGFloat retweetViewH = 0;
        
        // 10.被转发微博的昵称
        CGFloat retweetNameLabelX = IWStatusCellBorder;
        CGFloat retweetNameLabelY = IWStatusCellBorder;
        CGSize retweetNameLabelSize = [status.retweeted_status.user.name sizeWithFont:IWRetweetStatusNameFont];
        _retweetNameLabelF = (CGRect){{retweetNameLabelX, retweetNameLabelY}, retweetNameLabelSize};
        
        // 11.被转发微博的正文
        CGFloat retweetContentLabelX = retweetNameLabelX;
        CGFloat retweetContentLabelY = CGRectGetMaxY(_retweetNameLabelF) + IWStatusCellBorder;
        CGFloat retweetContentLabelMaxW = retweetViewW - 2 * IWStatusCellBorder;
        CGSize retweetContentLabelSize = [status.retweeted_status.text sizeWithFont:IWRetweetStatusContentFont constrainedToSize:CGSizeMake(retweetContentLabelMaxW, MAXFLOAT)];
        _retweetContentLabelF = (CGRect){{retweetContentLabelX, retweetContentLabelY}, retweetContentLabelSize};
        
        // 12.被转发微博的配图
        if(status.retweeted_status.pic_urls.count) {
//            CGFloat retweetPhotoViewWH = 70;
            CGSize retweetPhotoViewSize =[PhotosView photosViewSizeWithPhotosCount:status.retweeted_status.pic_urls.count];
            CGFloat retweetPhotoViewX = retweetContentLabelX;
            CGFloat retweetPhotoViewY  = CGRectGetMaxY(_retweetContentLabelF) + IWStatusCellBorder;
            _retweetPhotoViewF = CGRectMake(retweetPhotoViewX, retweetPhotoViewY, retweetPhotoViewSize.width, retweetPhotoViewSize.height);
            
            retweetViewH = CGRectGetMaxY(_retweetPhotoViewF);
        } else { // 没有配图
            retweetViewH = CGRectGetMaxY(_retweetContentLabelF);
        }
        retweetViewH += IWStatusCellBorder;
        _retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        
        // 有转发微博时topViewH
        topViewH = CGRectGetMaxY(_retweetViewF);
    } else { // 没有转发微博
        if (status.pic_urls.count) { // 有图
            topViewH = CGRectGetMaxY(_photoViewF);
        } else { // 无图
            topViewH = CGRectGetMaxY(_contentLabelF);
        }
    }
    topViewH += IWStatusCellBorder;
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    // 13.工具条
    CGFloat statusToolbarX = topViewX;
    CGFloat statusToolbarY = CGRectGetMaxY(_topViewF);
    CGFloat statusToolbarW = topViewW;
    CGFloat statusToolbarH = 35;
    _statusToolbarF = CGRectMake(statusToolbarX, statusToolbarY, statusToolbarW, statusToolbarH);
    
    // 14.cell的高度
    _cellHeight = CGRectGetMaxY(_statusToolbarF) + 10;

}

- (CGRect)timeLabelFrame
{
    CGFloat timeLabelX = CGRectGetMaxX(_iconViewF) + IWStatusCellBorder;
    CGFloat timeLabelY = CGRectGetMaxY(_nameLabelF) + IWStatusCellBorder;
    CGSize timeLabelSize = [_status.created_at sizeWithFont:IWStatusTimeFont];

//    NSLog(@"CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH)==%@",NSStringFromCGRect(CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH)));
    return (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
}
@end
