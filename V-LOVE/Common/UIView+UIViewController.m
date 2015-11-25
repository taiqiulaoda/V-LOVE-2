//
//  UIView+UIViewController.m
//  V-LOVE
//
//  Created by mac on 15/10/22.
//  Copyright (c) 2015年 XXX. All rights reserved.
//

#import "UIView+UIViewController.h"

@implementation UIView (UIViewController)

- (UIViewController *)viewController
{
    UIResponder *next = self.nextResponder;
    while (next)
    {
        if ([next isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
    }
    return nil;
}



@end
