s3=sqrt(3);

diamondsize=110;
hexagonsize=100;
lednum=24;
ledpos=59.8/2;
ledsize=3;

dimples=false;
sidecovers=false;

diamondcase();
diamondbottom();
translate([0,0,20]) hexfront();
translate([0,0,18]) covers();

*mirror([0,0,1]) diamondcase();
*diamondbottom();
*mirror([0,0,1]) hexfront();

module diamondcase() {
    union() {
        difference() {
            linear_extrude(height=20) diamond(diamondsize, 2);
            translate([0,0,15]) linear_extrude(height=6) hexagon(hexagonsize-10);
            if (sidecovers) {
                translate([0,0,-1]) linear_extrude(height=17) diamond(diamondsize-4, 1);
                translate([0,0,-1]) linear_extrude(height=3) diamond(diamondsize-2, 1);
                ds1 = (diamondsize-4)/2;
                ds2 = (hexagonsize-2)/2;
                translate([0,0,15]) linear_extrude(height=3) polygon([
                    [-ds2,-ds1/s3-(ds1-ds2)/s3],[0,-ds1*2/s3],[ ds2,-ds1/s3-(ds1-ds2)/s3],
                    [ ds2, ds1/s3+(ds1-ds2)/s3],[0, ds1*2/s3],[-ds2, ds1/s3+(ds1-ds2)/s3]
                ]);
                translate([ diamondsize*0.64,0,18]) linear_extrude(height=3) triangle(diamondsize*0.63,[0,0,0]);
                translate([-diamondsize*0.64,0,18]) linear_extrude(height=3) mirror([1,0,0]) triangle(diamondsize*0.63,[0,0,0]);
                translate([ diamondsize*0.64,0,14]) linear_extrude(height=5) triangle(diamondsize/2,[1,1,1]);
                translate([-diamondsize*0.64,0,14]) linear_extrude(height=5) mirror([1,0,0]) triangle(diamondsize/2,[1,1,1]);
            } else {
                translate([0,0,-1]) linear_extrude(height=19) diamond(diamondsize-4, 1);
                translate([0,0,-1]) linear_extrude(height=3) diamond(diamondsize-2, 1);
            }
            if (dimples) {
                translate([-diamondsize*0.75,-diamondsize*0.24,18]) sphere(10,$fn=64);
                translate([-diamondsize*0.75, diamondsize*0.24,18]) sphere(10,$fn=64);
                translate([ diamondsize*0.75,-diamondsize*0.24,18]) sphere(10,$fn=64);
                translate([ diamondsize*0.75, diamondsize*0.24,18]) sphere(10,$fn=64);
            }
            rotate([0,0, 30]) casetabcut();
            rotate([0,0,150]) casetabcut();
            rotate([0,0,270]) casetabcut();

            for (a=[0:60:300]) rotate([0,0,a]) casepinhole();
        }
        rotate([0,0, 30]) bottomtablip(-20);
        rotate([0,0,-30]) bottomtablip( 20);
        rotate([0,0,150]) bottomtablip( 20);
        rotate([0,0,210]) bottomtablip(-20);
    }
}

module diamondbottom() {
    difference() {
        union() {
            linear_extrude(height=1.8) diamond(diamondsize-2-0.2, 1);
            translate([0,0,1.8]) linear_extrude(height=0.1,scale=0.998) diamond(diamondsize-2-0.2, 1);
            rotate([0,0, 30]) bottomtab(-20);
            rotate([0,0,-30]) bottomtab( 20);
            rotate([0,0,150]) bottomtab( 20);
            rotate([0,0,210]) bottomtab(-20);
        }
        translate([-diamondsize/2.5,0,-0.5]) linear_extrude(height=3) diamond(diamondsize/4, 1);
        translate([ diamondsize/2.5,0,-0.5]) linear_extrude(height=3) diamond(diamondsize/4, 1);
        translate([0,-diamondsize/s3/2.5,-0.5]) linear_extrude(height=3) diamond(diamondsize/4, 1);
        translate([0, diamondsize/s3/2.5,-0.5]) linear_extrude(height=3) diamond(diamondsize/4, 1);
    }
}

