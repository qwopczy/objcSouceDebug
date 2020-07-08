//
//  main.m
//  objc-debug
//
//  Created by 灏 孙  on 2018/12/6.
//

#import "NSObject+Test.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import <objc/object.h>

/**
 constructor属性表示在main函数执行之前，可以执行一些操作。destructor属性表示在main函数执行之后做一些操作。constructor的执行时机是在所有load方法都执行完之后，才会执行所有constructor属性修饰的函数。

 */

__attribute__((constructor(101))) static void beforeMain1() {//属性后面直接跟优先级。
    NSLog(@"after main 1");
}

__attribute__((constructor(102))) static void beforeMain2() {
    NSLog(@"after main 2");
}
__attribute__((destructor)) static void afterMain() {
    NSLog(@"after main");
}
void defaultFunction() {
     id obj = [NSObject new];
    __strong id obj1 = obj;
    __strong id obj2 = obj;
//    __weak NSObject *p3 = obj;
    
    NSLog(@"%p objc_destroyWeak objc_storeStrong  will",obj);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
/**
 __attribute__ __attribute__是一套编译器指令，被GNU和LLVM编译器所支持，允许对于__attribute__增加一些参数，做一些高级检查和优化。

 __attribute__的语法是，在后面加两个括号，然后写属性列表，属性列表以逗号分隔。在iOS中，很多例如NS_CLASS_AVAILABLE_IOS的宏定义，内部也是通过__attribute__实现的。
__attribute__((attribute1, attribute2));
 
 
 objc_subclassing_restricted属性表示被修饰的类不能被其他类继承，否则会报下面的错误。eg:
 __attribute__((objc_subclassing_restricted))

 
 objc_requires_super属性表示子类必须调用被修饰的方法super，否则报黄色警告。eg:
 - (void)testMethod __attribute__((objc_requires_super));
 
 
 对象关系映射(Object Relational Mapping)，用于面向对象语言中不同系统数据之间的转换。 可以通过对象关系映射来实现JSON转模型，使用比较多的是Mantle、MJExtension、
 */
//        TestObject *object = [[TestObject alloc] init];
//        object.name = @"test";
//        [object release];
        //
        //        NSObject *newobj = [[NSObject alloc] init];
        //        newobj.object = object;
        //        NSLog(@"%@",newobj.object.name);
        ////        object = nil;
        //
        //        [[NSNumber alloc] init];
        //        [[NSDictionary alloc] init];
        //        [[NSArray alloc] init];
        //
        ////        [object testMethod];
        //
        //        NSLog(@"hello world");
        
//         NSObject *p = [[NSObject alloc] init];
//         __weak NSObject *p1 __attribute__((unused)) = p; //unused属性消除这个警告。
        /**
         //        void *context = objc_autoreleasePoolPush();
         context 正是这个哨兵对象的地址
         //                objc_autoreleasePoolPop(context);
         */
//      NSNumber *num =  [[NSNumber alloc] init];
//        defaultFunction();
        NSLog(@"@autoreleasepool before");
        
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        

        @autoreleasepool{
            NSObject *p2 = [[NSObject alloc] init];
            __weak NSObject *p3 __attribute__((unused)) = p2;
            // {}中的代码
            NSLog(@"pop before%@",p2);
            
        }
        
//         [p1 release];
         //        [p release];
         //        __weak NSObject *p2 = p;
        /*
         void (*function) (id self, SEL _cmd);
         
         TestObject *object1 = [[TestObject alloc] init];
         void(*function1)(id, SEL) = (void(*)(id, SEL))class_getMethodImplementation([TestObject class], @selector(testMethod));
         function1(object, @selector(testMethod));
         
         //        testMain();
         NSLog(@"hello world======");
         
         
         IMP function2 = imp_implementationWithBlock(^(id self, NSString *text) { NSLog(@"callback block : %@", text);
         });
         const char *types = sel_getName(@selector(testMethodNew:));
         
         class_replaceMethod([TestObject class], @selector(testMethodNew:), function2, types);
         TestObject *object2 = [TestObject new];
         [object2 testMethodNew:@"lxz"];
         */
         NSLog(@"hello world===");
         
         
        //        Class testClass = objc_allocateClassPair([NSObject class], "TestObject", 0);
        //        BOOL isAdded = class_addIvar(testClass, "password", sizeof(NSString *), log2(sizeof (NSString *)), @encode(NSString *));
        
        
        //        objc_registerClassPair(testClass);
        //        if (isAdded) {
        //        id object = [[testClass alloc] init]; [object setValue:@"lxz" forKey:@"password"];
        //        }
        /*
        
         TestObject *obj = [[TestObject alloc] init];
                id classsuper = [obj superclass];
                id classself = [obj class];
                void* classselfn = (__bridge void *)([obj class]);
                [obj testLog];
                [obj isKindOfClass:[NSArray class]];
                ((void (*)(id, SEL))objc_msgSend)((id)obj, @selector(testLog));
                NSString *string = ((NSString * (*)(id, SEL))objc_msgSend)((id)obj, @selector(description));
                
                //内存管理
                 NSObject *obja = [[NSObject alloc] init];
                
                id  __strong objNew = [[NSObject alloc]init];
                NSLog(@"retain count = %ld",(long)CFGetRetainCount((__bridge CFTypeRef)(objNew)));
                id __weak objcW = objNew;
                NSLog(@"retain count = %ld",(long)CFGetRetainCount((__bridge CFTypeRef)(objNew)));
                id __autoreleasing autoObj = objNew;//__autoreleasing 会注册到 autoreleasePool 池
                
                NSLog(@"retain count = %ld",(long)CFGetRetainCount((__bridge CFTypeRef)(objNew)));
                for(int i=0; i<argc; i++){
                    printf("test ===%s\n", argv[i]);
                }
                BOOL res1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];
                   
                BOOL res2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
                 BOOL res3 = [(id)[TestObject class] isKindOfClass:[TestObject class]];
                BOOL res4 = [(id)[TestObject class] isMemberOfClass:[TestObject class]];
                   NSLog(@"%d %d %d %d", res1, res2, res3, res4);
                
                
                
                id cls = [TestObject class];
                void *objN = &cls;
                void *objClass = (__bridge void *)(cls);
                [(id)CFBridgingRelease(objClass) speak];
                [(__bridge id)objN speak];
                */
//                
//                int double_num_times_asm(int num, int times);
//                int doubleNum1 =  double_num_times_asm(1, 23);
//                NSLog(@"double_num_times_asm == %d",double_num_times_asm(1, 23));
//                run_objc_inspect();
                
                
//                Class newClass = objc_allocateClassPair([NSObject class], "TestClass", 0);
//                objc_registerClassPair(newClass);
        CFRunLoopRun();
    }
    return 0;
}
