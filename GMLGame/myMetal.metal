//
//  myMetal.metal
//  GMLGame
//
//  Created by guominglong on 16/1/25.
//  Copyright © 2016年 guominglong. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

vertex float4 basic_vertex(const device packed_float3 * vertex_array[[buffer(0)]],unsigned int vid[[vertex_id]])
{
    return float4(vertex_array[vid],1.0);
}



