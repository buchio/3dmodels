difference() {
    cylinder(10, 23, 20, $fn=100, center = true);
    {
        translate([0, 0, 2] ) {
            cylinder(10, 18, 18, $fn=100, center = true);
        }
        cylinder(10.1, .5, 7, $fn=100, center = true);
    }
};