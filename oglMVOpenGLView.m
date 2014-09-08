//
//  oglMVOpenGLView.m
//  oglModelViewer
//
//  Created by Łukasz on 22.06.2014.
//  Copyright (c) 2014 apios. All rights reserved.
//

#import "oglMVOpenGLView.h"

@implementation oglMVOpenGLView

- (oglMVOpenGLView*)init
{
    self = [super init];

    rotationX = 0.0f;
    rotationY = 0.0f;
    return self;
}

- (void)mouseDragged:(NSEvent*) event
{
    // some basic rotation to test if everything works dynamically
    NSLog(@"DeltaX: %.1f, DeltaY: %.1f", event.deltaX, event.deltaY);
    rotationX += 0.1f * event.deltaX;
    rotationY += 0.1f * event.deltaY;

    [self setNeedsDisplay: true];
}

- (void)drawRect:(NSRect) bounds
{
    glClearColor(0.0, 0.0, 0.0, 0.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    glColor3f(1.0f, 0.85f, 0.35f);
    glRotatef(rotationX, 0.0f, 1.0f, 0.0f);
    glRotatef(rotationY, 1.0f, 0.0f, 0.0f);
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
