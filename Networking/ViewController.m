//
//  ViewController.m
//  Networking
//

#import "ViewController.h"
#import "NetworkManager.h"

@interface ViewController ()<NetworkManagerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self callWSForLogin];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Call Web-Service
#pragma mark -

- (void)callWSForLogin
{
    NSMutableDictionary *postDataDict = [[NSMutableDictionary alloc]init];
    [postDataDict setObject:@"" forKey:@""];
    [postDataDict setObject:@"" forKey:@""];
    
    [[[NetworkManager getInstance:self] showProgress] callWSForLogin:@"" withParameters:postDataDict successCallback:^(NSURLSessionTask *task, BOOL isSuccess, id responseObject) {
        
        if ([[responseObject valueForKey:@"Status"] isEqualToString:@"Success"]) {
            
            NSMutableDictionary *dicresponse = [responseObject valueForKey:@"Data"];
            NSLog(@"%@",dicresponse);
            
            
        }else{
            
           // kCustomToast([responseObject valueForKey:@"Message"])
        }
    } failureCallback:^(NSURLSessionTask *operation, NSError *error) {
        
    }];
}
@end
