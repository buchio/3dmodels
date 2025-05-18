// 3点と厚さを指定して、厚みのある三角形（三角柱）を作成するモジュール
module solid_triangle(p1, p2, p3, thickness, scale=1.0) {
    // 3点から2つのベクトルを計算
    v12 = p2 - p1;
    v13 = p3 - p1;

    // 法線ベクトルを計算 (v12 と v13 の外積)
    // OpenSCAD 2019.05 以降では cross() 関数が利用可能
    normal_vec = cross(v12, v13);

    // 法線ベクトルの長さ（ノルム）を計算
    normal_len = norm(normal_vec);

    // 3点が一直線上にある（縮退している）場合、警告を出して処理を中断
    if (normal_len < 0.00001) { // 小さな許容値を設ける
        echo(str("Warning: Points p1=", p1, ", p2=", p2, ", p3=", p3, " are collinear or too close. Cannot form a solid triangle."));
        // 空のオブジェクトを描画するか、エラーとして扱います
        polyhedron(points=[], faces=[]);
    } else {
        // 法線ベクトルを正規化（単位ベクトル化）
        unit_normal = normal_vec / normal_len;

        // 6つの頂点を定義
        // 底面の頂点 (インデックス: 0, 1, 2)
        pt0 = p1;
        pt1 = p2;
        pt2 = p3;
        // 上面の頂点 (インデックス: 3, 4, 5)
        pt3 = p1 + unit_normal * thickness;
        pt4 = p2 + unit_normal * thickness;
        pt5 = p3 + unit_normal * thickness;

        all_points = [
            pt0, pt1, pt2,  // 0, 1, 2
            pt3, pt4, pt5   // 3, 4, 5
        ];

        // 面を定義 (すべての法線が外側を向くように頂点の巻き順を調整)
        // OpenSCADでは通常、面を外側から見て反時計回りに頂点を指定します。
        all_faces = [
            // 底面 (法線が unit_normal と逆方向を向くように)
            [0, 2, 1],  // p1, p3, p2

            // 上面 (法線が unit_normal と同じ方向を向くように)
            [3, 4, 5],  // p1_top, p2_top, p3_top

            // 側面 (各四角形を2つの三角形に分割)
            // 側面1: p1-p2-p2_top-p1_top
            [0, 1, 4], [0, 4, 3],
            // 側面2: p2-p3-p3_top-p2_top
            [1, 2, 5], [1, 5, 4],
            // 側面3: p3-p1-p1_top-p3_top
            [2, 0, 3], [2, 3, 5]
        ];
        center = (pt0 + pt1 + pt2 + pt3 + pt4 + pt5) / 6;
        translate(center)
            scale(scale)
                translate(-center)
                    polyhedron(points = all_points, faces = all_faces, convexity = 5);
        // convexity はレンダリングのヒントです。単純な形状では大きな影響はありません。
    }
}

