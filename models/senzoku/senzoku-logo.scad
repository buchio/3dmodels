// 幅を持つ円弧 (リングセグメント) を描画するモジュール (for comprehension 版 - 角度はすべて度数法で扱う)
module wide_arc_polygon(outer_radius, inner_radius, start_angle, end_angle, fn = $fn) {
    if (inner_radius >= outer_radius) {
        echo("エラー: inner_radius は outer_radius より小さくする必要があります。");
        // return; // OpenSCADでは機能しないので、削除するかコメントアウト
    }
    
    // 角度はすでに度数法で与えられているので、ラジアン変換は不要
    // start_rad = start_angle; // 便宜上の変数名を変更
    // end_rad = end_angle;     // 便宜上の変数名を変更
    
    // 円周上の点の数を計算
    // 角度の差を考慮して、適切なセグメント数を決定します
    angle_range = end_angle - start_angle;
    // num_segments の計算ロジックは以前のものでも問題ありませんが、
    // より直感的に角度の範囲全体に $fn の解像度を適用する形に変更
    num_segments = max(2, ceil(abs(angle_range) / (360 / fn)));
    
    // 外側の円弧の点をリスト内包表記で生成
    outer_points = [ 
        for (i = [0 : num_segments]) 
            let(current_angle_deg = start_angle + angle_range * i / num_segments) // ここも度数法のまま
            [outer_radius * cos(current_angle_deg), outer_radius * sin(current_angle_deg)] 
    ];

    // 内側の円弧の点を逆順でリスト内包表記で生成
    inner_points_reversed = [
        for (i = [0 : num_segments])
            // 角度の計算も度数法のまま、逆順になるように調整
            let(current_angle_deg = start_angle + angle_range * (num_segments - i) / num_segments)
            [inner_radius * cos(current_angle_deg), inner_radius * sin(current_angle_deg)]
    ];

    // これらをconcatで結合
    points = concat(outer_points, inner_points_reversed);
    
    polygon(points);
}

$fn=64;

module edge() {
    translate([.5, 0, 0]) {
        hull() {
            circle(.5);
            translate([3, 0, 0]) circle(.5);
        }
    }
}

module senzoku_logo_silhouette(offset=0) {
    union() {
        translate([0, -5, 0]) {
            circle(12+offset);
        }
        translate([-2, 10, 0]) {
                circle(7+offset);
        }
    }
}

module senzoku_logo_inner() {
    union() {
        //wide_arc_polygon(22, 18, 0, 360);
        translate([0, -5, 0]) {
            wide_arc_polygon(12, 8, 20, 357);
            translate([1, -3, 0]) square([8, 3]);
            rotate([0, 0, 20]) translate([8, 0, 0]) edge();
            translate([8, -.5, 0])  edge();
        }
        translate([-2, 10, 0]) {
                wide_arc_polygon(7, 3, 15, 270);
                rotate([0, 0, 15]) translate([3, 0, 0]) edge();

        }
        translate([-2, -1, 0]) {
                wide_arc_polygon(8, 4, -210, 90);
        }
    }
}

//senzoku_logo_inner();
//translate([50, 0, 0]) senzoku_logo_silhouette();



