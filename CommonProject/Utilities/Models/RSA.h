//
//  RSA.h
//  zjsm
//
//  Created by sunjun on 13-3-23.
//  Copyright (c) 2013年 sunjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h> 
#import "GTMBase64.h"


@interface RSA : NSObject
+ (NSString *)decryptWithText:(NSString *)sText;
+ (NSString *)encryptWithText:(NSString *)sText;
@end
