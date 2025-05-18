
$fn=50;

use <modules/isocahedron.scad>

difference() {
    difference() {
        sphere(0.90);
        sphere(0.87);
    }
    isocahedron(initial_depth=2, scale=0.7, type=3);
}
      
        




