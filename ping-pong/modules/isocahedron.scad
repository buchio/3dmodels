use <triangle.scad>

module connect_points(point1, point2, radius) {
  // 1. 2点の座標
  start_point = point1;
  end_point = point2;

  // 2. 方向ベクトル
  direction_vector = end_point - start_point;

  // 3. 円柱の高さ (方向ベクトルの長さ)
  height = norm(direction_vector);

  // 4. 回転の計算
  // 方向ベクトルを単位ベクトルに正規化
  normalized_direction = direction_vector / height;

  // 回転軸の計算 (upベクトルと方向ベクトルの外積)
  rotation_axis = cross([0, 0, 1], normalized_direction);

  // 回転角の計算 (upベクトルと方向ベクトルの内積からコサインを求め、アークコサインで角度を取得)
  rotation_angle = acos([0, 0, 1] * normalized_direction);

  // 5. 円柱の描画
  translate(start_point) // 始点に移動
  rotate(a = rotation_angle, v = rotation_axis) // 計算した軸と角度で回転
  cylinder(h = height, r = radius, center = false); // 円柱を描画 (底面が原点)
}

function cent(v) = (norm(v) == 0) ? v : v / norm(v);

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
            if(type == 3) {
                connect_points(v1, v2, thickness);
                connect_points(v1, v3, thickness);
                translate(v1) sphere(thickness*1.1);
                translate(v2) sphere(thickness*1.1);
                translate(v3) sphere(thickness*1.1);
            } else {
                solid_triangle_scaled(v1, v2, v3, thickness, scale);
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
