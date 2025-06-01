include <BOSL2/std.scad>
include <BOSL2/threading.scad>
$fn=16;

// --- Parameters ---
pillar_size = 10;         // Outer size of pillar
pillar_thickness = 1.1;   // Wall thickness of pillar
clearance = 0.2;         // Gap/clearance for fitting

rect_outer_size = pillar_size - clearance*2;
hook_bar_width = pillar_thickness - clearance;

// --- Modules ---
module pillar_wall() {
    outer_rounding = pillar_thickness/2*[1, 1, 1, 1];
    inner_rounding = pillar_thickness/2*[1, 1, 1, 1];
    outer_size = rect_outer_size;
    inner_size = rect_outer_size - pillar_thickness*2;
    difference() {
        rect(outer_size, rounding=outer_rounding);
        rect(inner_size, rounding=inner_rounding);
    }
}

module pillar_wall_hall() {
    hall_x = (pillar_size - pillar_thickness) / 2;
    hall_y = 0;
    hall_size = [pillar_thickness*2, pillar_thickness];
    corner_offset = hall_x - clearance;
    corner_size = [pillar_thickness, pillar_thickness];
    corner_rounding1 = pillar_thickness/2*[0, -1, 0, 0];
    corner_rounding2 = pillar_thickness/2*[-1, 0, 0, 0];
    translate([hall_x, hall_y, 0]) rect(hall_size);
    translate([corner_offset, 0, 0]) {
        rotate([0, 0, -90]) {
            rect(corner_size, rounding=corner_rounding1);
        }
    }
    translate([corner_offset, 0, 0]) {
        rotate([0, 0, -90]) {
            rect(corner_size, rounding=corner_rounding2);
        }
    }
}

module pillar_wall_hall_parts() {
    part_x = pillar_size/2 - pillar_thickness*1.5 - clearance/2;
    part_y1 = pillar_thickness;
    part_y2 = -pillar_thickness;
    part_size = [pillar_thickness, pillar_thickness];
    part_rounding = pillar_thickness/2*[0, 1, 1, 0];
    union() {
        translate([part_x, part_y1, 0])
            rect(part_size, rounding=part_rounding);
        translate([part_x, part_y2, 0])
            rect(part_size, rounding=part_rounding);
    }
}

module pillar_wall_with_hall(hall_direction=[1, 0, 0, 0]) {
    union() {
        difference() {
            pillar_wall();
            union() {
                if (hall_direction[0] != 0) {
                    pillar_wall_hall();
                }
                if (hall_direction[1] != 0) {
                    rotate(90) pillar_wall_hall();
                }
                if (hall_direction[2] != 0) {
                    rotate(180) pillar_wall_hall();
                }
                if (hall_direction[3] != 0) {
                    rotate(270) pillar_wall_hall();
                }
            }
        }
        if (hall_direction[0] != 0) {
            pillar_wall_hall_parts();
        }
        if (hall_direction[1] != 0) {
            rotate(90) pillar_wall_hall_parts();
        }
        if (hall_direction[2] != 0) {
            rotate(180) pillar_wall_hall_parts();
        }
        if (hall_direction[3] != 0) {
            rotate(270) pillar_wall_hall_parts();
        }
    }
}

//color("blue", .5) pillar_wall();
//color("red", .5) pillar_wall_with_hall([1, 1, 1, 1]);

module pillar_wall_hook() {
    // Main bar
    bar_x = -rect_outer_size/2 - pillar_thickness - clearance*1.5;
    bar_size = [pillar_thickness*2 + clearance*3, hook_bar_width];
    // Vertical block
    block_x = -rect_outer_size/2 - pillar_thickness*2.5 - clearance*3;
    block_size = [pillar_thickness, pillar_thickness*3 + clearance*2];
    // Lower hook
    lower_hook_x = -rect_outer_size/2 - pillar_thickness*2 - clearance*3;
    lower_hook_y = -pillar_thickness*2;
    lower_hook_size = [pillar_thickness*2, hook_bar_width];
    lower_hook_rounding = hook_bar_width/2*[1, 0, 1, 1];
    // Upper hook
    upper_hook_x = lower_hook_x;
    upper_hook_y = pillar_thickness*2;
    upper_hook_size = [pillar_thickness*2, hook_bar_width];
    upper_hook_rounding = hook_bar_width/2*[1, 1, 0, 1];

    translate([bar_x, 0, 0])
        rect(bar_size);
    translate([block_x, 0, 0])
        rect(block_size);
    translate([lower_hook_x, lower_hook_y, 0])
        rect(lower_hook_size, rounding=lower_hook_rounding);
    translate([upper_hook_x, upper_hook_y, 0])
        rect(upper_hook_size, rounding=upper_hook_rounding);
}

module pillar_wall_with_hook(hook_direction=[1, 0, 0, 0], hall_direction=[1, 0, 0, 0], hook_only=false) {
    if (!hook_only) pillar_wall_with_hall(hall_direction);
    if (hook_direction[0] != 0) {
        pillar_wall_hook();
    }
    if (hook_direction[1] != 0) {
        rotate(90) pillar_wall_hook();
    }
    if (hook_direction[2] != 0) {
        rotate(180) pillar_wall_hook();
    }
    if (hook_direction[3] != 0) {
        rotate(270) pillar_wall_hook();
    }
}

