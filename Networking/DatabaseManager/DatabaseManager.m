//
//  DatabaseManager.m
//

#import "DatabaseManager.h"

static DatabaseManager *instance = nil;

@implementation DatabaseManager

+(DatabaseManager *)getInstance{
    
    if (!instance) {
        
        instance = [[DatabaseManager alloc]init];
        instance.database = [FMDatabase databaseWithPath:[self getFilePath:@"UserDetail.sqlite"]];
    }
    return instance;
}

#pragma mark - set LocalDatabase Path

+(NSString *)getFilePath :(NSString *)fileName{
    
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:fileName];
}

#pragma mark - Copy DataBase

+(void)copyFile:(NSString *)file{
    
    NSString *toPath = [self getFilePath:file];
    NSLog(@"toPath :- %@",toPath);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:toPath]) {
        
        NSString *fromPath = [[NSBundle mainBundle]pathForResource:@"UserDetail" ofType:@"sqlite"];
        [fileManager copyItemAtPath:fromPath toPath:toPath error:nil];
    }
}

#pragma mark - InsertLogin


#pragma mark - INSERT Queries Clients
#pragma mark -

//-(void)insertinclients:(Client *)objClients
//{
//    [instance.database open];
//
//    @try {
//        NSString *insQuery =[NSString stringWithFormat:@"Insert into inclients(Id,ClientName,Logo,CustomerSince,AboutCompany,Address,CountryId,CountryName,RevenueYrToDate,Assets,Latitude,Longitude,CreatedDate,CreatedBy,ModifiedDate,ModifiedBy,IsActive) values('%d','%@','%@','%@','%@','%@','%d','%@','%f','%f','%f','%f','%@','%d','%@','%d','%d')",
//                             (int)objClients.internalBaseClassIdentifier,
//                             EMPTYSTR_IFNULL(objClients.clientName),
//                             EMPTYSTR_IFNULL(objClients.logo),
//                             EMPTYSTR_IFNULL(objClients.customerSince),
//                             EMPTYSTR_IFNULL(objClients.aboutCompany),
//                             EMPTYSTR_IFNULL(objClients.address),
//                             (int)objClients.countryId,
//                             EMPTYSTR_IFNULL(objClients.countryName),
//                             objClients.revenueYrToDate,
//                             objClients.assets,
//                             objClients.latitude,
//                             objClients.longitude,
//                             EMPTYSTR_IFNULL(objClients.createdDate),
//                             (int)objClients.createdBy,
//                             EMPTYSTR_IFNULL(objClients.modifiedDate),
//                             (int)objClients.modifiedBy,
//                             (int)objClients.isActive];
//
//        BOOL isInserted = [instance.database executeUpdate:insQuery];
//        [instance.database close];
//
//        if (isInserted) {
//
//        }
//        else{
//
//            NSLog(@"Error occured while inserting");
//        }
//    }
//    @catch (NSException *exception) {
//    }
//    @finally {
//    }
//}
//
//-(NSMutableArray *)getClients
//{
//    [instance.database open];
//
//    NSMutableArray *arrClient = [[NSMutableArray alloc] init];
//
//    FMResultSet *resultSet=[instance.database executeQuery:@"SELECT * FROM inclients"];
//    if(resultSet)
//    {
//        while([resultSet next])
//        {
//            Client *objClient = [[Client alloc]initWithDictionary:[resultSet resultDictionary]];
//            [arrClient addObject:objClient];
//        }
//    }
//    [instance.database close];
//    return arrClient;
//}
//
//-(NSMutableArray *)getSingleClientsWithId:(int)clientId
//{
//    [instance.database open];
//
//    NSMutableArray *arrClient = [[NSMutableArray alloc] init];
//
//    FMResultSet *resultSet=[instance.database executeQuery:[NSString stringWithFormat:@"SELECT * FROM inclients where Id= '%d'",clientId]];
//    if(resultSet)
//    {
//        while([resultSet next])
//        {
//            Client  *objClient = [[Client alloc]initWithDictionary:[resultSet resultDictionary]];
//            [arrClient addObject:objClient];
//        }
//    }
//    [instance.database close];
//    return arrClient;
//}
//
//-(void)deleteClients
//{
//    [instance.database open];
//
//    NSString *insQuery =[NSString stringWithFormat:@"delete from inclients"];
//
//    BOOL isInserted = [instance.database executeUpdate:insQuery];
//    [instance.database close];
//
//    if (isInserted) {
//
//        NSLog(@"Deleted Successfully");
//    }
//    else{
//
//        NSLog(@"Error occured while inserting");
//    }
//}

@end
