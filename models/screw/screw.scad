$fn=100;

wall_size = .8;
blade_width = 7;
blade_length = 30;
spiral_height = 60;

thread_wall_size = 2;
thread_height = 50;

module blade(inner=false) {
    x = blade_width;
    y = blade_length;
    border = inner ? wall_size : 0;
    
    difference() {
        hull() {
            r = x/2-border;
            translate([0, y/2-x/2, 0]) circle(r);
            translate([0, -y/2+x/2, 0]) circle(r);
        }
        union() {
            r = y + border/4;
            l = y + x*x/y -(border/2);
            translate([l, 0, 0]) circle(r);
            translate([-l, 0, 0]) circle(r);
        }
    }
}

// Check blade
//blade();
//color("red") translate([0, 0, 1]) blade(true);

 
module flower(inner=false) {
    blade(inner);
    rotate(60) blade(inner);
    rotate(120) blade(inner);
    if(inner)
        circle(blade_width/2);
    else
        circle(blade_width/2+wall_size);
}

// Check flower
//flower();
//color("red") translate([0, 0, 1]) flower(.8);


module spiral(height, inner=false) {
    linear_extrude(height, twist=height/spiral_height * 360)
        flower(inner);
}

// Check spiral
//spiral(30);
//color("green") spiral(40, true);


module straight_external_thread() {
    spiral(thread_height, true);
}


module straight_internal_thread() {
    difference() {
        translate([0, 0, 0.01]) cylinder(thread_height-0.02, r = blade_length / 2 + thread_wall_size);
        spiral(thread_height);
    }
}

//translate([0, blade_length, 0]) straight_external_thread();
//translate([blade_length, 0, 0]) straight_internal_thread();


module corn_external_thread() {
    r1 = blade_length / 2 + thread_wall_size;
    r2 = blade_width/2;
    h = thread_height - r2;
    intersection() {
        union() {
            cylinder(h, r1, r2);
            translate([0, 0, h]) sphere(r2);
        }
        spiral(thread_height, true);
    }
}
module corn_internal_thread() {
    r1 = blade_length / 2 + thread_wall_size;
    r2 = blade_width/2+wall_size;
    h = thread_height - r2;
    difference() {
        difference() {
            cylinder(h, r1, r2);
            spiral(thread_height);
        }
        translate([r1, r1, h-r2]) cube(r1*1.5);
    }
}
//translate([0, -blade_length, 0]) corn_external_thread();
//translate([-blade_length, 0, 0]) corn_internal_thread();
corn_external_thread();
corn_internal_thread();
