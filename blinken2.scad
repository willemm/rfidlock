s3 = sqrt(3);

studwidth = 60;
studheight = studwidth/s3/2;
holesize = 8;
holeheight = 8;
holetop = 11;
bottom = 1;
thickness = 1.3;
numstuds = 4;
studspace = 8;
sideheight = 10;
boxheight = 22;
boxthick = 2;
edge = 0;

for (i = [0:numstuds-1]) {
    color("white")
    translate([(i-(numstuds-1)/2)*(studwidth+studspace),0,0])
    lightstud();
}
color("DimGray") lightbox();
color("Gray") translate([0,0,-boxheight-sideheight]) lightbottom();

color("Teal") translate([0,0,-boxheight-sideheight+boxthick]) rotate([180,0,90]) batteryholder();


/*
for (i = [0:numstuds-1]) {
    translate([(i-(numstuds-1)/2)*(studwidth+studspace),0,-boxthick]) {
        rotate([90,0,0]) translate([-11,0,-0.5]) clip();
        rotate([90,0,0]) translate([ 11,0,-0.5]) clip();
    }
}
*/

*rotate([0,0,40]) mirror([0,0,1]) lightbox();
*lightstud();
*rotate([0,0,40]) lightbottom();


module clip() {
    cw = 6/2;
    ch = bottom+boxthick;
    linear_extrude(height=1) polygon([
        [-cw-1,-2],[-cw-2,-1],[-cw-2,0],
        [-cw,0],[-cw,ch],[-cw-1.5,ch+1.5],[-cw+0.5,ch+3.5],
        [-cw+2,ch+2],[-cw+2,0],
        [cw-2,0],[cw-2,ch+2],
        [cw-0.5,ch+3.5],[cw+1.5,ch+1.5],[cw,ch],[cw,0],
        [cw+2,0],[cw+2,-1],[cw+1,-2]
    ]);
}

module lightbox() {
    ol = boxthick-1;
    xs2 = (studwidth*(numstuds-1) + studspace*(numstuds-1))/2;
    xs1 = xs2 + studwidth/2 + s3*edge;
    ys = studheight + edge;
    h = sideheight;
    h2 = h + boxheight+2;
    xb1 = xs1 + h*s3;
    xb2 = xs2;
    yb = ys + h;
    
    xo1 = xb1 - ol*s3;
    xo2 = xb2;
    yo = yb - ol;
    
    ho = h2 - boxthick;
    xi1 = xb1 - boxthick*s3;
    xi2 = xb2;
    yi = yb - boxthick;
    hi = boxthick;
    
    sxs = studwidth/2-0.4*s3;
    sys = studwidth/s3/2-0.4;
    
