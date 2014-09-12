//
//  oglMVModel.m
//  oglModelViewer
//
//  Created by Łukasz on 11.09.2014.
//  Copyright (c) 2014 apios. All rights reserved.
//

#import "oglMVModel.h"

@implementation oglMVModel

// parsing function - collects information about model and converts it to usable data
-(bool)parse:(NSArray*) fileLines
{
    // first round of pre parsing - calculate available groups
    for (NSString* line in fileLines)
    {
        //NSLog(@"Line: %@", line);
        NSArray* tokens = [line componentsSeparatedByString:@" "];

        // search for group
        if ([[tokens objectAtIndex: 0] isEqual: @"g"])
        {
            NSLog(@"Found group %@", [tokens objectAtIndex: 1]);

            // add new mesh (which will represent one group)
            [mMeshArray addObject: [[oglMVMesh alloc] init]];
            mMeshCount++;
            continue;
        }

        // all data found right now will belong to recently found group

        // search for vertices info (begins with "v")
        if ([[tokens objectAtIndex: 0] isEqual: @"v"])
        {
            //NSLog(@"Found vert");

            // add new mesh (which will represent one group)
            [[mMeshArray objectAtIndex: mMeshCount-1] addVertex:
                   [[tokens objectAtIndex: 1] floatValue] yCoord:
                   [[tokens objectAtIndex: 2] floatValue] zCoord:
                   [[tokens objectAtIndex: 3] floatValue]];
            continue;
        }

        // search for index info (begins with "f")
        if ([[tokens objectAtIndex: 0] isEqual: @"f"])
        {
            //NSLog(@"Found face %@", [tokens objectAtIndex: 1]);

            // add new mesh (which will represent one group)
            [[mMeshArray objectAtIndex: mMeshCount-1] addFace:
                     [[tokens objectAtIndex: 1] integerValue] bVert:
                     [[tokens objectAtIndex: 2] integerValue] cVert:
                     [[tokens objectAtIndex: 3] integerValue]];
            continue;
        }
    }

    return true;
}

-(bool)parseModel:(NSString*) path
{
    mMeshCount = 0;
    mMeshArray = [[NSMutableArray alloc] init];
    // read file
    NSString* fileContents = [NSString stringWithContentsOfFile: path
                                                       encoding:NSUTF8StringEncoding
                                                          error:nil];

    // split into strings
    NSArray* fileLines = [fileContents componentsSeparatedByCharactersInSet:
                          [NSCharacterSet newlineCharacterSet]];

    if (![self parse:fileLines])
    {
        NSLog(@"Failed to pre-parse provided file.");
        return false;
    }

    NSLog(@"Generating buffer. Mesh groups: %lu", (unsigned long)[mMeshArray count]);
    for (id mesh in mMeshArray)
    {
        [mesh generateBuffers];
    }

    return true;
}

-(unsigned long)getMeshCount
{
    return [mMeshArray count];
}



-(NSString*)getNameFromMesh:(unsigned long) mesh
{
    return [[mMeshArray objectAtIndex: mesh] getName];
}



-(unsigned int)getVertexBufferFromMesh:(unsigned long) mesh
{
    return [[mMeshArray objectAtIndex: mesh] getVBID];
}

-(unsigned int)getVertexCountFromMesh:(unsigned long) mesh
{
    return [[mMeshArray objectAtIndex: mesh] getVertexCount];
}

-(float*)getVertexPtrFromMesh:(unsigned long) mesh
{
    return [[mMeshArray objectAtIndex: mesh] getVertPtr];
}



-(unsigned int)getFaceBufferFromMesh:(unsigned long) mesh
{
    return [[mMeshArray objectAtIndex: mesh] getIBID];
}

-(unsigned int)getFaceCountFromMesh:(unsigned long) mesh
{
    return [[mMeshArray objectAtIndex: mesh] getFaceCount];
}

-(int*)getFacePtrFromMesh:(unsigned long) mesh
{
    return [[mMeshArray objectAtIndex: mesh] getFacePtr];
}

@end
