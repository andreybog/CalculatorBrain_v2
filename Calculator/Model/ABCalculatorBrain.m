//
//  CalculatorBrain.m
//  Calculator
//
//  Created by goit on 8/8/16.
//  Copyright © 2016 goit. All rights reserved.
//

#import "ABCalculatorBrain.h"

@interface ABCalculatorBrain()

@property (strong, nonatomic) NSMutableArray <NSNumber *> *digitsArray;
@property (assign) ABCalculatorOperation currentOperation;

@end

@implementation ABCalculatorBrain

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.digitsArray = [NSMutableArray array];
    }
    return self;
}


- (float) executeOperation:(ABCalculatorOperation) operation {
    
    switch (operation) {
            
        case ABCalculatorOperationAdd:
            return [self performOperationWithBlockBinary:^float(float x, float y) {
                return x + y;
            }];
            
        case ABCalculatorOperationSubtract:
            return [self performOperationWithBlockBinary:^float(float x, float y) {
                return y - x;
            }];
            
            
        case ABCalculatorOperationMultiply:
            return [self performOperationWithBlockBinary:^float(float x, float y) {
                return x * y;
            }];
            
            
        case ABCalculatorOperationDivide:
            return [self performOperationWithBlockBinary:^float(float x, float y) {
                return y / x;
            }];
            
        case ABCalculatorOperationSqrt:
            
            return [self performOperationWithBlockUnary:^float(float x) {
                return sqrtf(x);
            }];
            
        default:
            break;
    }
    
    return 0;
}

- (float) executeOpertation:(ABCalculatorOperation) operation withDigit:(float) digit {
    
    [self.digitsArray addObject:@(digit)];
    
    if ( operation == ABCalculatorOperationSqrt ) {

        if ( self.currentOperation != ABCalculatorOperationNone ) {
            
            [self.digitsArray addObject:@([self executeOperation:self.currentOperation])];
        }
        
        self.currentOperation = ABCalculatorOperationNone;
        
        return [self executeOperation:operation];
    }
    
    if ( operation == ABCalculatorOperationEqual ) {
        
        float result;
        
        if ( self.currentOperation != ABCalculatorOperationNone ) {
            
            result = [self executeOperation:self.currentOperation];
            
        } else {
            
            result = [[self.digitsArray lastObject] floatValue];
            [self.digitsArray removeLastObject];
        }
        
        self.currentOperation = ABCalculatorOperationNone;
        
        return result;
    }
    
    if ( self.currentOperation == ABCalculatorOperationNone ) {
        
        self.currentOperation = operation;
        
        return [[self.digitsArray lastObject] floatValue];
        
    }
    
    float result = [self executeOperation:self.currentOperation];
    [self.digitsArray addObject:@(result)];
    
    self.currentOperation = operation;
    
    return result;
    
}

 
- (float) performOperationWithBlockBinary:( float (^)(float, float) ) operation {
    
    if ( [self.digitsArray count] >= 2 ) {
        
        float x = [[self.digitsArray lastObject] floatValue];
        [self.digitsArray removeLastObject];
        
        float y = [[self.digitsArray lastObject] floatValue];
        [self.digitsArray removeLastObject];
        
        
        return operation(x, y);
        
    }
    
    return 0;
}

- (float) performOperationWithBlockUnary:( float (^)(float) ) operation {
    
    if ( [self.digitsArray count] >= 1 ) {
        
        float x = [[self.digitsArray lastObject] floatValue];
        [self.digitsArray removeLastObject];
        
        return operation(x);
        
    }
    
    return 0;
}

@end
