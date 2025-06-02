include <BOSL2/std.scad>
include <BOSL2/rounding.scad>


g = [10, 320];
s1 = [5, 240];
s2 = [6, 310];


module logo(w = 4) {
    path = turtle([
        "turn", - g[1] + 90,
        "arcleft", g[0], g[1],
        "turn", -90,
        "move", -(g[0]-2.6),
        "turn", 180-s2[1],
        "arcright", s2[0], 180,
        "turn", 180,
        "arcleft", s2[0], s2[1],
        "arcright", s1[0], s1[1],
    ]);
    translate([7.6, 1.3, 0]) {
        stroke(path, width=w);
    }
}

s2_ = [5, 180];
module logo_(w = 4) {
    path_g = turtle([
        "turn", - g[1] + 90,
        "arcleft", g[0], g[1],
        "turn", -90,
        "move", -(g[0]*.12),
    ]);
    path_s = turtle([
        "turn", 180-s2_[1],
        "arcleft", s2_[0], s2_[1],
        "arcright", s1[0], s1[1],
    ]);
    translate([7.6, 1.3, 0]) {
        stroke(path_g, width=w);
    }
    translate([-2., -5.4, 0]) {
        stroke(path_s, width=w);
    }
}


$fn=128;

//logo_(5);
//translate([0, 0, 1])
//color("red") logo_(3);

//color("blue") circle(16);
//translate([0, 0, 1])
//color("red") rect([24, 20]);
//
//translate([0, 0, 2])
//color("yellow") 
//logo(5);
//
//translate([0, 0, 2])
//color("green") 
//logo(3);

// cylinder
height = 50;
spiral_height = 60;
spiral_twist = height / spiral_height * 360;
color("red")  linear_extrude(height, twist=spiral_twist) logo_(3);
translate([50, 0, 0])
color("blue") 
difference() {cylinder(h=height, r=19, center=false);linear_extrude(height, twist=spiral_twist)  logo_(5);}

// madama
//color("red");
//intersection() {translate([0, 0, 25]) sphere(25); linear_extrude(50, twist=360) logo_(3);}
//color("blue") 
//difference() {translate([0, 0, 25]) sphere(25); linear_extrude(50, twist=360)  logo_(4);}

