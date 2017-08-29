//
//  RunTimeTool.h
//  runtime运行时
//
//  Created by Quan Li on 2017/8/29.
//  Copyright © 2017年 Azuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RunTimeTool : NSObject
//获取所有成员变量名和类型
+(NSArray*)getAllVariableFromObject:(NSString*)objectName;
//获取属性的变量名和类型
+(NSArray*)getPropertyFromObject:(NSString*)objectName;
//获取所有方法名
+(NSArray *)getMethodNameFromObject:(NSString *)objectName;
//执行某个类的某个方法
+(BOOL)executeMethodWithObject:(NSString *)objectName andMethodName:(NSString *)methodName;

@end
