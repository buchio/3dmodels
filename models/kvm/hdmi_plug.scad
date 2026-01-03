// HDMI Type A Plug Shell
// Dimensions are in mm

$fn = 50;

// パラメータ設定
width_top = 13.9;
width_bottom = 9.5;
height = 4.45;
depth = 10.0;
wall_thickness = 0.5; // 外殻の厚み（中空にする場合）

module hdmi_plug_solid() {
    // 断面の座標計算
    // 中心を原点(0,0)にするためのオフセット
    x1 = width_top / 2;
    x2 = width_bottom / 2;
    y1 = height / 2;
    y2 = -height / 2;

    linear_extrude(height = depth) {
        polygon(points = [
            [-x1,  y1], // 左上
            [ x1,  y1], // 右上
            [ x1,  y2 + 1.2], // 右側面（垂直部分の終わり）
            [ x2,  y2], // 右下（傾斜の終わり）
            [-x2,  y2], // 左下（傾斜の始まり）
            [-x1,  y2 + 1.2]  // 左側面（垂直部分の始まり）
        ]);
    }
}

// 実行（中空のシェルとして作成）
difference() {
    hdmi_plug_solid();
    
    // 内部をくり抜く（必要に応じて）
    translate([0, 0, -1])
        scale([(width_top-wall_thickness*2)/width_top, (height-wall_thickness*2)/height, 1.2])
            hdmi_plug_solid();
}

// ガイド用の中心線（デバッグ用）
#translate([0,0,depth/2]) cube([0.1, 10, depth+2], center=true);


