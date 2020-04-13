//
//  NSString+Encode.m
//  Owncloud iOs Client
//
// Copyright (C) 2016, ownCloud GmbH. ( http://www.owncloud.org/ )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//


#import "NSString+Encode.h"
#import <CommonCrypto/CommonCrypto.h>
@implementation NSString (encode)

/**
 *  URLEncode
 */
- (NSString *)ug_urlencodedString
{
    CFStringRef stringRef = CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self,
                                                                    NULL, (CFStringRef)@";@$+{}<>,!'*",
                                                                    CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    NSString *output = (NSString *)CFBridgingRelease(stringRef);
    
    
    
    
    int countCharactersAfterPercent = -1;
    
    for(int i = 0 ; i < [output length] ; i++) {
        NSString * newString = [output substringWithRange:NSMakeRange(i, 1)];
        //NSLog(@"newString: %@", newString);
        
        if(countCharactersAfterPercent>=0) {
            
            //NSLog(@"newString lowercaseString: %@", [newString lowercaseString]);
            output = [output stringByReplacingCharactersInRange:NSMakeRange(i, 1) withString:[newString lowercaseString]];
            countCharactersAfterPercent++;
        }
        
        if([newString isEqualToString:@"%"]) {
            countCharactersAfterPercent = 0;
        }
        
        if(countCharactersAfterPercent==2) {
            countCharactersAfterPercent = -1;
        }
    }
    
    // NSLog(@"output: %@", output);
    
    return output;
}

/**
 *  URLDecode
 */
-(NSString *)ug_urldecodedString
{
    
    
    NSString *encodedString = self;
    NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    return decodedString;
}


-(nullable NSString *)md5{

    
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    NSMutableString *md5Str = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; ++i) {
        [md5Str appendFormat:@"%02x", result[i]];
    }
    return md5Str;
}

+ (NSString *)emptyStr:(NSString *)str {
    
    if(([str isKindOfClass:[NSNull class]]) || ([str isEqual:[NSNull null]]) || (str == nil) || (!str)) {
        
        str = @"";
    }
    return str;
}
@end
