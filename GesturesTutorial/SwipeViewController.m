//
//  SwipeViewController.m
//  GesturesTutorial
//
//  Created by Jun Oh on 2019-01-17.
//  Copyright © 2019 Jun Oh. All rights reserved.
//

#import "SwipeViewController.h"

@interface SwipeViewController ()

@property (nonatomic) NSLayoutConstraint* viewCenterXConstraint;

@end

@implementation SwipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView* viewBelow = [[UIView alloc] initWithFrame:CGRectZero];
    viewBelow.backgroundColor = [UIColor brownColor];
    viewBelow.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:viewBelow];
    
    [NSLayoutConstraint constraintWithItem:viewBelow attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:viewBelow attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50].active = YES;
    
    [NSLayoutConstraint constraintWithItem:viewBelow attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:viewBelow attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0].active = YES;
    
    UIView* view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor yellowColor];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [viewBelow addSubview:view];
    
    [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:viewBelow attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:viewBelow attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0].active = YES;
    
    self.viewCenterXConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:viewBelow attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    self.viewCenterXConstraint.active = YES;
    
    [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:viewBelow attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0].active = YES;
    
    UISwipeGestureRecognizer* swipeLeftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(viewSwiped:)];
    swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [view addGestureRecognizer:swipeLeftGesture];
    
    UISwipeGestureRecognizer* swipeRightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(viewSwiped:)];
    swipeRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [view addGestureRecognizer:swipeRightGesture];
}

- (void) viewSwiped:(UISwipeGestureRecognizer *)sender {
    static BOOL swipeRight = NO;
    static BOOL swipeLeft = NO;
    if(sender.direction == UISwipeGestureRecognizerDirectionRight) {
        if(!swipeRight && swipeLeft) {
            [UIView animateWithDuration:1.0 animations:^{
                self.viewCenterXConstraint.constant += 150;
                [self.view layoutIfNeeded];
            }];
            swipeLeft = NO;
            
        } else if(!swipeRight && !swipeLeft) {
            [UIView animateWithDuration:1.0 animations:^{
                self.viewCenterXConstraint.constant += 150;
                [self.view layoutIfNeeded];
            }];
            swipeRight = YES;
            [self.view layoutIfNeeded];
        }
    } else if(sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        if(!swipeLeft && swipeRight) {
            [UIView animateWithDuration:1.0 animations:^{
                self.viewCenterXConstraint.constant -= 150;
                [self.view layoutIfNeeded];
            }];
            swipeRight = NO;
            [self.view layoutIfNeeded];
        } else if(!swipeLeft && !swipeRight) {
            [UIView animateWithDuration:1.0 animations:^{
                self.viewCenterXConstraint.constant -= 150;
                [self.view layoutIfNeeded];
            }];
            swipeLeft = YES;
            [self.view layoutIfNeeded];
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
