//
//  oglMVOpenGLView.h
//  oglModelViewer
//
//  Created by Łukasz on 22.06.2014.
//  Copyright (c) 2014 apios. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "oglMVCamera.h"
#import "oglMVModel.h"
#include <OpenGL/gl.h>

@interface oglMVOpenGLView : NSOpenGLView
{
@private
    // window details
    float mWindowWidth, mWindowHeight;

    // opengl stuff
    oglMVCamera* mCamera;
    GLKMatrix4 mProjectionMatrix;
    float mBackgroundColor[3];

    // model file
    oglMVModel* mModel;
}

-(bool)openOBJFile:(NSString*) path;

-(void)setBackgroundColorRed:(float) red;
-(void)setBackgroundColorGreen:(float) green;
-(void)setBackgroundColorBlue:(float) blue;
-(void)setSensitivity:(float) sensitivity;
-(void)setScrollSensitivity:(float) sensitivity;
-(void)setExponentialZoom:(bool) enabled;

@end
