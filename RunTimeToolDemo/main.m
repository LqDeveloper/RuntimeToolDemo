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
int main(int argc, const char * argv[]) {
    @autoreleasepool {

        NSLog(@"%@",[RunTimeTool getPropertyFromObject:@"Person"]);
        NSLog(@"%@",[RunTimeTool getMethodNameFromObject:@"Person"]);
        [RunTimeTool executeMethodWithObject:@"Person" andMethodName:@"eatFood"];
    }
    return 0;
}
