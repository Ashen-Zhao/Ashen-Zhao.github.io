---
layout: post
title: "iOS 常用加密方法"
date: 2016-01-07 17:30:15 +0800
comments: true
tags: iOS 加密方法, 加密
keywords: iOS加密方法, iOS安全, 加密, MD5, RSA, Base64
description: iOS 几种加密方法
categories: i|OS
---

###为何要加密
&emsp;为什么要加密，顾名思义，如果你不想让别人轻而易举的就拿到你的账号以及登录密码，如果你不想让别人获取你的敏感的数据(利益、聊天等数据),and so on; 不对数据进行加密，那就像你只穿个裤头，在到处跑，随时都可能走光；加密的重要性，我不多说，自己悟吧;  
&emsp;iOS 开发中经常用到的几种加密方式：MD5、Base64、RSA、AES  
&emsp;一般来说最常用的就是MD5和Base64：  
>
1. MD5主要应用于普通请求、返回数据，进行数据完整性校验
2. Base64 主要用于防止数据明文传输
3. AES 一般用于登录加密
4. RSA 经常用于重要数据 以及敏感数据的加密  

<!--more-->
##MD5
	- (NSString *) stringFromMD5 {
    if(self == nil || [self length] == 0) {        return nil;
    }    const char *value = [self UTF8String];    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, strlen(value), outputBuffer);
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }    	return outputString;
	}
导入头文件：#import <CommonCrypto/CommonDigest.h>   
 该方法为NSString的分类方法
##Base64
	static const char _base64EncodingTable[64] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
	static const short _base64DecodingTable[256] = {
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -1, -1, -2, -1, -1, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -1, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, 62, -2, -2, -2, 63,
    52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -2, -2, -2, -2, -2, -2,
    -2,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
    15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -2, -2, -2, -2, -2,
    -2, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
    41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2
	};


	+ (NSString *) encodeBase64WithString: (NSString *) strData {
    NSData *objData = [strData dataUsingEncoding:NSUTF8StringEncoding];
    const unsigned char * objRawData = [objData bytes];
    char * objPointer;    char * strResult;    // Get the Raw Data length and ensure we actually have data
    int intLength = [objData length];    if (intLength == 0) return nil;    // Setup the String-based Result placeholder and pointer within that placeholder
    strResult = (char *)calloc(((intLength + 2) / 3) * 4, sizeof(char));    objPointer = strResult;    // Iterate through everything
    while (intLength > 2) { // keep going until we have less than 24 bits        *objPointer++ = _base64EncodingTable[objRawData[0] >> 2];        *objPointer++ = _base64EncodingTable[((objRawData[0] & 0x03) << 4) + (objRawData[1] >> 4)]; *objPointer++ = _base64EncodingTable[((objRawData[1] & 0x0f) << 2) + (objRawData[2] >> 6)]; *objPointer++ = _base64EncodingTable[objRawData[2] & 0x3f];        // we just handled 3 octets (24 bits) of data
        objRawData += 3;        intLength -= 3;    }    // now deal with the tail end of things    if (intLength != 0) {        *objPointer++ = _base64EncodingTable[objRawData[0] >> 2];        if (intLength > 1) {            *objPointer++ = _base64EncodingTable[((objRawData[0] & 0x03) << 4) + (objRawData[1] >> 4)]; *objPointer++ = _base64EncodingTable[(objRawData[1] & 0x0f) << 2];            *objPointer++ = '=';        } else {            *objPointer++ = _base64EncodingTable[(objRawData[0] & 0x03) << 4];            *objPointer++ = '=';            *objPointer++ = '=';        }    }    // Terminate the string-based result
    *objPointer = '\0';    NSString *rstStr = [NSString stringWithCString:strResult encoding:NSASCIIStringEncoding]; free(objPointer);    return rstStr;	}
  
  	
	+ (NSData *)decodeBase64WithString:(NSString *)strBase64 {
    const char *objPointer = [strBase64 cStringUsingEncoding:NSASCIIStringEncoding];
    size_t intLength = strlen(objPointer);
    int intCurrent;
    int i = 0, j = 0, k;
    
    unsigned char *objResult = calloc(intLength, sizeof(unsigned char));
    
    // Run through the whole string, converting as we go
    while ( ((intCurrent = *objPointer++) != '\0') && (intLength-- > 0) ) {
        if (intCurrent == '=') {
            if (*objPointer != '=' && ((i % 4) == 1)) {// || (intLength > 0)) {
                // the padding character is invalid at this point -- so this entire string is invalid
                free(objResult);
                return nil;
            }
            continue;
        }
        
        intCurrent = _base64DecodingTable[intCurrent];
        if (intCurrent == -1) {
            // we're at a whitespace -- simply skip over
            continue;
        } else if (intCurrent == -2) {
            // we're at an invalid character
            free(objResult);
            return nil;
        }
        
        switch (i % 4) {
            case 0:
                objResult[j] = intCurrent << 2;
                break;
                
            case 1:
                objResult[j++] |= intCurrent >> 4;
                objResult[j] = (intCurrent & 0x0f) << 4;
                break;
                
            case 2:
                objResult[j++] |= intCurrent >>2;
                objResult[j] = (intCurrent & 0x03) << 6;
                break;
                
            case 3:
                objResult[j++] |= intCurrent;
                break;
        }
        i++;
    }
    
    // mop things up if we ended on a boundary
    k = j;
    if (intCurrent == '=') {
        switch (i % 4) {
            case 1:
                // Invalid state
                free(objResult);
                return nil;
                
            case 2:
                k++;
                // flow through
            case 3:
                objResult[k] = 0;
        }
    }
    
    // Cleanup and setup the return NSData
    NSData * objData = [[NSData alloc] initWithBytes:objResult length:j];
    free(objResult);
    return objData;
	}
  
##RSA  
RSA: 比较复杂，这有一篇博客可以参考[iOS下的RSA加密算法](http://blog.iamzsx.me/show.html?id=155002)  
##AES  
对于AES 这也有一个不错的博客[AES加密算法](http://www.tuicool.com/articles/UVRjmyN)    
