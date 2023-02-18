

difference() {
    union() {
        translate([10.5, 0, 0]) {
            cube([4,18,20], center = true);
        }
        cylinder(h=20, r=12.5, center=true);
    }
    cylinder(h=25, r=11, center=true);
};

translate([13.5, 0, 0]) {
    rotate([0,90,0]) {
        translate([-8, 0, 0]) {
            difference() {
                {
                    translate([6,0,0]) {
                        cylinder(h=4, r=13, center=true);
                    }
                }
                {
                    cylinder(h=6, r=12.5, center=true);
                    cube([10, 50, 20], center=true);
                }
            }
            translate([5,12.15,0]) cylinder(h=4, r=.75, center=true, $fn=20);
            translate([5,-12.15,0]) cylinder(h=4, r=.75, center=true, $fn=20);
            
        }
    }
    rotate([45, 0, 0]) {
        difference() {
            cube([4,30,30], center = true);
            translate([3.8, 0, 0]) {
                cube([6,28,28], center = true);
            }
        }
    }
}