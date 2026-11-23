include <BOSL2/std.scad>
include <BOSL2/threading.scad>
$fn=16;

// --- Parameters ---
pillar_size = 10;         // Outer size of pillar
pillar_height = 20;       // Height of pillar
grid_x = 2;               // Number of pillars along X
grid_y = 1;               // Number of pillars along Y
// Top cap opacity (0: transparent/hidden, 1: opaque)
top_cap_alpha = 1;      // [0:0.05:1]
pillar_thickness = pillar_size * .12;   // Wall thickness of pillar
clearance = pillar_size / 25;         // Gap/clearance for fitting

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
    hall_width = pillar_thickness + clearance;
    hall_x = (pillar_size - pillar_thickness) / 2;
    hall_y = 0;
    hall_size = [pillar_thickness*2, hall_width];
    corner_offset = hall_x - clearance;
    corner_size = [hall_width, pillar_thickness];
    corner_rounding1 = pillar_thickness/2*[0, -1, -1, 0];
    corner_rounding2 = pillar_thickness/2*[-1, 0, 0, -1];
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
    }
}

module pillar_wall_hook() {
    // Main bar
    bar_length = pillar_thickness + clearance*3;
    bar_x = -rect_outer_size/2 - bar_length/2;
    bar_size = [bar_length, hook_bar_width];
    // Vertical block
    block_x = -rect_outer_size/2 - hook_bar_width/2 - bar_length;
    block_size = [hook_bar_width, pillar_thickness*3 + clearance*2];

    translate([bar_x, 0, 0])
        rect(bar_size);
    translate([block_x, 0, 0])
        rect(block_size, rounding=hook_bar_width/2);
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

module pillar_part(height, hook_direction=[0,0,0,0], hall_direction=[0,0,0,0], hook_only=false) {
    linear_extrude(height) pillar_wall_with_hook(hook_direction, hall_direction, hook_only);
}

module pillar_hook_end(height) {
    // Main block
    main_block_width = pillar_thickness + clearance*3 + hook_bar_width;
    main_block_x = -rect_outer_size/2 - main_block_width/2;
    main_block_size = [main_block_width, pillar_thickness - clearance, height/2];
    // Wedge under main block
    wedge1_x = main_block_x;
    wedge1_size = [pillar_thickness - clearance, main_block_width, height/2];
    // Side wedges and cubes
    side_x = -rect_outer_size/2 - main_block_width + hook_bar_width/2;
    side_y1 = pillar_thickness*1.5 - clearance;
    side_y2 = -pillar_thickness*1.5 + clearance;
    wedge2_size = [hook_bar_width, pillar_thickness*2, height/2];

    union() {
        translate([main_block_x, 0, height*3/4]) {
            cube(main_block_size, center=true);
        }
        translate([wedge1_x, 0, height/4]) {
            rotate([0, 180, 90])
                wedge(wedge1_size, center=true);
        }
        translate([side_x, side_y1, height*.75])
            rotate([0, 180, 0]) wedge(wedge2_size, center=true);
        translate([side_x, side_y2, height*.75])
            rotate([180, 0, 0]) wedge(wedge2_size, center=true);
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

    assert(top_cap_alpha >= 0 && top_cap_alpha <= 1, "top_cap_alpha must be between 0 and 1");

    // Top cap
    if (top_cap_alpha > 0) {
        if (top_cap_alpha < 1) {
            color(alpha = top_cap_alpha)
                translate([0, 0, total_height]) cap();
        } else {
            translate([0, 0, total_height]) cap();
        }
    }
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

module pillar_grid(nx, ny, height) {
    assert(nx >= 1 && ny >= 1, "nx and ny must be >= 1");
    cx = floor(nx / 2);
    cy = floor(ny / 2);
    for (iy = [0 : 1 : ny - 1]) {
        for (ix = [0 : 1 : nx - 1]) {
            hook_direction = [
                (ix > 0 && ix <= cx) ? 1 : 0,      // -X
                (iy > 0 && iy <= cy) ? 1 : 0,      // -Y
                (ix < nx - 1 && ix >= cx) ? 1 : 0, // +X
                (iy < ny - 1 && iy >= cy) ? 1 : 0  // +Y
            ];
            hall_direction = [
                (ix < cx) ? 1 : 0,                 // +X
                (iy < cy) ? 1 : 0,                 // +Y
                (ix > cx) ? 1 : 0,                 // -X
                (iy > cy) ? 1 : 0                  // -Y
            ];
            x = (ix - (nx - 1) / 2) * pillar_size;
            y = (iy - (ny - 1) / 2) * pillar_size;
            translate([x, y, 0])
                pillar(height, hook_direction, hall_direction);
        }
    }
}

pillar_grid(grid_x, grid_y, pillar_height);


