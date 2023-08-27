// hinge

$nf = 20;
$fs = 0.1;
$fa = 1;

total_length = 120/3;
outer_radius = 5;
pin_radius = outer_radius / 2;
pin_length = total_length / 2 * 0.9 - pin_radius;
leaf_length = total_length / 2;
receiver_radius = outer_radius / 2 * 1.1;
receiver_length = total_length / 2;
male_hemicap = false;
female_hemicap = false;
catch_setback = total_length * 0.15;

male();
translate([outer_radius * 2 + 1, 0]) female();

module male() {
    union() difference() {
        uncut();
        plus_cuts();
    }

    module uncut() {
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

    module plus_cuts() {
        cut_depth = 5;
        rotate(a = 45, v = [0,0,1]) {
            translate([0,0, (total_length - catch_setback) * 1.01]) {
                cube([pin_radius * 0.3, pin_radius * cut_depth, pin_radius* cut_depth], center=true);
                cube([pin_radius * cut_depth, pin_radius * 0.3,  pin_radius* cut_depth], center=true);
            }
        }
    }
}

module female() {
    union() {
        difference() {
            difference() {
                cylinder(r=outer_radius, h=receiver_length, center=false);
                cylinder(r=receiver_radius, h=receiver_length + receiver_radius, center=false);
            }
            translate([0, 0, receiver_length - catch_setback]) catch_ring();
        }
        if (female_hemicap) {
            translate([0, 0, receiver_length])
                sphere(outer_radius);
        }
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
            translate([0, radius, 0]) circle(radius);
            translate([0, -radius, 0]) circle(radius);
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