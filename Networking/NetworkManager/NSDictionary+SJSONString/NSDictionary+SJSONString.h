//
//  NSDictionary+SJSONString.h
//
//
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SJSONString)
- (NSString*)jsonStringWithPrettyPrint:(BOOL)prettyPrint;
@end
