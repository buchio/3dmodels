$fn=64;

module blade(x=5, y=20, border=0) {
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
}
//blade();
//color("red") translate([0, 0, 1]) blade(border=.6);

 
module flower(b=0) {
    blade(border=b);
    rotate(60) blade(border=b);
    rotate(120) blade(border=b);
}

//flower();
//color("red") translate([0, 0, 1]) flower(.6);


module spiral(b=0) {
    linear_extrude(60, twist=360, center=true) 
        flower(b);
}

//spiral();
//color("green") translate([0, 0, 10]) spiral(.7);

intersection() {
    cube([100, 100, 30], center=true);
    union() {
        translate([-20, 0, 0] ) spiral(.7);
        translate([20, 0, 0] ) difference() {
            cylinder(60, 12, 12, center=true);
            spiral();
        }
    }
}

translate([0, -20, 0]) {
    difference() {
        cylinder(30, 12, 3, center=true);
        spiral(.7);
    }
}

translate([0, 20, 0]) {
    intersection() {
        cylinder(30, 12, 3, center=true);
        spiral();
    }
}