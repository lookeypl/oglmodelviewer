//
//  oglMVOpenGLView.h
//  oglModelViewer
//
//  Created by Łukasz on 22.06.2014.
//  Copyright (c) 2014 apios. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "oglMVCamera.h"
#include <OpenGL/gl.h>

@interface oglMVOpenGLView : NSOpenGLView
{
@private
    oglMVCamera* mCamera;
    GLKMatrix4 mProjectionMatrix;
    float mBackgroundColor[3];
}

-(void)setBackgroundColorRed:(float) red;
-(void)setBackgroundColorGreen:(float) green;
-(void)setBackgroundColorBlue:(float) blue;
-(void)drawRect:(NSRect) bounds;

@end
