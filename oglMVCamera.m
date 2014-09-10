//
//  oglMVCamera.m
//  oglModelViewer
//
//  Created by Łukasz on 01.09.2014.
//  Copyright (c) 2014 apios. All rights reserved.
//

#import "oglMVCamera.h"
#include <GLKit/GLKit.h>

@implementation oglMVCamera

-(oglMVCamera*)init
{
    // mUp will tell us where "up" in 3D world is, let's assume up is in (0.0f, 1.0f, 0.0f)
    mUp = GLKVector4Make(0.0f, 1.0f, 0.0f, 0.0f);

    // mDir will always point to the center of our world, we'll leave it as it is
    mDir = GLKVector4Make(0.0f, 0.0f, 0.0f, 0.0f);

    // mPos should be moved away from center, to avoid issues with mDir-mPos calculation
    mPos = GLKVector4Make(2.0f, 2.0f, 2.0f, 0.0f);

    // construct mViewMatrix from supplied data
    mViewMatrix = GLKMatrix4MakeLookAt(mPos.v[0], mPos.v[1], mPos.v[2],
                                       mDir.v[0], mDir.v[1], mDir.v[2],
                                       mUp.v[0], mUp.v[1], mUp.v[2]);

    return self;
}

// translates mouse deltaX and deltaY to valid vector triplet: pos, dir, up
// and builds viewMatrix to use in OpenGL transformations
-(void)update:(float) deltaX and: (float) deltaY;
{
    NSLog(@"oglMVCamera::update: DeltaX: %.1f, DeltaY: %.1f", deltaX, deltaY);

    // save current distance to center for further use
    float distToCenter = GLKVector4Length(mPos);

    // calculate support vectors
    GLKVector4 forwardNorm = GLKVector4Normalize(GLKVector4Subtract(mDir, mPos));
    GLKVector4 sideNorm = GLKVector4Normalize(GLKVector4CrossProduct(mUp, forwardNorm));
    GLKVector4 upNorm = GLKVector4CrossProduct(forwardNorm, sideNorm);

    // calculate new position of camera
    mPos = GLKVector4Add(mPos, GLKVector4MultiplyScalar(sideNorm, deltaX * 0.05f));
    mPos = GLKVector4Add(mPos, GLKVector4MultiplyScalar(upNorm, deltaY * 0.05f));

    // recalculate "forward" support vector
    GLKVector4 forward = GLKVector4Subtract(mDir, mPos);
    forwardNorm = GLKVector4Normalize(forward);

    // correct position to keep moving in circle
    mPos = GLKVector4Add(mPos, GLKVector4MultiplyScalar(forwardNorm, GLKVector4Length(forward) - distToCenter));

    mViewMatrix = GLKMatrix4MakeLookAt(mPos.v[0], mPos.v[1], mPos.v[2],
                                       mDir.v[0], mDir.v[1], mDir.v[2],
                                       mUp.v[0], mUp.v[1], mUp.v[2]);
}

-(GLKVector4)getPos
{
    return mPos;
}

-(GLKVector4)getDir
{
    return mDir;
}

-(GLKVector4)getUp;
{
    return mUp;
}

-(GLKMatrix4)getViewMatrix
{
    return mViewMatrix;
}

@end
