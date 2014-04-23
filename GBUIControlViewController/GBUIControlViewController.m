//
//  GBUIControlViewController.m
//  GBUIControlViewController
//
//  Created by George Boumis on 16/12/13.
//  Copyright (c) 2013 George Boumis <developer.george.boumis@gmail.com>. All rights reserved.
//

#import "GBUIControlViewController.h"

@interface GBUIControlViewController ()
@property (strong, nonatomic) NSArray *subviewsConstraints;
@end

@implementation GBUIControlViewController

- (instancetype)initWithControlPosition:(GBUIControlViewControllerControlPosition)position {
	self = [super init];
	if (nil!=self) {
		_controlPosition = position;
	}
	return self;
}

- (void)loadView {
	UIView *mainView = [[UIView alloc] initWithFrame:CGRectZero];
	UIView *controlView = self.controlView;
	UIView *contentView = self.contentView;
	controlView.translatesAutoresizingMaskIntoConstraints =
	contentView.translatesAutoresizingMaskIntoConstraints = NO;
	
	[mainView addSubview:controlView];
	[mainView addSubview:contentView];
	
	self.view = mainView;
}

- (void)updateViewConstraints {
	if (self.subviewsConstraints)
		[self.view removeConstraints:self.subviewsConstraints];
	self.subviewsConstraints = [self constraintsFroSubviews];
	[self.view addConstraints:self.subviewsConstraints];
	[super updateViewConstraints];
}

- (NSArray *)constraintsFroSubviews {
	@autoreleasepool {
		UIView *controlView = self.controlView;
		UIView *contentView = self.contentView;
		
		NSMutableArray *constraints = [[NSMutableArray alloc] init];
		id top = self.topLayoutGuide, bottom = self.bottomLayoutGuide;
		NSDictionary *bindings = NSDictionaryOfVariableBindings(controlView, contentView, top, bottom);
		NSString *controlFullSizeFormat = nil;
		NSString *contentFullSizeFormat = nil;
		NSString *otherDimensionFormat = nil;
		switch (_controlPosition) {
			case GBUIControlViewControllerControlPositionTop:
				controlFullSizeFormat = [NSString stringWithFormat:@"%@:|[controlView]|", @"H"];
				contentFullSizeFormat = [NSString stringWithFormat:@"%@:|[contentView]|", @"H"];
				otherDimensionFormat = [NSString stringWithFormat:@"%@:[top][controlView][contentView][bottom]", @"V"];
				break;
			case GBUIControlViewControllerControlPositionBottom:
				controlFullSizeFormat = [NSString stringWithFormat:@"%@:|[controlView]|", @"H"];
				contentFullSizeFormat = [NSString stringWithFormat:@"%@:|[contentView]|", @"H"];
				otherDimensionFormat = [NSString stringWithFormat:@"%@:[top][controlView][contentView][bottom]", @"V"];
				break;
			case GBUIControlViewControllerControlPositionLeft:
				controlFullSizeFormat = [NSString stringWithFormat:@"%@:[top][controlView][bottom]", @"V"];
				contentFullSizeFormat = [NSString stringWithFormat:@"%@:[top][contentView][bottom]", @"V"];
				otherDimensionFormat = [NSString stringWithFormat:@"%@:|[controlView][contentView]|", @"H"];
				break;
			case GBUIControlViewControllerControlPositionRight:
				controlFullSizeFormat = [NSString stringWithFormat:@"%@:[top][controlView][bottom]", @"V"];
				contentFullSizeFormat = [NSString stringWithFormat:@"%@:[top][contentView][bottom]", @"V"];
				otherDimensionFormat = [NSString stringWithFormat:@"%@:|[contentView][controlView]|", @"H"];
				break;
			default:
				break;
		}
		[constraints addObjectsFromArray:
		 [NSLayoutConstraint constraintsWithVisualFormat:controlFullSizeFormat options:0 metrics:nil views:bindings]];
		[constraints addObjectsFromArray:
		 [NSLayoutConstraint constraintsWithVisualFormat:contentFullSizeFormat options:0 metrics:nil views:bindings]];
		[constraints addObjectsFromArray:
		 [NSLayoutConstraint constraintsWithVisualFormat:otherDimensionFormat options:0 metrics:nil views:bindings]];
		return constraints;
	}
}

- (void)setControlPosition:(GBUIControlViewControllerControlPosition)controlPosition {
	if (_controlPosition != controlPosition) {
		_controlPosition = controlPosition;
		
		UIView *mainView = self.view;
		
		UIView *controlView = self.controlView;
		UIView *contentView = self.contentView;
		controlView.translatesAutoresizingMaskIntoConstraints =
		contentView.translatesAutoresizingMaskIntoConstraints = NO;
		
		[controlView removeFromSuperview];
		[contentView removeFromSuperview];
		
		[mainView addSubview:controlView];
		[mainView addSubview:contentView];
		
		[mainView addConstraints:[self constraintsFroSubviews]];
	}
}

@end
