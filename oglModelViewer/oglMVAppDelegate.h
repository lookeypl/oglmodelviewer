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

-(IBAction)redSliderMoved:(id) sender;
-(IBAction)greenSliderMoved:(id) sender;
-(IBAction)blueSliderMoved:(id) sender;

@end
