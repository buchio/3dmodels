include <BOSL2/std.scad>

$fn=128;


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

color("red", .5)

translate([30, 9, 9])
difference() {
    cylinder(r=12, h=44);
    linear_extrude(40, twist=720) flower(9, .5, 20);
}

cylinder(r=12, h=10);
linear_extrude(40, twist=720) hexagon(id=18);
