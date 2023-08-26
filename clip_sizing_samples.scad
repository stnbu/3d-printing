
door = 34;
counter = 30;
ply = 18.3;
fridge = 36;

tweak = 0.2;

for (v =[-2: 1]) {
    translate([v * (fridge + 5 * 2 + 5), -25, 0])
        profile(fridge, 15, 15, 5);
}

for (v =[-2: 1]) {
    translate([v * (door + 5 * 2 + 5), 0, 0])
        profile(door, 15, 15, 5);
}

for (v =[-2: 1]) {
    translate([v * (counter + 5 * 2 + 5), 25, 0])
        profile(counter, 15, 15, 5);
}

for (v =[-2: 1]) {
    translate([v * (ply + 5 * 2 + 5), 50, 0])
        profile(ply, 15, 15, 5);
}

module profile(thickness, height, length, wall) {
    difference() {
        cube([thickness + wall * 2, height + wall, length]);
        
        translate([wall, wall, -0.1]) cube([thickness, height * 1.5, length * 1.1]);
}
}