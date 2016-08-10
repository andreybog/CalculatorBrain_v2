//
//  CalculatorBrain.h
//  Calculator
//
//  Created by goit on 8/8/16.
//  Copyright © 2016 goit. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger, ABCalculatorOperation) {
    ABCalculatorOperationNone,
    ABCalculatorOperationAdd,
    ABCalculatorOperationSubtract,
    ABCalculatorOperationMultiply,
    ABCalculatorOperationDivide,
    ABCalculatorOperationSqrt,
    ABCalculatorOperationEqual
};

@interface ABCalculatorBrain : NSObject

- (float) executeOpertation:(ABCalculatorOperation) operation withDigit:(float) digit;



@end
