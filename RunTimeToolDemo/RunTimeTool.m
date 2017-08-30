//
//  RunTimeTool.m
//  runtime运行时
//
//  Created by Quan Li on 2017/8/29.
//  Copyright © 2017年 Azuo. All rights reserved.
//

#import "RunTimeTool.h"
#import <objc/runtime.h>
@implementation RunTimeTool
+(NSArray*)getAllVariableFromObject:(NSString *)objectName{

    
    NSMutableArray *array = [NSMutableArray array];
    
    Class className  = NSClassFromString(objectName);
    
    unsigned int  count;
    Ivar *allVar = class_copyIvarList(className, &count);
    
    for (int i = 0; i < count; i++) {
        Ivar ivar = allVar[i];
        const char * varName = ivar_getName(ivar);
        const char *varType = ivar_getTypeEncoding(ivar);
        [array addObject:@{@"name":[NSString stringWithUTF8String:varName],@"type":[NSString stringWithUTF8String:varType]}];
    }
    
    free(allVar);
    
    return array;
}

/*属性类型  name值：T  value：变化
 编码类型  name值：C(copy) &(strong) W(weak) 空(assign) 等 value：无
 非/原子性 name值：空(atomic) N(Nonatomic)  value：无
 变量名称  name值：V  value：变化
 。*/
+(NSArray *)getPropertyFromObject:(NSString *)objectName{
    NSMutableArray *array = [NSMutableArray array];

    Class className  = NSClassFromString(objectName);


    unsigned int  count;

    objc_property_t *propertyList = class_copyPropertyList(className,&count);

    for (unsigned int i = 0; i< count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSString *name = [NSString stringWithUTF8String:propertyName];
        
        const char *propertyDesc = property_getAttributes(propertyList[i]);
        NSString *type = [NSString stringWithUTF8String:propertyDesc];
        
        //属性的特性
//        unsigned int attrCount = 0;
//        objc_property_attribute_t * attrs = property_copyAttributeList(propertyList[i], &attrCount);
//        for (unsigned int j = 0; j < attrCount; j ++) {
//            objc_property_attribute_t attr = attrs[j];
//            const char * name = attr.name;
//            const char * value = attr.value;
//            NSLog(@"属性的描述：%s 值：%s", name, value);
//        }
  
        [array addObject:@{@"name":name,@"type":type}];
    }
    free(propertyList);
    return array;
}

+(NSArray *)getMethodNameFromObject:(NSString *)objectName{
    
    NSMutableArray *array = [NSMutableArray array];
   
    Class className = NSClassFromString(objectName);
    unsigned int count;
    
    Method *methodList = class_copyMethodList(className, &count);
    
    for (int i = 0; i < count; i++) {
        Method method = methodList[i];
        
        SEL name = method_getName(method);
        NSString *methodName = NSStringFromSelector(name);
        [array addObject:methodName];
    }
    
    
    return array;
}

+(BOOL)executeMethodWithObject:(NSString *)objectName andMethodName:(NSString *)methodName{
    
    Class className = NSClassFromString(objectName);
    
    NSObject *object = [[className alloc]init];
    
    unsigned int count;
    
    Method *methodList  = class_copyMethodList(className, &count);
    
    for (int i = 0;i < count;i++) {
        Method method  =  methodList[i];
        
        SEL selector = method_getName(method);
        NSString *selectorStr = NSStringFromSelector(selector);
        if ([selectorStr isEqualToString:methodName]) {
            if ([object respondsToSelector:selector]) {
                [object performSelector:selector];
            }
            free(methodList);
            return YES;
        }
    }
    free(methodList);
    return NO;
}


+(void)addProtertyWithObject:(id)object andPropertyName:(NSString *)propertyName andValue:(NSString *)value{
    
    Class className = [object class];
    
    unsigned int count;
    
    objc_property_t *propertyList = class_copyPropertyList(className, &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        if ([name isEqualToString:propertyName]) {
            free(propertyList);
            return;
        }
    }
    
    const char *charName = [propertyName cStringUsingEncoding:NSASCIIStringEncoding];
    
    objc_setAssociatedObject(object, charName, value, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    free(propertyList);
}
+(id)getProtertyWithObject:(id)object andPropertyName:(NSString *)propertyName{
    
    Class className = [object class];
    
    unsigned int count;
    
    objc_property_t *propertyList = class_copyPropertyList(className, &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t proterty = propertyList[i];
        NSString *name  =  [NSString stringWithUTF8String:property_getName(proterty)];
        if ([name isEqualToString:propertyName]){
            free(propertyList);
            return objc_getAssociatedObject(object, [propertyName cStringUsingEncoding:NSASCIIStringEncoding]);
        }
    }
    free(propertyList);
    return nil;
}

@end