// Example placements (commented out)
//translate([-pillar_size, -pillar_size, 0]) pillar_wall_with_hook([0, 0, 0, 0], [1, 1, 0, 0]);
//translate([-pillar_size, 0, 0])   pillar_wall_with_hook([0, 1, 0, 1], [1, 0, 0, 0]);
//translate([-pillar_size, pillar_size, 0])  pillar_wall_with_hook([0, 0, 0, 0], [1, 0, 0, 1]);
//translate([0, -pillar_size, 0])   pillar_wall_with_hook([1, 0, 1, 0], [0, 1, 0, 0]);
//translate([0, 0, 0])     pillar_wall_with_hook([1, 1, 1, 1], [0, 0, 0, 0]);
//translate([0, pillar_size, 0])    pillar_wall_with_hook([1, 0, 1, 0], [0, 0, 0, 1]);
//translate([pillar_size, -pillar_size, 0])  pillar_wall_with_hook([0, 0, 0, 0], [0, 1, 1, 0]);
//translate([pillar_size, 0, 0])    pillar_wall_with_hook([0, 1, 0, 1], [0, 0, 1, 0]);
//translate([pillar_size, pillar_size, 0])   pillar_wall_with_hook([0, 0, 0, 0], [0, 0, 1, 1]);

module pillar_part(height, hook_direction=[0,0,0,0], hall_direction=[0,0,0,0], hook_only=false) {
    linear_extrude(height) pillar_wall_with_hook(hook_direction, hall_direction, hook_only);
}

module pillar_hook_end(height) {
    // Main block
    main_block_x = -rect_outer_size/2 - pillar_thickness*1.5 - clearance*1.5;
    main_block_size = [pillar_thickness*3 + clearance*3, pillar_thickness - clearance, height/2];
    // Wedge under main block
    wedge1_x = main_block_x;
    wedge1_size = [pillar_thickness - clearance, pillar_thickness*3 + clearance*3, height/2];
    // Side wedges and cubes
    side_x = -rect_outer_size/2 - pillar_thickness*2.5 - clearance*3;
    side_y1 = pillar_thickness*1.5 - clearance/2;
    side_y2 = -pillar_thickness*1.5 + clearance/2;
    wedge2_size = [pillar_thickness, pillar_thickness*2, height/4];
    cube2_size = [pillar_thickness, pillar_thickness*2, height/4];
    // Small side wedges
    small_wedge_x = -rect_outer_size/2 - pillar_thickness*1.5 - clearance*3;
    small_wedge_y1 = pillar_thickness*2;
    small_wedge_y2 = -pillar_thickness*2;
    small_wedge_size = [hook_bar_width, pillar_thickness, height/4];

    union() {
        translate([main_block_x, 0, height*3/4]) {
            cube(main_block_size, center=true);
        }
        translate([wedge1_x, 0, height/4]) {
            rotate([0, 180, 90])
                wedge(wedge1_size, center=true);
        }
        translate([side_x, side_y1, height*5/8])
            rotate([0, 180, 0]) wedge(wedge2_size, center=true);
        translate([side_x, side_y2, height*5/8])
            rotate([180, 0, 0]) wedge(wedge2_size, center=true);
        translate([side_x, side_y1, height*7/8])
            cube(cube2_size, center=true);
        translate([side_x, side_y2, height*7/8])
            cube(cube2_size, center=true);
        translate([small_wedge_x, small_wedge_y1, height*7/8])
            rotate([180, 0, 90]) wedge(small_wedge_size, center=true);
        translate([small_wedge_x, small_wedge_y2, height*7/8])
            rotate([180, 0, 90]) wedge(small_wedge_size, center=true);
    }
}

module cap() {
    cap_height = rect_outer_size/2;
    cap_rounding = pillar_thickness/2;
    cap_inner_size = rect_outer_size - pillar_thickness*2;
    difference() {
        translate([0, 0, rect_outer_size/4])
            cuboid([rect_outer_size, rect_outer_size, cap_height], rounding=cap_rounding, except=BOT);
        prismoid(
            size1=[cap_inner_size, cap_inner_size],
            size2=[pillar_thickness, clearance],
            h=cap_height - pillar_thickness
        );
    }
}

module pillar(total_height, hook_direction, hall_direction) {
    top_height = (total_height - pillar_size) / 2;
    mid1_height = pillar_size*.25;
    mid2_height = pillar_size*.75;
    bottom_height = (total_height - pillar_size) / 2;

    // Top cap
    translate([0, 0, total_height]) cap();
    // Bottom cap (flipped)
    rotate([180, 0, 0]) cap();

    // Main pillar body
    translate([0, 0, bottom_height + mid1_height + mid2_height])
        pillar_part(top_height, hall_direction=hall_direction);
    translate([0, 0, bottom_height + mid2_height])
        pillar_part(mid1_height, hook_direction, hall_direction);
    translate([0, 0, bottom_height]) {
        pillar_part(mid2_height, hall_direction=hall_direction);
        intersection() {
            pillar_part(mid2_height, hook_direction, hook_only=true);
            union() {
                if (hook_direction[0] != 0) {
                    pillar_hook_end(mid2_height);
                }
                if (hook_direction[1] != 0) {
                    rotate(90) pillar_hook_end(mid2_height);
                }
                if (hook_direction[2] != 0) {
                    rotate(180) pillar_hook_end(mid2_height);
                }
                if (hook_direction[3] != 0) {
                    rotate(270) pillar_hook_end(mid2_height);
                }
            }
        }
    }
    translate([0, 0, 0]) pillar_part(bottom_height, hall_direction=hall_direction);
}

// --- Example usage ---
pillar_height = pillar_size*1.2;
translate([0, 0, 0]) pillar(pillar_height, [0, 1, 0, 0], [1, 0, 0, 0]);
translate([pillar_size, 0, 0]) pillar(pillar_height, [1, 1, 0, 0], [0, 0, 0, 0]);
translate([pillar_size, -pillar_size, 0]) pillar(pillar_height, [1, 0, 0, 0], [0, 1, 0, 0]);
translate([0, -pillar_size, 0]) pillar(pillar_height, [0, 0, 0, 0], [1, 1, 0, 0]);

