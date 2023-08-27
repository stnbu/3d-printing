
// hinge
$nf = 20;
$fs = 0.1;
$fa = 1;

width = 120;
outer_radius = 5;
pin_radius = outer_radius / 2;
pin_length = width / 2 * 0.9;
leaf_length = width / 2;

receiver_radius = outer_radius / 2;
receiver_length = width / 2;

male();
*female();

module male() {
    cylinder(r=outer_radius, h=leaf_length, center=false);
    translate([0, 0, leaf_length]) cylinder(r=pin_radius, h=pin_length, center=false);

    catch_resess = width * 0.1;
    translate([0,0,width - catch_resess]) catch();
}

module female() {
    translate([0,0,receiver_length]) difference() {
        cylinder(r=outer_radius, h=receiver_length, center=false);
        cylinder(r=receiver_radius, h=pin_length, center=false);
    }
}

module catch() {
    radius = receiver_radius * 0.5;
    for (i = [0:90:360]) {
        rotate(a=i, v=[0,0,1]) translate([receiver_radius, 0, 0]) hull() {
            translate([0,0,radius])    sphere(radius);
            translate([0,0,-radius])    sphere(radius);
        }
    }
}