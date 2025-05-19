
$fn=50;

use <modules/isocahedron.scad>

scale(15) difference() {
    difference() {
        sphere(.9);
        sphere(.8);
    }
    isocahedron(initial_depth=2, thickness=10, scale=0.7, type=3);
}
//scale(15)    isocahedron(initial_depth=2, thickness=10, scale=0.7, type=3);

      
        




