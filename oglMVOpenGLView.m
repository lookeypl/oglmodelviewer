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
    [[self superview] setAutoresizingMask: NSViewWidthSizable|NSViewHeightSizable];

    mCamera = [[oglMVCamera alloc] init];
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

    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glLoadMatrixf(mProjectionMatrix.m);

    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    glLoadMatrixf([mCamera getViewMatrix].m);

    // grid drawing
    if (mGridEnabled)
    {
        glColor3f(0.5f, 0.5f, 0.5f);
        glBegin(GL_LINES);

        for (int i=-10; i<=10; ++i)
        {
            glVertex3f(10.0f, 0.0f, 1.0f*i);
            glVertex3f(-10.0f, 0.0f, 1.0f*i);
        }

        for (int i=-10; i<=10; ++i)
        {
            glVertex3f(i*1.0f, 0.0f, 10.0f);
            glVertex3f(i*1.0f, 0.0f,-10.0f);
        }

        glEnd();
    }

    // arrow drawing
    if (mArrowsEnabled)
    {
        glBegin(GL_LINES);

        // red arrow - X axis
        glColor3f(1.0f, 0.0f, 0.0f);
        glVertex3f(0.0f, 0.0f, 0.0f);
        glVertex3f(5.0f, 0.0f, 0.0f);
        glVertex3f(5.0f, 0.0f, 0.0f);
        glVertex3f(4.0f, 0.0f, 1.0f);
        glVertex3f(5.0f, 0.0f, 0.0f);
        glVertex3f(4.0f, 0.0f, -1.0f);

        // green arrow - Y axis
        glColor3f(0.0f, 1.0f, 0.0f);
        glVertex3f(0.0f, 0.0f, 0.0f);
        glVertex3f(0.0f, 5.0f, 0.0f);
        glVertex3f(0.0f, 5.0f, 0.0f);
        glVertex3f(0.0f, 4.0f, 1.0f);
        glVertex3f(0.0f, 5.0f, 0.0f);
        glVertex3f(0.0f, 4.0f, -1.0f);

        // blue arrow - Z axis
        glColor3f(0.0f, 0.0f, 1.0f);
        glVertex3f(0.0f, 0.0f, 0.0f);
        glVertex3f(0.0f, 0.0f, 5.0f);
        glVertex3f(0.0f, 0.0f, 5.0f);
        glVertex3f(1.0f, 0.0f, 4.0f);
        glVertex3f(0.0f, 0.0f, 5.0f);
        glVertex3f(-1.0f, 0.0f, 4.0f);

        glEnd();
    }

    glColor3f(1.0f, 0.85f, 0.3f);

    // draw model if it is available
    if (mModel)
    {
        for (unsigned long i=0; i<[mModel getMeshCount]; ++i)
        {
            if ([mModel getVertexBufferFromMesh:i])
            {
                // vertex buffer created, render regularly
                glEnableClientState(GL_VERTEX_ARRAY);
                glBindBuffer(GL_ARRAY_BUFFER, [mModel getVertexBufferFromMesh:i]);
                glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, [mModel getFaceBufferFromMesh:i]);
                glDrawElements(GL_TRIANGLES, [mModel getFaceCountFromMesh:i]*3, GL_UNSIGNED_INT, 0);
                glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
                glBindBuffer(GL_ARRAY_BUFFER, 0);
                glDisableClientState(GL_VERTEX_ARRAY);
            }
            else
            {
                // there is no vertex buffer - fall back to classic rendering
                NSLog(@"Vertex buffer not allocated - falling back to fixed function rendering");
                float* vertPtr = [mModel getVertexPtrFromMesh:i];
                int* facePtr = [mModel getFacePtrFromMesh:i];

                glBegin(GL_TRIANGLES);
                for(unsigned int j=0; j<[mModel getFaceCountFromMesh:i]*3; j+=3)
                {
                    glVertex3f(vertPtr[facePtr[j]*3], vertPtr[(facePtr[j]*3)+1], vertPtr[(facePtr[j]*3)+2]);
                    glVertex3f(vertPtr[facePtr[j+1]*3], vertPtr[(facePtr[j+1]*3)+1], vertPtr[(facePtr[j+1]*3)+2]);
                    glVertex3f(vertPtr[facePtr[j+2]*3], vertPtr[(facePtr[j+2]*3)+1], vertPtr[(facePtr[j+2]*3)+2]);
                }
                glEnd();
            }
        }
    }

    glFlush();
}

-(void)reshape
{
    NSSize viewSize = self.window.frame.size;
    mWindowWidth = viewSize.width;
    mWindowHeight = viewSize.height;

    NSRect rect = NSMakeRect(0.0, 0.0, mWindowWidth, mWindowHeight);
    [self setFrame: rect];

    mProjectionMatrix = GLKMatrix4MakePerspective(45.0f, mWindowWidth/mWindowHeight, 0.1f, 1000.0f);
}

// additional externally visible methods
-(bool)openOBJFile:(NSString*) path
{
    mModel = [[oglMVModel alloc] init];

    return [self->mModel parseModel: path];
}

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

-(void)setGridEnabled:(bool) enabled
{
    mGridEnabled = enabled;
    [self setNeedsDisplay: true];
}

-(void)setArrowsEnabled:(bool) enabled
{
    mArrowsEnabled = enabled;
    [self setNeedsDisplay: true];
}

@end
