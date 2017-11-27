//
//  WXPayEntryActivity.m
//  Line0new
//
//  Created by line0 on 14-6-27.
//  Copyright (c) 2014年 zhanglei. All rights reserved.
//

#import "WXPayEntryActivity.h"

@implementation WXPayEntryActivity

+(void)payOrderStringAtWXWithDetail:(NSDictionary*)orderString {
    
        //PayReq * payRequest = [[PayReq alloc] init];
    
        //payRequest.openID = [orderString objectForKey:@"appid"];
        //payRequest.partnerId = [orderString objectForKey:@"partnerid"];
        //payRequest.prepayId = [orderString objectForKey:@"prepayid"];
        // payRequest.nonceStr = [orderString objectForKey:@"noncestr"];
        //payRequest.timeStamp = (UInt32)[[orderString objectForKey:@"timestamp"] integerValue];
        //payRequest.package = @"Sign=WXPay";
    
        //payRequest.sign = [orderString objectForKey:@"sign"];
    
        //BOOL rect = [WXApi sendReq:payRequest];
        //if (!rect) {
            // NSLog(@"WX Pay Failed!");
            //}
    
    /** appid */
    NSString *appid           = orderString[@"appid"];
    /** 商家向财付通申请的商家id */
    NSString *partnerId       = orderString[@"partnerid"];
    /** 预支付订单 */
    NSString *prepayId        = orderString[@"prepayid"];
    /** 随机串，防重发 */
    NSString *nonceStr        = orderString[@"noncestr"];
    /** 时间戳，防重发 */
    NSString *timeStamp       = orderString[@"timestamp"];
    /** 商家根据财付通文档填写的数据和签名 */
        //NSString *package         = orderString[@"package"];
    /** 商家根据微信开放平台文档对数据做的签名 */
    NSString *sign            = orderString[@"sign"];
    
        //生成URLscheme
    NSString *str = [NSString stringWithFormat:@"weixin://app/%@/pay/?nonceStr=%@&package=Sign%%3DWXPay&partnerId=%@&prepayId=%@&timeStamp=%@&sign=%@&signType=SHA1",appid,nonceStr,partnerId,prepayId,[NSString stringWithFormat:@"%d",[timeStamp intValue] ],sign];
    
        //通过openURL的方法唤起支付界面
    AppOpenUrlScheme(str);
}

@end
