//
//  oglMVAppDelegate.m
//  oglModelViewer
//
//  Created by Łukasz on 21.06.2014.
//  Copyright (c) 2014 apios. All rights reserved.
//

#import "oglMVAppDelegate.h"

@implementation oglMVAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

-(IBAction)redSliderMoved:(id) sender;
{
    // "normalize" values to 0.0f...1.0f
    float movedValue = (float)[sender integerValue] / 255.0f;
    NSLog(@"moved red: %f", movedValue);
    [self.oglView setBackgroundColorRed: movedValue];
    [self.oglView setNeedsDisplay: true];
}

-(IBAction)greenSliderMoved:(id) sender
{
    float movedValue = (float)[sender integerValue] / 255.0f;
    NSLog(@"moved green: %f", movedValue);
    [self.oglView setBackgroundColorGreen: movedValue];
    [self.oglView setNeedsDisplay: true];
}

-(IBAction)blueSliderMoved:(id) sender
{
    float movedValue = (float)[sender integerValue] / 255.0f;
    NSLog(@"moved blue: %f", movedValue);
    [self.oglView setBackgroundColorBlue: movedValue];
    [self.oglView setNeedsDisplay: true];
}

@end
