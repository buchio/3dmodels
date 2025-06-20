// OpenSCAD Script to draw a circular path on a cylinder surface
// using only standard OpenSCAD functions.
// OpenSCADの標準機能のみを使用して、円筒表面に円形パスを描画するスクリプト。

// You can customize the parameters below.
// 以下のパラメータを自由に調整してください。

// Main Cylinder Parameters
cylinder_radius = 40; // 円筒の半径
cylinder_height = 100; // 円筒の高さ

// Path Parameters
// 「展開図」に描く円のパラメータ
path_radius = 25;      // 展開図上での円の半径 (mm)
path_center_height = 0;// 円の中心の高さ (Z座標)
path_thickness = 2;    // パスの太さ (断面の半径)
path_fn = 100;         // パスを描画するための解像度


// --- Module to create the wrapped circle path ---
// --- 巻き付けた円形パスを生成するモジュール ---
module WrappedCircle(cyl_r, path_r, path_z, thickness, p_fn) {

    // Helper function to map a 2D point to the cylinder's surface
    // 2D座標を円筒表面にマッピング（巻き付け）するヘルパー関数
    function wrap_point(p) =
        let(
            // 2DのX座標 -> 円周に沿った距離 -> 角度
            angle = (p[0] / cyl_r) * (180 / PI),
            // 2DのY座標 -> 高さ (Z)
            z_pos = path_z + p[1]
        )
        // 3D直交座標に変換して返す
        [cyl_r * cos(angle), cyl_r * sin(angle), z_pos];

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


// --- Example 1: Engraving a circular groove ---
// --- 例1: 円形の溝を彫る ---

// We move this model to the left.
// モデルを左側に移動します。
translate([-cylinder_radius-10, 0, 0]) {
    difference() {
        // Base cylinder
        cylinder(h = cylinder_height, r = cylinder_radius, center=true, $fn=100);

        // Create the groove by subtracting the wrapped circle
        // 巻き付けた円を引き算して溝を作成
        WrappedCircle(
            cyl_r = cylinder_radius,
            path_r = path_radius,
            path_z = path_center_height,
            thickness = path_thickness,
            p_fn = path_fn
        );
    }
}


// --- Example 2: Adding a circular bump ---
// --- 例2: 円形の突起を追加する ---

// We move this model to the right.
// モデルを右側に移動します。
translate([cylinder_radius+10, 0, 0]) {
    union() {
        // Base cylinder
        cylinder(h = cylinder_height, r = cylinder_radius, center=true, $fn=100);

        // Create the bump by adding the wrapped circle
        // 巻き付けた円を足し算して突起を作成
        WrappedCircle(
            cyl_r = cylinder_radius,
            path_r = path_radius,
            path_z = path_center_height,
            thickness = path_thickness,
            p_fn = path_fn
        );
    }
}
