//
//  Utils.m
//  


#import "Utils.h"
#import "AppDelegate.h"

static Utils *sharedInstance = nil;

@implementation Utils

+(Utils *)getInstance {
    if(sharedInstance == nil) {
        sharedInstance  = [[Utils alloc] init];
        
    }
    return sharedInstance;
}

#pragma mark - Show/Hide Network Indicatior
#pragma mark -

+ (void)ShowNetworkIndicator:(BOOL)Istrue
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:Istrue];
}


@end
