
use <solid_triangle.scad>

module isocahedron(initial_depth=2, thickness=0.2, scale=0.5, type=1) {
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
        echo(v1, v2, v3, depth)
        if(depth == 0)
        {
            echo(v1, v2, v3, depth);
            solid_triangle(v1, v2, v3, thickness, scale);
        } else if (depth == 1) {
            s12 = v1 + v2;
            v12 = (norm(s12) == 0) ? s12 : s12 / norm(s12);
            s23 = v2 + v3;
            v23 = (norm(s23) == 0) ? s23 : s23 / norm(s23);
            s31 = v1 + v3;
            v31 = (norm(s31) == 0) ? s31 : s31 / norm(s31);

            if(type == 1) {
                subdivide(v1, v12, v31, depth-1);
                subdivide(v2, v23, v12, depth-1);
                subdivide(v3, v31, v23, depth-1);
                subdivide(v12, v23, v31, depth-1);
            } else if(type == 2) {
                subdivide(v12, v23, v31, depth-1);
            } else if(type == 3) {
                subdivide(v1, v12, v31, depth-1);
                subdivide(v2, v23, v12, depth-1);
                //subdivide(v3, v31, v23, depth-1);
                //subdivide(v12, v23, v31, depth-1);
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
