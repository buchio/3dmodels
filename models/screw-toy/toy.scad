include <BOSL2/std.scad>
use <cylinder.scad>

$fn=64;


module flower(a, r, t) {
    render(convexity = 2) {
        for(p = [0:60:300]) {
            rotate([0, 0, p])
            translate([0, sqrt(3)/2*a, 0])
            glued_circles(d=a*r, spread=a, tangent=t);
        }
        hexagon(ir=a);
    }
}

//circle(r=12);
//translate([0, 0, 1])
//color("red") flower(8., .7, 20);
//circle(r=12);
//translate([0, 0, 2])
//rotate([0, 0, 0])
//color("green") hexagon(d=20);

r = 13;
h = 55;
tw = -13.1;


module cyl() {
    //translate([0, 0, 55/2]) shippou(13, 54, .5);
    translate([0, 0, 55/2]) hemp(13, 54, .5);
    //cylinder(r=r, h=55);
    
    cylinder(r=r, h=1);
    translate([0, 0, 54])
    cylinder(r=r, h=1);
}


tp = [15, 0, (h-10)/2, 180, -12.5];
//tp = [0, 10, 0, 0, 0];

translate([-tp[0], 0, tp[1]]) {
    translate([0, 0, tp[2]])
    rotate([tp[3], 0, 0])
    translate([0, 0, -tp[2]-10]) {
        difference() {
            difference() {
                cyl();
                translate([0, 0, 5]) cube([26, 26, 10], center=true);
            }
            {
                translate([0, 0, 10]) cylinder(h=3, r1=r*.95, r2=5);
                difference() {
                    linear_extrude(h, twist=tw*h) flower(8.2, .7, 20);
                    {
                        translate([0, 0, h]) cube([r*2, r*2, 5], center=true);
                    }
                }
            }
        }
    }
}

translate([tp[0], 0, 0]) {
    rotate([0, 0, tp[4]])
    difference() {
        cyl();
        {
            translate([0, 0, 10-3]) cylinder(h=3, r1=5, r2=r*.95);
            translate([0, 0, 55/2+10]) cube([26, 26, 55], center=true);
        }
    }
    
    
    difference() {
        linear_extrude(h, twist=tw*h) hexagon(d=20);
        {
            translate([0, 0, h]) cube([r*2, r*2, 8], center=true);
            cylinder(r=r/2, h=h);
        }
    }
}
