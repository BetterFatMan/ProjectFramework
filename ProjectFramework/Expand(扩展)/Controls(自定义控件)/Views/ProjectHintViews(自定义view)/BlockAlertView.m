//
//  BlockAlertView.m
//  BlockContacts
//
//  Created by i zoro on 12-12-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BlockAlertView.h"

@implementation BlockAlertView
{
    blockAlertViewCallBackBlock _callbackBlock;
}

- (void)dealloc
{
    _callbackBlock = nil;
}

- (void)showAlertWithTitle:(NSString *)title msg:(NSString *)msg callbackBlock:(blockAlertViewCallBackBlock)block
     cancelButtonTitle:(NSString *)cancelBtnTitle otherButtonTitles:(NSString *)otherButtonTitles, ... ;
{
    if (!block)
    {
        return;
    }
    
    _callbackBlock = nil;
        //强引用
    _callbackBlock = [block copy];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:cancelBtnTitle otherButtonTitles:nil];
    if (otherButtonTitles)
    {
        [alert addButtonWithTitle:otherButtonTitles];
        va_list args ;
        va_start(args, otherButtonTitles);
        NSString *title = nil;
        while ((title = va_arg(args, NSString *)))
        {
            [alert addButtonWithTitle:title];
        }
        va_end(args);
    }
    
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    _callbackBlock((int)buttonIndex);
}


@end
