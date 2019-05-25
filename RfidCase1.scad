s3=sqrt(3);

diamondsize=110;
hexagonsize=100;
lednum=24;
ledpos=59.8/2;
ledsize=3;

union() {
    difference() {
        linear_extrude(height=20) diamond(diamondsize, 2);
        translate([0,0,-1]) linear_extrude(height=17) diamond(diamondsize-2, 1);
        translate([0,0,17]) linear_extrude(height=4) hexagon(hexagonsize-10);
        translate([ diamondsize*0.64,0,18]) linear_extrude(height=3) triangle(diamondsize*0.63,0);
        translate([-diamondsize*0.64,0,18]) linear_extrude(height=3) mirror([1,0,0]) triangle(diamondsize*0.63,0);
        translate([ diamondsize*0.64,0,14]) linear_extrude(height=5) triangle(diamondsize/2,1);
        translate([-diamondsize*0.64,0,14]) linear_extrude(height=5) mirror([1,0,0]) triangle(diamondsize/2,1);
        translate([-diamondsize*0.75,-diamondsize*0.24,18]) sphere(10,$fn=64);
        translate([-diamondsize*0.75, diamondsize*0.24,18]) sphere(10,$fn=64);
        translate([ diamondsize*0.75,-diamondsize*0.24,18]) sphere(10,$fn=64);
        translate([ diamondsize*0.75, diamondsize*0.24,18]) sphere(10,$fn=64);
    }
}
translate([0,0,18]) {
    difference() {
        translate([diamondsize*0.64,0,0]) linear_extrude(height=2) triangle(diamondsize*0.6235,2);
        translate([ diamondsize*0.746,-diamondsize*0.233,-4]) sphere(10,$fn=64);
        translate([ diamondsize*0.746, diamondsize*0.233,-4]) sphere(10,$fn=64);
    }
    *translate([diamondsize*0.64,0,2]) linear_extrude(height=1, scale=0.97) triangle(diamondsize*0.6235,2);
    difference() {
        translate([-diamondsize*0.64,0,0]) linear_extrude(height=2) mirror([1,0,0]) triangle(diamondsize*0.6235,2);
        translate([-diamondsize*0.746,-diamondsize*0.233,-4]) sphere(10,$fn=64);
        translate([-diamondsize*0.746, diamondsize*0.233,-4]) sphere(10,$fn=64);
    }
    *translate([-diamondsize*0.64,0,2]) linear_extrude(height=1, scale=0.97) mirror([1,0,0]) triangle(diamondsize*0.6235,2);
}

translate([0,0,20]) mirror([0,0,0]) difference() {
    union() {
        difference() {
            linear_extrude(height=10, scale=(hexagonsize-15)/hexagonsize) hexagon(hexagonsize);
            translate([0,0,-2]) linear_extrude(height=10, scale=(hexagonsize-16)/(hexagonsize-1)) hexagon(hexagonsize-1);
        }
        translate([0,0,3.5]) rotate([0,0,360/48]) cylinder(2.5, 53.6/2, 53.6/2, $fn=24);
        translate([0,0,6]) rotate([0,0,360/48]) cylinder(2, 68/2, 68/2, $fn=24);
    }
    for (an = [360/lednum:360/lednum:360]) {
        rotate([0,0,an]) {
            *translate([ledpos, 0, 9.5]) linear_extrude(height=2) diamond(ledsize);
            translate([ledpos, 0, 6]) linear_extrude(height=3.6, scale=1.9) diamond(ledsize/1.9, 0);
            translate([ledpos, 0, 6]) cylinder(3.6, 1.8, 1.5, $fn=32);
            translate([ledpos, 0, 6]) cube([5.5,5.5,2],true);
        }
    }
    translate([0,0,3.5]) rotate([0,0,360/48]) cylinder(4, 53.6/2-2, 53.6/2-2, $fn=24);
    translate([0,0,6]) rotate([0,0,7.5]) cube([41.8,43.2,6],true);
}

module hexagon(hw) {
    c1=hw/2;
    c2=c1/s3;
    polygon([[-c1,-c2],[0,-c2*2],[c1,-c2],[c1,c2],[0,c2*2],[-c1,c2]]);
}

module diamond(dw, rd=2) {
    polygon(concat(
        [for (an = [-60:10:60]) [-dw+rd*2-rd*cos(an),rd*sin(an)] ],
        [[0,dw/s3]],
        [for (an = [-60:10:60]) [dw-rd*2+rd*cos(an),-rd*sin(an)] ],
        [[0,-dw/s3]]
    ));
}

module triangle(tw, rd) {
    twrd = (tw-rd*6/s3);
    polygon(concat(
        [for (an = [  0:10:120]) [-twrd/2/s3-rd*cos(an), twrd/2+rd*sin(an)] ],
        [for (an = [120:10:240]) [ twrd/s3-rd*cos(an),rd*sin(an)] ],
        [for (an = [240:10:360]) [-twrd/2/s3-rd*cos(an),-twrd/2+rd*sin(an)] ]
        /* [[tw/s3,0],[-tw/2/s3,tw/2],[-tw/2/s3,-tw/2]] */
    ));
}