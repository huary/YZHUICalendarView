//
//  YZHUIGraphicsImage.m
//  YZHUIAlertViewDemo
//
//  Created by yuan on 2018/5/18.
//  Copyright © 2018年 yuan. All rights reserved.
//

#import "YZHUIGraphicsImage.h"
#import "UIBezierPath+CornerRadius.h"

@implementation YZHUIGraphicsImageBeginInfo

-(instancetype)initWithGraphicsSize:(CGSize)graphicsSize opaque:(BOOL)opaque scale:(CGFloat)scale lineWidth:(CGFloat)lineWidth
{
    self = [super init];
    if (self) {
        self.scale = scale;
        self.opaque = opaque;
        self.lineWidth = lineWidth;
        self.graphicsSize = graphicsSize;
    }
    return self;
}

@end

@implementation YZHUIGraphicsImageContext

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.imageAlignment = NSGraphicsImageAlignmentLeft;
        self.ctx = NULL;
    }
    return self;
}

-(instancetype)initWithBeginBlock:(UIGraphicsImageBeginBlock)beginBlock runBlock:(UIGraphicsImageRunBlock)runBlock endPathBlock:(UIGraphicsImageEndPathBlock)endPathBlock
{
    self = [self init];
    if (self) {
        self.graphicsBeginBlock = beginBlock;
        self.graphicsRunBlock = runBlock;
        self.graphicsEndPathBlock = endPathBlock;
    }
    return self;
}

-(instancetype)initWithBeginBlock:(UIGraphicsImageBeginBlock)beginBlock runBlock:(UIGraphicsImageRunBlock)runBlock endPathBlock:(UIGraphicsImageEndPathBlock)endPathBlock completionBlock:(UIGraphicsImageCompletionBlock)completionBlock
{
    self = [self  initWithBeginBlock:beginBlock runBlock:runBlock endPathBlock:endPathBlock];
    if (self) {
        self.graphicsCompletionBlock = completionBlock;
    }
    return self;
}

-(UIImage*)createGraphicesImageWithStrokeColor:(UIColor*)strokeColor
{
    BOOL opaque = NO;
    CGFloat scale = 0;
    CGFloat lineWidth = 0.0;
    CGSize size = CGSizeZero;
    if (self.graphicsBeginBlock) {
        self.graphicsBeginBlock(self);
        YZHUIGraphicsImageBeginInfo *beginInfo = self.beginInfo;
        if (beginInfo) {
            scale = beginInfo.scale;
            opaque = beginInfo.opaque;
            lineWidth = beginInfo.lineWidth;
            if (beginInfo.graphicsSize.width > 0 && beginInfo.graphicsSize.height > 0) {
                size = beginInfo.graphicsSize;
            }
            else {
                beginInfo.graphicsSize = size;
            }
        }
        else {
            beginInfo = [[YZHUIGraphicsImageBeginInfo alloc] initWithGraphicsSize:size opaque:opaque scale:scale lineWidth:lineWidth];
            self.beginInfo = beginInfo;
        }
    }
    
    UIGraphicsBeginImageContextWithOptions(size, opaque, scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, lineWidth);
    if (strokeColor) {
        CGContextSetStrokeColorWithColor(ctx, strokeColor.CGColor);
    }
    
    self.ctx = ctx;
    if (self.graphicsRunBlock) {
        self.graphicsRunBlock(self);
    }
    
    CGContextStrokePath(ctx);
    
    if (self.graphicsEndPathBlock) {
        self.graphicsEndPathBlock(self);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    if (self.graphicsCompletionBlock) {
        self.graphicsCompletionBlock(self, image);
    }
    return image;
}

//创建关闭的符号：x
+(UIImage*)createCrossImageWithSize:(CGSize)size lineWidth:(CGFloat)lineWidth backgroundColor:(UIColor*)backgroundColor strokeColor:(UIColor*)strokeColor
{
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        return nil;
    }
    YZHUIGraphicsImageContext *ctx = [[YZHUIGraphicsImageContext alloc] initWithBeginBlock:^(YZHUIGraphicsImageContext *context) {
        context.beginInfo = [[YZHUIGraphicsImageBeginInfo alloc] init];
        context.beginInfo.lineWidth = lineWidth;
        context.beginInfo.graphicsSize = size;
    } runBlock:^(YZHUIGraphicsImageContext *context) {
        if (backgroundColor) {
            CGContextSetFillColorWithColor(context.ctx, backgroundColor.CGColor);
            CGContextFillRect(context.ctx, CGRectMake(0, 0, size.width, size.height));
        }
        
        CGContextMoveToPoint(context.ctx, 0, 0);
        CGContextAddLineToPoint(context.ctx, size.width, size.height);
        CGContextMoveToPoint(context.ctx, size.width, 0);
        CGContextAddLineToPoint(context.ctx, 0, size.height);
    } endPathBlock:nil];
    return [ctx createGraphicesImageWithStrokeColor:strokeColor];
}

