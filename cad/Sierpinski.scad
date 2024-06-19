module tetrahedron(x) {
    polyhedron(points=[ [1,1,1],[-1,-1,1],[1,-1,-1],[-1,1,-1]  ],
        faces=[ [0,1,2], [0,1,3], [1,2,3], [0,2,3] ]);
}
        
sx = 0.52;
tx = 0.5;


module sierpinsky(ord) {
    if( ord > 0 ) {
        translate([tx,tx,tx]) scale([sx,sx,sx]) sierpinsky(ord-1);
        translate([-tx,-tx,tx]) scale([sx,sx,sx]) sierpinsky(ord-1);
        translate([tx,-tx,-tx]) scale([sx,sx,sx]) sierpinsky(ord-1);
        translate([-tx,tx,-tx]) scale([sx,sx,sx]) sierpinsky(ord-1);
    } else {
        polyhedron(points=[ [1,1,1],[-1,-1,1],[1,-1,-1],[-1,1,-1]  ],
                   faces=[ [0,1,2], [1,2,3], [0,1,3], [0,2,3] ]);
    }
}

//scale(10) 
//    translate([0, 0, 0.6]) 
//    rotate([atan(sqrt(2)), 0, 0]) 
//    rotate([0, 0, 45]) sierpinsky(1);


points = [[-1,-1,-1], [-1,1,-1], [1,-1,-1], [-1,-1,1]];
polyhedron(points, [[0,2,1], [0,1,3], [1,2,3], [0,3,2]]);
translate([1,0,0]) polyhedron(points, [[0,2,1], [0,1,3], [1,2,3], [0,3,2]]);
