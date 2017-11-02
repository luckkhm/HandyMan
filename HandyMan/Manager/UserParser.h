//
//  UserParser.h
//  heyy
//
//  Created by Ahmed Khemiri on 11/24/16.
//  Copyright © 2016 iMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserParser : NSObject

@property(weak,nonatomic) NSDictionary *jsonSocialMesiaAccounts;
@property(strong,nonatomic) NSDictionary *jsonUser;
@property(weak,nonatomic) NSDictionary *jsonEmails;
@property(weak,nonatomic) NSDictionary *jsonPhones;

+ (void)saveUserInLocalWith:(NSDictionary*)user;

+ (void)logInWithResult:(NSDictionary *)parameters didFinish:(void (^)(bool succes,NSDictionary *result,NSError *error))isGet;
+ (void)signUpWithResult:(NSDictionary *)parameters didFinish:(void (^)(bool succes,NSDictionary *result,NSError *error))isGet;
+ (void)signInWithResult:(NSDictionary *)parameters didFinish:(void (^)(bool succes,NSDictionary *result,NSError *error))isGet;
+ (void)logOutDidFinish:(void (^)(bool succes,NSDictionary *result,NSError *error))isGet;
+ (void)updateUser:(NSDictionary *)parameters didFinish:(void (^)(bool succes,NSDictionary *result,NSError *error))isGet;
+ (void)updateScore:(NSDictionary *)score didFinish:(void (^)(bool succes,NSDictionary *result,NSError *error))isGet;
+ (void)uploadImageProfile:(NSData *)imageData didFinish:(void (^)(bool succes,NSDictionary *result,NSError *error))isGet;
+ (void)sendMail:(NSDictionary *)parameters didFinish:(void (^)(bool succes,NSDictionary *result,NSError *error))isGet;

@end
