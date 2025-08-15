module right_triangle(side1,side2,corner_radius,triangle_height){
    translate([corner_radius,corner_radius,0]){  
        hull(){  
        cylinder(r=corner_radius,h=triangle_height);
          translate([side1 - corner_radius * 2,0,0])cylinder(r=corner_radius,h=triangle_height);
              translate([0,side2 - corner_radius * 2,0])cylinder(r=corner_radius,h=triangle_height);  
        }
    }
}
$fn=20;


t=8;
r=5;
h=60;
w=120;
s=100;

rotate([0, -90, 0]) {
    translate([0, 0, 0])
    right_triangle(h, w, r, t);
    translate([0, 0, s-t])
    right_triangle(h, w, r, t);

    translate([r, r, 0]) cylinder(h=s, r=r);
    translate([r, w/2, 0]) cylinder(h=s, r=r);
    translate([h-r, r, 0]) cylinder(h=s, r=r);
    translate([h/2, w/2, 0]) cylinder(h=s, r=r);
    translate([r, w-r, 0]) cylinder(h=s, r=r);

    translate([4, w-4.5, 0]) rotate([0, 0, 25]) cube([16, 4, s]);
}