include <BOSL2/std.scad>
include <BOSL2/isosurface.scad>

$fn=5;

//spec = [
//    left(9), mb_sphere(1),
//    left(0), mb_sphere(2),
//    right(9), mb_sphere(1)
//];
//metaballs(spec, voxel_size=0.5,
//    bounding_box=[[-16,-7,-7], [16,7,7]]);

    
path = [[-20,0,0], [0,0,0], [0,-10,0]];
spec = [
        move([0, 0, 0]), mb_sphere(2),
//        move([10, 0, 0]), mb_sphere(3),
        move([0, 0, 0]), mb_connector([0, 0, 0], [10, 0, 0], 2),
];
metaballs(spec, voxel_size=0.9,
    bounding_box=[[-20,-20,-20], [20,20,20]]);