//
//  NSObject+Type.m
//  RunTimeToolDemo
//
//  Created by Quan Li on 2017/8/30.
//  Copyright © 2017年 Quan Li. All rights reserved.
//

#import "NSObject+Type.h"
#import <objc/runtime.h>
@implementation NSObject (Type)
-(void)setType:(NSString *)type{
    objc_setAssociatedObject(self,"type", type, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)type{
    return  objc_getAssociatedObject(self, "type");
}


@end
