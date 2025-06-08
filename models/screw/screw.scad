$fn=100;

wall_size = .8;
blade_width = 7;
blade_length = 30;
spiral_height = 60;

thread_wall_size = 2;
thread_height = 50;

module blade(wall) {
    x = blade_width;
    y = blade_length;
    
    difference() {
        hull() {
            r = x/2-wall;
            translate([0, y/2-x/2, 0]) circle(r);
            translate([0, -y/2+x/2, 0]) circle(r);
        }
        union() {
            r = y + wall/4;
            l = y + x*x/y -(wall/2);
            translate([l, 0, 0]) circle(r);
            translate([-l, 0, 0]) circle(r);
        }
    }
}

// Check blade
//blade(0);
//color("red") translate([0, 0, 1]) blade(wall_size);

 
module flower(wall) {
    blade(wall);
    rotate(60) blade(wall);
    rotate(120) blade(wall);
    if(wall == wall_size) {
        //circle(blade_width/2);
    } else {
        circle(blade_width/2);
    }
}

// Check flower
//color("blue") translate([0, 0, -1]) flower(-wall_size*2);
//flower(0);
//color("red") translate([0, 0, 1]) flower(wall_size);


module spiral(height, wall) {
    linear_extrude(height, twist=height/spiral_height * 360)
        flower(wall);
}

// Check spiral
//color("red") spiral(20, -wall_size*2);
//color("yellow") spiral(30, 0);
//color("green") spiral(40, wall_size);


module straight_external_thread() {
    spiral(thread_height, wall_size);
}


module straight_internal_thread() {
    difference() {
        translate([0, 0, 0.01]) cylinder(thread_height-0.02, r = blade_length / 2 + thread_wall_size);
        spiral(thread_height, 0);
    }
}

//translate([0, blade_length, 0]) straight_external_thread();
//translate([blade_length, 0, 0]) straight_internal_thread();


module external_thread() {
    spiral(thread_height, wall_size);
}

module spiral_internal_thread() {
    difference() {
        spiral(thread_height, -wall_size*2);
        spiral(thread_height, 0);
    }
}

module corn_external_thread() {
    r1 = blade_length / 2 + thread_wall_size;
    r2 = blade_width/2;
    h = thread_height - r2;
    intersection() {
        union() {
            cylinder(h, r1, r2);
            translate([0, 0, h]) sphere(r2);
        }
        spiral(thread_height, wall_size);
    }
}
module corn_internal_thread() {
    r1 = blade_length / 2 + thread_wall_size;
    r2 = blade_width/2+wall_size;
    h = thread_height - r2;
    difference() {
        difference() {
            cylinder(h, r1, r2);
            spiral(thread_height, 0);
        }
        translate([r1, r1, h-r2]) cube(r1*1.5);
    }
}

translate([0, blade_length, 0]) external_thread();
//translate([0, blade_length, 0]) spiral_internal_thread();
translate([0, blade_length, 0]) straight_internal_thread();
translate([0, -blade_length, 0]) corn_external_thread();
translate([0, -blade_length, 0]) corn_internal_thread();
