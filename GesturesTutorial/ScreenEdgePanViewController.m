//
//  ScreenEdgePanViewController.m
//  GesturesTutorial
//
//  Created by Jun Oh on 2019-01-17.
//  Copyright © 2019 Jun Oh. All rights reserved.
//

#import "ScreenEdgePanViewController.h"

@interface ScreenEdgePanViewController ()

@property (nonatomic) NSLayoutConstraint* viewCenterXConstraint;

@property (nonatomic) UIScreenEdgePanGestureRecognizer* edgePanGesture;

@property (nonatomic) UIPanGestureRecognizer* panGesture;

@property (nonatomic) UIView* panView;

@end

@implementation ScreenEdgePanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView* view = [[UIView alloc] initWithFrame:CGRectZero];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
    
    [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.8 constant:0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0].active = YES;
    
    self.viewCenterXConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:2.7 constant:0];
    self.viewCenterXConstraint.active = YES;
    
    self.edgePanGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(viewEdgePanned:)];
    self.edgePanGesture.edges = UIRectEdgeRight;
    [view addGestureRecognizer:self.edgePanGesture];
    
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(viewPanned:)];
    
    self.panView = view;
}

- (void) viewEdgePanned:(UIScreenEdgePanGestureRecognizer *)sender {
    sender.view.transform = CGAffineTransformMakeTranslation([sender translationInView:self.view].x, 0);
    if(sender.state == UIGestureRecognizerStateEnded) {
        if([sender translationInView:self.view].x > -100.0) {
            sender.view.transform = CGAffineTransformMakeTranslation(0, 0);
        } else {
            sender.view.transform = CGAffineTransformMakeTranslation(-280, 0);
            [sender.view removeGestureRecognizer:self.edgePanGesture];
            [self.panView addGestureRecognizer:self.panGesture];
        }
    }
}

- (void) viewPanned:(UIPanGestureRecognizer *)sender {
    if([sender translationInView:self.view].x > 0) {
        sender.view.transform = CGAffineTransformMakeTranslation([sender translationInView:self.view].x-280, 0);
    }
    
    if(sender.state == UIGestureRecognizerStateEnded) {
        if([sender translationInView:self.view].x < 100.0) {
            sender.view.transform = CGAffineTransformMakeTranslation(-280, 0);
        } else {
            sender.view.transform = CGAffineTransformMakeTranslation(0, 0);
            [sender.view removeGestureRecognizer:self.panGesture];
            [self.panView addGestureRecognizer:self.edgePanGesture];
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