    difference() {
        polyhedron(
            points = concat(
                hexbox(xs1,xs2,ys,0),
                hexbox(xb1,xb2,yb,-h),
                hexbox(xb1,xb2,yb,-ho),
                hexbox(xo1,xo2,yo,-ho),
                hexbox(xo1,xo2,yo,-ho),
                hexbox(xi1,xi2,yi,-ho),
                hexbox(xi1,xi2,yi,-h),
                hexbox(xs1,xs2,ys,-hi)
            ),
            faces = concat(
                [[for(i=[0:5]) i]],
                nquads(6,0),
                nquads(6,6),
                nquads(6,12),
                nquads(6,18),
                nquads(6,24),
                nquads(6,30),
                nquads(6,36),
                [[for(i=[5:-1:0]) i+42]]
            )
        );
        /*
        for (i = [0:numstuds-1]) {
            translate([(i-(numstuds-1)/2)*(studwidth+studspace),0,-hi-0.1]) {
                linear_extrude(height=hi+0.2)
                polygon([[-sxs,0],[0,sys],[sxs,0],[0,-sys]]);
                translate([0,0,hi-0.3])
                linear_extrude(height=0.5,scale=(sys+0.5)/sys)
                polygon([[-sxs,0],[0,sys],[sxs,0],[0,-sys]]);
            }
        }
        */
        for (i = [0:numstuds-1]) {
            translate([(i-(numstuds-1)/2)*(studwidth+studspace),0,-hi-0.1]) {
                cylinder(boxthick+0.2,holesize/2,holesize/2,$fn=64);
            }
        }
    }
    for (i = [0:numstuds-2]) {
        translate([(i-(numstuds-1)/2)*(studwidth+studspace),0,-hi-(0.75/2)]) {
            translate([(holesize+1)/2,0,0]) cube([1,ys*2+1.5,0.75],true);
        }
        translate([(i+1-(numstuds-1)/2)*(studwidth+studspace),0,-hi-(0.75/2)]) {
            translate([-(holesize+1)/2,0,0]) cube([1,ys*2+1.5,0.75],true);
        }
    }
    for (i = [0:numstuds-1]) {
        translate([(i-(numstuds-1)/2)*(studwidth+studspace),0,-hi-(0.45/2)]) {
            translate([0,(holesize+1)/2,0]) cube([holesize+1,1,0.45],true);
            translate([0,-(holesize+1)/2,0]) cube([holesize+1,1,0.45],true);
        }
        translate([(i-(numstuds-1)/2)*(studwidth+studspace),0,-hi-(0.15/2)]) {
            for (a = [45:90:315]) rotate([0,0,a]) {
                translate([0,(holesize+1)/2,0]) cube([holesize/sqrt(2)-1.6,1,0.15],true);
            }
        }
    }
    translate([((numstuds-1)/2)*(studwidth+studspace),0,-hi-(0.75/2)]) {
        translate([(holesize+1)/2,0,0]) cube([1,ys*2-(holesize-1.6)/s3,0.75],true);
    }
    translate([(-(numstuds-1)/2)*(studwidth+studspace),0,-hi-(0.75/2)]) {
        translate([-(holesize+1)/2,0,0]) cube([1,ys*2-(holesize-1.6)/s3,0.75],true);
    }

    translate([0,0,-boxheight-sideheight]) {
        for (i = [0:numstuds-2]) {
            bottomtablip((i-(numstuds-2)/2)*(studwidth+studspace));
            mirror([0,1,0]) bottomtablip((i-(numstuds-2)/2)*(studwidth+studspace));
        }
        rpos = (studheight+edge+sideheight-boxthick-0.8) * s3/2;
        translate([-(studwidth+studspace)*(numstuds-1)/2,0,0]) rotate([0,0,30]) bottomtablip(-studwidth/4, rpos);
        translate([-(studwidth+studspace)*(numstuds-1)/2,0,0]) rotate([0,0,150]) bottomtablip(studwidth/4, rpos);
        translate([(studwidth+studspace)*(numstuds-1)/2,0,0]) rotate([0,0,-30]) bottomtablip(studwidth/4, rpos);
        translate([(studwidth+studspace)*(numstuds-1)/2,0,0]) rotate([0,0,-150]) bottomtablip(-studwidth/4, rpos);
    }
}

module lightbottom() {
    tol=0.2;
    ol = boxthick;
    
    xs2 = (studwidth*(numstuds-1) + studspace*(numstuds-1))/2;
    xs1 = xs2 + studwidth/2 + s3*edge;
    ys = studheight + edge;
    h = sideheight;
    xb1 = xs1 + h*s3;
    xb2 = xs2;
    yb = ys + h;
    
    xi1 = xb1 - ol*s3 - tol*s3;
    xi2 = xb2;
    yi = yb - ol - tol;
    
