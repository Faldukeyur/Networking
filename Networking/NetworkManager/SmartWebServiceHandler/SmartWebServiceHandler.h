//
//  SmartWebServiceHandler.h
//
//


#import <Foundation/Foundation.h>

//#import "Reachability.h"

@protocol SmartWebServiceDelegate <NSObject>

typedef void(^sucessCompletionHandler)(NSURLSessionTask *task, id responseObject);
typedef void(^sucessWithFileCompletionHandler)(NSURLResponse *task, NSURL *filePath, id responseObject);

typedef void(^failureCompletionHandler)(NSURLSessionTask *operation, NSError *error);
typedef void(^failureWithFileCompletionHandler)(NSURLResponse *operation, NSError *error);

@end

@interface SmartWebServiceHandler : NSObject
{
    BOOL _isNetAvailable;
}

+ (SmartWebServiceHandler *)getInstance:(id<SmartWebServiceDelegate>)delegate;


- (void)startPOSTOperationForAPI:(NSString *)apiType withIsHeaders:(BOOL)isHeader withParams:(NSDictionary *)param success:(sucessCompletionHandler)successHandler failure:(failureCompletionHandler)failureHandler;

- (void)startPOSTOperationForFileUpload:(NSString *)apiType Parameter:(NSDictionary *)parameter FileData:(NSData *)fileData success:(sucessWithFileCompletionHandler)successHandler failure :(failureWithFileCompletionHandler)failureHandler;

- (void)startGETOperationForAPI:(NSString *)apiType withIsHeaders:(BOOL)isHeader withParams:(NSDictionary *)param success:(sucessCompletionHandler)successHandler failure:(failureCompletionHandler)failureHandler;


@end
