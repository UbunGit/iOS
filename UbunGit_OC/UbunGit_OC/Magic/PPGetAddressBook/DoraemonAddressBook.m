//
//  DoraemonAddressBook.m
//  UbunGit_OC
//
//  Created by admin on 2019/3/11.
//  Copyright © 2019 admin. All rights reserved.
//

#import "DoraemonAddressBook.h"
#import "AddressBookController.h"
#import "DoraemonUtil.h"

@implementation DoraemonAddressBook

- (void)pluginDidLoad{
    AddressBookController *vc = [[AddressBookController alloc] init];
    [DoraemonUtil openPlugin:vc];
}

@end
