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
    [self.redTextLabel setStringValue:[self.redColorSlider stringValue]];
    [self.greenTextLabel setStringValue:[self.greenColorSlider stringValue]];
    [self.blueTextLabel setStringValue:[self.blueColorSlider stringValue]];

    float movedValue = [self.sensitivitySlider floatValue] / 1000.0f;
    [self.oglView setSensitivity: movedValue];
    movedValue = [self.scrollSensitivitySlider floatValue] / 500.0f;
    [self.oglView setScrollSensitivity: movedValue];
}

-(IBAction)redSliderMoved:(id) sender;
{
    // "normalize" values to 0.0f...1.0f
    float movedValue = [sender floatValue] / 255.0f;
    NSLog(@"moved red: %f", movedValue);
    [self.oglView setBackgroundColorRed: movedValue];
    [self.oglView setNeedsDisplay: true];

    // update label
    [self.redTextLabel setStringValue:[self.redColorSlider stringValue]];
}

-(IBAction)greenSliderMoved:(id) sender
{
    // "normalize" values to 0.0f...1.0f
    float movedValue = [sender floatValue] / 255.0f;
    NSLog(@"moved green: %f", movedValue);
    [self.oglView setBackgroundColorGreen: movedValue];
    [self.oglView setNeedsDisplay: true];

    // update label
    [self.greenTextLabel setStringValue:[self.greenColorSlider stringValue]];
}

-(IBAction)blueSliderMoved:(id) sender
{
    // "normalize" values to 0.0f...1.0f
    float movedValue = [sender floatValue] / 255.0f;
    NSLog(@"moved blue: %f", movedValue);
    [self.oglView setBackgroundColorBlue: movedValue];
    [self.oglView setNeedsDisplay: true];

    // update label
    [self.blueTextLabel setStringValue:[self.blueColorSlider stringValue]];
}

-(IBAction)sensitivitySliderMoved:(id) sender
{
    // "normalize" values to 0.01f..0.1f
    float movedValue = [sender floatValue] / 1000.0f;
    [self.oglView setSensitivity: movedValue];
}

-(IBAction)scrollSensitivitySliderMoved:(id) sender
{
    // "normalize" values to 0.02f..0.1f
    float movedValue = [sender floatValue] / 500.0f;
    [self.oglView setScrollSensitivity: movedValue];
}

-(IBAction)exponentialScrollSwitched:(id) sender
{
    [self.oglView setExponentialZoom: (bool)self.exponentialSwitchButton.state];
}

-(NSSize)windowWillResize:(NSWindow*) sender toSize:(NSSize) frameSize
{
    //if (sender.identifier == self.window.identifier)
        //[self.oglView setViewSize: frameSize];

    return frameSize;
}

@end
