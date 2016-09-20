#import "CALayer+RuntimeAttribute.h"

@implementation CALayer (IBConfiguration)

- (void)setBorderIBColor:(UIColor *)color {
    [self setBorderColor:color.CGColor];
}

- (UIColor *)borderIBColor {
    return [UIColor colorWithCGColor:self.borderColor];
}

- (void)setShadowIBColor:(UIColor *)color {
    [self setShadowColor:color.CGColor];
}

- (UIColor *)shadowIBColor {
    return [UIColor colorWithCGColor:self.shadowColor];
}

- (void)setBackgroundIBColor:(UIColor*)color {
    [self setBackgroundColor:color.CGColor];
}

- (UIColor *)backgroundIBColor
{
    return [UIColor colorWithCGColor:self.shadowColor];
}


@end