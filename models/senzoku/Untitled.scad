include <BOSL2/std.scad>
include <BOSL2/rounding.scad>


$fn=32;

path = turtle([
    "turn", 120,
    "arcleft", 10, 330,
    "xmove", -7.6,
    "turn", 150,
    "arcright", 6, 180,
    "turn", 180,
    "arcleft", 6, 300,
    "arcright", 5, 250,
]);

color("red")  linear_extrude(50, twist=360) translate([10, 0, 0]) stroke(path, width=4);
translate([50, 0, 0])
color("blue") 
difference() {
    cylinder(h=50, r=18, center=false);
    linear_extrude(50, twist=360)  translate([10, 0, 0]) stroke(path, width=4.8);
}

////
//       translate([0, -5, 0]) {
//            wide_arc_polygon(12, 8, 20, 357);
//            translate([1, -3, 0]) square([8, 3]);
//            rotate([0, 0, 20]) translate([8, 0, 0]) edge();
//            translate([8, -.5, 0])  edge();
//        }
//        translate([-2, 10, 0]) {
//                wide_arc_polygon(7, 3, 15, 270);
//                rotate([0, 0, 15]) translate([3, 0, 0]) edge();
//
//        }
//        translate([-2, -1, 0]) {
//                wide_arc_polygon(8, 4, -210, 90);
//        }
//    }cube([20, 20, 20])
//    edge_profile(type="round", r=5, $fn=64); // 半径5でエッジを丸める