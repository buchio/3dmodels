module tetrahedron(x) {
    polyhedron(points=[ [1,1,1],[-1,-1,1],[1,-1,-1],[-1,1,-1]  ],
        faces=[ [0,1,2], [0,1,3], [1,2,3], [0,2,3] ]);
}
        
sx = 0.52;
tx = 0.5;
module l1() {
    translate([tx,tx,tx]) scale([sx,sx,sx]) tetrahedron();
    translate([-tx,-tx,tx]) scale([sx,sx,sx]) tetrahedron();
    translate([tx,-tx,-tx]) scale([sx,sx,sx]) tetrahedron();
    translate([-tx,tx,-tx]) scale([sx,sx,sx]) tetrahedron();
}
module l2() {
    translate([tx,tx,tx]) scale([sx,sx,sx]) l1();
    translate([-tx,-tx,tx]) scale([sx,sx,sx]) l1();
    translate([tx,-tx,-tx]) scale([sx,sx,sx]) l1();
    translate([-tx,tx,-tx]) scale([sx,sx,sx]) l1();
}

module l3() {
    translate([tx,tx,tx]) scale([sx,sx,sx]) l2();
    translate([-tx,-tx,tx]) scale([sx,sx,sx]) l2();
    translate([tx,-tx,-tx]) scale([sx,sx,sx]) l2();
    translate([-tx,tx,-tx]) scale([sx,sx,sx]) l2();
}

module l4() {
    translate([tx,tx,tx]) scale([sx,sx,sx]) l3();
    translate([-tx,-tx,tx]) scale([sx,sx,sx]) l3();
    translate([tx,-tx,-tx]) scale([sx,sx,sx]) l3();
    translate([-tx,tx,-tx]) scale([sx,sx,sx]) l3();
}

module l5() {
    translate([tx, tx,tx]) scale([sx,sx,sx]) l4();
    translate([-tx,-tx,tx]) scale([sx,sx,sx]) l4();
    translate([tx,-tx,-tx]) scale([sx,sx,sx]) l4();
    translate([-tx,tx,-tx]) scale([sx,sx,sx]) l4();
}

module l6() {
    translate([tx,tx,tx]) scale([sx,sx,sx]) l5();
    translate([-tx,-tx,tx]) scale([sx,sx,sx]) l5();
    translate([tx,-tx,-tx]) scale([sx,sx,sx]) l5();
    translate([-tx,tx,-tx]) scale([sx,sx,sx]) l5();
}

//l2();

scale(10) translate([0, 0, 0.6]) rotate([atan(sqrt(2)), 0, 0]) rotate([0, 0, 45]) l6();


