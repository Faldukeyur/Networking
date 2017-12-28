
#import "NetworkManager.h"

@implementation NetworkManager
{
    
}

static NetworkManager *instance = nil;
UIWindow *window;

+(NetworkManager *)getInstance:(id<NetworkManagerDelegate> )delegate
{
    if(delegate == nil)
    {
        return nil;
    }
    commnunicationDelegate = delegate;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        window = [[[UIApplication sharedApplication] windows] lastObject];
        
    });
    return instance;
}

-(NetworkManager *)showProgress
{
    if(commnunicationDelegate != nil)
    {
        @autoreleasepool {
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
            hud.activityIndicatorColor = [UIColor redColor];
        
            return [NetworkManager getInstance:commnunicationDelegate];
        }
    }
    return nil;
}

-(void)dismissProgressDialog
{
    @autoreleasepool {
        [MBProgressHUD hideHUDForView:window animated:YES];
    }
}

/*
 *
 * Implemented sevice methods
 *
 */
-(void)callWSForLogin:(NSString *)url withParameters:(NSMutableDictionary *)dicUserData successCallback:(onSuccess)r_success failureCallback:(onFailure)r_failure
{
    [[SmartWebServiceHandler getInstance:self] startPOSTOperationForAPI:[NSString stringWithFormat:@"%@%@",@"",url] withIsHeaders:NO withParams:dicUserData success:^(NSURLSessionTask *task, id responseObject) {
        
        [self dismissProgressDialog];
        
        if(responseObject != nil) {
            r_success(task ,TRUE ,responseObject);
        } else {
            r_success(task ,FALSE ,responseObject);
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        [self dismissProgressDialog];
        
        r_failure(operation,error);
    }];
}

-(void)callWSForGetClientORContacts:(NSString *)url withParameters:(NSMutableDictionary *)dicUserData successCallback:(onSuccess)r_success failureCallback:(onFailure)r_failure
{
    [[SmartWebServiceHandler getInstance:self] startGETOperationForAPI:[NSString stringWithFormat:@"%@%@",@"",@""] withIsHeaders:NO withParams:dicUserData success:^(NSURLSessionTask *task, id responseObject) {

        [self dismissProgressDialog];

        if(responseObject != nil) {
            r_success(task ,TRUE ,responseObject);
        } else {
            r_success(task ,FALSE ,responseObject);
        }

    } failure:^(NSURLSessionTask *operation, NSError *error) {

        [self dismissProgressDialog];

        r_failure(operation,error);
    }];
}

-(void)callWSForUpdateUserProfile:(NSString *)url withParameters:(NSMutableDictionary *)dicUserData WithData:(NSData *)imgData successCallback:(onSuccessWithFile)r_success failureCallback:(onFailureWithFile)r_failure{
    
    [[SmartWebServiceHandler getInstance:self] startPOSTOperationForFileUpload:[NSString stringWithFormat:@"%@%@",@"",@""] Parameter:dicUserData FileData:imgData success:^(NSURLResponse *task, NSURL *filePath, id responseObject) {
        [self dismissProgressDialog];
        
        if(responseObject != nil) {
            r_success(task ,TRUE ,responseObject);
        } else {
            r_success(task ,FALSE ,responseObject);
        }
    } failure:^(NSURLResponse *operation, NSError *error) {
        
        [self dismissProgressDialog];
        
        r_failure(operation,error);
    }];
}



//-(void)callWSForList:(NSString *)url withParameters:(NSMutableDictionary *)dicUserData successCallback:(onSuccess)r_success failureCallback:(onFailure)r_failure
//{
//    [[SmartWebServiceHandler getInstance:self] startGETOperationForAPI:[NSString stringWithFormat:@"%@%@",kBaseApiUrl,url] withIsHeaders:YES withParams:dicUserData success:^(NSURLSessionTask *task, id responseObject) {
//
//        [self dismissProgressDialog];
//
//        if(responseObject != nil) {
//            r_success(task ,TRUE ,responseObject);
//        } else {
//            r_success(task ,FALSE ,responseObject);
//        }
//
//    } failure:^(NSURLSessionTask *operation, NSError *error) {
//
//        [self dismissProgressDialog];
//
//        r_failure(operation,error);
//    }];
//}
//-(void)callWSForRegister:(NSString *)url withParameters:(NSMutableDictionary *)dicUserData successCallback:(onSuccess)r_success failureCallback:(onFailure)r_failure
//{
//    [[SmartWebServiceHandler getInstance:self] startPOSTOperationForAPI:[NSString stringWithFormat:@"%@%@",kBaseApiUrl,url] withIsHeaders:NO withParams:dicUserData success:^(NSURLSessionTask *task, id responseObject) {
//
//        [self dismissProgressDialog];
//
//        if(responseObject != nil) {
//            r_success(task ,TRUE ,responseObject);
//        } else {
//            r_success(task ,FALSE ,responseObject);
//        }
//
//    } failure:^(NSURLSessionTask *operation, NSError *error) {
//
//        [self dismissProgressDialog];
//
//        r_failure(operation,error);
//    }];
//}
//-(void)callWSForRegister:(NSString *)url withParameters:(NSDictionary *)dicUserData withPhoto:(NSData *)data withPath:(NSString *)filePath successCallback:(onSuccessWithFile)r_success failureCallback:(onFailureWithFile)r_failure;
//{
//    [[SmartWebServiceHandler getInstance:self] startPOSTOperationForFileUpload:[NSString stringWithFormat:@"%@%@",kBaseApiUrl,url] withIsHeaders:YES FileName:filePath MimeType:@"image/jpeg" Parameter:dicUserData FileData:data FileParamName:@"image_name" success:^(NSURLResponse *task, NSURL *filePath, id responseObject) {
//
//        [self dismissProgressDialog];
//
//        if(responseObject != nil) {
//            r_success(task ,TRUE ,responseObject);
//        } else {
//            r_success(task ,FALSE ,responseObject);
//        }
//
//    } failure:^(NSURLResponse *operation, NSError *error) {
//
//        [self dismissProgressDialog];
//
//        r_failure(operation,error);
//
//    }];
//}
//
//-(void)callWebService:(NSString *)url withParameters:(NSMutableDictionary *)dicUserData successCallback:(onSuccess)r_success failureCallback:(onFailure)r_failure
//{
//    [[SmartWebServiceHandler getInstance:self] startPOSTOperationForAPI:[NSString stringWithFormat:@"%@%@",kBaseApiUrl,url] withIsHeaders:YES withParams:dicUserData success:^(NSURLSessionTask *task, id responseObject) {
//
//        [self dismissProgressDialog];
//
//        if(responseObject != nil) {
//            r_success(task ,TRUE ,responseObject);
//        } else {
//            r_success(task ,FALSE ,responseObject);
//        }
//
//    } failure:^(NSURLSessionTask *operation, NSError *error) {
//
//        [self dismissProgressDialog];
//
//        r_failure(operation,error);
//    }];
//}
@end
