// hinge

$nf = 20;
$fs = 0.1;
$fa = 1;

total_length = 120;
outer_radius = 5;
pin_radius = outer_radius / 2;
pin_length = total_length / 2 * 0.9 - pin_radius;
leaf_length = total_length / 2;
receiver_radius = outer_radius / 2;
receiver_length = total_length / 2;
male_hemicap = true;
female_hemicap = true;
catch_setback = total_length * 0.1;

male();
translate([outer_radius * 2.2, 0, 0]) female();

module male() {
    cylinder(r=outer_radius, h=leaf_length, center=false);
    if (male_hemicap) {
        sphere(outer_radius);
    }
    translate([0, 0, leaf_length])
        cylinder(r=pin_radius, h=pin_length, center=false);
    translate([0, 0, leaf_length + pin_length])
        sphere(pin_radius);
    translate([0,0,total_length - catch_setback])
        catch();
}

module female() {
    difference() {
        difference() {
            cylinder(r=outer_radius, h=receiver_length, center=false);
            cylinder(r=receiver_radius, h=pin_length, center=false);
        }
        translate([0,0,receiver_length - catch_setback]) catch_ring();
    }
    if (female_hemicap) {
        translate([0, 0, receiver_length])
            sphere(outer_radius);
    }
}

module catch() {
    radius = pin_radius * 0.4;
    for (i = [0:90:360]) {
        rotate(a=i, v=[0, 0, 1]) translate([pin_radius, 0, 0])
            tictac(radius);
    }
}

module catch_ring() {
    $nf = 5;
    $fs = 0.5;
    $fa = 10;
    radius = receiver_radius * 0.4;
    rotate_extrude(angle = 360) {
        translate([receiver_radius,0,0]) hull() {
            translate([0,radius,0]) circle(radius);
            translate([0,-radius,0]) circle(radius);
        }
    }
}

module tictac(r) {
    union() {
        hull() {
            translate([0, 0, r]) sphere(r);
            translate([0, 0, -r]) sphere(r);
        }
    }
}