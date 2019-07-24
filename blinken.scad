s3 = sqrt(3);

studwidth = 50;
studheight = studwidth/s3/2;
holesize = 8;
holeheight = 8;
holetop = 11;
bottom = 2;
thickness = 1.3;
numstuds = 4;
studspace = 10;
sideheight = 20;
boxheight = 20;
boxthick = 3;

*for (i = [0:numstuds-1]) {
    color("white")
    translate([(i-(numstuds-1)/2)*(studwidth+studspace),0,0])
    lightstud();
}

rotate([0,0,40]) mirror([0,0,1]) lightbox();

module lightbox() {
    xs1 = (studwidth*numstuds + studspace*(numstuds-1))/2;
    xs2 = xs1 - studwidth/2;
    ys = studheight;
    h = sideheight;
    h2 = h + boxheight;
    xb1 = xs1 + h*s3;
    xb2 = xs2;
    yb = ys + h;
    
    xi1 = xb1 - boxthick*s3;
    xi2 = xb2;
    yi = yb - boxthick;
    hi = boxthick;
    
    difference() {
        polyhedron(
            points = concat(
                hexbox(xs1,xs2,ys,0),
                hexbox(xb1,xb2,yb,-h),
                hexbox(xb1,xb2,yb,-h2),
                hexbox(xi1,xi2,yi,-h2),
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
                [[for(i=[5:-1:0]) i+30]]
            )
        );
        for (i = [0:numstuds-1]) {
            translate([(i-(numstuds-1)/2)*(studwidth+studspace),0,-boxthick-0.1])
            cylinder(boxthick+0.2,holesize/2,holesize/2,$fn=64);
    
        }
    }
}

module lightstud() {
    xs = studwidth/2;
    ys = studwidth/s3/2;
    zs = studheight;
    cs = holesize/2;
    //ch = holeheight;
    ch = bottom;
    tt = thickness;
    zs2 = zs - tt;
    xs2 = xs - (ch+tt)*s3;
    ys2 = ys - (ch+tt);
    sides = 64;
    ld = 10;

    polyhedron(
        points = concat(
            [[0,0,zs2],[xs2,0,ch],[0,-ys2,ch],[-xs2,0,ch],[0,ys2,ch]],
            [[0,0,zs],[xs,0,0],[0,-ys,0],[-xs,0,0],[0,ys,0]],
            [for (an=[0:360/sides:359]) [sin(an)*cs,cos(an)*cs,0]],
            [for (an=[0:360/sides:359]) [sin(an)*cs,cos(an)*cs,ch]]
        ),
        faces = concat(
            [[2,1,0],[3,2,0],[4,3,0],[1,4,0]],
            [for (i=[0:3]) for (j=[0:sides/4-1])
                [ i+6, ld+((i*sides/4)+j+sides/8)%sides, ld+((i*sides/4)+j+sides/8+1)%sides ]],
            [for (i=[0:3]) [i+6,(i+3)%4+6, ld+(i*sides/4+sides/8)%sides]],
            [for (j=[0:sides-1]) [j+ld,j+sides+ld,(j+1)%sides+sides+ld,(j+1)%sides+ld]],
            [for (i=[0:3]) for (j=[0:sides/4-1])
                [ i+1, ld+sides+((i*sides/4)+j+sides/8+1)%sides, ld+sides+((i*sides/4)+j+sides/8)%sides ]],
            [for (i=[0:3]) [(i+3)%4+1,i+1, ld+sides+(i*sides/4+sides/8)%sides]],
            [[6,7,5],[7,8,5],[8,9,5],[9,6,5]]

        )
    );

}

function nquads(n,o) = concat(
    [for (i=[0:n-1]) [(i+1)%n+o,i+o,i+o+n]],
    [for (i=[0:n-1]) [(i+1)%n+o,i+o+n,(i+1)%n+o+n]]
);
function hexbox(x1,x2,y,z) = [[-x1,0,z],[-x2,y,z],[x2,y,z],[x1,0,z],[x2,-y,z],[-x2,-y,z]];