$fn = 20;
sx = 0.5;
tx = 0.5;
r = 0.3;

module hen() {
    sphere(r);
    cylinder(2*sqrt(2), r=r);
}

module sierpinsky(ord) {
    if( ord > 0 ) {
         union() {
             translate([tx,tx,tx]) scale([sx,sx,sx]) sierpinsky(ord-1);
             translate([-tx,-tx,tx]) scale([sx,sx,sx]) sierpinsky(ord-1);
             translate([tx,-tx,-tx]) scale([sx,sx,sx]) sierpinsky(ord-1);
             translate([-tx,tx,-tx]) scale([sx,sx,sx]) sierpinsky(ord-1);
         }
     } else {
         translate([-1, -1, 1]) rotate([0, 90, 45]) hen();
         translate([1, -1, -1]) rotate([0, 90, 135])hen();
         translate([1, -1, -1]) rotate([180, -135, 180])hen();
         translate([1, 1, 1]) rotate([180, 45, 90]) hen();
         translate([-1, -1, 1]) rotate([135, 0, 180])hen();
         translate([-1, 1, -1]) rotate([45, 0, 90])hen();
         points = [[1,1,1], [-1,1,-1], [1,-1,-1], [-1,-1,1]];
         faces = [[0,2,1], [0,1,3], [1,2,3], [0,3,2]];
         polyhedron(points, faces);
    }
}

scale(2) {
    rotate([0, 0, 0]) {
        rotate([0, -atan(sqrt(2)), 0]) {
            rotate([0, 0, 45]) {
                sierpinsky(4);
            }
        }
    }
}

//translate([8.2, 0, 0]) cylinder(11.6, r=.3);
//translate([-4.1, -7.1, 0]) cylinder(11.6, r=.3);
//translate([-4.1, 7.1, 0]) cylinder(11.6, r=.3);
//
//
//p1 = [1,1,1];
//p2 = [-1,1, -1];
//d = p2 - p1;
//echo([atan2(d[1], d[2]), atan2(d[0], d[2]), atan2(d[1], d[0])]);

