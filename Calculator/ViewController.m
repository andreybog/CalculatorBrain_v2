//
//  ViewController.m
//  Calculator
//
//  Created by goit on 8/3/16.
//  Copyright © 2016 goit. All rights reserved.
//

#import "ViewController.h"
#import "ABCalculatorBrain.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (assign, nonatomic, getter=isUserStartTyping) BOOL userStartTyping;
@property (assign, nonatomic, getter=isUnaryOperationDidPressed) BOOL unaryOperationDidPressed;

@property (strong, nonatomic) ABCalculatorBrain *calculator;

@end


@implementation ViewController

#pragma mark - Properties

- (ABCalculatorBrain *) calculator {
    
    if ( ! _calculator ) {
        _calculator = [[ABCalculatorBrain alloc] init];
    }
    
    return _calculator;
}

#pragma mark - UIApplicationDelegate

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    UIButton *sqrtButton = [[UIButton alloc] initWithFrame:
                            CGRectMake(80, 250, 50, 50)];
    
    [sqrtButton setTitle:@"√" forState:UIControlStateNormal];
    
    [sqrtButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [sqrtButton addTarget:self
                   action:@selector(actionTouchOperatorUnary:)
         forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:sqrtButton];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions

- (IBAction)actionTouchDigit:(UIButton *)sender {
    
    if ( ! self.isUserStartTyping ) {
        
        self.resultLabel.text = sender.currentTitle;
        self.userStartTyping = YES;
        
    } else {
        if ( ! self.isUnaryOperationDidPressed ) {
            self.resultLabel.text = [self.resultLabel.text stringByAppendingString:sender.currentTitle];
        }
    }
}

- (IBAction)actionTouchOperatorUnary:(UIButton *)sender {
    
    NSString *operator = sender.currentTitle;
    
    [self touchOperator:operator unary:YES];
}

- (IBAction)actionTouchOperatorBinary:(UIButton *)sender {
    
    NSString *operator = sender.currentTitle;
    
    [self touchOperator:operator unary:NO];
    
}

- (void) touchOperator:(NSString *)operator unary:(BOOL) unary {
    
    if ( self.isUserStartTyping ) {
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        NSNumber *number = [formatter numberFromString:self.resultLabel.text];
        ABCalculatorOperation operation = [self calculatorOperationWithString: operator];
        
        float result = [self.calculator executeOpertation:operation withDigit:[number floatValue]];
        
        self.resultLabel.text = [NSString stringWithFormat:@"%g", result];
        
        if ( unary ) {
            
            self.userStartTyping = YES;
            self.unaryOperationDidPressed = YES;
           
        } else {
            
            self.userStartTyping = NO;
            self.unaryOperationDidPressed = NO;
            
        }
    }
    
}

#pragma mark - Help functions

- (ABCalculatorOperation) calculatorOperationWithString:(NSString *) operation {
    
    if ( [operation isEqualToString:@"+"] ) {
        return ABCalculatorOperationAdd;
        
    } else if ( [operation isEqualToString:@"-"] ) {
        return ABCalculatorOperationSubtract;
        
    }  else if ( [operation isEqualToString:@"×"] ) {
        return ABCalculatorOperationMultiply;
        
    } else if ( [operation isEqualToString:@"÷"] ) {
        return ABCalculatorOperationDivide;
        
    }  else if ( [operation isEqualToString:@"√"] ) {
        return ABCalculatorOperationSqrt;
        
    } else if ( [operation isEqualToString:@"="] ) {
        return ABCalculatorOperationEqual;
    }
    
    return ABCalculatorOperationNone;
}




@end
