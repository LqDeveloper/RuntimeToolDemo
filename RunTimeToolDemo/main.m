//
//  main.m
//  RunTimeToolDemo
//
//  Created by Quan Li on 2017/8/29.
//  Copyright © 2017年 Quan Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "RunTimeTool.h"
#import "NSObject+Type.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {

        NSLog(@"%@",[RunTimeTool getPropertyFromObject:@"Person"]);
        NSLog(@"%@",[RunTimeTool getMethodNameFromObject:@"Person"]);
        [RunTimeTool executeMethodWithObject:@"Person" andMethodName:@"eatFood"];
        
        NSObject *object = [[NSObject alloc]init];
        object.type = @"学生";
        NSLog(@"%@",object.type);
        
        [RunTimeTool addProtertyWithObject:object andPropertyName:@"name" andValue:@"小明"];
       
    }
    return 0;
}