    difference() {
        union() {
            linear_extrude(height=boxthick) polygon([
                [-xi1,0],[-xi2,yi],[xi2,yi],[xi1,0],[xi2,-yi],[-xi2,-yi]
            ]);
            translate([0,0,-1])
            linear_extrude(height=1) polygon([
                [-xb1,0],[-xb2,yb],[xb2,yb],[xb1,0],[xb2,-yb],[-xb2,-yb]
            ]);
        }
        for (i = [-numstuds+1:numstuds-1]) {
            translate([i*(studwidth+studspace)/2,0,-1.1])
            // rotate([0,0,30]) cylinder(boxthick+0.2,10,10,$fn=6);
            rotate([0,0,30]) hexslice();
        }
    }
    for (i = [0:numstuds-2]) {
        bottomtab((i-(numstuds-2)/2)*(studwidth+studspace));
        mirror([0,1,0]) bottomtab((i-(numstuds-2)/2)*(studwidth+studspace));
    }
    rpos = (studheight+edge+sideheight-boxthick-0.9) * s3/2;
    translate([-(studwidth+studspace)*(numstuds-1)/2,0,0]) rotate([0,0,30]) bottomtab(-studwidth/4, rpos);
    translate([-(studwidth+studspace)*(numstuds-1)/2,0,0]) rotate([0,0,150]) bottomtab(studwidth/4, rpos);
    translate([(studwidth+studspace)*(numstuds-1)/2,0,0]) rotate([0,0,-30]) bottomtab(studwidth/4, rpos);
    translate([(studwidth+studspace)*(numstuds-1)/2,0,0]) rotate([0,0,-150]) bottomtab(-studwidth/4, rpos);

    translate([(numstuds/2-1) * (studwidth+studspace) + studwidth/2+2, 0, boxthick]) mirror([0,0,1]) wemosd1();

    rotate([180,0,90]) translate([0,0,-boxthick]) batteryclips();
}

module batteryclips() {
    translate([-33/2,-94.8/2,0]) batterypin();
    translate([-33/2, 94.8/2,0]) batterypin();
    translate([ 33/2,-94.8/2,0]) batterypin();
    translate([ 33/2, 94.8/2,0]) batterypin();
    translate([-14,-50.2,0]) rotate([0,0,180]) batterytab(10);
    translate([-14, 50.2,0]) batterytab(10);
    translate([ 14,-50.2,0]) rotate([0,0,180]) batterytab(10);
    translate([ 14, 50.2,0]) batterytab(10);
}

module batterypin() {
    rotate([0,0,360/48]) {
        translate([0,0,-1.9]) cylinder(3.4,2.25,2.25, $fn=24);
        translate([0,0,-3.5]) cylinder(1.7,1.2,1.2, $fn=24);
        translate([0,0,-4.0]) cylinder(0.5,0.8,1.2, $fn=24);
    }
}

module batterytab(w) {
    translate([-w/2,0,0]) rotate([0,90,0]) linear_extrude(height=w) polygon([
        [-2,0],[3.0,0],[3.7,-0.7],[5.7,0.5],[4.5,1.5],[-2,1.5]
    ]);
}


module hexslice(sz=14, sl=3, h=boxthick+1.2) {
    vs = (s3/2*sz)/((2*sl)-0.5);
    hs = (sz/2)/(sl-0.25);
    linear_extrude(height=h) union() {
        for (i = [-sl:-1]) polygon([[-sz-(i+0.25)*hs,(i+0.25)*vs*2],[sz+(i+0.25)*hs,(i+0.25)*vs*2],
            [sz+(i+0.75)*hs,(i+0.75)*vs*2],[-sz-(i+0.75)*hs,(i+0.75)*vs*2]]);
        for (i = [1:sl]) polygon([[-sz+(i-0.25)*hs,(i-0.25)*vs*2],[sz-(i-0.25)*hs,(i-0.25)*vs*2],
            [sz-(i-0.75)*hs,(i-0.75)*vs*2],[-sz+(i-0.75)*hs,(i-0.75)*vs*2]]);
    }
}

module lightstud() {
    tol=0;
    xs = studwidth/2-tol;
    ys = xs/s3;
    zs = studheight;
    cs = holesize/2;
    
    xse = xs - 0.6*s3;
    yse = ys - 0.6;
    
    //ch = holeheight;
    ch = 0;
    tt = thickness;
    zs2 = zs - tt;
    xs2 = xs - (ch+tt)*s3;
    ys2 = ys - (ch+tt);

