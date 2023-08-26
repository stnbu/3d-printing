
//hinge();

width = 120;
outer_radius = 5;
shaft_radius = outer_radius / 2;
shaft_length = width;
leaf_length = width / 2;

receiver_radius_delta = 1.1;
receiver_radius = outer_radius / 2 * receiver_radius_delta;
receiver_length = width / 2;

male();
translate([15, 0, 120/2])
    female();

module male() {
    cylinder(r=shaft_radius, h=shaft_length * 0.8, center=false);
    cylinder(r=outer_radius, h=leaf_length, center=false);
}

module female() {
    d = 0.95;
    difference() {
        cylinder(r=outer_radius, h=receiver_length, center=false);
        cylinder(r=receiver_radius, h=receiver_length, center=false);
    }
}