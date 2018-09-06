//
//  UIView+Geometry.h
//  YZHUIExcelViewDemo
//
//  Created by yuan on 2017/9/20.
//  Copyright © 2017年 yuan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SET_OBJ_top(OBJ,TOP)        {CGRect F = OBJ.frame; F.origin.y = TOP; OBJ.frame=F;}
#define SET_OBJ_left(OBJ,LEFT)      {CGRect F = OBJ.frame; F.origin.x = LEFT; OBJ.frame=F;}
#define SET_OBJ_right(OBJ,RIGHT)    {CGRect F = OBJ.frame; F.origin.x = RIGHT - F.size.width; OBJ.frame=F;}
#define SET_OBJ_bottom(OBJ,BOTTOM)  {CGRect F = OBJ.frame; F.origin.y = BOTTOM - F.size.height; OBJ.frame=F;}
#define SET_OBJ_width(OBJ,WIDTH)    {CGRect F = OBJ.frame; F.size.width = WIDTH; OBJ.frame=F;}
#define SET_OBJ_height(OBJ,HEIGHT)  {CGRect F = OBJ.frame; F.size.height = HEIGHT; OBJ.frame=F;}
#define SET_OBJ_centerX(OBJ,CX)     {OBJ.center = CGPointMake(CX,OBJ.center.y);}
#define SET_OBJ_centerY(OBJ,CY)     {OBJ.center = CGPointMake(OBJ.center.x,CY);}
#define SET_OBJ_origin(OBJ,ORG)     {CGRect F = OBJ.frame; F.origin = ORG; OBJ.frame=F;}
#define SET_OBJ_size(OBJ, SIZE)     {CGRect F = OBJ.frame; F.size = SIZE; OBJ.frame=F;}

#define GET_OBJ_top(OBJ)            (OBJ.frame.origin.y)
#define GET_OBJ_left(OBJ)           (OBJ.frame.origin.x)
#define GET_OBJ_right(OBJ)          (OBJ.frame.origin.x + OBJ.frame.size.width)
#define GET_OBJ_bottom(OBJ)         (OBJ.frame.origin.y + OBJ.frame.size.height)
#define GET_OBJ_width(OBJ)          (OBJ.frame.size.width)
#define GET_OBJ_height(OBJ)         (OBJ.frame.size.height)
#define GET_OBJ_centerX(OBJ)        (OBJ.center.x)
#define GET_OBJ_centerY(OBJ)        (OBJ.center.y)
#define GET_OBJ_origin(OBJ)         (OBJ.frame.origin)
#define GET_OBJ_size(OBJ)           (OBJ.frame.size)


#define SET_OBJ_TOP(OBJ,TOP)        SET_OBJ_top(OBJ,TOP)
#define SET_OBJ_LEFT(OBJ,LEFT)      SET_OBJ_left(OBJ,LEFT)
#define SET_OBJ_RIGHT(OBJ,RIGHT)    SET_OBJ_right(OBJ,RIGHT)
#define SET_OBJ_BOTTOM(OBJ,BOTTOM)  SET_OBJ_bottom(OBJ,BOTTOM)
#define SET_OBJ_WIDTH(OBJ,WIDTH)    SET_OBJ_width(OBJ,WIDTH)
#define SET_OBJ_HEIGHT(OBJ,HEIGHT)  SET_OBJ_height(OBJ,HEIGHT)
#define SET_OBJ_CENTER_X(OBJ,CX)    SET_OBJ_centerX(OBJ,CX)
#define SET_OBJ_CENTER_Y(OBJ,CY)    SET_OBJ_centerY(OBJ,CY)
#define SET_OBJ_ORIGIN(OBJ,ORG)     SET_OBJ_origin(OBJ,ORG)
#define SET_OBJ_SIZE(OBJ, SIZE)     SET_OBJ_size(OBJ, SIZE)

#define GET_OBJ_TOP(OBJ)            GET_OBJ_top(OBJ)
#define GET_OBJ_LEFT(OBJ)           GET_OBJ_left(OBJ)
#define GET_OBJ_RIGHT(OBJ)          GET_OBJ_right(OBJ)
#define GET_OBJ_BOTTOM(OBJ)         GET_OBJ_bottom(OBJ)
#define GET_OBJ_WIDTH(OBJ)          SET_OBJ_width(OBJ)
#define GET_OBJ_HEIGHT(OBJ)         SET_OBJ_height(OBJ)
#define GET_OBJ_CENTER_X(OBJ)       SET_OBJ_centerX(OBJ)
#define GET_OBJ_CENTER_Y(OBJ)       SET_OBJ_centerY(OBJ)
#define GET_OBJ_ORIGIN(OBJ)         SET_OBJ_origin(OBJ)
#define GET_OBJ_SIZE(OBJ)           SET_OBJ_size(OBJ)

#define GET_PROPERTY(TYPE,PROPERTY)             \
    -(TYPE)PROPERTY                             \
    {                                           \
        return GET_OBJ_##PROPERTY(self);        \
    }

#define SET_PROPERTY(TYPE,PROPERTY,NAME)       \
    -(void)set##NAME:(TYPE)PROPERTY            \
    {                                          \
        SET_OBJ_##PROPERTY(self,PROPERTY);     \
    }

#define GET_SET_PROPERTY(TYPE,PROPERTY,NAME)    \
    GET_PROPERTY(TYPE, PROPERTY)                \
    SET_PROPERTY(TYPE,PROPERTY,NAME)            \

@interface UIView (Geometry)

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize  size;

@end
