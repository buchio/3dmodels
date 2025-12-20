// HDMI Type A Socket (Port Cutout)
// 3Dプリンタでの出力を想定し、少し余裕（クリアランス）を持たせています

module hdmi_socket_cutout(depth = 12, clearance = 0.2) {
    // 基本寸法 + クリアランス
    w_top = 14.0 + clearance;
    w_bottom = 9.6 + clearance;
    h = 4.55 + clearance;
    
    // 座標計算
    x1 = w_top / 2;
    x2 = w_bottom / 2;
    y1 = h / 2;
    y2 = -h / 2;
    slope_h = 1.2; // 下部の傾斜が始まる高さ

    translate([0, 0, 0])
    linear_extrude(height = depth) {
        polygon(points = [
            [-x1,  y1], 
            [ x1,  y1], 
            [ x1,  y2 + slope_h], 
            [ x2,  y2], 
            [-x2,  y2], 
            [-x1,  y2 + slope_h]
        ]);
    }
}




// --- 使用例: ケースの壁に穴を開ける ---
difference() {
    // ケースの壁面（例）
    translate([-15, -10, 0]) cube([30, 20, 3]); 
    
    // HDMIポートを配置（壁を貫通させるために少しずらす）
    translate([0, 0, -1]) 
        hdmi_socket_cutout(depth = 5, clearance = 0.3);
}