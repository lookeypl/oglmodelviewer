//
//  oglMVMesh.m
//  oglModelViewer
//
//  Created by Łukasz on 11.09.2014.
//  Copyright (c) 2014 apios. All rights reserved.
//

#import "oglMVMesh.h"
#include <OpenGL/gl.h>

@implementation oglMVMesh

-(oglMVMesh*)init
{
    mVertices = [[NSMutableArray alloc] init];
    mFaces = [[NSMutableArray alloc] init];

    mVBID = 0;
    mIBID = 0;

    return self;
}

-(oglMVMesh*)initWithName:(NSString*) name
{
    mMeshName = name;

    return self.init;
}

-(NSString*)getName
{
    return mMeshName;
}

-(unsigned int)getVBID
{
    return mVBID;
}

-(float*)getVertPtr
{
    return mVertPtr;
}

-(unsigned int)getVertexCount
{
    return mVertexCount;
}

-(unsigned int)getIBID
{
    return mIBID;
}

-(int*)getFacePtr
{
    return mFacePtr;
}

-(unsigned int)getFaceCount
{
    return mFaceCount;
}

-(void)addVertex:(float) x yCoord:(float) y zCoord:(float) z
{
    [mVertices addObject: [NSNumber numberWithFloat:x]];
    [mVertices addObject: [NSNumber numberWithFloat:y]];
    [mVertices addObject: [NSNumber numberWithFloat:z]];

    mVertexCount++;
}

-(void)addFace:(long) a bVert:(long) b cVert:(long) c
{
    [mFaces addObject: [NSNumber numberWithLong:a]];
    [mFaces addObject: [NSNumber numberWithLong:b]];
    [mFaces addObject: [NSNumber numberWithLong:c]];

    mFaceCount++;
}

-(void)generateBuffers
{
    // vertex buffer
    glGenBuffers(1, &mVBID);
    glBindBuffer(GL_ARRAY_BUFFER, mVBID);
    unsigned long vertCount = (unsigned long)[mVertices count];
    mVertPtr = malloc(sizeof(float) * vertCount);

    for (unsigned long i=0; i<vertCount; ++i)
        mVertPtr[i] = [[mVertices objectAtIndex:i] floatValue];

    glBufferData(GL_ARRAY_BUFFER, sizeof(float)*vertCount, mVertPtr, GL_STATIC_DRAW);
    glVertexPointer(3, GL_FLOAT, 0, 0);
    glBindBuffer(GL_ARRAY_BUFFER, 0);

    // index buffer
    glGenBuffers(1, &mIBID);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, mIBID);
    unsigned long faceCount = (unsigned long)[mFaces count];
    mFacePtr = malloc(sizeof(int) * faceCount);

    for (unsigned long i=0; i<faceCount; ++i)
    {
        // correction for relative vertex numbers
        if (mFacePtr[i] < 0)
        {
            mFacePtr[i] += mVertexCount;
            mFacePtr[i] = (int)[[mFaces objectAtIndex:i] integerValue];
        }
        else
        {
            mFacePtr[i] = (int)[[mFaces objectAtIndex:i] integerValue]-1;
        }
    }

    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(int)*faceCount, mFacePtr, GL_STATIC_DRAW);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
}

-(void)dealloc
{
    if (mVBID)
    {
        glDeleteBuffers(1, &mVBID);
        mVBID = 0;
    }

    if (mIBID)
    {
        glDeleteBuffers(1, &mIBID);
        mIBID = 0;
    }

    if (mVertPtr)
    {
        free(mVertPtr);
        mVertPtr = 0;
    }

    if (mFacePtr)
    {
        free(mFacePtr);
        mFacePtr = 0;
    }
}

@end
