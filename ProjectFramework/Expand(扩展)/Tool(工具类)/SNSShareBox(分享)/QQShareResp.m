//
//  QQShareResp.m
//  YooMath
//
//  Created by Elanking_MacMini on 15/12/22.
//  Copyright © 2015年 ZhangLei. All rights reserved.
//

#import "QQShareResp.h"


@implementation QQShareResp

#pragma mark - QQApiInterfaceDelegate
- (void)onReq:(QQBaseReq *)req
{
    
}

- (void)onResp:(QQBaseResp *)resp
{
    if (resp.type == 2) {
        NSString *result = [NSString stringWithFormat:@"%@", resp.result];
        if ([result integerValue] == 0) {
            if (_delegate && [_delegate respondsToSelector:@selector(showQQShareResult:)]) {
                [_delegate showQQShareResult:1];
            }
        } else {
            if (_delegate && [_delegate respondsToSelector:@selector(showQQShareResult:)]) {
                [_delegate showQQShareResult:0];
            }
        }
    }
}

- (void)isOnlineResponse:(NSDictionary *)response
{
    NSLog(@"isOnlineResponse: %@ |", response);
}

@end
