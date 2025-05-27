difference() {
    union() {
        resize([106, 7, 5]){
            translate([15, 2.5, 2.5] ) {
                rotate([0, 90, 0]) {
                    cylinder(h=106, r=2.5, $fn=30);
                }
            }
                //cube([106,7,5],false);
        }
        resize([15.05, 7, 5]) {
            translate([0, 3.5, 3.5] ) {
                rotate([0, 90, 0]) {
                    rotate([0, 0, 45]) {
                        cylinder(h=15, r1=0.5, r2=3.5, center=false, $fn=30);
                    }
                }
            }
        }

        translate([121, 3.5, 1.5]) {
            cylinder(h=2, r=3.2, $fn=20);
        }
    }
    translate([121, 3.5, -3]) {
        cylinder(h=10, r=1.7, $fn=20);
    }
}

