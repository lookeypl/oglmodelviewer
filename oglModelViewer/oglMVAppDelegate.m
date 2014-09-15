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
    mConfig = [[oglMVConfig alloc] init];

    // load data from config
    if (![mConfig readConfig])
    {
        NSLog(@"Failed to read config. Falling back to default values.");
        // default values are kept in MainMenu.xib, we just have to read them
        // nothing to do here
    }
    else
    {
        // config read successfully, apply settings to all controls
        [self.redColorSlider setFloatValue: mConfig->mBackgroundColorRed];
        [self.greenColorSlider setFloatValue: mConfig->mBackgroundColorGreen];
        [self.blueColorSlider setFloatValue: mConfig->mBackgroundColorBlue];

        NSInteger expSwitchState = mConfig->mMouseExponentialScroll ? 1 : 0;
        [self.exponentialSwitchButton setState: expSwitchState];
        [self.sensitivitySlider setFloatValue: mConfig->mMouseSensitivity];
        [self.scrollSensitivitySlider setFloatValue: mConfig->mMouseScrollSensitivity];

        NSInteger gridSwitchState = mConfig->mGridEnabled ? 1 : 0;
        NSInteger arrowSwitchState = mConfig->mXYZArrowsEnabled ? 1 : 0;
        [self.gridMenuItem setState: gridSwitchState];
        [self.arrowsMenuItem setState: arrowSwitchState];
    }

    // set required values and variables in sliders and inside oglView
    float movedValue = [self.redColorSlider floatValue] / 255.0f;
    [self.oglView setBackgroundColorRed: movedValue];
    [self.redTextLabel setStringValue:[self.redColorSlider stringValue]];

    movedValue = [self.greenColorSlider floatValue] / 255.0f;
    [self.oglView setBackgroundColorGreen: movedValue];
    [self.greenTextLabel setStringValue:[self.greenColorSlider stringValue]];

    movedValue = [self.blueColorSlider floatValue] / 255.0f;
    [self.oglView setBackgroundColorBlue: movedValue];
    [self.blueTextLabel setStringValue:[self.blueColorSlider stringValue]];

    movedValue = [self.sensitivitySlider floatValue] / 1000.0f;
    [self.oglView setSensitivity: movedValue];
    movedValue = [self.scrollSensitivitySlider floatValue] / 500.0f;
    [self.oglView setScrollSensitivity: movedValue];

    [self.oglView setGridEnabled: (bool)self.gridMenuItem.state];
    [self.oglView setArrowsEnabled: (bool)self.arrowsMenuItem.state];
    [self.oglView setNeedsDisplay: true];
}

-(void)applicationWillTerminate:(NSNotification *)notification
{
    // get current values from all controls and transfer them to mConfig
    if (mConfig)
    {
        mConfig->mMouseSensitivity = [self.sensitivitySlider floatValue];
        mConfig->mMouseScrollSensitivity = [self.scrollSensitivitySlider floatValue];
        mConfig->mMouseExponentialScroll = (bool)self.exponentialSwitchButton.state;

        mConfig->mBackgroundColorRed = [self.redColorSlider floatValue];
        mConfig->mBackgroundColorGreen = [self.greenColorSlider floatValue];
        mConfig->mBackgroundColorBlue = [self.blueColorSlider floatValue];

        mConfig->mGridEnabled = self.gridMenuItem.state;
        mConfig->mXYZArrowsEnabled = self.arrowsMenuItem.state;

        // commence config save
        if (![mConfig saveConfig])
            NSLog(@"Failed to save config");
    }
}

-(IBAction)redSliderMoved:(id) sender;
{
    // "normalize" values to 0.0f...1.0f
    float movedValue = [sender floatValue] / 255.0f;
    [self.oglView setBackgroundColorRed: movedValue];
    [self.oglView setNeedsDisplay: true];

    // update label
    [self.redTextLabel setStringValue:[self.redColorSlider stringValue]];
}

-(IBAction)greenSliderMoved:(id) sender
{
    // "normalize" values to 0.0f...1.0f
    float movedValue = [sender floatValue] / 255.0f;
    [self.oglView setBackgroundColorGreen: movedValue];
    [self.oglView setNeedsDisplay: true];

    // update label
    [self.greenTextLabel setStringValue:[self.greenColorSlider stringValue]];
}

-(IBAction)blueSliderMoved:(id) sender
{
    // "normalize" values to 0.0f...1.0f
    float movedValue = [sender floatValue] / 255.0f;
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

-(IBAction)gridMenuItemSwitched:(id) sender
{
    if (self.gridMenuItem.state)
        [self.gridMenuItem setState:NSOffState];
    else
        [self.gridMenuItem setState:NSOnState];

    [self.oglView setGridEnabled: (bool)self.gridMenuItem.state];
}

-(IBAction)arrowsMenuItemSwitched:(id) sender
{
    if (self.arrowsMenuItem.state)
        [self.arrowsMenuItem setState:NSOffState];
    else
        [self.arrowsMenuItem setState:NSOnState];

    [self.oglView setArrowsEnabled: (bool)self.arrowsMenuItem.state];
}

-(IBAction)openOBJFile:(id) sender
{
    NSOpenPanel* openDialog = [NSOpenPanel openPanel];

    [openDialog setCanChooseFiles: true];
    [openDialog setCanChooseDirectories: false];
    [openDialog setAllowsMultipleSelection: false];

    if ([openDialog runModal] == NSOKButton)
    {
        NSString* filePath = [[openDialog URLs] objectAtIndex: 0];
        NSLog(@"File opened: %@", filePath);

        if (![self.oglView openOBJFile: filePath])
        {
            NSLog(@"Failed to open OBJ file.");
            NSAlert* alert = [[NSAlert alloc] init];
            [alert addButtonWithTitle: @"OK"];
            [alert setMessageText: @"Failed to open OBJ file."];
            [alert runModal];
        }

        [self.oglView setNeedsDisplay: true];
    }
}

@end
