// 3D三角形に厚みを持たせ、その重心を中心に拡大縮小するモジュール
module solid_triangle_scaled(p1, p2, p3, thickness, scale_factor = 1) {
    // ベクトル計算
    v12 = p2 - p1;
    v13 = p3 - p1;
    normal_vec = cross(v12, v13); // 法線ベクトル
    normal_len = norm(normal_vec); // 法線ベクトルの長さ

    // スケーリングファクターの妥当性確認と調整
    actual_scale_factor = scale_factor;
    if (scale_factor <= 0 && scale_factor != 1) { // 0以下は無効（1と異なる場合のみ警告）
        echo(str("Warning: scale_factor (", scale_factor, ") must be positive. Using 1 (no scaling)."));
        actual_scale_factor = 1;
    }
    // 厚みの妥当性確認 (ここでは0以上を許容。0なら厚みなしの面になるが、polyhedronとしては描画される)
    if (thickness < 0){
        echo(str("Warning: thickness (", thickness, ") should be non-negative. Using 0."));
        thickness = 0;
    }


    if (normal_len < 0.00001) { // 3点がほぼ一直線上にある場合 (縮退ケース)
        echo(str("Warning: Points ", p1, ", ", p2, ", ", p3, " are nearly collinear. Cannot form a proper solid triangle."));
        // 縮退ケースでは、元の3点の中心に小さな球を表示するなどのフォールバック
        object_center_collinear = (p1 + p2 + p3) / 3;
        translate(object_center_collinear) {
            sphere(r = 0.1 * thickness > 0 ? thickness : 1, $fn=8); // 非常に小さなオブジェクト
        }
    } else { // 通常の三角形の場合
        unit_normal = normal_vec / normal_len; // 正規化された法線ベクトル

        // 1. 三角柱の6つの頂点を計算
        pt0_orig = p1 - unit_normal * thickness / 2; // 底面
        pt1_orig = p2 - unit_normal * thickness / 2;
        pt2_orig = p3 - unit_normal * thickness / 2;
        pt3_orig = p1 + unit_normal * thickness / 2; // 上面
        pt4_orig = p2 + unit_normal * thickness / 2;
        pt5_orig = p3 + unit_normal * thickness / 2;

        original_vertices = [
            pt0_orig, pt1_orig, pt2_orig,
            pt3_orig, pt4_orig, pt5_orig
        ];

        // 2. 三角柱の重心を計算
        centroid_prism = (pt0_orig + pt1_orig + pt2_orig + pt3_orig + pt4_orig + pt5_orig) / 6;

        // 面の定義 (polyhedron用)
        solid_faces = [
            [0, 2, 1],  // 底面 (p1, p3, p2) - 外向き法線のため巻き順調整
            [3, 4, 5],  // 上面 (p1_top, p2_top, p3_top)
            [0, 1, 4], [0, 4, 3], // 側面1 (p1-p2-p2_top-p1_top)
            [1, 2, 5], [1, 5, 4], // 側面2 (p2-p3-p3_top-p2_top)
            [2, 0, 3], [2, 3, 5]  // 側面3 (p3-p1-p1_top-p3_top)
        ];

        // 3. スケーリングと描画
        if (actual_scale_factor == 1) {
            // スケーリングなし: 元の頂点で polyhedron を描画
            polyhedron(points = original_vertices, faces = solid_faces, convexity = 5);
        } else {
            // スケーリングあり: 重心中心にスケーリング
            translate(centroid_prism) {
                scale(actual_scale_factor) {
                    translate(-centroid_prism) {
                        // スケーリング対象のオブジェクト (元の三角柱)
                        polyhedron(points = original_vertices, faces = solid_faces, convexity = 5);
                    }
                }
            }
        }
    }
}

// --- 使用例 ---
P1_orig = [0, 0, 0];
P2_orig = [20, 5, 2];
P3_orig = [10, 25, 8];
thickness_val = 3;

// 例1: スケーリングなし (scale_factor = 1)
color("blue") {
    solid_triangle_scaled(P1_orig, P2_orig, P3_orig, thickness_val, scale_factor = 1);
}

// 例2: 50%に縮小
translate([0,0,0]) { // 表示位置をずらす
    color("red") {
        solid_triangle_scaled(P1_orig, P2_orig, P3_orig, thickness_val, scale_factor = 0.5);
    }
}

// 例3: 150%に拡大
translate([0,0,0]) { // 表示位置をずらす
    color("green") {
        solid_triangle_scaled(P1_orig, P2_orig, P3_orig, thickness_val, scale_factor = 3.5);
    }
}

// 元の3点の位置を小さな球で示す (参考)
%color("yellow") {
    translate(P1_orig) sphere(r=6, $fn=12);
    translate(P2_orig) sphere(r=4, $fn=12);
    translate(P3_orig) sphere(r=4, $fn=12);
}