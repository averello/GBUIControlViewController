//
//  GBUIControlViewController.h
//  GBUIControlViewController
//
//  Created by George Boumis on 16/12/13.
//  Copyright (c) 2013 George Boumis <developer.george.boumis@gmail.com>. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GBUIControlViewControllerControlPosition) {
	GBUIControlViewControllerControlPositionTop,
	GBUIControlViewControllerControlPositionBottom,
	GBUIControlViewControllerControlPositionLeft,
	GBUIControlViewControllerControlPositionRight
};

@protocol GBUIControlViewControllerDecoratable <NSObject>
- (UIView *)controlView;
- (UIView *)contentView;
@end

@interface GBUIControlViewController : UIViewController<GBUIControlViewControllerDecoratable>
@property (nonatomic, readwrite) GBUIControlViewControllerControlPosition controlPosition;
@property (strong, nonatomic, readonly) UIView *controlView;
@property (strong, nonatomic, readonly) UIView *contentView;

- (instancetype)initWithControlPosition:(GBUIControlViewControllerControlPosition)position;
- (NSArray *)constraintsFroSubviews;
@end
