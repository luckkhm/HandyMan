//
//  WebServices.h
//  heyy
//
//  Created by Ahmed Khemiri on 11/24/16.
//  Copyright © 2016 iMac. All rights reserved.
//

#ifndef WebServices_h
#define WebServices_h

#define TIME_OUT_CONNECTION 10.0

// Test and debug
// ENV 0  : Test
// ENV 1  : Prod

#define version                          [[NSUserDefaults standardUserDefaults] valueForKey:@"VersionService"]
#define ENV 1
#if (ENV == 0)
#define BASE_URL @"http://ec2-52-8-168-232.us-west-1.compute.amazonaws.com:2017"
#define API_URL [@"http://ec2-52-8-168-232.us-west-1.compute.amazonaws.com:2017/" stringByAppendingString:version]
#elif (ENV == 1)
#define BASE_URL @"http://ec2-52-8-168-232.us-west-1.compute.amazonaws.com:3000"
#define API_URL [@"http://ec2-52-8-168-232.us-west-1.compute.amazonaws.com:3000/" stringByAppendingString:version]
#endif

#define SIGN_IN_SOCIAL                   @"/authenticate/social"
#define SIGN_IN_NATIVE                   @"/authenticate/signin"
#define SIGN_UP                          @"/signup"
#define LOG_OUT                          @"/logout"
#define UPDATE_PROFILE                   @"/user/edit"
#define UPDATE_SCORE                     @"/user/editScore"
#define UPLOAD_IMAGE                     @"/user/uploadProfileImage"
#define SEND_VIA_EMAIL                     @"/sharing/viamail/"




#endif /* WebServices_h */
