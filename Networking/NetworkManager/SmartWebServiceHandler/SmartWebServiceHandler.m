//
//  SmartWebServiceHandler.m
//
//

#import "SmartWebServiceHandler.h"
#import "AFNetworking.h"
#import "NSDictionary+SJSONString.h"
#import "Utils.h"

static id<SmartWebServiceDelegate> smartDelegate;

@implementation SmartWebServiceHandler

+(SmartWebServiceHandler *)getInstance:(id<SmartWebServiceDelegate>)delegate
{
    smartDelegate = delegate;
    static SmartWebServiceHandler *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)startPOSTOperationForAPI:(NSString *)apiType withIsHeaders:(BOOL)isHeader withParams:(NSDictionary *)param success:(sucessCompletionHandler)successHandler failure:(failureCompletionHandler)failureHandler
{
    @try {
       
         [Utils ShowNetworkIndicator:YES];
        NSLog(@"SWH-Request \n [URL : %@] \n %@ : %@", apiType, [[NSURL URLWithString:apiType] lastPathComponent], [param jsonStringWithPrettyPrint:YES]);
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager POST:apiType parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
             [Utils ShowNetworkIndicator:NO];
            NSLog(@"SWH-Response JSON - %@ : %@", [[NSURL URLWithString:apiType] lastPathComponent], responseObject);
            successHandler(task, responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
             [Utils ShowNetworkIndicator:NO];
            NSLog(@"Error: %@", error);
            
            NSString *strMsg;
            
//            if (error.code == kCFURLErrorTimedOut) {
//                strMsg = kRequestTimeOut;
//            }
//            else if (error.code == kCFURLErrorNotConnectedToInternet) {
//                strMsg = kCheckInternet;
//            }
//            else {
//                strMsg = kSomethingWentWrong;
//            }
            
            failureHandler(task, error);
           // kCustomAlertWithParamAndTarget(nil, strMsg, self);
        }];
        
    }
    @catch (NSException *exception) {
        NSLog(@"Exception - %@", [exception debugDescription]);
    }
    @finally {
        
    }
}
- (void)startGETOperationForAPI:(NSString *)apiType withIsHeaders:(BOOL)isHeader withParams:(NSDictionary *)param success:(sucessCompletionHandler)successHandler failure:(failureCompletionHandler)failureHandler
{
    @try {
        
        [Utils ShowNetworkIndicator:YES];
        
        NSLog(@"SWH-Request \n [URL : %@] \n %@ : %@", apiType, [[NSURL URLWithString:apiType] lastPathComponent], [param jsonStringWithPrettyPrint:YES]);
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager GET:apiType parameters:param progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            
            [Utils ShowNetworkIndicator:NO];
            NSLog(@"SWH-Response JSON - %@ : %@", [[NSURL URLWithString:apiType] lastPathComponent], responseObject);
            successHandler(task, responseObject);
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            
            [Utils ShowNetworkIndicator:NO];
            NSLog(@"Error: %@", error);
            
//            NSString *strMsg;
//
//            if (error.code == kCFURLErrorTimedOut) {
//                strMsg = kRequestTimeOut;
//            }
//            else if (error.code == kCFURLErrorNotConnectedToInternet) {
//                strMsg = kCheckInternet;
//            }
//            else {
//                strMsg = kSomethingWentWrong;
//            }
            
            failureHandler(operation, error);
            //kCustomAlertWithParamAndTarget(nil, strMsg, self);
            
        }];
        
    }
    @catch (NSException *exception) {
        NSLog(@"Exception - %@", [exception debugDescription]);
    }
    @finally {
        
    }
}

- (void)startPOSTOperationForFileUpload:(NSString *)apiType Parameter:(NSDictionary *)parameter FileData:(NSData *)fileData success:(sucessWithFileCompletionHandler)successHandler failure :(failureWithFileCompletionHandler)failureHandler
{
    @try {
        
         [Utils ShowNetworkIndicator:YES];

        NSLog(@"SWH-Request \n [URL : %@] \n %@ : %@", apiType, [[NSURL URLWithString:apiType] lastPathComponent], [parameter jsonStringWithPrettyPrint:YES]);
        
        NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:apiType parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            if (fileData != nil) {
                
                [formData appendPartWithFileData:fileData name:@"ProfilePic" fileName:[NSString stringWithFormat:@"%ld.jpg",(long)[[NSDate date] timeIntervalSince1970]] mimeType:@"multipart/form-data"];
            }
        } error:nil];
        
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        NSURLSessionUploadTask *uploadTask;
        uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            if (!error) {
                
                 [Utils ShowNetworkIndicator:NO];
                NSLog(@"SWH-Response JSON - %@ : %@", [[NSURL URLWithString:apiType] lastPathComponent], responseObject);
                successHandler(response, nil, responseObject);
            } else {
                
                 [Utils ShowNetworkIndicator:NO];
                NSLog(@"Error: %@", error);
                
                NSString *strMsg;
                
//                if (error.code == kCFURLErrorTimedOut) {
//                    strMsg = kRequestTimeOut;
//                }
//                else if (error.code == kCFURLErrorNotConnectedToInternet) {
//                    strMsg = kCheckInternet;
//                }
//                else {
//                    strMsg = kSomethingWentWrong;
//                }
                NSError *err = [NSError errorWithDomain:@"some_domain"
                                                   code:100
                                               userInfo:@{
                                                          NSLocalizedDescriptionKey:strMsg
                                                          }];
                failureHandler(response, err);
            }
        }];
        
        [uploadTask resume];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception - %@", [exception debugDescription]);
    }
    @finally {
        
    }
}
@end
