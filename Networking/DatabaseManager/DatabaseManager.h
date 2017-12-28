//
//  DatabaseManager.h
// 


#import <Foundation/Foundation.h>

#import "FMDatabase.h"

@interface DatabaseManager : NSObject

@property (nonatomic,strong)FMDatabase *database;

+(DatabaseManager *)getInstance;
+(void)copyFile:(NSString *)file;
+(NSString *)getFilePath :(NSString *)fileName;

//-(void)insertLoginUser:(LoginUser *)objUser;
//-(NSMutableDictionary *)getLoginUser;
//-(void)deleteuser;

@end
