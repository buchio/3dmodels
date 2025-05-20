$fn=16;

use <modules/isocahedron.scad>

scale(18*.95) intersection() {
    sphere(1, $fn=32);
    isocahedron(initial_depth=2, thickness=.05, scale=0.7, type=3);
}

