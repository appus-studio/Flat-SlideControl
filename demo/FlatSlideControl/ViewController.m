//
//  ViewController.m
//  AppusFlatSlideControl
//
//  Created by Alexey Kubas on 9/21/15.
//  Copyright (c) 2015 Appus. All rights reserved.
//

#import "ViewController.h"
#import "APFlatSlideControl.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet APFlatSlideControl *slideControl;
@property (weak, nonatomic) IBOutlet UILabel *valuesLabel;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftlabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@property (weak, nonatomic) IBOutlet UIStepper *countSteper;
@property (weak, nonatomic) IBOutlet UIStepper *leftSteper;
@property (weak, nonatomic) IBOutlet UIStepper *rightSteper;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.slideControl setLeftValue:self.leftSteper.value
                         rightValue:self.rightSteper.value];
    [self validateControlsValues];
}


- (IBAction)actionCountChanged:(UIStepper*)sender {
    self.slideControl.thumbsCount = sender.value;
    [self validateControlsValues];
}

- (IBAction)actionLeftChanged:(UIStepper*)sender {
    [self.slideControl setLeftValue:self.leftSteper.value
                rightValue:self.rightSteper.value];
    [self validateControlsValues];
}

-(void)updateLabels{
    self.valuesLabel.text = [NSString stringWithFormat:@"%lu - %lu", self.slideControl.leftValue, self.slideControl
                             .rightValue ];
    self.countLabel.text = [@(self.countSteper.value)stringValue];
    self.leftlabel.text = [@(self.leftSteper.value)stringValue];
    self.rightLabel.text = [@(self.rightSteper.value)stringValue];
}
-(void)validateControlsValues{
    self.leftSteper.value = self.slideControl.leftValue;
    self.rightSteper.value = self.slideControl.rightValue;
    
    [self updateLabels];
}

- (IBAction)actionBarValueChanged:(APFlatSlideControl*)sender {
    // update controls
    [self validateControlsValues];
}



@end
