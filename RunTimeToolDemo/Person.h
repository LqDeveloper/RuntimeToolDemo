//
//  Person.h
//  ReactiveCocoaDemo
//
//  Created by Quan Li on 2017/7/26.
//  Copyright © 2017年 Quan Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,assign)NSInteger age;
-(void)eatFood;
-(void)drinkMilk;
@end
