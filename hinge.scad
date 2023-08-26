
//hinge();

male(120, 5);
translate([15, 0, 120/2])
    female(120, 5);

/*
module hinge() {
    outer_radius = 5;
    shaft_radius = 3;
    width = 60;

    translate([0,0,10]) {
        cylinder(r=outer_radius, h=width, center=true);
        translate([0,0,width/2]) {
            cylinder(r=shaft_radius, h=width, center=true);
        }
    }
}
*/

module male(width, outer_radius) {
    // shaft
    shaft_radius = outer_radius / 2;
    shaft_length = width;
    cylinder(r=shaft_radius, h=shaft_length * 0.8, center=false);

    // leaf (attach point)
    leaf_length = width / 2;
    cylinder(r=outer_radius, h=leaf_length, center=false);
}

module female(width, outer_radius) {
    d = 0.95;
    receiver_radius = outer_radius / 2 * d;
    receiver_length = width / 2;
    difference() {
        cylinder(r=outer_radius, h=receiver_length, center=false);
        cylinder(r=receiver_radius, h=receiver_length * 0.8, center=false);
    }
}