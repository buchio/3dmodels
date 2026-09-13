include <BOSL2/std.scad>
include <BOSL2/gears.scad>


$fn=100;

// --- ギア・機構パラメータ ---
z       = 12;            // 歯数（4の倍数にすると45度対角で完璧に噛み合う）
r_pitch = 33;            // ピッチ円半径（瞳のサイズに合わせた半径）
d       = r_pitch * 2;   // ギア同士の中心間距離
l       = sqrt(2) * d;   // 正方格子の1辺（対角距離が d になる間隔）
p = 1;

nx = 1;
ny = 1;


// 四隅グループ
for (x = [0:nx], y = [0:ny])
    translate([x, y] * l * p)
        synced_eye($t * 360 + 180 / z, 1);

// 中央グループ
for (x = [0:nx-1], y = [0:ny-1])
    translate([x + 0.5, y + 0.5] * l * p)
        synced_eye(-$t * 360, -1);

translate([(nx+1)*r_pitch*2+100*p, 0, 0]) {        

translate([-l/2, -l/2, 0])
                linear_extrude(height = 10, center = false, convexity = 10, twist = 0)
                square([(nx+1)*l, (ny+1)*l]);

// 四隅グループ
for (x = [0:nx], y = [0:ny])
    translate([x*l, y*l, 10]) {
        cylinder(70, 18, 9);
    }

// 中央グループ
for (x = [0:nx-1], y = [0:ny-1])
    translate([(x+0.5)*l, (y+0.5)*l, 10]) {
        cylinder(70, 18, 9);
    }
}


// 歯車と瞳の一体モジュール
module synced_eye(angle = 0, t) {
    rotate(angle) {
        difference() {
            union() {
                translate([0, 0, 2])
                linear_extrude(height = 20, center = false, convexity = 10, twist = 0)
                    spur_gear2d(circ_pitch=r_pitch/2, teeth=12, pressure_angle=20);
                cylinder(25.5, 26, 26);
                translate([0, 0, 25]) {
                    linear_extrude(height = 200, center = false, convexity = 10, twist = 180*t)
                    scale([1.45, 1.2, 1]) eye();
                }
            }
            translate([0, 0, -.01]) cylinder(80, 20, 10);
        }
    }
}

// 瞳モジュール
module eye() {
    color("forestgreen")
    intersection() {
        translate([0, -25]) circle(40);
        translate([0,  25]) circle(40);
    }
}
