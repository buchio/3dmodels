$fn=100;

module skirt() {
    cylinder(r=16,h=3);
    cylinder(r=14,h=3.2);
    cylinder(r=13,h=3.4);
    cylinder(r=12,h=3.6);
    cylinder(r=11,h=3.8);
    cylinder(r=10,h=7);
}

module tube1() {
    translate([0, 0, -1]) {
        intersection() {
            cylinder(r=8.6,h=30);
            minkowski() {
                cube([7.2,4.2,10], center=true);
                cylinder(r=5,h=10);
            }
        }
    }
}
module tube2() {
    translate([0, 0, -2]) {
        intersection() {
            cylinder(r=7.1,h=30);
            minkowski() {
                cube([7.2,4.2,12], center=true);
                cylinder(r=3.5,h=12);
            }
        }
    }
}


module innertube() {
    intersection() {
        translate([0, 0, 3.5]) cube([20, 20, 7], center=true);
        difference() {
            tube1();
            tube2();
        }
    }
}

module hontai() {
    difference() {
        skirt();
        tube1();
    }
}

module tube3() {
    difference() {
        innertube();
        {
            translate([0, 0, -1]) {
                cube([10, 10, 10]);
            }
            translate([-10, 0, -1]) {
                rotate([-7, 0, 0]) {
                    cube([20, 20, 10]);
                }
            }
            translate([10, -8, -1]) {
                rotate([0, 0, 45]) {
                    cube([10, 10, 10]);
                }
            }
            translate([9.6, -8, -1]) {
                rotate([0, 2, 45]) {
                    cube([10, 10, 10]);
                }
            }
        }
    }
}

module extratube() {
    translate([0, 0, -14]) {
        scale([1, 1, 2]) {
            innertube();
        }
    }
}

module t1() {
    difference() {
        extratube();
        {
            translate([0, 0, -19]) {
                cube([10, 10, 20]);
            }
            translate([-10, -2, -18]) {
                rotate([-7, 0, 0]) {
                    cube([20, 20, 20]);
                }
            }
            translate([10, -8, -19]) {
                rotate([0, 0, 45]) {
                    cube([10, 10, 20]);
                }
            }
            translate([9.6, -9, -19]) {
                rotate([0, 2, 45]) {
                    cube([10, 10, 20]);
                }
            }
        }
    }
}

module brokentube() {
    intersection() {
        t1();
        translate([0, -7, 0]) {
            scale([.8, .8, 1]) {
                sphere(r=14);
            }
        }
    }
}

rotate([180, 0, 0]) {
    hontai();
    tube3();
    brokentube();
}