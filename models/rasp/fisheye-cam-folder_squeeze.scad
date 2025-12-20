$fn=20;

rotate([-20, -20, 0]) 
translate([.5, -30, 2]) 
{
    translate([14, 14, 0]) cylinder(2.5, 0.9, 0.9, center=true);
    translate([-14, 14, 0]) cylinder(2.5, 0.9, 0.9, center=true);
    translate([14, -14, 0]) cylinder(2.5, 0.9, 0.9, center=true);
    translate([-14, -14, 0]) cylinder(2.5, 0.9, 0.9, center=true);
    difference() {
        union() {
            cube([33, 33, 2.5], center=true);
        }
        union() {
            translate([0, 0, .5]) cube([32, 32, 2.5], center=true);
            translate([0, 17, .5]) cube([22, 10, 2.5], center=true);
            translate([10, 0, 0]) cylinder(10, 2.5, 2.5, center=true);
            translate([-10, 0, 0]) cylinder(10, 2.5, 2.5, center=true);
        }
    }
    color("blue") translate([0, 26, 0.1]) cube([11.8, 12, 2.8], center=true);

    color("green")
    translate([0, 16.7, -1])
    // --- hull()を使って角錐台を生成 ---
    hull() {
        // 1. 底面の図形 (Z=0の位置)
        // 非常に薄い(0.01)立方体を配置します
        translate([0, 0, 0]) {
            cube([20, 1, .5], center = true);
        }
        
        // 2. 天面の図形 (Z=heightの位置)
        // 高さを変えて、もう一つの立方体を配置します
        translate([0, 10, .45]) {
            cube([10, 1, 1.5], center = true);
        }
    }
}
color("red") translate([0, 24, 1.4]) cube([11.8, 15, 2.8], center=true);

translate([0, 17, 1.4])
rotate([90, 0, 0])
linear_extrude(15, twist=-20)
    square([11.8, 2.8], center=true);