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

    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glLoadMatrixf(mProjectionMatrix.m);

    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    glLoadMatrixf([mCamera getViewMatrix].m);

    /*glBegin(GL_TRIANGLES);
    {
        glColor3f(1.0f, 0.85f, 0.35f);
        glVertex3f( 0.0, 0.6, 0.0);
        glVertex3f(-0.2,-0.3, 0.0);
        glVertex3f( 0.2,-0.3, 0.0);
    }
    glEnd();*/

    if (mModel)
    {
        for (unsigned long i=0; i<[mModel getMeshCount]; ++i)
        {
            if ([mModel getVertexBufferFromMesh:i])
            {
                // vertex buffer created, render regularly
                glEnableClientState(GL_VERTEX_ARRAY);

                glBindBuffer(GL_ARRAY_BUFFER, [mModel getVertexBufferFromMesh:i]);
                glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, [mModel getVertexBufferFromMesh:i]);
                glDrawArrays(GL_POINTS, 0, 1);
                glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
                glBindBuffer(GL_ARRAY_BUFFER, 0);
                glDisableClientState(GL_VERTEX_ARRAY);
            }
            else
            {
                // there is no vertex buffer - fall back to classic rendering
                float* vertPtr = [mModel getVertexPtrFromMesh:i];
                int* facePtr = [mModel getFacePtrFromMesh:i];

                glBegin(GL_TRIANGLES);
                glColor3f(1.0f, 0.85f, 0.35f);
                for(unsigned int j=0; j<[mModel getFaceCountFromMesh:i]*3; j+=3)
                {
                    glVertex3f(vertPtr[(facePtr[j]-1)*3], vertPtr[((facePtr[j]-1)*3)+1], vertPtr[((facePtr[j]-1)*3)+2]);
                    glVertex3f(vertPtr[(facePtr[j+1]-1)*3], vertPtr[((facePtr[j+1]-1)*3)+1], vertPtr[((facePtr[j+1]-1)*3)+2]);
                    glVertex3f(vertPtr[(facePtr[j+2]-1)*3], vertPtr[((facePtr[j+2]-1)*3)+1], vertPtr[((facePtr[j+2]-1)*3)+2]);
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

@end
