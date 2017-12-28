
#import <Foundation/Foundation.h>
#import "SmartWebServiceHandler.h"
#import "Utils.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"

@protocol NetworkManagerDelegate <NSObject>

@optional

typedef void(^onSuccess)(NSURLSessionTask *task, BOOL isSuccess, id responseObject);
typedef void(^onFailure)(NSURLSessionTask *operation, NSError *error);

typedef void(^onSuccessWithFile)(NSURLResponse *task, BOOL isSuccess, id responseObject);
typedef void(^onFailureWithFile)(NSURLResponse *operation, NSError *error);

@end

static id<NetworkManagerDelegate> commnunicationDelegate;

@interface NetworkManager : NSObject <SmartWebServiceDelegate>


+(NetworkManager *)getInstance:(id<NetworkManagerDelegate> )delegate;

-(NetworkManager *)showProgress;
-(void)dismissProgressDialog;

/*
 *
 * Implemented sevice methods
 *
 */
#pragma mark - Login SignUp
#pragma mark -

-(void)callWSForLogin:(NSString *)url withParameters:(NSMutableDictionary *)dicUserData successCallback:(onSuccess)r_success failureCallback:(onFailure)r_failure;

-(void)callWSForGetClientORContacts:(NSString *)url withParameters:(NSMutableDictionary *)dicUserData successCallback:(onSuccess)r_success failureCallback:(onFailure)r_failure;

-(void)callWSForUpdateUserProfile:(NSString *)url withParameters:(NSMutableDictionary *)dicUserData WithData:(NSData *)imgData successCallback:(onSuccessWithFile)r_success failureCallback:(onFailureWithFile)r_failure;


//-(void)callWSForLogOut:(NSString *)url withParameters:(NSMutableDictionary *)dicUserData successCallback:(onSuccess)r_success failureCallback:(onFailure)r_failure;
//
//-(void)callWSForList:(NSString *)url withParameters:(NSMutableDictionary *)dicUserData successCallback:(onSuccess)r_success failureCallback:(onFailure)r_failure;
//
//-(void)callWSForRegister:(NSString *)url withParameters:(NSMutableDictionary *)dicUserData successCallback:(onSuccess)r_success failureCallback:(onFailure)r_failure;
//
//-(void)callWSForRegister:(NSString *)url withParameters:(NSDictionary *)dicUserData withPhoto:(NSData *)data withPath:(NSString *)filePath successCallback:(onSuccessWithFile)r_success failureCallback:(onFailureWithFile)r_failure;;
//
//-(void)callWebService:(NSString *)url withParameters:(NSMutableDictionary *)dicUserData successCallback:(onSuccess)r_success failureCallback:(onFailure)r_failure;

@end
