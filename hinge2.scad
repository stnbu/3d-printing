pin_length = 20;
outer_radius = 5;

unit = pin_length / 50;
pin_radius = outer_radius / 2;
nub_radius = pin_radius / 2;

$fs = outer_radius / 75;

male();
translate([outer_radius * 2.2, 0, 0]) female();

module male() {
    base = unit * 5;
    rotate_extrude() union() {
        square([outer_radius, base]);
        translate([0, base, 0]) square([pin_radius, pin_length]);
        translate([pin_radius, base + pin_length - nub_radius]) circle(nub_radius, $fs=nub_radius * 0.06);
    }
}

module female() {
    receiver_radius = pin_radius * 1.1;
    receiver_thickness = outer_radius - receiver_radius;
    channel_radius = nub_radius * 1.1;
    rotate_extrude() difference() {
        translate([receiver_radius, 0, 0]) square([receiver_thickness, pin_length]);
        translate([receiver_radius, pin_length - channel_radius]) circle(channel_radius, $fs=channel_radius * 0.06);
    }
}