include <BOSL2/std.scad>

// 壁のパラメータ
wall_length = 56;     // 壁の全長
wall_height = 30;      // 壁の高さ
wall_thickness = 2;    // 壁の厚み
wall_amplitude = 7;        // sinカーブの振幅（波の高さ）
frequency = 2;         // sinカーブの周波数（波の数）
resolution = 100;      // カーブの解像度（値を大きくすると滑らかになる）

// 1. sinカーブのパスを生成
path = [
    for (i = [0:1:resolution])
        let(angle = i/resolution * 360 * frequency)
        [i/resolution * wall_length, wall_amplitude * cos(angle), 0]
];

// 2. 壁の断面となる長方形を定義
shape = rect([wall_thickness, wall_height]);

// 3. パスに沿って断面を押し出して壁を作成


// ========= パラメータ =========
length = 56;          // 板の全長 (X軸方向)
width = 50;            // 板の基本幅 (Y軸方向)
amplitude = 5;
thickness = 60;         // 板の厚み
// ============================

// 板の輪郭となる閉じたパスを生成
path_points = concat(
    // 1. 底辺の頂点 (左下から右下へ)
    [[0,0], [length,0]],
    // 2. sinカーブの縁の頂点 (右から左へ)
    [for (i=[resolution:-1:0])
        let(
            x = i/resolution * length,
            angle = i/resolution * 360 * frequency
        )
        [x, width + amplitude * sin(angle)]
    ]
);

// 輪郭を押し出して板を作成


difference() {
    union() translate([0, 7, 15]) {
        translate([0, 28, 0]){
        translate([0, 14, 0]) rotate([180, 0, 0])path_sweep(shape, path);
        path_sweep(shape, path);
        }
        translate([0, 14, 0]) rotate([180, 0, 0])path_sweep(shape, path);
        path_sweep(shape, path);
    }

    union() {
        translate([0, -2, length+wall_height-amplitude*2-2])
        rotate([-90, 0, 0])
        linear_sweep(path_points, height=thickness);
        translate([-2, -2, 25]) cube([5, 60, 20]);
        translate([55.5, -2, 25]) cube([5, 60, 20]);
    }
}



difference() {
    translate([-2, -2, 0]) cube([60, 60, 25]);
    union() {
        cube([56, 56, 25]);
    }
}
union() {
}
