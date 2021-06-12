/* enclosure (inner dimensions): */
L = 100;
W = 70;
H = 50;
WT = 2; /* wall thickness */
RT = 2; /* rim thickness */

/* PCBs: */
PCB_L = 50;
PCB_W = 38;
PCB1_T = 15;
PCB2_T = 35;
PCB1_YO = 5; /* Y offset */
PCB2_YO = PCB_W + 10; /* Y offset */

/* voltmeter module: */
VM_W = 45;
VM_H = 26;
VM_D = 20;
VM_XO = 5; /* X offset */
VM_YO = 5; /* Y offset */


module PCB(c, t) {
    color(c) cube([PCB_L, PCB_W, t]);
}

module PCBs() {
    translate([(W-PCB_L)/2,PCB1_YO,0]) PCB("red", PCB1_T);
    translate([(W-PCB_L)/2,PCB2_YO,0]) PCB("brown", PCB2_T);
}

module bottom() {
    /* enclosure (without top): */
    difference() {
        translate([-WT,-WT,-WT]) cube([W+2*WT,L+2*WT,H+WT]);
        cube([W,L,H+1]);
    }
    /* rim around PCBs: */
    difference() {
        translate([0,0,WT]) cube([W,L,RT]);
        PCBs();
    }
}

module top() {
    translate([0,0,H]) linear_extrude(WT) difference() {
         translate([-WT,-WT]) square([W+2*WT,L+2*WT]);
        /* voltmeter hole: */
        translate([VM_XO,VM_YO]) square([VM_H,VM_W]);
    }
    /* TODO: holes for voltmeter and switches */
    /* TODO: hold PCBs down? */
}


!bottom();
top();
/* TODO: how to connect top and bottom? */
/* TODO: add holes for cables and strain relief */

/* PCBs: */
PCBs();
/* volmeter module: */
translate([VM_XO,VM_YO,H-VM_D+WT]) color("gray") cube([VM_H,VM_W,VM_D]);