//
//  UserParser.m
//  heyy
//
//  Created by Ahmed Khemiri on 11/24/16.
//  Copyright © 2016 iMac. All rights reserved.
//

#import "UserParser.h"
#import "WebServices.h"

@implementation UserParser

+(NSDictionary *)headersFields{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary *headers = @{ @"content-type": @"application/json",
                               @"x-access-token": [SUtilities stringIsNilOrEmpty:[userDefault valueForKey:@"token"]]?@"":[userDefault valueForKey:@"token"],
                               @"x-access-device-id": [SUtilities getUDID],
                               @"x-access-user-id":[SUtilities stringIsNilOrEmpty:[userDefault valueForKey:@"user_id"]]?@"":[userDefault valueForKey:@"user_id"]};
    return headers;
}

+(NSMutableURLRequest *)requestWithUrl:(NSURL *)url timeoutInterval:(NSTimeInterval)timeOut setHTTPMethod:(NSString *)method withParamHeaderFields:(NSDictionary *)headerFields andBody:(NSData *) body{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:timeOut];
    
    [request setHTTPMethod:method];
    if (headerFields != nil) {
        [request setAllHTTPHeaderFields:headerFields];
    }
    if (body != nil) {
        [request setHTTPBody:body];
    }
    return request;
}
+(void)parserWebServiceWithRequest:(NSMutableURLRequest *)request getFinish:(void (^)(bool succes,NSDictionary *result,NSError *error))isGet{
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            @autoreleasepool {
                NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *) response;
                id jsonObjects = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                switch (httpResp.statusCode) {
                    case 200:{
                        isGet(true,jsonObjects,nil);
                    }
                        break;
                    case 404:
                        isGet(false,(NSDictionary *)@"Are you connected? Check your network and try again.",nil);
                        break;
                    default:
                        isGet(false,(NSDictionary *)@"Check your info and try again",nil);
                        break;
                }
            }
        }
        else {
            isGet(false,(NSDictionary *)@"Check your info and try again",error);
        }
    }] resume];
    
}