//创建返回的符号：<
+(UIImage*)createBackImageWithSize:(CGSize)size lineWidth:(CGFloat)lineWidth backgroundColor:(UIColor*)backgroundColor strokeColor:(UIColor*)strokeColor
{
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        return nil;
    }
    YZHUIGraphicsImageContext *ctx = [[YZHUIGraphicsImageContext alloc] initWithBeginBlock:^(YZHUIGraphicsImageContext *context) {
        context.beginInfo = [[YZHUIGraphicsImageBeginInfo alloc] init];
        context.beginInfo.lineWidth = lineWidth;
        context.beginInfo.graphicsSize = size;
    } runBlock:^(YZHUIGraphicsImageContext *context) {
        if (backgroundColor) {
            CGContextSetFillColorWithColor(context.ctx, backgroundColor.CGColor);
            CGContextFillRect(context.ctx, CGRectMake(0, 0, size.width, size.height));
        }
        CGFloat width = context.beginInfo.graphicsSize.width;
        CGFloat height = context.beginInfo.graphicsSize.height;
        NSLog(@"width=%f,height=%f",width,height);
        CGFloat lineWidth = context.beginInfo.lineWidth;
        CGContextMoveToPoint(context.ctx, width - lineWidth/2, lineWidth/2);
        CGContextAddLineToPoint(context.ctx, lineWidth/2, height/2);
        CGContextAddLineToPoint(context.ctx, width - lineWidth/2, height - lineWidth/2);
    } endPathBlock:nil];
    return [ctx createGraphicesImageWithStrokeColor:strokeColor];
}

//创建前进的符号：>
+(UIImage*)createForwardImageWithSize:(CGSize)size lineWidth:(CGFloat)lineWidth backgroundColor:(UIColor*)backgroundColor strokeColor:(UIColor*)strokeColor
{
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        return nil;
    }
    YZHUIGraphicsImageContext *ctx = [[YZHUIGraphicsImageContext alloc] initWithBeginBlock:^(YZHUIGraphicsImageContext *context) {
        context.beginInfo = [[YZHUIGraphicsImageBeginInfo alloc] init];
        context.beginInfo.lineWidth = lineWidth;
        context.beginInfo.graphicsSize = size;
    } runBlock:^(YZHUIGraphicsImageContext *context) {
        CGFloat width = context.beginInfo.graphicsSize.width;
        CGFloat height = context.beginInfo.graphicsSize.height;
        if (backgroundColor) {
            CGContextSetFillColorWithColor(context.ctx, backgroundColor.CGColor);
            CGContextFillRect(context.ctx, CGRectMake(0, 0, width, height));
        }
        NSLog(@"width=%f,height=%f",width,height);
        CGFloat lineWidth = context.beginInfo.lineWidth;
        CGContextMoveToPoint(context.ctx, lineWidth/2, lineWidth/2);
        CGContextAddLineToPoint(context.ctx, width - lineWidth/2, height/2);
        CGContextAddLineToPoint(context.ctx, lineWidth/2, height - lineWidth/2);
    } endPathBlock:nil];
    return [ctx createGraphicesImageWithStrokeColor:strokeColor];
}


//创建带圆角的图片
+(UIImage*)createImageWithSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor backgroundColor:(UIColor*)backgroundColor
{
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        return nil;
    }
    
    YZHUIGraphicsImageContext *ctx = [[YZHUIGraphicsImageContext alloc] initWithBeginBlock:^(YZHUIGraphicsImageContext *context) {
        context.beginInfo = [[YZHUIGraphicsImageBeginInfo alloc] init];
        context.beginInfo.lineWidth = borderWidth;
        context.beginInfo.graphicsSize = size;
    } runBlock:^(YZHUIGraphicsImageContext *context) {
        CGFloat width = context.beginInfo.graphicsSize.width;
        CGFloat height = context.beginInfo.graphicsSize.height;
        if (backgroundColor) {
            CGContextSetFillColorWithColor(context.ctx, backgroundColor.CGColor);
        }
        CGRect rect = CGRectMake(0, 0, width, height);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
        [path closePath];
        CGContextAddPath(context.ctx, path.CGPath);
        CGContextDrawPath(context.ctx, kCGPathFill);
        
        CGFloat minWH = MIN(width, height);
        if (borderWidth > 0 && borderColor && borderWidth < minWH) {
            UIBezierPath *borderPath = [UIBezierPath borderBezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadius:cornerRadius borderWidth:borderWidth];
            [borderPath closePath];
            CGContextAddPath(context.ctx, borderPath.CGPath);
//            CGContextDrawPath(context.ctx, kCGPathStroke);
        }
    } endPathBlock:nil];
    return [ctx createGraphicesImageWithStrokeColor:borderColor];
}