module covers() {
    if (sidecovers) {
        difference() {
            translate([diamondsize*0.64,0,0]) linear_extrude(height=2) triangle(diamondsize*0.6235,[0,2,0]);
            if (dimples) {
                translate([diamondsize*0.746,-diamondsize*0.233,-4]) sphere(10,$fn=64);
                translate([diamondsize*0.746, diamondsize*0.233,-4]) sphere(10,$fn=64);
            }
        }
        difference() {
            translate([-diamondsize*0.64,0,0]) linear_extrude(height=2) mirror([1,0,0]) triangle(diamondsize*0.6235,[0,2,0]);
            if (dimples) {
                translate([-diamondsize*0.746,-diamondsize*0.233,-4]) sphere(10,$fn=64);
                translate([-diamondsize*0.746, diamondsize*0.233,-4]) sphere(10,$fn=64);
            }
        }
    }
}

module hexfront() {
    difference() {
        union() {
            hexdia = hexagonsize*2/s3;
            hexcover(10, hexdia-15, hexdia, 1.5, 2);

            translate([0,0,3.3]) rotate([0,0,360/48]) cylinder(2.5, 53.6/2, 53.6/2, $fn=24);
            translate([0,0,5.8]) rotate([0,0,360/48]) cylinder(2.5, 68/2, 68/2, $fn=24);
            translate([-5,-33,3.3]) rotate([0,90,0])
                linear_extrude(height=10) polygon([
                    [-5,-3],[-5,-1],[-1,-1],[0.5,0.5],[2,-0.5],[-0.5,-3]
                ]);
            translate([5,33,3.3]) rotate([0,90,180])
                linear_extrude(height=10) polygon([
                    [-5,-3],[-5,-1],[-1,-1],[0.5,0.5],[2,-0.5],[-0.5,-3]
                ]);

            rotate([0,0, 30]) casetab();
            rotate([0,0,150]) casetab();
            rotate([0,0,270]) casetab();

            for (a=[0:60:300]) rotate([0,0,a]) casepin();
        }
        for (an = [360/lednum:360/lednum:360]) {
            rotate([0,0,an]) {
                translate([ledpos, 0, 6.7]) ledhole();
                translate([ledpos, 0, 5.8]) cube([5.5,5.5,2],true);
            }
        }
        translate([0,0,2.7]) rotate([0,0,360/48]) cylinder(4.1, 53.6/2-2, 53.6/2-2, $fn=24);
        translate([0,0,5.3]) rotate([0,0,7.5]) cube([41.8,43.2,6],true);
    }
}

module casepin() {
    sides=24;
    h=4;
    slant=1;
    r=1;
    taper=0.7;
    translate([0, hexagonsize/s3-2.5,-2]) polyhedron(
        points = concat(
            [for (a=[0:360/sides:360-360/sides]) [sin(a)*r*taper,cos(a)*r*taper,0] ],
            [for (a=[0:360/sides:360-360/sides]) [sin(a)*r,cos(a)*r,0.5] ],
            [for (a=[0:360/sides:360-360/sides]) [sin(a)*r,cos(a)*r,h-slant*cos(a)*r] ]
        ),
        faces = concat(
            [[for(i=[0:sides-1]) i]],
            nquads(sides,0),
            nquads(sides,sides),
            [[for(i=[sides*3-1:-1:sides*2]) i]]
        )
    );
}

module casepinhole() {
    sides=24;
    h=3;
    r=1.1;
    translate([0, hexagonsize/s3-2.5,17.5]) polyhedron(
        points = concat(
            [for (a=[0:360/sides:360-360/sides]) [sin(a)*r,cos(a)*r,0] ],
            [for (a=[0:360/sides:360-360/sides]) [sin(a)*r,cos(a)*r,h] ]
        ),
        faces = concat(
            [[for(i=[0:sides-1]) i]],
            nquads(sides,0),
            [[for(i=[sides*2-1:-1:sides]) i]]
        )
    );
    
    // cylinder(4,1,1, $fn=sides);
}

module casetabcut() {
    translate([-10.5,(hexagonsize-10)/2+0.1,18])
        rotate([0,90,0])
            linear_extrude(height=21) polygon([
                [-2.5,-1],[-2.5,1],[-1,0],[-0.5,0],[0.5,1],[0.5,-1]
            ]);
}

