
$fn=50;

use <modules/isocahedron.scad>

scale(18) intersection() {
    difference() {
        sphere(0.95);
        sphere(0.88);
    }
    isocahedron(initial_depth=3, thickness=1, scale=1.4, type=2);
}