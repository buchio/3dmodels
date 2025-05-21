$fn=16;

use <modules/isocahedron.scad>

scale(18*.95) intersection() {
    sphere(1, $fn=32);
    scale(0.965) isocahedron(initial_depth=3, thickness=.04, scale=0.7, type=3);
}

