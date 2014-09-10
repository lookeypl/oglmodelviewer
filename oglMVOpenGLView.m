//
//  oglMVOpenGLView.m
//  oglModelViewer
//
//  Created by Łukasz on 22.06.2014.
//  Copyright (c) 2014 apios. All rights reserved.
//

#import "oglMVOpenGLView.h"

@implementation oglMVOpenGLView

-(void)awakeFromNib
{
    [super awakeFromNib];

    mCamera = [[oglMVCamera alloc] init];
    NSLog(@"oglMVOpenGLView::init: camera: %p", mCamera);
    mProjectionMatrix = GLKMatrix4MakePerspective(45.0f, 1.0f, 0.1f, 1000.0f);
}

- (void)mouseDragged:(NSEvent*) event
{
    [mCamera update: event.deltaX and: event.deltaY];
    [self setNeedsDisplay: true];
}

- (void)drawRect:(NSRect) bounds
{
    glClearColor(0.0, 0.0, 0.0, 0.0);
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

@end