    difference() {
        polyhedron(
            points = concat(
                [[0,0,zs2],[xs2,0,ch],[0,-ys2,ch],[-xs2,0,ch],[0,ys2,ch]],
                [[0,0,zs],[xs,0,0],[0,-ys,0],[-xs,0,0],[0,ys,0]]
            ),
            faces = concat(
                [[2,1,0],[3,2,0],[4,3,0],[1,4,0]],
                [[6,7,5],[7,8,5],[8,9,5],[9,6,5]],
                [[1,2,7,6],[2,3,8,7],[3,4,9,8],[4,1,6,9]]
            )
        );
    }
}

module wemosd1() {
    *#translate([0,0,-2.4]) cube([34.6,25.4,4.8], true);
    // translate([-17.3,   0,0]) rotate([0,0,90]) mcutab(12);
    // translate([ 17.3,-7.2,0]) rotate([0,0,-90]) mcutab(8);
    translate([ 17.3, 0,0]) rotate([0,0,-90]) mcutab(15);
    translate([-17.3,-9.2,0]) rotate([0,0, 90]) mcutab(8);
    translate([-17.3, 9.2,0]) rotate([0,0, 90]) mcutab(8);

    translate([ 10,-12.7-2/2,-7/2+0.1]) cube([7,2,7],true);
    translate([ 10, 12.7+2/2,-7/2+0.1]) cube([7,2,7],true);
    translate([-10,-12.7-2/2,-7/2+0.1]) cube([7,2,7],true);
    translate([-10, 12.7+2/2,-7/2+0.1]) cube([7,2,7],true);
}

module mcutab(w) {
    translate([-w/2,0,0]) rotate([0,90,0]) linear_extrude(height=w) polygon([
        [0,0],[4.8,0],[5.4,-0.5],[7,0.5],[5.4,1.5],[0,1.5]
    ]);
}

module bottomtab(off=0, pos=studheight+edge+sideheight-boxthick-0.9) {
    translate([-10+off,pos,0])
    rotate([0,90,0])
    linear_extrude(height=20) polygon([
        [0,-1.5],[0,0],[-8.2,0],[-9,0.8],[-11,-0.5],[-9.5,-1.5]
    ]);
}

module bottomtablip(off=0, pos=studheight+edge+sideheight-boxthick-0.8) {
    translate([-10+off,pos,0])
    rotate([0,90,0])
    linear_extrude(height=20) polygon([
        [-6,1.3],[-8.2,0],[-9.5,1.3]
    ]);
}

module batteryholder() {
    cr=5;
    bh=48/2-cr;
    bw=100/2-cr;
    difference() {
        union() {
            translate([-1,0,-3]) linear_extrude(height=1) polygon(concat(
                [for (an=[  0:10: 90]) [ bh+sin(an)*cr, bw+cos(an)*cr]],
                [for (an=[ 90:10:180]) [ bh+sin(an)*cr,-bw+cos(an)*cr]],
                [for (an=[180:10:270]) [-bh+sin(an)*cr,-bw+cos(an)*cr]],
                [for (an=[270:10:360]) [-bh+sin(an)*cr, bw+cos(an)*cr]]
            ));
            translate([-1, 6,-12]) cube([40,77,24], true);
        }
        translate([-33/2,-94.5/2,-4.5]) cylinder(3,1.25,1.25, $fn=24);
        translate([-33/2, 94.5/2,-4.5]) cylinder(3,1.25,1.25, $fn=24);
        translate([ 33/2,-94.5/2,-4.5]) cylinder(3,1.25,1.25, $fn=24);
        translate([ 33/2, 94.5/2,-4.5]) cylinder(3,1.25,1.25, $fn=24);
    }
}

function nquads(n,o) = concat(
    [for (i=[0:n-1]) [(i+1)%n+o,i+o,i+o+n]],
    [for (i=[0:n-1]) [(i+1)%n+o,i+o+n,(i+1)%n+o+n]]
);
function hexbox(x1,x2,y,z) = [[-x1,0,z],[-x2,y,z],[x2,y,z],[x1,0,z],[x2,-y,z],[-x2,-y,z]];
