s3 = sqrt(3);

studwidth = 50;
studheight = studwidth/s3/2;
holesize = 8;
holeheight = 8;
holetop = 11;
thickness = 2;

lightstud();

module lightstud() {
    xs = studwidth/2;
    ys = studwidth/s3/2;
    zs = studheight;
    cs = holesize/2;
    //ch = holeheight;
    ch = thickness;
    tt = thickness * 1.15;
    zs2 = zs - tt;
    xs2 = xs - tt*2*s3;
    ys2 = ys - tt*2;
    sides = 64;
    ld = 10;
    polyhedron(
        points = concat(
            [[0,0,zs],[xs,0,0],[0,-ys,0],[-xs,0,0],[0,ys,0]],
            [[0,0,zs2],[xs2,0,ch],[0,-ys2,ch],[-xs2,0,ch],[0,ys2,ch]],
            [for (an=[360/sides:360/sides:360]) [sin(an)*cs,cos(an)*cs,0]],
            [for (an=[360/sides:360/sides:360]) [sin(an)*cs,cos(an)*cs,ch]]
        ),
        faces = concat(
            [[1,2,0],[2,3,0],[3,4,0],[4,1,0]],
            [for (i=[0:3]) for (j=[0:sides/4-1])
                [ i+1, ld+((i*sides/4)+j+sides/8-1)%sides, ld+((i*sides/4)+j+sides/8)%sides ]],
            [for (i=[0:3]) [i+1,(i+3)%4+1, ld+(i*sides/4+sides/8-1)%sides]],
            [for (j=[0:sides-1]) [j+ld,j+sides+ld,(j+1)%sides+sides+ld,(j+1)%sides+ld]],
            [for (i=[0:3]) for (j=[0:sides/4-1])
                [ i+6, ld+sides+((i*sides/4)+j+sides/8)%sides, ld+sides+((i*sides/4)+j+sides/8-1)%sides ]],
            [for (i=[0:3]) [(i+3)%4+6,i+6, ld+sides+(i*sides/4+sides/8-1)%sides]],
            [[7,6,5],[8,7,5],[9,8,5],[6,9,5]]

        )
    );
}
