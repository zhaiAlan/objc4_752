//
//  main.m
//  XZClassAnalyze
//
//  Created by Alan on 3/11/20.
//

#import <Foundation/Foundation.h>
#import "XZPerson.h"
#import <objc/runtime.h>
#import <malloc/malloc.h>


void testObjc_copyIvar(Class pClass){
    
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(pClass, &count);
    for (unsigned int i=0; i < count; i++) {
        Ivar const ivar = ivars[i];
        //获取实例变量名
        const char*cName = ivar_getName(ivar);
        NSString *ivarName = [NSString stringWithUTF8String:cName];
        NSLog(@"class_copyIvarList:%@",ivarName);
    }
  // 切记需要使用完成后需要释放
    free(ivars);

}
void testObjc_copyProperies(Class pClass){
    
    unsigned int pCount = 0;
    objc_property_t *properties = class_copyPropertyList(pClass, &pCount);
    for (unsigned int i=0; i < pCount; i++) {
        objc_property_t const property = properties[i];
        //获取属性名
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        //获取属性值
        NSLog(@"class_copyProperiesList:%@",propertyName);
    }
    // 切记需要使用完成后需要释放
    free(properties);

    
}

void testObjc_copyMethodList(Class pClass){
    unsigned int count = 0;
    Method *methods = class_copyMethodList(pClass, &count);
    for (unsigned int i=0; i < count; i++) {
        Method const method = methods[i];
        //获取方法名
        NSString *key = NSStringFromSelector(method_getName(method));
        
        NSLog(@"Method, name: %@", key);
    }
    // 切记需要使用完成后需要释放
    free(methods);
}
//获取类和元类实例方法：
void testInstanceMethod_classToMetaclass(Class pClass){
    
    const char *className = class_getName(pClass);
    Class metaClass = objc_getMetaClass(className);
    
    Method method1 = class_getInstanceMethod(pClass, @selector(sayHello));
    Method method2 = class_getInstanceMethod(metaClass, @selector(sayHello));

    Method method3 = class_getInstanceMethod(pClass, @selector(sayHappy));
    Method method4 = class_getInstanceMethod(metaClass, @selector(sayHappy));
    
    NSLog(@"%p-%p-%p-%p",method1,method2,method3,method4);
    NSLog(@"%s",__func__);
}
//查看类和元类中类方法查看方法
void testClassMethod_classToMetaclass(Class pClass){
    
    const char *className = class_getName(pClass);
    Class metaClass = objc_getMetaClass(className);
    
    Method method1 = class_getClassMethod(pClass, @selector(sayHello));
    Method method2 = class_getClassMethod(metaClass, @selector(sayHello));

    Method method3 = class_getClassMethod(pClass, @selector(sayHappy));
//    元类中也存在类方法？
    Method method4 = class_getClassMethod(metaClass, @selector(sayHappy));
    
    NSLog(@"%p-%p-%p-%p",method1,method2,method3,method4);
    NSLog(@"%s",__func__);
}

void testIMP_classToMetaclass(Class pClass){
    
    const char *className = class_getName(pClass);
    Class metaClass = objc_getMetaClass(className);

    IMP imp1 = class_getMethodImplementation(pClass, @selector(sayHello));
    IMP imp2 = class_getMethodImplementation(metaClass, @selector(sayHello));

    IMP imp3 = class_getMethodImplementation(pClass, @selector(sayHappy));
    IMP imp4 = class_getMethodImplementation(metaClass, @selector(sayHappy));

    NSLog(@"%p-%p-%p-%p",imp1,imp2,imp3,imp4);
    NSLog(@"%s",__func__);
}



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        //        Class pClass = object_getClass(p1);
        //        testObjc_copyIvar(pClass);
        //        testObjc_copyProperies(pClass);
        //        testObjc_copyMethodList(pClass);
        //        testInstanceMethod_classToMetaclass(pClass);
        //        testClassMethod_classToMetaclass(pClass);
        //        testIMP_classToMetaclass(pClass);
        /***
         struct objc_class : objc_object {
         //    Class ISA;    //8字节
             Class superclass;  //父类  8字节
             cache_t cache; //缓存   结构体所占大小需要看内部定义16字节16字节
             // formerly cache pointer and vtable
             class_data_bits_t bits;    // class_rw_t * plus custom rr/alloc flags

         */
        
        /**
        cache_t 为什么没有  -->第一次没有进行缓存
         // cache_t mask
         // 方法缓存的原理 证明我们需要处理
         // 来一个方法就缓存 - 有一个特殊的处理
        */

        XZPerson *p1 = [[XZPerson alloc] init];
        Class pClass = [XZPerson class];
        [p1 sayHello];
        [p1 sayCat];
        [p1 sayDog];
        [p1 sayPig];

        NSLog(@"%@ --- %@",p1,pClass);
        
    }
    return 0;
}
