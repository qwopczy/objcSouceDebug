//
//  TestObject.h
//  objc-debug
//
//  Created by 灏 孙  on 2018/12/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestObject : NSObject
@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSDictionary *data;

- (void)testLog;
- (void)speak;
- (void)testMethodNew:(NSString *)text;
@end

NS_ASSUME_NONNULL_END
