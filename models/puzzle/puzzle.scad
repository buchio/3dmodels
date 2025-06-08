
width = 10;
length = 85;
t = 17;


module stick1_1() {
    translate([t, 0, 0]) {
        difference() {
            rotate([0, 0, 0]) {
                translate([-t, 0, 0]) cube([width, length, width], center=true);
            }
            union() {
                rotate([0, 0, 60]) {
                    translate([t, 0, width*.375]) cube([width*1.1, length, width/4], center=true);
                    translate([-t, 0, width*.375]) cube([width*1.1, length, width/4], center=true);
                }
                rotate([0, 0, 120]) {
                    translate([t, 0, -width*.375]) cube([width*1.1, length, width/4], center=true);
                    translate([-t, 0, -width*.375]) cube([width*1.1, length, width/4], center=true);
                }
            }
        }
    }
}

module stick1_2() {
    rotate([0, 180, 0]) stick1_1();
}

module stick2_1() {
    translate([t, 0, 0]) {
        difference() {
            rotate([0, 0, 0]) {
                translate([-t, 0, 0]) cube([width, length, width], center=true);
            }
            union() {
                rotate([0, 0, 60]) {
                    translate([t, 0, width*.125]) cube([width*1.1, length, width*.75], center=true);
                    translate([-t, 0, width*.125]) cube([width*1.1, length, width*.75], center=true);
                }
                rotate([0, 0, 120]) {
                    translate([t, 0, -width*.125]) cube([width*1.1, length, width*.75], center=true);
                    translate([-t, 0, -width*.125]) cube([width*1.1, length, width*.75], center=true);
                }
            }
        }
    }
}

module stick2_2() {
    rotate([0, 180, 0]) stick2_1();
}

//translate([0, 0, 15]) stick1_1();
//translate([0, 0, 30]) stick2_1();
//translate([0, 0, 45]) stick1_2();
//translate([0, 0, 60]) stick2_2();

translate([80, 0, 0]) rotate([0, 90, 0]) stick1_1();
translate([100, 0, 0]) rotate([0, 90, 0]) stick2_1();


//rotate([0, 0, 0]) {
//    color("navy", .3) translate([t, 0, 0]) stick2_2();
//    color("blue", .3) translate([-t, 0, 0]) stick2_1();
//}
//rotate([0, 0, 60]) {
//    color("darkred", .3) translate([t, 0, 0]) stick2_2();
//    color("red", .3) translate([-t, 0, 0]) stick2_1();
//}
//rotate([0, 0, 120]) {
//    color("darkgreen", .3) translate([t, 0, 0]) stick1_2();
//    color("green", .3) translate([-t, 0, 0]) stick1_1();
//}
