use <triangle.scad>

function cent(v) = (norm(v) == 0) ? v : v / norm(v);
function quarter(v1, v2) = cent(v1 + cent(v1+v2));
function _dot(v1, v2) = v1.x * v2.x + v1.y * v2.y + v1.z * v2.z;
function project_point_on_line(p1, p2, p3) = (p2 + _dot((p1-p2),(p3-p2)) / _dot((p3-p2),(p3-p2)) * (p3-p2));

module isocahedron(initial_depth=2, thickness=0.4, scale=0.5, type=1) {
    X = 0.525731112119133606;
    Z = 0.850650808352039932;
    vdata = [
        [-X, 0.0, Z], [ X, 0.0, Z ], [ -X, 0.0, -Z ], [ X, 0.0, -Z ],
        [ 0.0, Z, X ], [ 0.0, Z, -X ], [ 0.0, -Z, X ], [ 0.0, -Z, -X ],
        [ Z, X, 0.0 ], [ -Z, X, 0.0 ], [ Z, -X, 0.0 ], [ -Z, -X, 0.0 ]
    ]; // isocahedron vertex coordinates
    tindices = [
        [0, 4, 1], [ 0, 9, 4 ], [ 9, 5, 4 ], [ 4, 5, 8 ], [ 4, 8, 1 ],
        [ 8, 10, 1 ], [ 8, 3, 10 ], [ 5, 3, 8 ], [ 5, 2, 3 ], [ 2, 7, 3 ],
        [ 7, 10, 3 ], [ 7, 6, 10 ], [ 7, 11, 6 ], [ 11, 0, 6 ], [ 0, 1, 6 ],
        [ 6, 1, 10 ], [ 9, 0, 11 ], [ 9, 11, 2 ], [ 9, 2, 5 ], [ 7, 2, 11 ]
    ]; // isocahedron triangles
    
    module subdivide(v1, v2, v3, depth) {
        //echo(v1, v2, v3, depth)
        if(depth == 0)
        {
            v123 = cent(v1+v2+v3);
            v1_123 = quarter(v1, v123);
            v2_123 = quarter(v2, v123);
            v3_123 = quarter(v3, v123);
            if( type == 1 ) {
                polyhedron([[0, 0, 0], v1_123, v2_123, v3_123], [[0, 1, 2], [0, 2, 3], [0, 3, 1], [1, 3, 2]]);
            } else if (type == 2) {
                p1 = v1 - (v123-v1)*.1;
                p2 = v2 - (v123-v2)*.1;
                p3 = v3 - (v123-v3)*.1;
                polyhedron([[0, 0, 0], p1, p2, p3], [[0, 1, 2], [0, 2, 3], [0, 3, 1], [1, 3, 2]]);
            } else if( type == 3 ) {
                p2= project_point_on_line(v2_123, v2, v3);
                p3= project_point_on_line(v3_123, v2, v3);
                polyhedron([[0, 0, 0], v1_123, p2, p3], [[0, 1, 2], [0, 2, 3], [0, 3, 1], [1, 3, 2]]);
            }
        } else if (depth == 1) {
            v12 = cent(v1 + v2);
            v23 = cent(v2 + v3);
            v31 = cent(v1 + v3);
            v123 = cent(v1 + v2 + v3);

            if(type == 1) {
                subdivide(v1, v12, v31, depth-1);
                subdivide(v2, v23, v12, depth-1);
                subdivide(v3, v31, v23, depth-1);
                subdivide(v12, v23, v31, depth-1);
            } else if(type == 2) {
                subdivide(v12, v23, v31, depth-1);
            } else if(type == 3) {
                subdivide(v123, v1, v2, depth-1);
                subdivide(v123, v2, v3, depth-1);
                subdivide(v123, v3, v1, depth-1);
            }
        } else {
            s12 = v1 + v2;
            v12 = (norm(s12) == 0) ? s12 : s12 / norm(s12);
            s23 = v2 + v3;
            v23 = (norm(s23) == 0) ? s23 : s23 / norm(s23);
            s31 = v1 + v3;
            v31 = (norm(s31) == 0) ? s31 : s31 / norm(s31);

            subdivide(v1, v12, v31, depth-1);
            subdivide(v2, v23, v12, depth-1);
            subdivide(v3, v31, v23, depth-1);
            subdivide(v12, v23, v31, depth-1);
        }
    }
 
    for(i = tindices) {
        subdivide(vdata[i[0]], vdata[i[1]], vdata[i[2]], initial_depth);
    }
};

module ball_type_1(depth=2) {
    scale(2) {
        difference() {
            difference() {
                sphere(.5);
                isocahedron(initial_depth=depth, type=1);
            }
            sphere(.45);
        }
    }
};

module ball_type_2(depth=2) {
    scale(2) {
        difference() {
            intersection() {
                sphere(.5);
                isocahedron(initial_depth=depth, type=2);
            }
            sphere(.45);
        }
    }
};

module ball_type_3(depth=2) {
    scale(2) {
        difference() {
            difference() {
                sphere(.5);
                isocahedron(initial_depth=depth, type=3);
            }
            sphere(.45);
        }
    }
};

$fn=64;
ball_type_3(3);