$fn = 20;
sx = 0.55;
tx = 0.5;


module sierpinsky(ord) {
    if( ord > 0 ) {
        union() {
            translate([tx,tx,tx]) scale([sx,sx,sx]) sierpinsky(ord-1);
            translate([-tx,-tx,tx]) scale([sx,sx,sx]) sierpinsky(ord-1);
            translate([tx,-tx,-tx]) scale([sx,sx,sx]) sierpinsky(ord-1);
            translate([-tx,tx,-tx]) scale([sx,sx,sx]) sierpinsky(ord-1);
        }
     } else {
        points = [[1,1,1], [-1,1,-1], [1,-1,-1], [-1,-1,1]];
        faces = [[0,2,1], [0,1,3], [1,2,3], [0,3,2]];
        polyhedron(points, faces);
    }
}

difference() {
    union() {
        scale(10) rotate([0, 0, 0]) translate([0, 0, 0.6]) rotate([0, -atan(sqrt(2)), 0]) rotate([0, 0, 45]) sierpinsky(4);
    }
    translate([0, 0, 1011.9]) cube([100,100,2000], center=true);
    translate([0, 0, -1015.9]) cube([100,100,2000], center=true);
}




