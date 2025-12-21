use <perforated_sheet.scad>


//color("red", 0.5)
//difference() {
//    translate([0, 0, -1]) cube([27, 37, 10], center=true);
//    union () {
//        cube([25, 35, 10], center=true);
//    translate([0, -17.5-2.5+4, 6-1.5]) cube([8, 6, 3], center=true);
//    translate([0, -17.5-2.5+4, -2]) cube([10, 6, 9], center=true);
//    }
//}

difference() {
    union() {
        translate([0, 0, -5.5]) {
            difference() {
                cube([27, 37, 1], center=true);
                cube([25, 35, 1.1], center=true);
            }
            perforated_sheet(27, 37, 1, 1.1, 3., center=true);
        }
        translate([-13, 0, -1]) {
            rotate([0, 90, 0]) {
                difference() {
                    cube([10, 37, 1], center=true);
                    cube([8, 35, 1.1], center=true);
                }
                perforated_sheet(10, 37, 1, 1.1, 3., center=true);
            }
        }
        translate([13, 0, -1]) {
            rotate([0, 90, 0]) {
                difference() {
                    cube([10, 37, 1], center=true);
                    cube([8, 35, 1.1], center=true);
                }
                perforated_sheet(10, 37, 1, 1.1, 3., center=true);
            }
        }
        translate([0, -18, -1]) {
            rotate([90, 0, 0]) {
                difference() {
                    cube([27, 10, 1], center=true);
                    cube([25, 8, 1.1], center=true);
                }
                perforated_sheet(27, 10, 1, 0, 3., center=true);
            }
        }
        translate([0, 18, -1]) {
            rotate([90, 0, 0]) {
                difference() {
                    cube([27, 10, 1], center=true);
                    cube([25, 8, 1.1], center=true);
                }
                perforated_sheet(27, 10, 1, 1.1, 3., center=true);
            }
        }
    }
    union() {
        cube([25, 35, 10], center=true);
        translate([0, -17.5-2.5+4, 6-1.5]) cube([8, 6, 3], center=true);
        translate([0, -17.5-2.5+4, -2]) cube([10, 6, 9], center=true);
    }

}