+ (void)logOutDidFinish:(void (^)(bool succes,NSDictionary *result,NSError *error))isGet{
    if (![SUtilities isInternetReachable]) {
        NSError *error;
        isGet(false,(NSDictionary *)@"Check your internet connection !",error);
    }
    else{
        NSMutableURLRequest *request = [self requestWithUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",API_URL,LOG_OUT]] timeoutInterval:TIME_OUT_CONNECTION setHTTPMethod:@"POST" withParamHeaderFields:[self headersFields] andBody:nil];
        
#if DEBUG
        NSLog(@"Start logOutDidFinish");
#endif
        
        [self parserWebServiceWithRequest:request getFinish:^(bool succes, NSDictionary *result, NSError *error) {
            if (succes) {
                isGet(true,result,nil);
            }
            else{
                isGet(false,result,error);
            }
        }];
        
    }
    
}


+ (void)signUpWithResult:(NSDictionary *)parameters didFinish:(void (^)(bool succes,NSDictionary *result,NSError *error))isGet{
    if (![SUtilities isInternetReachable]) {
        NSError *error;
        isGet(false,(NSDictionary *)@"Check your internet connection !",error);
    }
    else{
        NSDictionary *headers = @{ @"content-type": @"application/json"};
        NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
        NSMutableURLRequest *request = [self requestWithUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",API_URL,SIGN_UP]] timeoutInterval:TIME_OUT_CONNECTION setHTTPMethod:@"POST" withParamHeaderFields:headers andBody:postData];
        
#if DEBUG
        NSLog(@"Start signUpWithResult");
#endif
        
        [self parserWebServiceWithRequest:request getFinish:^(bool succes, NSDictionary *result, NSError *error) {
            if (succes) {
                NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                [userDefault setObject:[result objectForKey:@"token"] forKey:@"token"];
                [userDefault setObject:[[result objectForKey:@"user"] objectForKey:@"_id"] forKey:@"user_id"];
                [userDefault synchronize];
                isGet(true,[result objectForKey:@"user"],nil);
            }
            else{
                isGet(false,result,error);
            }
        }];
        
    }
    
}

+ (void)logInWithResult:(NSDictionary *)parameters didFinish:(void (^)(bool succes,NSDictionary *result,NSError *error))isGet{
    if (![SUtilities isInternetReachable]) {
        NSError *error;
        isGet(false,(NSDictionary *)@"Check your internet connection !",error);
    }
    else{
        
        NSDictionary *headers = @{ @"content-type": @"application/json"};
        NSData *jsonParamData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
        
        NSMutableURLRequest *request = [self requestWithUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",API_URL,SIGN_IN_NATIVE]] timeoutInterval:TIME_OUT_CONNECTION setHTTPMethod:@"POST" withParamHeaderFields:headers andBody:jsonParamData];
#if DEBUG
        NSLog(@"Start logInWithResult");
#endif
        [self parserWebServiceWithRequest:request getFinish:^(bool succes, NSDictionary *result, NSError *error) {
            if (succes) {
                isGet(true,[result objectForKey:@"user"],nil);
                NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                [userDefault setObject:[result objectForKey:@"token"] forKey:@"token"];
                [userDefault setObject:[[result objectForKey:@"user"] objectForKey:@"_id"] forKey:@"user_id"];
                [userDefault synchronize];
                [self saveUserInLocalWith:[result objectForKey:@"user"]];
            }
            else{
                isGet(false,result,error);
            }
        }];
    }
}

+ (void)signInWithResult:(NSDictionary *)parameters didFinish:(void (^)(bool succes,NSDictionary *result,NSError *error))isGet{
    if (![SUtilities isInternetReachable]) {
        NSError *error;
        isGet(false,(NSDictionary *)@"Check your internet connection !",error);
    }
    else{
        
        NSDictionary *headers = @{ @"content-type": @"application/json"};
        NSData *jsonParamData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
        NSMutableURLRequest *request = [self requestWithUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",API_URL,SIGN_IN_SOCIAL]] timeoutInterval:TIME_OUT_CONNECTION setHTTPMethod:@"POST" withParamHeaderFields:headers andBody:jsonParamData];
        
#if DEBUG
        NSLog(@"Start signInWithResult");
#endif
        [self parserWebServiceWithRequest:request getFinish:^(bool succes, NSDictionary *result, NSError *error) {
            if (succes) {
                NSLog(@"jsonObjectsjsonObjects %@",result);
                if ([result count] > 1) {
                    NSLog(@"isExist");
                    isGet(true,result,nil);
                    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                    [userDefault setObject:[result objectForKey:@"token"] forKey:@"token"];
                    [userDefault setObject:[[result objectForKey:@"user"] objectForKey:@"_id"] forKey:@"user_id"];
                    [userDefault synchronize];
                    [self saveUserInLocalWith:[result objectForKey:@"user"]];
                }
                else{
                    isGet(true,result,nil);
                }
            }
            else{
                isGet(false,result,error);
            }
        }];
    }
}

+ (void)updateUser:(NSDictionary *)parameters didFinish:(void (^)(bool succes,NSDictionary *result,NSError *error))isGet{
    if (![SUtilities isInternetReachable]) {
        NSError *error;
        isGet(false,(NSDictionary *)@"Check your internet connection !",error);
    }
    else{
        NSData *jsonUserData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
        NSMutableURLRequest *request = [self requestWithUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",API_URL,UPDATE_PROFILE]] timeoutInterval:TIME_OUT_CONNECTION setHTTPMethod:@"PUT" withParamHeaderFields:[self headersFields] andBody:jsonUserData];
#if DEBUG
        NSLog(@"Start updateUser");
#endif
        
        [self parserWebServiceWithRequest:request getFinish:^(bool succes, NSDictionary *result, NSError *error) {
            if (succes) {
                isGet(true,result,nil);
            }
            else{
                isGet(false,result,error);
            }
        }];
    }
}
+ (void)sendMail:(NSDictionary *)parameters didFinish:(void (^)(bool succes,NSDictionary *result,NSError *error))isGet{
    if (![SUtilities isInternetReachable]) {
        NSError *error;
        isGet(false,(NSDictionary *)@"Check your internet connection !",error);
    }
    else{
        NSData *jsonMailData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
        NSMutableURLRequest *request = [self requestWithUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",API_URL,SEND_VIA_EMAIL]] timeoutInterval:TIME_OUT_CONNECTION setHTTPMethod:@"POST" withParamHeaderFields:[self headersFields] andBody:jsonMailData];
#if DEBUG
        NSLog(@"Start sendMail");
#endif
        
        [self parserWebServiceWithRequest:request getFinish:^(bool succes, NSDictionary *result, NSError *error) {
            if (succes) {
                isGet(true,result,nil);
            }
            else{
                isGet(false,result,error);
            }
        }];
    }
}

+ (void)updateScore:(NSDictionary *)score didFinish:(void (^)(bool succes,NSDictionary *result,NSError *error))isGet{
    if (![SUtilities isInternetReachable]) {
        NSError *error;
        isGet(false,(NSDictionary *)@"Check your internet connection !",error);
    }
    else{
        NSData *jsonMailData = [NSJSONSerialization dataWithJSONObject:score options:NSJSONWritingPrettyPrinted error:nil];
        NSMutableURLRequest *request = [self requestWithUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",API_URL,UPDATE_SCORE]] timeoutInterval:TIME_OUT_CONNECTION setHTTPMethod:@"PUT" withParamHeaderFields:[self headersFields] andBody:jsonMailData];
        
#if DEBUG
        NSLog(@"Start updateScore");
#endif
        [self parserWebServiceWithRequest:request getFinish:^(bool succes, NSDictionary *result, NSError *error) {
            if (succes) {
                isGet(true,result,nil);
            }
            else{
                isGet(false,result,error);
            }
        }];
    }
}

+ (void)uploadImageProfile:(NSData *)imageData didFinish:(void (^)(bool succes,NSDictionary *result,NSError *error))isGet{
    if (![SUtilities isInternetReachable]) {
        NSError *error;
        isGet(false,(NSDictionary *)@"Check your internet connection !",error);
    }
    else{
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",API_URL,UPLOAD_IMAGE]]
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:120.0];
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSDictionary *headers = @{@"x-access-token": [SUtilities stringIsNilOrEmpty:[userDefault valueForKey:@"token"]]?@"":[userDefault valueForKey:@"token"],
                                  @"x-access-device-id": [SUtilities getUDID],
                                  @"x-access-user-id":[SUtilities stringIsNilOrEmpty:[userDefault valueForKey:@"user_id"]]?@"":[userDefault valueForKey:@"user_id"]};
        
        NSMutableData *body = [NSMutableData data];
        NSString *BoundaryConstant = @"----------V2ymHFg03ehbqgZCaKO6jy";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", BoundaryConstant];
        [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
        NSLog(@"imageDataimageData %@ %@ %@",[userDefault valueForKey:@"token"],[SUtilities getUDID],[userDefault valueForKey:@"user_id"]);
        if (imageData) {
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"profile.jpg\"\r\n", @""] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:imageData];
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            NSLog(@"jsonObjects UpdateImage av in  ");
        }
        [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [request setHTTPMethod:@"POST"];
        [request setAllHTTPHeaderFields:headers];
        [request setHTTPBody:body];
        
#if DEBUG
        NSLog(@"Start uploadImageProfile");
#endif
        NSURLSession *session = [NSURLSession sharedSession];
        [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (!error) {
                @autoreleasepool {
                    NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *) response;
                    id jsonObjects = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    
                    switch (httpResp.statusCode) {
                        case 200:{
                            isGet(true,jsonObjects,nil);
                            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                            [userDefault setObject:[jsonObjects objectForKey:@"profileImage"] forKey:@"urlImageP"];
                            [userDefault synchronize];
                            
                        }
                            break;
                        case 404:
                            isGet(false,[SUtilities stringIsNilOrEmpty:[[jsonObjects objectForKey:@"error"] objectForKey:@"message"]]?(NSDictionary *)httpResp:[[jsonObjects objectForKey:@"error"] objectForKey:@"message"],nil);
                            break;
                            
                        default:
                            isGet(false,[SUtilities stringIsNilOrEmpty:[[jsonObjects objectForKey:@"error"] objectForKey:@"message"]]?jsonObjects:[[jsonObjects objectForKey:@"error"] objectForKey:@"message"],nil);
                            break;
                    }
                }
            }
            else {
                isGet(false,(NSDictionary *)error,error);
            }
        }] resume];
    }
}

+(void)saveUserInLocalWith:(NSDictionary*)user{
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSEntityDescription *userEntity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:userEntity];
    User *userDelete = [[self managedObjectContext] executeFetchRequest:request error:nil].firstObject;
    if (userDelete != nil) {
        [managedObjectContext deleteObject:userDelete];
    }
    socialManager *socialManag = [socialManager sharedInstance];
    socialNetwork* phoneObj = [socialManag.dicoSocial objectForKey:PhoneKey];
    socialNetwork* EmailObj = [socialManag.dicoSocial objectForKey:EmailKey];
    socialNetwork* webSiteObj = [socialManag.dicoSocial objectForKey:WebsiteKey];
    socialNetwork* locationObject = [socialManag.dicoSocial objectForKey:LocationKey];
    User *userInfo = [[User alloc]initWithEntity:userEntity insertIntoManagedObjectContext:managedObjectContext];
    NSString* lastName = @"";
    if (![SUtilities stringIsNilOrEmpty:[user valueForKey:@"lastName"]]) {
        lastName = [user valueForKey:@"lastName"];
    }
    userInfo.lastName = lastName;
    NSString* firstName = @"";
    if (![SUtilities stringIsNilOrEmpty:[user valueForKey:@"firstName"]]) {
        firstName = [user valueForKey:@"firstName"];
    }
    userInfo.firstName = firstName;
    NSString* jobTitle = @"";
    if (![SUtilities stringIsNilOrEmpty:[user valueForKey:@"jobTitle"]]) {
        jobTitle = [user valueForKey:@"jobTitle"];
    }
    userInfo.jobTitle = jobTitle;
    NSString* company = @"";
    if (![SUtilities stringIsNilOrEmpty:[user valueForKey:@"company"]]) {
        company = [user valueForKey:@"company"];
    }
    userInfo.company = company;
    NSNumber *scor = @100;
    if (![[user valueForKey:@"score"] isEqual:[NSNull null]]) {
        scor = [user valueForKey:@"score"];
    }
    if ([scor isEqual: @0]) {
        scor = @100;
    }
    userInfo.score = scor;
    
    if (![[user valueForKey:@"phones"] isEqual:[NSNull null]]) {
        BOOL isPhone = false;
        BOOL isChoose = false;
        for (NSDictionary *phone in [user valueForKey:@"phones"]) {
            isPhone = true;
            if (![SUtilities stringIsNilOrEmpty:[phone valueForKey:@"phone"]]) {
                NSString *prefix = @"";
                if (![SUtilities stringIsNilOrEmpty:[phone valueForKey:@"prefix"]]) {
                    prefix = [phone valueForKey:@"prefix"];
                }
                userInfo.phone = [NSString stringWithFormat:@"%@ %@",prefix,[phone valueForKey:@"phone"]];
                userInfo.fullphone = [NSString stringWithFormat:@"%@ %@",prefix,[phone valueForKey:@"phone"]];
                Phones *phoneObject  = [NSEntityDescription insertNewObjectForEntityForName:@"Phones" inManagedObjectContext:managedObjectContext];
                phoneObject.value = [NSString stringWithFormat:@"%@ %@",prefix,[phone valueForKey:@"phone"]];
                phoneObject.label = [phone valueForKey:@"label"];
                if (!isChoose) {
                    [phoneObject setIsChoose:[NSNumber numberWithBool:YES]];
                    isChoose = true;
                }
                [managedObjectContext insertObject:phoneObject];
                [userInfo addPhonesObject:phoneObject];
                phoneObj.socialProfilData = [NSString stringWithFormat:@"%@ %@",prefix,[phone valueForKey:@"phone"]];
                
            }
        }
        if (!isPhone) {
            phoneObj.socialProfilData = nil;
            phoneObj.socialStatus = false;
        }
        [socialManag updateSocialNewtwork:phoneObj];
        
    }
    
    BOOL isWeb = false;
    if (![[user valueForKey:@"websites"] isEqual:[NSNull null]]) {
        BOOL isWebsite = false;
        BOOL isChoose = false;
        for (NSDictionary *web in [user valueForKey:@"websites"]) {
            isWeb = true;
            isWebsite = true;
            if (![SUtilities stringIsNilOrEmpty:[web valueForKey:@"value"]]) {
                Websites *webObject = [NSEntityDescription insertNewObjectForEntityForName:@"Websites" inManagedObjectContext:managedObjectContext];
                
                webObject.value = [web valueForKey:@"value"];
                webObject.label = [web valueForKey:@"label"];
                if (!isChoose) {
                    webObject.isChoose = [NSNumber numberWithBool:YES];
                    isChoose = true;
                }
                [managedObjectContext insertObject:webObject];
                [userInfo addWebsitesObject:webObject];
                webSiteObj.socialProfilData = [NSString stringWithFormat:@"%@",[web valueForKey:@"value"]];
                
            }
        }
        if (!isWebsite) {
            webSiteObj.socialProfilData = nil;
            webSiteObj.socialStatus = false;
        }
        [socialManag updateSocialNewtwork:webSiteObj];
        
    }
    BOOL isAdr = false;
    if (![[user valueForKey:@"addresses"] isEqual:[NSNull null]]) {
        BOOL isAddress = false;
        BOOL isChoose = false;
        for (NSDictionary *adr in [user valueForKey:@"addresses"]) {
            isAdr = true;
            isAddress = true;
            if (![SUtilities stringIsNilOrEmpty:[adr valueForKey:@"street"]]) {
                Address *adrObject = [NSEntityDescription insertNewObjectForEntityForName:@"Address" inManagedObjectContext:managedObjectContext];
                
                adrObject.value = [adr valueForKey:@"street"];
                adrObject.label = [adr valueForKey:@"label"];
                if (!isChoose) {
                    adrObject.isChoose = [NSNumber numberWithBool:YES];
                    isChoose = true;
                }
                [managedObjectContext insertObject:adrObject];
                [userInfo addAddressObject:adrObject];
                locationObject.socialProfilData = [NSString stringWithFormat:@"%@",[adr valueForKey:@"street"]];
                
            }
        }
        if (!isAddress) {
            locationObject.socialProfilData = nil;
            locationObject.socialStatus = false;
        }
        [socialManag updateSocialNewtwork:locationObject];
        
    }
    
    if (![[user valueForKey:@"emails"] isEqual:[NSNull null]]) {
        BOOL isEmail = false;
        for (NSDictionary *email in [user valueForKey:@"emails"]) {
            isEmail = true;
            NSString *emailS = @"";
            if (![SUtilities stringIsNilOrEmpty:[email valueForKey:@"email"]]) {
                emailS = [email valueForKey:@"email"];
            }
            else
                if (![SUtilities stringIsNilOrEmpty:[email valueForKey:@"Email"]]) {
                    emailS = [email valueForKey:@"Email"];
                }
            
            if (![SUtilities stringIsNilOrEmpty:emailS]) {
                NSString *label = @"home";
                if (![SUtilities stringIsNilOrEmpty:[email valueForKey:@"label"]]) {
                    label = [email valueForKey:@"label"];
                }
                
                Emails *emailObject = [NSEntityDescription insertNewObjectForEntityForName:@"Emails" inManagedObjectContext:managedObjectContext];
                emailObject.value = emailS;
                emailObject.label = label;
                if ([[user valueForKey:@"accountMail"] isEqualToString:emailS] ) {
                    emailObject.idBackend = @"accountMail";
                    emailObject.isChoose = [NSNumber numberWithBool:YES];
                }
                [managedObjectContext insertObject:emailObject];
                [userInfo addEmailsObject:emailObject];
                EmailObj.socialProfilData = [NSString stringWithFormat:@"%@",emailS];
            }
        }
        if (!isEmail) {
            EmailObj.socialProfilData = nil;
            EmailObj.socialStatus = false;
        }
        [socialManag updateSocialNewtwork:EmailObj];
    }
    
    if (![[user valueForKey:@"jobs"] isEqual:[NSNull null]]) {
        for (NSDictionary *job in [user valueForKey:@"jobs"]) {
            if (![SUtilities stringIsNilOrEmpty:[job valueForKey:@"company"]] || ![SUtilities stringIsNilOrEmpty:[job valueForKey:@"jobTitle"]]) {
                Jobs *jobObject = [NSEntityDescription insertNewObjectForEntityForName:@"Jobs" inManagedObjectContext:managedObjectContext];
                
                jobObject.value = [job valueForKey:@"company"];
                jobObject.label = [job valueForKey:@"jobTitle"];
                
                [managedObjectContext insertObject:jobObject];
                [userInfo addJobsObject:jobObject];
                
            }
        }
        
    }
    
    if (![[user valueForKey:@"socialMediaAccount"] isEqual:[NSNull null]]) {
        
        for (NSDictionary *social in [user valueForKey:@"socialMediaAccount"]) {
            if(![SUtilities stringIsNilOrEmpty:[social valueForKey:@"value"]] && ![SUtilities stringIsNilOrEmpty:[social valueForKey:@"label"]]){
                if (![SUtilities stringIsNilOrEmpty:[social valueForKey:@"id"]] && [[social valueForKey:@"id"] isEqualToString:WebsiteKey] && !isWeb) {
                    Websites *webObject = [NSEntityDescription insertNewObjectForEntityForName:@"Websites" inManagedObjectContext:managedObjectContext];
                    
                    webObject.value = [social valueForKey:@"value"];
                    webObject.label = [social valueForKey:@"label"];
                    
                    [managedObjectContext insertObject:webObject];
                    [userInfo addWebsitesObject:webObject];
                    socialNetwork *webSocial = [socialManag.dicoSocial objectForKey:WebsiteKey];
                    webSocial.socialProfilData = [NSString stringWithFormat:@"%@",[social valueForKey:@"value"]];
                    [socialManag updateSocialNewtwork:webSocial];
                }
                else if (![SUtilities stringIsNilOrEmpty:[social valueForKey:@"id"]] && [[social valueForKey:@"id"] isEqualToString:LocationKey] && !isAdr) {
                    Address *adrObject = [NSEntityDescription insertNewObjectForEntityForName:@"Address" inManagedObjectContext:managedObjectContext];
                    
                    adrObject.value = [social valueForKey:@"value"];
                    adrObject.label = [social valueForKey:@"label"];
                    
                    [managedObjectContext insertObject:adrObject];
                    [userInfo addAddressObject:adrObject];
                    socialNetwork *adrSocial = [socialManag.dicoSocial objectForKey:LocationKey];
                    adrSocial.socialProfilData = [NSString stringWithFormat:@"%@",[social valueForKey:@"value"]];
                    [socialManag updateSocialNewtwork:adrSocial];
                }
                else{
                    socialNetwork *facebook = [socialManag.dicoSocial objectForKey:[social valueForKey:@"label"]];
                    facebook.socialProfilData = [social valueForKey:@"value"];
                    [socialManag updateSocialNewtwork:facebook];
                    Social *socials = [NSEntityDescription insertNewObjectForEntityForName:@"Social" inManagedObjectContext:managedObjectContext];
                    socials.value= [social valueForKey:@"value"];
                    socials.label= [social valueForKey:@"label"];
                    socials.idBackend= [social valueForKey:@"id"];
                    [managedObjectContext insertObject:socials];
                    [userInfo addSocialNetworksObject:socials];
                }
            }
        }
        NSArray* LabelsocialNetworksArray = [NSArray new];
        NSArray *socialNetworks = [user valueForKey:@"socialMediaAccount"];
        LabelsocialNetworksArray = @[TwitterKey,FacebookKey,SkypeKey,LinkedInKey,SnapchatKey,/*@"Youtube",*/GoogleKey,TumblrKey,PinterestKey,InstagramKey];
        for (NSString *dic in LabelsocialNetworksArray) {
            if (![self UpdateSocialNework:dic array:socialNetworks])
            {
                socialNetwork* socialObject = [socialManag.dicoSocial objectForKey:dic];
                if (socialObject.socialProfilData != nil) {
                    socialObject.socialProfilData = nil;
                    socialObject.socialStatus = false;
                    [socialManag updateSocialNewtwork:socialObject];
                }
            }
        }
    }
    
    [managedObjectContext save:nil];
    
}
+(BOOL)UpdateSocialNework:(NSString*)SocialNetwork array:(NSArray*)ArraySocial{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"label == %@",SocialNetwork];
    NSArray *result =  [ArraySocial filteredArrayUsingPredicate:predicate];
    if (result.count > 0) {
        return true;
    }
    return false;
}
#pragma mark - Core Data Stack

+ (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
@end