+(UIImage*)createBorderStrokeImageWithSize:(CGSize)size byRoundingCorners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor backgroundColor:(UIColor*)backgroundColor
{
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        return nil;
    }
    
    YZHUIGraphicsImageContext *ctx = [[YZHUIGraphicsImageContext alloc] initWithBeginBlock:^(YZHUIGraphicsImageContext *context) {
        context.beginInfo = [[YZHUIGraphicsImageBeginInfo alloc] init];
        context.beginInfo.lineWidth = borderWidth;
        context.beginInfo.graphicsSize = size;
    } runBlock:^(YZHUIGraphicsImageContext *context) {
        CGFloat width = context.beginInfo.graphicsSize.width;
        CGFloat height = context.beginInfo.graphicsSize.height;
        CGRect rect = CGRectMake(0, 0, width, height);
        if (backgroundColor) {
            CGContextSetFillColorWithColor(context.ctx, backgroundColor.CGColor);
            CGContextFillRect(context.ctx, rect);
        }
        UIBezierPath *path = [UIBezierPath borderBezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadius:cornerRadius borderWidth:borderWidth];
        [path closePath];
//        [borderColor setStroke];
        CGContextAddPath(context.ctx, path.CGPath);
//        CGContextDrawPath(context.ctx, kCGPathStroke);
    } endPathBlock:nil];
    return [ctx createGraphicesImageWithStrokeColor:borderColor];
}

//对图片进行圆角
+(UIImage*)graphicesImage:(UIImage*)image cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor
{
    CGSize size = image.size;
    return [YZHUIGraphicsImageContext graphicesImage:image graphicsSize:size inRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:cornerRadius borderWidth:borderWidth borderColor:borderColor];
}

//将图片放入到Rect中，并进行圆角
+(UIImage*)graphicesImage:(UIImage*)image inRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor
{
    CGSize size = CGSizeMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    return [YZHUIGraphicsImageContext graphicesImage:image graphicsSize:size inRect:rect cornerRadius:cornerRadius borderWidth:borderWidth borderColor:borderColor];
}

//将图片放入到Rect中，并进行圆角，在graphicsSize中按rect进行绘画
+(UIImage*)graphicesImage:(UIImage*)image graphicsSize:(CGSize)graphicsSize inRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor
{
    return [YZHUIGraphicsImageContext graphicesImage:image graphicsSize:graphicsSize inRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadius:cornerRadius borderWidth:borderWidth borderColor:borderColor];
}

+(UIImage*)graphicesImage:(UIImage*)image graphicsSize:(CGSize)graphicsSize inRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor
{
    
    CGSize size = rect.size;
    if (image == nil || CGSizeEqualToSize(size, CGSizeZero) || CGSizeEqualToSize(graphicsSize, CGSizeZero)) {
        return nil;
    }
    
    //交换top和bottom，从UIRectCorner枚举值来看就是相互交换高低各两位
    corners = TYPE_OR(TYPE_LS(TYPE_AND(corners, 3), 2), TYPE_RS(TYPE_AND(corners, 12), 2));
    
    CGRect drawRect = rect;
    drawRect.origin.y = graphicsSize.height - CGRectGetMaxY(rect);
    
    YZHUIGraphicsImageContext *ctx = [[YZHUIGraphicsImageContext alloc] initWithBeginBlock:^(YZHUIGraphicsImageContext *context) {
        context.beginInfo = [[YZHUIGraphicsImageBeginInfo alloc] init];
        context.beginInfo.lineWidth = borderWidth;
        context.beginInfo.graphicsSize = graphicsSize;
    } runBlock:^(YZHUIGraphicsImageContext *context) {
        CGFloat width = context.beginInfo.graphicsSize.width;
        CGFloat height = context.beginInfo.graphicsSize.height;
        
        CGContextScaleCTM(context.ctx, 1, -1);
        CGContextTranslateCTM(context.ctx, 0, -height);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:drawRect byRoundingCorners:corners cornerRadius:cornerRadius];
        [path closePath];
//        CGContextSaveGState(context.ctx);
        [path addClip];
        CGContextDrawImage(context.ctx, drawRect, image.CGImage);
//        CGContextRestoreGState(context.ctx);
        
        CGFloat minWH = MIN(width, height);
        if (borderWidth > 0 && borderColor && borderWidth < minWH) {
            UIBezierPath *borderPath = [UIBezierPath borderBezierPathWithRoundedRect:drawRect byRoundingCorners:corners cornerRadius:cornerRadius borderWidth:borderWidth];
            [borderPath closePath];
//            [borderColor setStroke];
            CGContextAddPath(context.ctx, borderPath.CGPath);
//            CGContextDrawPath(context.ctx, kCGPathStroke);
        }
    } endPathBlock:nil];
    return [ctx createGraphicesImageWithStrokeColor:borderColor];
}
@end
