

difference() {
    union() {
        translate([10.5, 0, 0]) {
            cube([4,18,20], center = true);
        }
        cylinder(h=20, r=12.5, center=true);
    }
    cylinder(h=25, r=10, center=true);
};

translate([13.5, 0, 0]) {
    rotate([0,90,0]) {
        translate([-5, 0, 0]) {
            difference() {
                translate([5,0,0]) {
                    cylinder(h=4, r=12, center=true);
                }
                cylinder(h=5, r=12, center=true);
            }
        }
    }
    rotate([45, 0, 0]) {
        difference() {
            cube([4,30,30], center = true);
            translate([4, 0, 0]) {
                cube([6,28,28], center = true);
            }
        }
    }
}