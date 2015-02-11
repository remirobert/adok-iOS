//
//  ObjectMisc.m
//  Adok
//
//  Created by Remi Robert on 11/02/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

#import "ObjectMisc.h"

@implementation ObjectMisc

id createObjectWithName(NSString *nameClass) {
    NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
    NSString *classStringName = [NSString stringWithFormat:@"_TtC%lu%@%lu%@", (unsigned long)appName.length,
                                 appName, (unsigned long)nameClass.length, nameClass];
    
    Class customClass = NSClassFromString(classStringName);
    if (customClass == nil) {
        return nil;
    }
    return [[customClass alloc] init];
}

@end
