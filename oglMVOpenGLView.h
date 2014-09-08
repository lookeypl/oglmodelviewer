//
//  oglMVOpenGLView.h
//  oglModelViewer
//
//  Created by Łukasz on 22.06.2014.
//  Copyright (c) 2014 apios. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#include <OpenGL/gl.h>

@interface oglMVOpenGLView : NSOpenGLView
{
@private
    float rotationX;
    float rotationY;
}

- (void)drawRect:(NSRect) bounds;

@end
