// Exploration of tangents, normals, and connectors
// real[] intersections(path p, explicit pair a, explicit pair b, real fuzz=-1);

path connector(path path0, real time0, path path1, real time1) {
    // Next: two paths, centers, angles
    pair n0 = rotate(-90) * dir(path0, time0);
    pair n1 = rotate(90) * dir(path1, time1);
    pair p0 = point(path0, time0);
    pair p1 = point(path1, time1);
    return p0{n0}..{n1}p1;
}

path connector(
    path path0, pair center0, real angle0,
    path path1, pair center1, real angle1) {
        // Not working well
        // Alternative: specify normalized arc length?
        pair a = center0;
        pair b = a + (Cos(angle0), Sin(angle0));
        real [] ints = intersections(path0, a, b);
        write(ints);
        return path0;  //!!!
    }

// Figure parameters
settings.render = 300 / 72;  // 300 DPI
real px = 72 / 300;  // 72 bp = 300 px

pair ctr = (0, 0);
real rad = 100px;
real sep = 400px;

path cir0 = circle(ctr, rad);
path cir1 = shift((sep, 0)) * circle(ctr, rad);
real tim0 = 3.5;
real tim1 = 2.5;
real ang0 = -15;
real ang1 = 195;

connector(cir0, ctr, ang0, cir1, (sep,0), ang1);
exit();

path con = connector(cir0, tim0, cir1, tim1);
draw(cir0);
draw(cir1);
draw(con, Arrow);

frame frame_out = bbox(20px, filltype=Fill, p=white);
shipout(frame_out);
