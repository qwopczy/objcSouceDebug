//
//  TestObject.m
//  objc-debug
//
//  Created by 灏 孙  on 2018/12/6.
//

#import "TestObject.h"
#import <objc/objc-sync.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "Sark.h"
@implementation TestObject

+ (void)initialize
{
    if (self == [TestObject class]) {
        NSLog(@"initialize == %@", NSStringFromClass([self class]));
        NSLog(@"%@", NSStringFromClass([super class]));
        // 创建一个新类
        NSString *errClassName = @"CrachClass";//NSStringFromClass([self class]);
        NSString *errSel = NSStringFromSelector("aSelector");
        
        NSLog(@"*** Crash Message: +[%@ %@]: unrecognized selector sent to class %p ***",errClassName, errSel, self);
        
        
        NSString *className = @"CrachClass";
        Class cls = NSClassFromString(className);
        
        // 如果类不存在 动态创建一个类
        if (!cls) {
            Class superClsss = [NSObject class];
            cls = objc_allocateClassPair(superClsss, className.UTF8String, 0);
            // 注册类
            objc_registerClassPair(cls);
        }
        // 如果类没有对应的方法，则动态添加一个
        if (!class_getInstanceMethod(NSClassFromString(className),  @selector(Crash))) {
            class_addMethod(cls, @selector(Crash), (IMP)Crash, "@@:@");
            

            id myobjc = ((id (*)(id, SEL))objc_msgSend)((id) cls, @selector(alloc));

            myobjc = ((id (*)(id, SEL))objc_msgSend)((id) myobjc, @selector(init));
            ((void (*)(id, SEL))objc_msgSend)((id) myobjc, @selector(Crash));

            

            
        }
    }
}
// 动态添加的方法实现
static int Crash(id slf, SEL selector) {
    NSLog(@"转发成功 Crash selector");

    return 0;
}
- (id)init
{
    self = [super init];
    if (self)
    {
        NSLog(@"init %@", NSStringFromClass([self class]));
        NSLog(@"%@", NSStringFromClass([super class]));
    }

    return self;
}

//- (void)dealloc {
//    [super dealloc];
//}

- (void)testMethod {
    NSLog(@"TestObject -testMethod");
    NSLog(@"[self class] %@", NSStringFromClass([self class]));
    NSLog(@"[super class] %@", NSStringFromClass([super class]));
}
- (void)testMethodNew:(NSString *)text {

    NSLog(@"testMethod : %@", text);
    
}

- (void)speak {
    NSLog(@"TestObject = %@ , 地址 = %p", self, &self);
       
       id cls = [Sark class];
       NSLog(@"Sark class = %@ 地址 = %p", cls, &cls);
       
       void *obj = &cls;
       NSLog(@"Void *obj = %@ 地址 = %p", obj,&obj);
       
       [(__bridge id)obj speak];
       
       Sark *sark = [[Sark alloc]init];
       NSLog(@"Sark instance = %@ 地址 = %p",sark,&sark);
       
       [sark speak];
//    NSLog(@"instance my name's %@", self.name);
}
+ (void)speak {
    NSLog(@"class my name's %@", @"class ");
}
- (void)testLog {
    NSLog(@"testLog==");
    NSLog(@"%@",[super class]);
    NSLog(@"%@",[self class]);
    [self injected];
}
-(void)injected{
    NSLog(@"I've been injected: %@", self);
}
@end
