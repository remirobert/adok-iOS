//
//  ImageOrientationFix.h
//  Adok
//
//  Created by Remi Robert on 09/03/15.
//  Copyright (c) 2015 Remi Robert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageOrientationFix : NSObject

+ (UIImage *) fixOrientationOfImage:(UIImage *)image;

@end
