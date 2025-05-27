
$fn=50;

use <modules/isocahedron.scad>

module cuttingcube() {
    translate([-1, -1, 0]) 
        cube(4);
}

difference() {
    {
        difference() {
            difference() {
                sphere(0.90);
                sphere(0.86);
            }
            isocahedron(thickness=0.3);
        }
    }
    cuttingcube();
}
      
        




