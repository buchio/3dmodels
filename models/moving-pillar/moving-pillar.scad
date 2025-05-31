include <BOSL2/std.scad>
include <BOSL2/threading.scad>
$fn=16;

pillar_size = 15;         // Pillar size
pillar_thickness = 1.8;   // Pillar thickness
clearance = 0.25;         // Gap/clearance

rect_size = pillar_size - clearance*2; // rectangle size
hook_width = pillar_thickness - clearance; // hook width

module pillar_wall() {
    difference() {
        rect(rect_size, rounding=pillar_thickness/2*[1, 1, 1, 1]);
        rect(rect_size-pillar_thickness*2, rounding=pillar_thickness/2*[1, 1, 1, 1]);
    }
}

module pillar_wall_hall() {
    translate([(pillar_size-pillar_thickness)/2, 0, 0]) rect([pillar_thickness*2, pillar_thickness]);
    translate([(pillar_size-pillar_thickness)/2-clearance, 0, 0]) {
        rotate([0, 0, -90]) {
            rect([pillar_thickness, pillar_thickness], rounding=pillar_thickness/2*[0, -1, 0, 0]);
        }
    }
    translate([(pillar_size-pillar_thickness)/2-clearance, 0, 0]) {
        rotate([0, 0, -90]) {
            rect([pillar_thickness, pillar_thickness], rounding=pillar_thickness/2*[-1, 0, 0, 0]);
        }
    }
}

module pillar_wall_hall_parts() {
    union() {
        translate([pillar_size/2-pillar_thickness*1.5-clearance/2, pillar_thickness, 0])
            rect([pillar_thickness, pillar_thickness], rounding=pillar_thickness/2*[0, 1, 1, 0]);
        translate([pillar_size/2-pillar_thickness*1.5-clearance/2, -pillar_thickness, 0])
            rect([pillar_thickness, pillar_thickness], rounding=pillar_thickness/2*[0, 1, 1, 0]);
    }
}

module pillar_wall_with_hall(pos=[1, 0, 0, 0]) {
    union() {
        difference() {
            pillar_wall();
            union() {
                if( pos[0] != 0 ) {
                    pillar_wall_hall();
                } 
                if (pos[1] != 0) {
                    rotate(90) pillar_wall_hall();
                } 
                if (pos[2] != 0) {
                    rotate(180) pillar_wall_hall();
                } 
                if (pos[3] != 0) {
                    rotate(270) pillar_wall_hall();
                }
            }
        }
        if( pos[0] != 0 ) {
            pillar_wall_hall_parts();
        } 
        if (pos[1] != 0) {
            rotate(90) pillar_wall_hall_parts();
        } 
        if (pos[2] != 0) {
            rotate(180) pillar_wall_hall_parts();
        } 
        if (pos[3] != 0) {
            rotate(270) pillar_wall_hall_parts();
        }
    }
}

//color("blue", .5) pillar_wall();
//color("red", .5) pillar_wall_with_hall([1, 1, 1, 1]);


module pillar_wall_hook() {
    translate([-rect_size/2-pillar_thickness-clearance*1.5, 0, 0])
        rect([pillar_thickness*2+clearance*3, hook_width]);
    translate([-rect_size/2-pillar_thickness*2.5-clearance*3, 0, 0])
        rect([pillar_thickness, pillar_thickness*3+clearance*2]);
    translate([-rect_size/2-pillar_thickness*2-clearance*3, -pillar_thickness*2, 0])
        rect([pillar_thickness*2, hook_width], rounding=hook_width/2*[1, 0, 1, 1]);
    translate([-rect_size/2-pillar_thickness*2-clearance*3, pillar_thickness*2, 0])
        rect([pillar_thickness*2, hook_width], rounding=hook_width/2*[1, 1, 0, 1]);
}

module pillar_wall_with_hook(hook_pos=[1, 0, 0, 0], hall_pos=[1, 0, 0, 0], hook_only=false) {
    if( ! hook_only ) pillar_wall_with_hall(hall_pos);
    if( hook_pos[0] != 0 ) {
        pillar_wall_hook();
    } 
    if (hook_pos[1] != 0) {
        rotate(90) pillar_wall_hook();
    } 
    if (hook_pos[2] != 0) {
        rotate(180) pillar_wall_hook();
    } 
    if (hook_pos[3] != 0) {
        rotate(270) pillar_wall_hook();
    }
}

//translate([-pillar_size, -pillar_size, 0]) pillar_wall_with_hook([0, 0, 0, 0], [1, 1, 0, 0]);
//translate([-pillar_size, 0, 0])   pillar_wall_with_hook([0, 1, 0, 1], [1, 0, 0, 0]);
//translate([-pillar_size, pillar_size, 0])  pillar_wall_with_hook([0, 0, 0, 0], [1, 0, 0, 1]);
//translate([0, -pillar_size, 0])   pillar_wall_with_hook([1, 0, 1, 0], [0, 1, 0, 0]);
//translate([0, 0, 0])     pillar_wall_with_hook([1, 1, 1, 1], [0, 0, 0, 0]);
//translate([0, pillar_size, 0])    pillar_wall_with_hook([1, 0, 1, 0], [0, 0, 0, 1]);
//translate([pillar_size, -pillar_size, 0])  pillar_wall_with_hook([0, 0, 0, 0], [0, 1, 1, 0]);
//translate([pillar_size, 0, 0])    pillar_wall_with_hook([0, 1, 0, 1], [0, 0, 1, 0]);
//translate([pillar_size, pillar_size, 0])   pillar_wall_with_hook([0, 0, 0, 0], [0, 0, 1, 1]);

