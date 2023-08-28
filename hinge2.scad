pin_length = 20;
outer_radius = 5;
echo("####>PART diameter: ", outer_radius * 2);

unit = pin_length / 50;
pin_radius = outer_radius / 2;
nub_radius = pin_radius / 3;

$fs = outer_radius / 75;

male();
translate([outer_radius * 2.2, 0, 0]) female();
//female();

module male() {
    base = unit * 5;
    union() difference() {
    rotate_extrude() {
            square([outer_radius, base]); // base
            echo("####>pin diameter: ", pin_radius * 2);
            echo("####>nub diameter: ", nub_radius * 2 + pin_radius * 2);
            translate([0, base, 0])
                square([pin_radius, pin_length]); // pin
            translate([pin_radius, base + pin_length - nub_radius])
                circle(nub_radius, $fs=nub_radius * 0.06); // nub
        }
        slice_length = (pin_radius + nub_radius) * 2; // clean through
        slice_thickness = pin_radius / 2;
        slice_depth = pin_radius * 3;
        slice_translation = base + pin_length - slice_depth / 2;
        translate([0,0, slice_translation])
            cube([slice_length, slice_thickness, slice_depth], center=true);
    }
}

module female() {
    receiver_radius = pin_radius * 1.2;
    receiver_wall_thickness = outer_radius - receiver_radius;
    keyway_size = nub_radius * 1.2 * 1.3;
    keyway_backoff = keyway_size / 2;
    echo("####>receiver diameter: ", receiver_radius * 2);
    echo("####>receiver wall: ", receiver_wall_thickness);
    echo("####>receiver outer diameter: ", receiver_radius * 2 + receiver_wall_thickness * 2);
    echo("####>keyway diameter: ", receiver_radius * 2 + keyway_size * 2);
    rotate_extrude() difference() {
        translate([receiver_radius, 0, 0])
            square([receiver_wall_thickness, pin_length]);
       translate([receiver_radius, pin_length - keyway_size - keyway_backoff])
            square([keyway_size, keyway_size]);
    }
}