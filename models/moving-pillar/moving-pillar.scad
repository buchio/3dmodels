include <BOSL2/std.scad>
include <BOSL2/threading.scad>
$fn=16;
ps = 15; // Pillar size
pt = 1.6;  // Pillar sickness
gap = 0.3; // 


rs = ps-gap*2; // rectangle size;
hw = pt - gap; // hook width

module pillar_wall() {
    difference() {
        rect(rs, rounding=pt/2*[1, 1, 1, 1]);
        rect(rs-pt*2, rounding=pt/2*[1, 1, 1, 1]);
    }
}

module pillar_wall_hall() {
    translate([(ps-pt)/2, 0, 0]) rect([pt*2, pt]);
    translate([(ps-pt)/2-gap, 0, 0]) {
        rotate([0, 0, -90]) {
            rect([pt, pt], rounding=pt/2*[0, -1, 0, 0]);
        }
    }
    translate([(ps-pt)/2-gap, 0, 0]) {
        rotate([0, 0, -90]) {
            rect([pt, pt], rounding=pt/2*[-1, 0, 0, 0]);
        }
    }
}

module pillar_wall_hall_parts() {
    union() {
        translate([ps/2-pt*1.5-gap/2, pt, 0]) rect([pt, pt], rounding=pt/2*[0, 1, 1, 0]);
        translate([ps/2-pt*1.5-gap/2, -pt, 0]) rect([pt, pt], rounding=pt/2*[0, 1, 1, 0]);
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
    translate([-rs/2-pt-gap*1.5, 0, 0]) rect([pt*2+gap*3, hw]);
    translate([-rs/2-pt*2.5-gap*3, 0, 0]) rect([pt, pt*3+gap*2]);
    translate([-rs/2-pt*2-gap*3, -pt*2, 0]) rect([pt*2, hw], rounding=hw/2*[1, 0, 1, 1]);
    translate([-rs/2-pt*2-gap*3, pt*2, 0]) rect([pt*2, hw], rounding=hw/2*[1, 1, 0, 1]);
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

//translate([-ps, -ps, 0]) pillar_wall_with_hook([0, 0, 0, 0], [1, 1, 0, 0]);
//translate([-ps, 0, 0])   pillar_wall_with_hook([0, 1, 0, 1], [1, 0, 0, 0]);
//translate([-ps, ps, 0])  pillar_wall_with_hook([0, 0, 0, 0], [1, 0, 0, 1]);
//translate([0, -ps, 0])   pillar_wall_with_hook([1, 0, 1, 0], [0, 1, 0, 0]);
//translate([0, 0, 0])     pillar_wall_with_hook([1, 1, 1, 1], [0, 0, 0, 0]);
//translate([0, ps, 0])    pillar_wall_with_hook([1, 0, 1, 0], [0, 0, 0, 1]);
//translate([ps, -ps, 0])  pillar_wall_with_hook([0, 0, 0, 0], [0, 1, 1, 0]);
//translate([ps, 0, 0])    pillar_wall_with_hook([0, 1, 0, 1], [0, 0, 1, 0]);
//translate([ps, ps, 0])   pillar_wall_with_hook([0, 0, 0, 0], [0, 0, 1, 1]);

module pillar_part(height, hook_pos=[0,0,0,0], hall_pos=[0,0,0,0], hook_only=false) {
    linear_extrude(height) pillar_wall_with_hook(hook_pos, hall_pos);
}


module pillar_hook_end(height) {
   union() {
        translate([-rs/2-pt*1.5-gap*1.5, 0, height*3/4]) {
            cube([pt*3+gap*3, pt-gap, height/2], center=true);
        }
        translate([-rs/2-pt*1.5-gap*1.5, 0, height/4]) {
            rotate([0, 180, 90])
                wedge([pt-gap, pt*3+gap*3, height/2], center=true);
        }

        translate([-rs/2-pt*2.5-gap*3, pt*1.5-gap/2, height*5/8]) rotate([0, 180, 0]) wedge([pt, pt*2, height/4], center=true);
        translate([-rs/2-pt*2.5-gap*3, -pt*1.5+gap/2, height*5/8]) rotate([180, 0, 0]) wedge([pt, pt*2, height/4], center=true);
        translate([-rs/2-pt*2.5-gap*3, pt*1.5-gap/2, height*7/8]) cube([pt, pt*2, height/4], center=true);
        translate([-rs/2-pt*2.5-gap*3, -pt*1.5+gap/2, height*7/8]) cube([pt, pt*2, height/4], center=true);

        translate([-rs/2-pt*1.5-gap*3, pt*2, height*7/8]) rotate([180, 0, 90]) wedge([hw, pt, height/4], center=true);
        translate([-rs/2-pt*1.5-gap*3, -pt*2, height*7/8]) rotate([180, 0, 90]) wedge([hw, pt, height/4], center=true);
    }
}

module cap() {
    difference() {
        translate([0, 0, rs/4]) cuboid([rs, rs, rs/2], rounding=pt/2, except=BOT);
        prismoid(size1=[rs-pt*2, rs-pt*2], size2=[pt, gap], h=rs/2-pt);
    }
}

module pillar(height, hook_pos, hall_pos) {
    top_height = height / 4;
    middle_height = height / 4; 
    bottom_height = height / 4;
        
    
    translate([0, 0, bottom_height+middle_height*2]) pillar_part(top_height, hall_pos=hall_pos);
    translate([0, 0, bottom_height+middle_height]) pillar_part(top_height, hook_pos, hall_pos);
    translate([0, 0, bottom_height]) {
        pillar_part(middle_height, hall_pos=hall_pos);
        intersection() {
            pillar_part(middle_height, hook_pos, hook_only=true);
            union() {
                if( hook_pos[0] != 0 ) {
                    pillar_hook_end(middle_height);
                } 
                if (hook_pos[1] != 0) {
                    rotate(90) pillar_hook_end(middle_height);
                } 
                if (hook_pos[2] != 0) {
                    rotate(180) pillar_hook_end(middle_height);
                } 
                if (hook_pos[3] != 0) {
                    rotate(270) pillar_hook_end(middle_height);
                }
            }
        }
    }
    translate([0, 0, 0]) pillar_part(top_height, hall_pos=hall_pos);
}

pillar(20, [0, 1, 0, 0], [1, 0, 0, 0]);
//translate([0, 0, 0]) pillar(20, [0, 1, 0, 0], [1, 0, 0, 0]);
//translate([ps, 0, 0]) pillar(20, [1, 1, 0, 0], [1, 0, 0, 0]);
//translate([ps, -ps, 0]) pillar(20, [1, 0, 0, 0], [0, 1, 0, 0]);
//translate([0, -ps, 0]) pillar(20, [0, 0, 0, 0], [1, 1, 0, 0]);