module pillar_part(height, hook_pos=[0,0,0,0], hall_pos=[0,0,0,0], hook_only=false) {
    linear_extrude(height) pillar_wall_with_hook(hook_pos, hall_pos);
}

module pillar_hook_end(height) {
   union() {
        translate([-rect_size/2-pillar_thickness*1.5-clearance*1.5, 0, height*3/4]) {
            cube([pillar_thickness*3+clearance*3, pillar_thickness-clearance, height/2], center=true);
        }
        translate([-rect_size/2-pillar_thickness*1.5-clearance*1.5, 0, height/4]) {
            rotate([0, 180, 90])
                wedge([pillar_thickness-clearance, pillar_thickness*3+clearance*3, height/2], center=true);
        }

        translate([-rect_size/2-pillar_thickness*2.5-clearance*3, pillar_thickness*1.5-clearance/2, height*5/8])
            rotate([0, 180, 0]) wedge([pillar_thickness, pillar_thickness*2, height/4], center=true);
        translate([-rect_size/2-pillar_thickness*2.5-clearance*3, -pillar_thickness*1.5+clearance/2, height*5/8])
            rotate([180, 0, 0]) wedge([pillar_thickness, pillar_thickness*2, height/4], center=true);
        translate([-rect_size/2-pillar_thickness*2.5-clearance*3, pillar_thickness*1.5-clearance/2, height*7/8])
            cube([pillar_thickness, pillar_thickness*2, height/4], center=true);
        translate([-rect_size/2-pillar_thickness*2.5-clearance*3, -pillar_thickness*1.5+clearance/2, height*7/8])
            cube([pillar_thickness, pillar_thickness*2, height/4], center=true);

        translate([-rect_size/2-pillar_thickness*1.5-clearance*3, pillar_thickness*2, height*7/8])
            rotate([180, 0, 90]) wedge([hook_width, pillar_thickness, height/4], center=true);
        translate([-rect_size/2-pillar_thickness*1.5-clearance*3, -pillar_thickness*2, height*7/8])
            rotate([180, 0, 90]) wedge([hook_width, pillar_thickness, height/4], center=true);
    }
}

module cap() {
    difference() {
        translate([0, 0, rect_size/4]) cuboid([rect_size, rect_size, rect_size/2], rounding=pillar_thickness/2, except=BOT);
        prismoid(size1=[rect_size-pillar_thickness*2, rect_size-pillar_thickness*2], size2=[pillar_thickness, clearance], h=rect_size/2-pillar_thickness);
    }
}

module pillar(height, hook_pos, hall_pos) {

    top_height = height - pillar_size*2.5;
    middle_height_1 = pillar_size/2; 
    middle_height_2 = pillar_size; 
    bottom_height = pillar_size;

    translate([0, 0, height]) cap();
    rotate([180, 0, 0]) cap();
    
    translate([0, 0, bottom_height+middle_height_1+middle_height_2]) pillar_part(top_height, hall_pos=hall_pos);
    translate([0, 0, bottom_height+middle_height_2]) pillar_part(middle_height_1, hook_pos, hall_pos);
    translate([0, 0, bottom_height]) {
        pillar_part(middle_height_2, hall_pos=hall_pos);
        intersection() {
            pillar_part(middle_height_2, hook_pos, hook_only=true);
            union() {
                if( hook_pos[0] != 0 ) {
                    pillar_hook_end(middle_height_2);
                } 
                if (hook_pos[1] != 0) {
                    rotate(90) pillar_hook_end(middle_height_2);
                } 
                if (hook_pos[2] != 0) {
                    rotate(180) pillar_hook_end(middle_height_2);
                } 
                if (hook_pos[3] != 0) {
                    rotate(270) pillar_hook_end(middle_height_2);
                }
            }
        }
    }
    translate([0, 0, 0]) pillar_part(bottom_height, hall_pos=hall_pos);
}

pillar_height = 50;
pillar(pillar_height, [0, 1, 0, 0], [1, 0, 0, 0]);
translate([0, 0, 0]) pillar(pillar_height, [0, 1, 0, 0], [1, 0, 0, 0]);
translate([pillar_size, 0, 0]) pillar(pillar_height, [1, 1, 0, 0], [0, 0, 0, 0]);
translate([pillar_size, -pillar_size, 0]) pillar(pillar_height, [1, 0, 0, 0], [0, 1, 0, 0]);
translate([0, -pillar_size, 0]) pillar(pillar_height, [0, 0, 0, 0], [1, 1, 0, 0]);

