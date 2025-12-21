use <perforated_sheet.scad>


//color("red", 0.5)
//difference() {
//    translate([0, 0, -1]) cube([27, 37, 10], center=true);
//    union () {
//        cube([23, 36, 10], center=true);
//    translate([0, -17.5-2.5+4, 6-1.5]) cube([8, 6, 3], center=true);
//    translate([0, -17.5-2.5+4, -2]) cube([10, 6, 9], center=true);
//    }
//}

difference() {
    union() {
        translate([0, 0, -5.5]) {
            difference() {
                cube([25, 38, 1], center=true);
                cube([23, 36, 1.1], center=true);
            }
            translate([0, -15, 0]) cube([14, 8, 1], center=true);
            perforated_sheet(25, 38, 1, 1.1, 3., center=true);
        }
        translate([-12, 0, -1]) {
            rotate([0, 90, 0]) {
                difference() {
                    cube([10, 38, 1], center=true);
                    cube([8, 36, 1.1], center=true);
                }
                perforated_sheet(10, 37, 1, 1.1, 3., center=true);
            }
        }
        translate([12, 0, -1]) {
            rotate([0, 90, 0]) {
                difference() {
                    cube([10, 38, 1], center=true);
                    cube([8, 36, 1.1], center=true);
                }
                perforated_sheet(10, 37, 1, 1.1, 3., center=true);
            }
        }
        translate([0, -18.5, -1]) {
            rotate([90, 0, 0]) {
                difference() {
                    cube([25, 10, 1], center=true);
                    cube([23, 8, 1.1], center=true);
                }
                perforated_sheet(25, 10, 1, 0, 3., center=true);
            }
        }
        translate([0, 18.5, -1]) {
            rotate([90, 0, 0]) {
                difference() {
                    cube([25, 10, 1], center=true);
                    cube([23, 8, 1.1], center=true);
                }
                perforated_sheet(25, 10, 1, 1.1, 3., center=true);
            }
        }
    }
    union() {
        cube([23, 36, 10], center=true);
        translate([0, -16, -1]) cube([12, 7, 12], center=true);
    }

}

