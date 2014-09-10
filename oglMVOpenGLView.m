//
//  oglMVOpenGLView.m
//  oglModelViewer
//
//  Created by Łukasz on 22.06.2014.
//  Copyright (c) 2014 apios. All rights reserved.
//

#import "oglMVOpenGLView.h"

@implementation oglMVOpenGLView

// overloaded methods
-(void)awakeFromNib
{
    [super awakeFromNib];
    [[self superview] setAutoresizingMask: NSViewWidthSizable];

    mCamera = [[oglMVCamera alloc] init];
    NSLog(@"oglMVOpenGLView::init: camera: %p", mCamera);
    for(int i=0; i<3; ++i)
        mBackgroundColor[i] = 0.0f;
}

-(void)mouseDragged:(NSEvent*) event
{
    [mCamera update: event.deltaX and: event.deltaY];
    [self setNeedsDisplay: true];
}

-(void)scrollWheel:(NSEvent*) event
{
    [mCamera updateZoom: event.deltaY];
    [self setNeedsDisplay: true];
}

-(void)drawRect:(NSRect) bounds
{
    glClearColor(mBackgroundColor[0], mBackgroundColor[1], mBackgroundColor[2], 0.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    glColor3f(1.0f, 0.85f, 0.35f);

    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glLoadMatrixf(mProjectionMatrix.m);

    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    glLoadMatrixf([mCamera getViewMatrix].m);

    glBegin(GL_TRIANGLES);
    {
        glVertex3f( 0.0, 0.6, 0.0);
        glVertex3f(-0.2,-0.3, 0.0);
        glVertex3f( 0.2,-0.3, 0.0);
    }
    glEnd();

    glFlush();
}

-(void)reshape
{
    NSSize viewSize = self.window.frame.size;
    mWindowWidth = viewSize.width;
    mWindowHeight = viewSize.height;

    mProjectionMatrix = GLKMatrix4MakePerspective(45.0f, mWindowWidth/mWindowHeight, 0.1f, 1000.0f);
}

// additional externally visible methods
-(void)setBackgroundColorRed:(float) red
{
    mBackgroundColor[0] = red;
}

-(void)setBackgroundColorGreen:(float) green
{
    mBackgroundColor[1] = green;
}

-(void)setBackgroundColorBlue:(float) blue
{
    mBackgroundColor[2] = blue;
}

-(void)setSensitivity:(float) sensitivity
{
    [self->mCamera setSensitivity: sensitivity];
}

-(void)setScrollSensitivity:(float) sensitivity
{
    [self->mCamera setScrollSensitivity: sensitivity];
}

-(void)setExponentialZoom:(bool) enabled
{
    [self->mCamera setExponentialZoom: enabled];
}

@end
