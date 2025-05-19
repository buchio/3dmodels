
$fn=50;

use <modules/isocahedron.scad>

scale(18) {
    difference() {
        difference() {
            sphere(0.95);
            sphere(0.88);
        }
        isocahedron(initial_depth=2,scale=0.7);
    }
    //isocahedron(initial_depth=2,scale=0.6);
}  
        