module casetab() {
    translate([-10,(hexagonsize-10)/2,-2])
        rotate([0,90,0])
            linear_extrude(height=20) polygon([
                [-11,-1.5],[-9,0],[-0.5,0],[0,0.5],[1.5,-0.5],[0.5,-1.5]
            ]);
}

module bottomtab(off=0) {
    translate([-10+off,(diamondsize-4)/2-0.9,0])
        rotate([0,90,0])
            linear_extrude(height=20) polygon([
                [0,-1.5],[0,0],[-9.2,0],[-10,0.8],[-12,-0.5],[-10.5,-1.5]
            ]);
}

module bottomtablip(off=0) {
    #translate([-10+off,(diamondsize-4)/2-0.8,0])
        rotate([0,90,0])
            linear_extrude(height=20) polygon([
                [-7,1.3],[-9.2,0],[-10.5,1.3]
            ]);
}

function linepoints(x1, y1, x2, y2, z, n) = [
    for (p = [0:n-1]) [x1+(x2-x1)*(p/n), y1+(y2-y1)*(p/n), z]
];

function ntris(n,n1,n2,o,f) = concat(
    [for (i=[n1:n2-1]) [(i+f)%n+o,i+o+n,(i+1)%n+o+n]],
    [for (i=[n1:n2-1]) [(i+1)%n+o,i+o,(i+1-f)%n+o+n]]
    );

module ledhole(height=2.7, size=3, sides=48) {
    polyhedron(
        points = concat(
            [for (a=[0:360/sides:360-360/sides]) [size*cos(a)*0.6,size*sin(a)*0.6,0]],
            linepoints( size, 0, 0,  size/s3, height, sides/4),
            linepoints(0,  size/s3, -size, 0, height, sides/4),
            linepoints(-size, 0, 0, -size/s3, height, sides/4),
            linepoints(0, -size/s3,  size, 0, height, sides/4)
        ),
        faces = concat(
            [[for(i=[0:sides-1]) i]],
            ntris(sides,      0  ,sides/4  ,0,1),
            ntris(sides,sides/4  ,sides/2  ,0,0),
            ntris(sides,sides/2  ,sides*3/4,0,1),
            ntris(sides,sides*3/4,sides    ,0,0),
            [[for(i=[sides*2-1:-1:sides]) i]]
            )
    );
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
    polygon(concat(
        [for (an = [  0:10:120]) [-(tw-rd[0]*6/s3)/2/s3-rd[0]*cos(an), (tw-rd[0]*6/s3)/2+rd[0]*sin(an)] ],
        [for (an = [120:10:240]) [ (tw-rd[1]*6/s3)/s3-rd[1]*cos(an),rd[1]*sin(an)] ],
        [for (an = [240:10:360]) [-(tw-rd[2]*6/s3)/2/s3-rd[2]*cos(an),-(tw-rd[2]*6/s3)/2+rd[2]*sin(an)] ]
        /* [[tw/s3,0],[-tw/2/s3,tw/2],[-tw/2/s3,-tw/2]] */
    ));
}

function ngon(n,w,h) = [for (a=[360/n:360/n:360]) [sin(a)*w,cos(a)*w,h]];

function nquads(n,o) = [for (i=[0:n-1]) [(i+1)%n+o,i+o,i+o+n,(i+1)%n+o+n]];

module hexcover(height, topwidth, bottomwidth, wallthickness, topthickness, sides=6) {
    slope = (bottomwidth-topwidth)/2/height;
    wtxo = sqrt(pow(wallthickness,2)+pow(wallthickness*slope,2));
    wtxo2 = wtxo-topthickness*slope;
    polyhedron(
        points = concat(
            ngon(sides,topwidth/2,height),
            ngon(sides,bottomwidth/2,0),
            ngon(sides,bottomwidth/2-wtxo,0),
            ngon(sides,topwidth/2-wtxo2,height-topthickness)),
        faces = concat(
            [[for(i=[0:sides-1]) i]],
            nquads(sides,0),
            nquads(sides,sides),
            nquads(sides,sides*2),
            [[for(i=[sides*4-1:-1:sides*3]) i]]),
        convexity=10);
}
