
$fn=50;

use <modules/isocahedron.scad>

scale(18) difference() {
    difference() {
        sphere(.95);
        sphere(.88);
    }
    isocahedron(initial_depth=3, scale=0.7, type=3);
}
