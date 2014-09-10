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
}

- (void)drawRect:(NSRect) bounds;

@end
