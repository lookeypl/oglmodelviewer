//
//  oglMVAppDelegate.h
//  oglModelViewer
//
//  Created by Łukasz on 21.06.2014.
//  Copyright (c) 2014 apios. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "oglMVOpenGLView.h"

@interface oglMVAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow* window;
@property (assign) IBOutlet oglMVOpenGLView* oglView;

@property (assign) IBOutlet NSWindow* preferencesWindow;
@property (assign) IBOutlet NSSlider* redColorSlider;
@property (assign) IBOutlet NSSlider* greenColorSlider;
@property (assign) IBOutlet NSSlider* blueColorSlider;

@property (assign) IBOutlet NSTextField* redTextLabel;
@property (assign) IBOutlet NSTextField* greenTextLabel;
@property (assign) IBOutlet NSTextField* blueTextLabel;

@property (assign) IBOutlet NSSlider* sensitivitySlider;
@property (assign) IBOutlet NSSlider* scrollSensitivitySlider;
@property (assign) IBOutlet NSButton* exponentialSwitchButton;

-(IBAction)redSliderMoved:(id) sender;
-(IBAction)greenSliderMoved:(id) sender;
-(IBAction)blueSliderMoved:(id) sender;

-(IBAction)sensitivitySliderMoved:(id) sender;
-(IBAction)scrollSensitivitySliderMoved:(id) sender;
-(IBAction)exponentialScrollSwitched:(id) sender;

-(IBAction)openOBJFile:(id) sender;

-(NSSize)windowWillResize:(NSWindow*) sender toSize:(NSSize) frameSize;

@end

