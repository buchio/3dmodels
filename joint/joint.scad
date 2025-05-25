include <BOSL2/std.scad>

// Parameters.
$fn=100;
gap = .2;
joint_radius = 2.5;
radius = 22;
hand_length = 2;
hand_angle = 65;


thickness = joint_radius * 2;
slit_width = (joint_radius + gap) * 2;
hand_radius = radius - hand_length;
hand_thickness = 4;
hand_radius_1 = joint_radius + gap;
hand_radius_2 = joint_radius + 2.5;

module plate() {
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
        translate([-(thickness/2+hand_length*2), 0, thickness/2]) {
            union() {
                xpos = -hand_radius/2;
                ypos = slit_width/2;
                zpos = thickness/2;
                translate([xpos, ypos, -zpos]) rotate([90, 0, 0]) rotate([0, 90, 0]) rounding_edge_mask(l=hand_radius, r=.5);
                translate([xpos, ypos, zpos]) rotate([0, 0, 0]) rotate([0, 90, 0]) rounding_edge_mask(l=hand_radius, r=.5);
                translate([xpos, -ypos, -zpos]) rotate([180, 0, 0]) rotate([0, 90, 0]) rounding_edge_mask(l=hand_radius, r=.5);
                translate([xpos, -ypos, zpos]) rotate([270, 0, 0]) rotate([0, 90, 0]) rounding_edge_mask(l=hand_radius, r=.5);
                translate([xpos, 0, 0]) cube([hand_radius, slit_width, thickness], center=true);
                right_half() {
                    translate([0, 0, zpos]) rounding_hole_mask(r=slit_width/2, rounding=.5);
                    translate([0, 0, -zpos]) rotate([-180, 0, 0]) rounding_hole_mask(r=slit_width/2, rounding=.5);
                    cylinder(h=thickness, r=slit_width/2, center=true);
                }
            }
        } 
    }        
}

module hands() {
    module hand() {

        module hand_end() {
            right_half() {
                convex_offset_extrude(bottom=os_circle(r=.5),top=os_circle(r=.5), height=hand_radius_2-hand_radius_1,steps=10) {
                    circle(r=2);
                }
            }
        }

        difference() {
            linear_extrude(hand_thickness) ring(r1=hand_radius_1,r2=hand_radius_2, angle=[hand_angle,360-hand_angle], n=$fn);
            union() {
                translate([0, 0, hand_thickness]) rounding_cylinder_mask(r=hand_radius_2, rounding=.5);
                rotate([180, 0, 0]) rounding_cylinder_mask(r=hand_radius_2, rounding=.5);
                translate([0, 0, hand_thickness]) rounding_hole_mask(r=hand_radius_1, rounding=.5);
                rotate([180, 0, 0]) rounding_hole_mask(r=hand_radius_1, rounding=.5);
            }
        }
        translate([hand_radius_1 * cos(hand_angle), -hand_radius_1 * sin(hand_angle), hand_thickness/2]) rotate([90, 0, 90-hand_angle]) hand_end();
        translate([hand_radius_1 * cos(hand_angle), hand_radius_1 * sin(hand_angle), hand_thickness/2]) rotate([-90, 0, -(90-hand_angle)]) hand_end();
        difference() {
            xpos = -(hand_radius/2 + (hand_radius_2 + hand_radius_1) / 2);
            ypos = thickness / 2;
            translate([xpos, -ypos, 0]) cube([hand_radius/2, thickness, hand_thickness]);
            union() {
                translate([xpos, ypos, 0]) rotate([180, 0, 0]) rotate([0, 90, 0]) rounding_edge_mask(l=hand_radius, r=.5);
                translate([xpos, ypos, hand_thickness]) rotate([-90, 0, 0]) rotate([0, 90, 0]) rounding_edge_mask(l=hand_radius, r=.5);
                translate([xpos, -ypos, 0]) rotate([90, 0, 0]) rotate([0, 90, 0]) rounding_edge_mask(l=hand_radius, r=.5);
                translate([xpos, -ypos, hand_thickness]) rotate([0, 0, 0]) rotate([0, 90, 0]) rounding_edge_mask(l=hand_radius, r=.5);
            }
        }
    }

    translate([-radius-4, hand_radius_1, joint_radius]) rotate([90, 0, 180]) hand();
    translate([-radius-4, -(hand_radius_1 + hand_thickness), joint_radius]) rotate([90, 0, 180]) hand();
}

rotate([0, 90, 0]) {
    plate();
    hands();
}