//
//  PCStackMenuItem.h
//  testStackMenu
//
//  Created by Joon on 13. 5. 30..
//  Copyright (c) 2013년 Joon. All rights reserved.
//

#import <UIKit/UIKit.h>


#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0
#define TextAlignementRight  NSTextAlignmentRight
#define TextAlignementLeft   NSTextAlignmentLeft
typedef NSTextAlignment PSTextAlignment;
#else
typedef NSTextAlignment PSTextAlignment;
#define TextAlignementRight  NSTextAlignmentRight
#define TextAlignementLeft   NSTextAlignmentLeft
#endif


@interface PCStackMenuItem : UIView

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title withImage:(UIImage *)image alignment:(PSTextAlignment)alignment;

@property (nonatomic)				BOOL			highlight;

@property (nonatomic, readonly)		UILabel			*stackTitleLabel;
@property (nonatomic, readonly) 	UIImageView		*stackIimageView;

@end


CGAffineTransform CGAffineTransformMakeRotationAt(CGFloat angle, CGPoint pt);
