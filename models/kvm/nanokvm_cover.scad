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

iw = 23.1;
ih = 36;
iz = 10;
th = 1.5;
p1 = 1;
p2 = 3;

translate([10.55, -ih/2+th*2, -(th/2+2)]) cube([5, 5+th, 6+th], center=true);
translate([-10.55, -ih/2+th*2, -(th/2+2)]) cube([5, 5+th, 6+th], center=true);

difference() {
    union() {
        translate([0, 0, -(iz+th)/2]) {
            difference() {
                cube([iw+th*2, ih+th*2, th], center=true);
                cube([iw, ih, th*1.1], center=true);
            }
            translate([0, -15, 0]) cube([14, 8, th], center=true);
            perforated_sheet(iw+th*2, ih+th*2, th, p1, p2, center=true);
        }
        translate([-(iw+th)/2, 0, 0]) {
            rotate([0, 90, 0]) {
                difference() {
                    cube([iz, ih+th*2, th], center=true);
                    cube([iz-th*2, ih, th*1.1], center=true);
                }
                perforated_sheet(iz, ih+th*2, th, p1, p2, center=true);
            }
        }
        translate([(iw+th)/2, 0, 0]) {
            rotate([0, 90, 0]) {
                difference() {
                    cube([iz, ih+th*2, th], center=true);
                    cube([iz-th*2, ih, th*1.1], center=true);
                }
                perforated_sheet(iz, ih+th*2, th, p1, p2, center=true);
            }
        }
        translate([0, -(ih+th)/2, 0]) {
            rotate([90, 0, 0]) {
                difference() {
                    cube([iw+th*2, iz, th], center=true);
                    cube([iw, iz-th*2, th*1.1], center=true);
                }
                perforated_sheet(iw+th*2, iz, th, 0, 1., center=true);
            }
        }
        translate([0, (ih+th)/2, 0]) {
            rotate([90, 0, 0]) {
                difference() {
                    cube([iw+th*2, iz, th], center=true);
                    cube([iw, iz-th*2, th*1.1], center=true);
                }
                perforated_sheet(iw, iz, th, p1, p2, center=true);
            }
        }
    }
    union() {
        cube([iw, ih, iz], center=true);
        translate([0, -16, -1]) cube([13, 8, 13], center=true);
    }

}

