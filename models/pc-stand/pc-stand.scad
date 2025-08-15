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


h=6;
w=12;
s=10;

rotate([0, -90, 0]) {
    translate([0, 0, 0])
    right_triangle(h, w, .5, 1);
    translate([0, 0, s-1])
    right_triangle(h, w, .5, 1);

    translate([.5, .5, 0]) cylinder(h=s, r=.5);
    //translate([h-.5, .5, 0]) cylinder(h=s, r=.5);
    translate([.5, w-.5, 0]) cylinder(h=s, r=.5);

    translate([.4, w-.45, 0]) rotate([0, 0, 25]) cube([1.6, .4, s]);
}