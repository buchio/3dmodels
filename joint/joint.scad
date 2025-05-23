include <BOSL2/std.scad>
//circle(r=44);

$fn=100;

asobi = .1;

joint_radius = 2.5;
radius = 22;
thickness = joint_radius * 2;
slit_width = (joint_radius + asobi) * 2;
hand_length = 20;
hand_thickness = 4;
hand_radius_1 = joint_radius + asobi;
hand_radius_2 = joint_radius + 2;

translate([0, 0, 5]) {
    convex_offset_extrude(bottom=os_circle(r=-1),top=os_circle(r=1), height=5,steps=10) {
        circle(r=2.5);
    }
}
translate([0, 0, -5]) {
    convex_offset_extrude(bottom=os_circle(r=1),top=os_circle(r=-1), height=5,steps=10) {
        circle(r=2.5);
    }
}

difference() {
    convex_offset_extrude(bottom=os_circle(r=joint_radius),top=os_circle(r=joint_radius), height=5,steps=10) {
        circle(r=radius);
    }
    translate([-(thickness/2+(radius-hand_length+2)), 0, thickness/2]) {
        union() {
            translate([-hand_length/2, slit_width/2, -thickness/2]) rotate([90, 0, 0]) rotate([0, 90, 0]) rounding_edge_mask(l=hand_length, r=.5);
            translate([-hand_length/2, slit_width/2, thickness/2]) rotate([0, 0, 0]) rotate([0, 90, 0]) rounding_edge_mask(l=hand_length, r=.5);
            translate([-hand_length/2, -slit_width/2, -thickness/2]) rotate([180, 0, 0]) rotate([0, 90, 0]) rounding_edge_mask(l=hand_length, r=.5);
            translate([-hand_length/2, -slit_width/2, thickness/2]) rotate([270, 0, 0]) rotate([0, 90, 0]) rounding_edge_mask(l=hand_length, r=.5);
            translate([-hand_length/2, 0, 0]) cube([hand_length, slit_width, thickness], center=true);
            right_half() {
                translate([0, 0, thickness/2])rounding_hole_mask(r=slit_width/2, rounding=.5);
                translate([0, 0, -thickness/2]) rotate([-180, 0, 0]) rounding_hole_mask(r=slit_width/2, rounding=.5);
                cylinder(h=thickness, r=slit_width/2, center=true);
            }
        }
    } 
}        

module hand_end() {
    right_half() {
        convex_offset_extrude(bottom=os_circle(r=.5),top=os_circle(r=.5), height=hand_radius_2-hand_radius_1,steps=10) {
            circle(r=2);
        }
    }
}

module hand() {
    difference() {
        linear_extrude(hand_thickness) ring(r1=hand_radius_1,r2=hand_radius_2, angle=[60,300], n=$fn);
        union() {
            translate([0, 0, hand_thickness]) rounding_cylinder_mask(r=hand_radius_2, rounding=.5);
            rotate([180, 0, 0]) rounding_cylinder_mask(r=hand_radius_2, rounding=.5);
            translate([0, 0, hand_thickness]) rounding_hole_mask(r=hand_radius_1, rounding=.5);
            rotate([180, 0, 0]) rounding_hole_mask(r=hand_radius_1, rounding=.5);
        }
    }
    // asobi=.1
    translate([1.21, -2.3, hand_thickness/2]) rotate([90, 0, 30]) hand_end();
    translate([1.21, 2.3, hand_thickness/2]) rotate([-90, 0, -30]) hand_end();
    // asobi=.3
    //translate([1.3, -2.5, hand_thickness/2]) rotate([90, 0, 30]) hand_end();
    //translate([1.3, 2.5, hand_thickness/2]) rotate([-90, 0, -30]) hand_end();
    difference() {
        translate([-(hand_length/2 + (hand_radius_2+hand_radius_1)/2), -thickness/2, 0]) cube([hand_length/2, thickness, hand_thickness]);
        union() {
            translate([-(hand_length/2 + (hand_radius_2+hand_radius_1)/2), thickness/2, 0]) rotate([180, 0, 0]) rotate([0, 90, 0]) rounding_edge_mask(l=hand_length, r=.5);
            translate([-(hand_length/2 + (hand_radius_2+hand_radius_1)/2), thickness/2, hand_thickness]) rotate([-90, 0, 0]) rotate([0, 90, 0]) rounding_edge_mask(l=hand_length, r=.5);
            translate([-(hand_length/2 + (hand_radius_2+hand_radius_1)/2), -thickness/2, 0]) rotate([90, 0, 0]) rotate([0, 90, 0]) rounding_edge_mask(l=hand_length, r=.5);
            translate([-(hand_length/2 + (hand_radius_2+hand_radius_1)/2), -thickness/2, hand_thickness]) rotate([0, 0, 0]) rotate([0, 90, 0]) rounding_edge_mask(l=hand_length, r=.5);
        }
    }
}

translate([-radius-4, hand_radius_1, joint_radius]) rotate([90, 0, 180]) hand();
translate([-radius-4, -(hand_radius_1 + hand_thickness), joint_radius]) rotate([90, 0, 180]) hand();