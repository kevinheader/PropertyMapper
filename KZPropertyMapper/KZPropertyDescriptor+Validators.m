//
//  Created by merowing on 08/10/2013.
//
//
//


#import <objc/message.h>
#import "KZPropertyMapper.h"
#import "KZPropertyDescriptor+Validators.h"
#import "KZPropertyMapperCommon.h"

@implementation KZPropertyDescriptor (Validators)

#pragma mark - Strings
- (KZPropertyDescriptor * (^)())isRequired
{
  return ^() {
    [self addValidatorWithName:@"isRequired" validation:^(id value) {
      return YES;
    }];
    return self;
  };
}

- (KZPropertyDescriptor * (^)(NSUInteger, NSUInteger))lengthRange
{
  return ^(NSUInteger min, NSUInteger max) {
    NSUInteger realMax = MAX(min, max);
    NSUInteger realMin = MIN(min, max);
    [self addValidatorWithName:@"lengthRange" validation:^BOOL(NSString *value) {
      return value.length >= realMin && value.length <= realMax;
    }];
    return self;
  };
}

- (KZPropertyDescriptor * (^)(NSRegularExpression *regEx))matchesRegEx
{
  return ^(NSRegularExpression *regEx) {
    [self addValidatorWithName:@"matchesRegex" validation:^BOOL(NSString *value) {
      NSUInteger matches = [regEx numberOfMatchesInString:value options:0 range:NSMakeRange(0, value.length)];
      return matches == 1;
    }];
    return self;
  };
}

- (KZPropertyDescriptor * (^)(NSUInteger length))length
{
  return ^(NSUInteger number) {
    [self addValidatorWithName:@"length" validation:^BOOL(NSString *value) {
      return value.length == number;
    }];
    return self;
  };
}

- (KZPropertyDescriptor * (^)(NSUInteger minLength))minLength
{
  return ^(NSUInteger number) {
    [self addValidatorWithName:@"minLength" validation:^BOOL(NSString *value) {
      return value.length >= number;
    }];
    return self;
  };
}

- (KZPropertyDescriptor * (^)(NSUInteger maxLength))maxLength
{
  return ^(NSUInteger number) {
    [self addValidatorWithName:@"maxLength" validation:^BOOL(NSString *value) {
      return value.length <= number;
    }];
    return self;
  };
}

- (KZPropertyDescriptor * (^)(NSArray *))oneOf
{
  return ^(NSArray *array) {
    [self addValidatorWithName:@"oneOf" validation:^BOOL(NSString *value) {
      return [array containsObject:value];
    }];
    return self;
  };
}

- (KZPropertyDescriptor * (^)(NSString *))equalTo
{
  return ^(NSString *compare) {
    [self addValidatorWithName:@"equalTo" validation:^BOOL(NSString* value) {
      return [value isEqualToString:compare];
    }];
    return self;
  };
}

#pragma mark - Numbers

- (KZPropertyDescriptor * (^)(NSUInteger min))min
{
  return ^(NSUInteger min) {
    [self addValidatorWithName:@"min" validation:^BOOL(NSNumber *value) {
      return value.integerValue >= min;
    }];
    return self;
  };
}

- (KZPropertyDescriptor * (^)(NSUInteger max))max
{
  return ^(NSUInteger maxNumber) {
    [self addValidatorWithName:@"max" validation:^BOOL(NSNumber *value) {
      BOOL v = value.integerValue <= maxNumber;
      return v;
    }];
    return self;
  };
}

- (KZPropertyDescriptor * (^)(NSUInteger, NSUInteger))range
{
  return ^(NSUInteger min, NSUInteger max) {
    NSUInteger realMax = MAX(min, max);
    NSUInteger realMin = MIN(min, max);
    [self addValidatorWithName:@"range" validation:^BOOL(NSNumber *value) {
      return value.integerValue >= realMin && value.integerValue <= realMax;
    }];
    return self;
  };
}


@end