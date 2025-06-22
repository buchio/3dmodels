// OpenSCAD Script to draw a circular path on a cylinder surface
// using only standard OpenSCAD functions.


// --- 線形補間 (Lerp) ---
// 2つの点(p1, p2)を、比率t(0から1)で内分する点を計算する
function lerp(p1, p2, t) = p1 * (1 - t) + p2 * t;

// --- パス上の点を取得する関数 ---
// path: 点の配列 [[x1,y1,z1], [x2,y2,z2], ...]
// t: パス全体のどの位置かを示す比率 (0=始点, 1=終点)
function get_point_on_path(path, t) =
    let(
        max_index = len(path) - 1,
        // t=1の場合にindex2が範囲外になるのを防ぐ
        float_index = t < 1 ? t * max_index : max_index - 0.00001,
        index1 = floor(float_index),
        index2 = ceil(float_index),
        local_t = float_index - index1
    )
    lerp(path[index1], path[index2], local_t);


// ================================================================
//  Function Definition (今回の主役)
// ================================================================

// Function: subdivide_path
// Description:
//   指定されたパス(path)をN個のセグメントに分割し、
//   その結果となるN+1個の点のリスト(配列)を返します。
// Arguments:
//   path: 点の配列 [[x1,y1,z1], [x2,y2,z2], ...]
//   n:    分割数 (正の整数)
// Returns:
//   新しい点のリスト(配列)
function subdivide_path(path, n = 10) =
    // リスト内包表記を使い、N+1個の点を計算して新しいリストを生成する
    [for (i = [0:n]) get_point_on_path(path, i / n)];


// Helper function to map a 2D point to the cylinder's surface
function wrap_point(p, cyl_r) =
    let(
        // 2DのX座標 -> 円周に沿った距離 -> 角度
        angle = (p[0] / cyl_r) * (180 / PI),
        // 2DのY座標 -> 高さ (Z)
        z_pos = p[1]
    )
    // 3D直交座標に変換して返す
    [cyl_r * cos(angle), cyl_r * sin(angle), z_pos];



// --- Module to create the wrapped circle path ---
module WrappedHemp(cyl_r, path_r, thickness, p_fn) {
    render(convexity = 2) {
        r = path_r;
        A = [-sqrt(3)/2 * r, 0];
        B = [0, r/2];
        C = [sqrt(3)/2 * r, 0];
        D = [0, -r/2];
        E = [-sqrt(3)/6 * r, 0];
        F = [sqrt(3)/6 * r, 0];

        // 1. Create a 2D circle path (a list of points)
        for (path2d = [[A,B],[B,C],[C, D],[D,A],[A,E],[E,B],[E,D],[B,D],[B,F],[D,F],[F,C]]) {
            // 2. Create the 3D path by applying the wrap function to each 2D point
            let (path3d = [for (p = subdivide_path(path2d, p_fn/4)) wrap_point(p, cyl_r)]) {
                // 3. Render the path as a tube by connecting spheres with hull()
                for (i = [0:len(path3d)-2]) {
                    hull() {
                        // Connect the current point to the next point
                        translate(path3d[i])
                        sphere(r = thickness, $fn=12);
                        translate(path3d[i + 1])
                        sphere(r = thickness, $fn=12);
                    }
                }
            }
        }
    }
}

// --- Module to create the wrapped circle path ---
module WrappedCircle(cyl_r, path_r, thickness, p_fn) {
    render(convexity = 2) {
        // 1. Create a 2D circle path (a list of points)
        path2d = [for (a = [0:360/p_fn:360-1/p_fn]) [path_r * cos(a), path_r * sin(a)]];

        // 2. Create the 3D path by applying the wrap function to each 2D point
        path3d = [for (p = path2d) wrap_point(p, cyl_r)];

        // 3. Render the path as a tube by connecting spheres with hull()
        for (i = [0:len(path3d)-1]) {
            hull() {
                // Connect the current point to the next point
                translate(path3d[i])
                    sphere(r = thickness, $fn=12);
                // Use modulo (%) to wrap around and close the loop
                translate(path3d[(i + 1) % len(path3d)])
                    sphere(r = thickness, $fn=12);
            }
        }
    }
}

$fn=32;

//cylinder(h = 54, r = 13, center=true);

// Test single WrappedHemp
//WrappedHemp(cyl_r = 13, path_r = 6.5, thickness = .5,  p_fn = $fn);
// Test single WrappedCircle
//WrappedCircle(cyl_r = 13, path_r = 6.5, thickness = .5,  p_fn = $fn);


// Shipppu Cylinder Parameters
// cylinder_radius: 円筒の半径
// cylinder_height: 円筒の高さ
// path_thickness : パスの太さ (断面の半径)
module shippou(cylinder_radius, cylinder_height, path_thickness) {
    path_radius = cylinder_radius / 2;  // 展開図上での円の半径 (mm)
    path_fn = 100;                      // パスを描画するための解像度
    difference() {
        cylinder(h = cylinder_height, r = cylinder_radius, center=true);
        {
            for (z = [-path_radius*4:path_radius*2:cylinder_height+path_radius*2]) {
                translate([0, 0, z])
                for (t = [0:60:300]) {
                    rotate([0, 0, t])
                    WrappedCircle(cyl_r = cylinder_radius, path_r = path_radius, thickness = path_thickness,  p_fn = $fn);
                    rotate([0, 0, t+30])
                    translate([0, 0, path_radius])
                    WrappedCircle(cyl_r = cylinder_radius, path_r = path_radius, thickness = path_thickness,  p_fn = $fn);
                }
            }
        }
    }
}
shippou(13, 54, .5);

// Hemp Cylinder Parameters
// cylinder_radius: 円筒の半径
// cylinder_height: 円筒の高さ
// path_thickness : パスの太さ (断面の半径)
module hemp(cylinder_radius, cylinder_height, path_thickness) {
    path_radius = cylinder_radius * .61;  // 展開図上での円の半径 (mm)
    path_fn = 100;                      // パスを描画するための解像度
    difference() {
        cylinder(h = cylinder_height, r = cylinder_radius, center=true);
        {
            for (z = [-(cylinder_height/2 + path_radius/2):path_radius:cylinder_height/2+path_radius/2]) {
                translate([0, 0, z])
                for (t = [0:60:300]) {
                    rotate([0, 0, t])
                    WrappedHemp(cyl_r = cylinder_radius, path_r = path_radius, thickness = path_thickness,  p_fn = $fn);
                    rotate([0, 0, t+30])
                    translate([0, 0, path_radius/2])
                    WrappedHemp(cyl_r = cylinder_radius, path_r = path_radius, thickness = path_thickness,  p_fn = $fn);
                }
            }
        }
    }
}
//hemp(13, 54, .5);
