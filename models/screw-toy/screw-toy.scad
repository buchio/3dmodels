include <BOSL2/std.scad>

$fn=64;


module flower(a, r, t) {
    translate([0, sqrt(3)/2*a, 0])
    glued_circles(d=a*r, spread=a, tangent=t);

    rotate([0, 0, 60])
    translate([0, sqrt(3)/2*a, 0])
    glued_circles(d=a*r, spread=a, tangent=t);

    rotate([0, 0, 120])
    translate([0, sqrt(3)/2*a, 0])
    glued_circles(d=a*r, spread=a, tangent=t);

    rotate([0, 0, 180])
    translate([0, sqrt(3)/2*a, 0])
    glued_circles(d=a*r, spread=a, tangent=t);

    rotate([0, 0, 240])
    translate([0, sqrt(3)/2*a, 0])
    glued_circles(d=a*r, spread=a, tangent=t);

    rotate([0, 0, 300])
    translate([0, sqrt(3)/2*a, 0])
    glued_circles(d=a*r, spread=a, tangent=t);

    hexagon(ir=a);
}

//circle(r=12);
//translate([0, 0, 1])
//color("red") flower(8., .7, 20);
//circle(r=12);
//translate([0, 0, 2])
//rotate([0, 0, 0])
//color("green") hexagon(d=20);

h1 = 42;
h2 = 40;
tw = 13;
translate([30, 0, 0])
difference() {
    cylinder(r=12, h=44);
    {
        translate([0, 0, 4]) linear_extrude(h1, twist=tw*h1) flower(8.2, .7, 20);
        translate([0, 12, 0]) cylinder(r=.5, h=44);
    }
}

difference() {
    cylinder(r=12, h=10);
    translate([0, 12, 0]) cylinder(r=.5, h=10);
}
translate([0, 0, 10]) {
    difference() {
        linear_extrude(h2, twist=tw*h2) hexagon(d=20);
        cylinder(r=6.5, h=h2);
    }
}
