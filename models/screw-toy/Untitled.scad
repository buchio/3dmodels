// OpenSCAD Script to draw a circular path on a cylinder surface
// using a projection from a 2D plane to cylindrical coordinates.


// Helper function to calculate a point on the wrapped circle
// 巻き付けた円周上の点を計算するヘルパー関数
function get_wrapped_point(step, total_steps, circle_r, cyl_r) =
    let (
        // 1. Calculate the angle (t) for the point on the 2D circle
        // 1. まず、平面上の円の点に対応する角度(t)を計算
        t = step * 360 / total_steps,
        // 2. Calculate the (x, y) coordinates on the 2D plane
        // 2. 次に、展開図上での円の座標(x,y)を計算
        x_plane = circle_r * cos(t),
        y_plane = circle_r * sin(t),
        // 3. Convert the 2D coordinates to cylindrical coordinates
        // 3. 2D座標を円筒座標に変換
        //    x_plane -> angle on the cylinder surface (円筒表面の角度)
        //    y_plane -> height on the cylinder (円筒の高さ)
        angle = (x_plane / cyl_r) * (180 / PI), // arc-length/radius -> rad -> deg
        z = y_plane,
        // 4. Convert cylindrical coordinates back to 3D Cartesian coordinates
        // 4. 最終的に円筒座標を3Dの直交座標に戻す
        x3d = cyl_r * cos(angle),
        y3d = cyl_r * sin(angle)
    ) [x3d, y3d, z];

module wrapped_circle(path_radius, cylinder_radius, path_thickness) {
    for (i=[0:$fn-1]) {
        let (p1 = get_wrapped_point(i, $fn, path_radius, cylinder_radius))
        let (p2 = get_wrapped_point(i+1, $fn, path_radius, cylinder_radius))
        {
            hull() {
                translate(p1) sphere(r = path_thickness);
                translate(p2) sphere(r = path_thickness);
            }
        }
    }
}

// --- Example 1: Engraving a circular groove ---
// --- 例1: 円形の溝を彫る ---

$fn=64;


cylinder_radius = 13; // 円筒の半径
cylinder_height = 55; // 円筒の高さ
path_radius = 6.5;      // 展開図上での円の半径 (mm)
path_thickness = 1;    // パスの太さ (断面の半径)

difference() {

    cylinder(h = cylinder_height, r = cylinder_radius, center=true);
    {
        for (y = [-path_radius*4:path_radius*2:cylinder_height+path_radius*2]) {
            translate([0, 0, y]) {
                for (t = [0:60:300]) {
                    translate([0, 0, -path_radius])
                    rotate([0, 0, t]) 
                    wrapped_circle(path_radius, cylinder_radius, path_thickness);
                    rotate([0, 0, t+30]) 
                    wrapped_circle(path_radius, cylinder_radius, path_thickness);
                }
            }
        }
    }
}


