
$fn=50;

use <modules/isocahedron.scad>

intersection() {
    difference() {
        sphere(0.90);
        sphere(0.87);
    }
    isocahedron(initial_depth=3, scale=1.3, type=3);
}
      
        




