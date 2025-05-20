$fn=64;

module blade() {
    difference() {
        hull() {
            translate([-5, 0, 0]) circle(1);
            translate([5, 0, 0]) circle(1);
        }
        union() {
            translate([0, 15.4, 0]) circle(15);
            translate([0, -15.4, 0]) circle(15);
        }
    }
}
module inner_blade() {
    difference() {
        hull() {
            translate([-5, 0, 0]) circle(0.8);
            translate([5, 0, 0]) circle(0.8);
        }
        union() {
            translate([0, 15.2, 0]) circle(15);
            translate([0, -15.2, 0]) circle(15);
        }
    }
}

//blade();
//color("red") translate([0, 0, 1]) inner_blade();

 
module flower() {
    blade();
    rotate(60) blade();
    rotate(120) blade();
}

module inner_flower() {
    inner_blade();
    rotate(60) inner_blade();
    rotate(120) inner_blade();
}

//flower();
//color("red") translate([0, 0, 1]) inner_flower();


module spiral() {
    linear_extrude(20, twist=360, center=true) 
        flower();
}

module inner_spiral() {
    linear_extrude(20, twist=360, center=true) 
        inner_flower();
}

//spiral();
//color("green") translate([0, 0, 10]) inner_spiral();

intersection() {
    cube([100, 100, 10], center=true);
    union() {
        translate([20, 0, 0] ) inner_spiral();
        difference() {
            cylinder(20, 8, 8, center=true);
            spiral();
        }
    }
}

//translate([20, 0, 0] ) inner_spiral();
//difference() {
//    cylinder(20, 8, 8, center=true);
//    spiral();
//}
