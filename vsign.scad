/*
A `sign` consists of two `side`s, each symmetrical about the `y` axis and therefore represented as `half` a `side` 

The `half` is mirrored and printed, creating one `side` of a `sign`.

At the top is the `handle`, below which is the `handle_opening`. At the base there is a `void` between the feet. The `handle_width` is less than the `foot_width`.

The edges of the `side`s, `handle_opening`, and `void` between the feet have a small raised `welt` for stiffness and esthetics.

Collectively, anything that makes a hole in the `side` are `holes`, which are a `union()` so they can be `difference()`'ed from the `side`.
*/

$fs = 0.4;
$fa = 4;

// Total height
height = 101;
// Width at the top: the handle's width
handle_width = 35;
handle_radius = 4.5;
// The hole for the handle at the top
handle_hole_width = 23;
handle_hole_height = 10;
// The width at the bottom
foot_width = 48;
// The hole between the feet at the bottom
void_width = 32.047;
void_height = 6.585;
// The angle (deg) a side is swung outwards, from the vertical
swing_angle = 15;

sign();

module sign() {
    separation = foot_width;
    translate([separation / 2, 0, 0]) side();
    translate([-separation / 2, 0, 0]) rotate([0, 0, 180]) side();
}

module side() {
    translate([0, -height / 2, 0]) {
    half();
    mirror([1, 0, 0]) half();
    }
}

module half() {
    difference() {
        difference() {
            union() {
                blank();
                half_handle();
            }
            vertical_cut();
        }
        side_back_cut();
    }
}

module half_handle() {
    rotate([0, 90, 0]) cylinder(h = handle_width / 2, r = handle_radius);
    translate([handle_width / 2, 0, 0]) sphere(handle_radius);
}

module vertical_cut() {
    width = handle_width;
    height = handle_radius * 6;
    thickness = handle_radius * 4 / 3;
    translate([handle_width / 4, 0, -thickness / 2]) rotate([-swing_angle, 0, 0]) cube([width, height, thickness], center=true);
}

module side_back_cut() {
    width = foot_width * 1.5 / 2;
    _height = height * 1.5;
    thickness = 10; // "big"
    translate([foot_width / 4, height / 2, -thickness / 2]) cube([width, _height, thickness], center=true);
}

module blank() {
    linear_extrude(height = 1, center = true) difference() {
        polygon([
            [0, 0],
            [handle_width / 2, 0],
            [foot_width / 2, height],
            [0, height],
            [0, 0],
        ]);
        holes();
    }
}

module holes() {
    union() {
        quarter_rounded_half_slot(handle_hole_width / 2, handle_hole_height);
        translate([0, height, 0]) mirror([0, 1, 0])
            quarter_rounded_half_slot(void_width / 2, void_height);
    }
}

module quarter_rounded_half_slot(width, height) {
    union() {
        square([width - height, height]);
        translate([width - height, 0, 0]) circle(height);
    }
}