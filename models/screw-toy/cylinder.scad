// OpenSCAD Script to draw a circular path on a cylinder surface
// using only standard OpenSCAD functions.
// This version includes the render() module for performance optimization.
//
// OpenSCADの標準機能のみを使用して、円筒表面に円形パスを描画するスクリプト。
// このバージョンでは、パフォーマンス最適化のために render() モジュールを使用しています。

// You can customize the parameters below.
// 以下のパラメータを自由に調整してください。

// --- Module to create the wrapped circle path ---
// --- 巻き付けた円形パスを生成するモジュール ---
module WrappedCircle(cyl_r, path_r, thickness, p_fn) {

    // Helper function to map a 2D point to the cylinder's surface
    // 2D座標を円筒表面にマッピング（巻き付け）するヘルパー関数
    function wrap_point(p) =
        let(
            // 2DのX座標 -> 円周に沿った距離 -> 角度
            angle = (p[0] / cyl_r) * (180 / PI),
            // 2DのY座標 -> 高さ (Z)
            z_pos = p[1]
        )
        // 3D直交座標に変換して返す
        [cyl_r * cos(angle), cyl_r * sin(angle), z_pos];

    // --- Optimization Point ---
    // --- 最適化のポイント ---
    // By wrapping the complex geometry generation in render(),
    // OpenSCAD caches the result as a single mesh. This significantly
    // speeds up subsequent boolean operations (difference/union).
    // 複雑な形状生成を render() で囲むことで、OpenSCADはその結果を
    // 一つのメッシュとしてキャッシュします。これにより、後続の
    // ブーリアン演算（difference/union）が大幅に高速化されます。
    render(convexity = 2) {
        // 1. Create a 2D circle path (a list of points)
        // 1. まず、2Dの円パス（点のリスト）を作成
        path2d = [for (a = [0:360/p_fn:360-1/p_fn]) [path_r * cos(a), path_r * sin(a)]];

        // 2. Create the 3D path by applying the wrap function to each 2D point
        // 2. 2Dパスの各点にwrap関数を適用し、3Dパスを作成
        path3d = [for (p = path2d) wrap_point(p)];

        // 3. Render the path as a tube by connecting spheres with hull()
        // 3. hull()で球をつなぎ合わせ、パスをチューブとして描画
        for (i = [0:len(path3d)-1]) {
            hull() {
                // Connect the current point to the next point
                // 現在の点と次の点を接続
                translate(path3d[i])
                    sphere(r = thickness, $fn=12);
                // Use modulo (%) to wrap around and close the loop
                // モジュロ(%)を使い、最後の点と最初の点を接続してループを閉じる
                translate(path3d[(i + 1) % len(path3d)])
                    sphere(r = thickness, $fn=12);
            }
        }
    }
}


// Main Cylinder Parameters
cylinder_radius = 13; // 円筒の半径
cylinder_height = 54; // 円筒の高さ

// Path Parameters
// 「展開図」に描く円のパラメータ
path_radius = 6.5;      // 展開図上での円の半径 (mm)
path_center_height = 0;// 円の中心の高さ (Z座標)
path_thickness = .5;    // パスの太さ (断面の半径)
path_fn = 100;         // パスを描画するための解像度

//    cylinder(h = cylinder_height, r = cylinder_radius, center=true);
//    {
//        for (y = [-path_radius*4:path_radius*2:cylinder_height+path_radius*2]) {
//            translate([0, 0, y]) {
//                for (t = [0:60:300]) {
//                    translate([0, 0, -path_radius])
//                    rotate([0, 0, t]) 
//                    wrapped_circle(path_radius, cylinder_radius, path_thickness);
//                    rotate([0, 0, t+30]) 
//                    wrapped_circle(path_radius, cylinder_radius, path_thickness);
//                }
//            }
//        }
//    }


difference() {
    cylinder(h = cylinder_height, r = cylinder_radius, center=true, $fn=100);
    {
        for (z = [-path_radius*4:path_radius*2:cylinder_height+path_radius*2]) {
            translate([0, 0, z])
            for (t = [0:60:300]) {
                rotate([0, 0, t])
                WrappedCircle(cyl_r = cylinder_radius, path_r = path_radius, thickness = path_thickness,  p_fn = path_fn);
                rotate([0, 0, t+30])
                translate([0, 0, path_radius])
                WrappedCircle(cyl_r = cylinder_radius, path_r = path_radius, thickness = path_thickness,  p_fn = path_fn);
            }
        }
    }
}
