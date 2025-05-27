$fn=64;

module blade(x=7, y=30, border=0) {
    difference() {
        hull() {
            r = x/2-border;
            translate([0, y/2-x/2, 0]) circle(r);
            translate([0, -y/2+x/2, 0]) circle(r);
        }
        union() {
            r = y + border/4;
            l = y + x*x/y -(border/2);
            translate([l, 0, 0]) circle(r);
            translate([-l, 0, 0]) circle(r);
        }
    }
    circle(3);
}
//blade();
//color("red") translate([0, 0, 1]) blade(border=.6);

 
module flower(b=0) {
    blade(border=b);
    rotate(60) blade(border=b);
    rotate(120) blade(border=b);
}

//flower();
//color("red") translate([0, 0, 1]) flower(.8);


module spiral(b=0) {
    linear_extrude(60, twist=360)
        flower(b);
}

//spiral();
//color("green") translate([0, 0, 10]) spiral(.7);


//translate([-30, 0, 0] ) {
//    intersection() {
//        cube([30, 30, 100], center=true);
//        spiral(.8);
//    }
//}
//
//translate([30, 0, 0] ) difference() {
//    cylinder(50, 16, 16);
//    spiral();
//}
//
//
translate([0, -30, 0]) {
    difference() {
        difference() {
            cylinder(57.692, 18, 3);
            spiral();
        }
        translate([-15, -15, 55]) cube([30, 30, 30]);
    }
}

translate([0, 30, 0]) {
    intersection() {
        union() {
            translate([0, 0, 57.5]) sphere(3);
            cylinder(57.692, 18, 3);
        }
        spiral(.8);
    }
}


//cylinder(50, 18, 5);
//color("green") cylinder(57.692, 18, 3);
