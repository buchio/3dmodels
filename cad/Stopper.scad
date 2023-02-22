difference() {
    cylinder(10, 23, 20, $fn=100, center = true);
    {
        translate([0, 0, 3] ) {
            cylinder(15, 18, 18, $fn=100, center = true);
        }
        cylinder(20, 1, 1, $fn=100, center = true);
        translate([0, 25, 0] ) {
            cube([0.5, 50, 30], center = true);
        }
        
    }
};