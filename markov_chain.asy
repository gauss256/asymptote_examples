// Figure parameters
size(200,0);
settings.render = 300 / 72;

// Create a connector between two paths based on centers
path connector(path path0, pair c0, path path1, pair c1) {
    path c0c1 = c0 -- c1;
    real [] i0 = intersect(path0, c0c1);
    real [] i1 = intersect(path1, c0c1);
    pair p0 = point(path0, i0[0]);
    pair p1 = point(path1, i1[0]);

    return p0 -- p1;
}

struct PenPals {
    pen fp;  // fillpen
    pen dp;  // drawpen

    static PenPals PenPals(pen fillpen, pen drawpen) {
        PenPals p=new PenPals;
        p.fp=fillpen;
        p.dp=drawpen;
        return p;
    }
}

struct PenColors {
    int white = 0;
    int gray = 1;
    int blue = 2;
    int green = 3;
    int orange = 4;
    int yellow = 5;
    int red = 6;
    int purple = 7;
}

PenColors pc;

PenPals [] pens;
pens[pc.white] = PenPals.PenPals(rgb(255, 255, 255), rgb(0, 0, 0));
pens[pc.gray] = PenPals.PenPals(rgb(245, 245, 245), rgb(102, 102, 102));
pens[pc.blue] = PenPals.PenPals(rgb(218, 232, 252), rgb(108, 142, 191));
pens[pc.green] = PenPals.PenPals(rgb(213, 232, 212), rgb(130, 179, 102));
pens[pc.orange] = PenPals.PenPals(rgb(255, 230, 204), rgb(215, 155, 0));
pens[pc.yellow] = PenPals.PenPals(rgb(255, 242, 204), rgb(214, 182, 86));
pens[pc.red] = PenPals.PenPals(rgb(248, 206, 204), rgb(184, 84, 80));

pen pen_arr = linewidth(1.0);
pen pen_cir = linewidth(1.0);

// Drawing parameters
pair [] cmp = {N, W, S, E};
string [] lbl = {"P", "R", "C", "S"};
int dist = 30;
real r = 10;

// Draw the circles
path [] circles;
pair [] centers;
int idx = 0;
for (pair c : cmp) {
    centers[idx] = c * dist;
    circles[idx] = circle(centers[idx], r);
    // filldraw(circles[idx], fillpen=pens[pc.blue + idx].fp, drawpen=pens[pc.blue + idx].dp+pen_cir);
    filldraw(circles[idx], fillpen=pens[pc.blue + idx].fp, drawpen=pen_cir);
    // label(lbl[idx], centers[idx], p=Helvetica("m", "n")+fontsize(18pt));
    label("$\textbf{" + lbl[idx] + "}$", centers[idx], p=Helvetica("m", "n")+fontsize(14pt));
    idx += 1;
}

// Draw the connectors between circles
for (int i = 0; i < circles.length - 1; ++i) {
    path p0 = circles[i];
    pair c0 = centers[i];
    for (int j = i + 1; j < circles.length; j += 1) {
        path p1 = circles[j];
        pair c1 = centers[j];
        draw(connector(p0, c0, p1, c1), arrow=ArcArrows(SimpleHead), p=pen_arr);
    }
}

// Draw the self connectors
real fov = 45.0;  // degrees
for (int i = 0; i < 4; ++i) {
    real ang_beg = 90.0 * (i + 1) - fov / 2;
    real ang_end = ang_beg + fov;

    pair dir_beg = (Cos(ang_beg), Sin(ang_beg));
    pair dir_end = (-Cos(ang_end), -Sin(ang_end));

    real tim_beg = ang_beg / 90.0;
    real tim_end = ang_end / 90.0;

    pair pnt_beg = point(circles[i], tim_beg);
    pair pnt_end = point(circles[i], tim_end);

    draw(pnt_beg{dir_beg}..{dir_end}pnt_end, arrow=Arrow(SimpleHead), p=pen_arr);
}

frame frame_out = bbox(0.5cm, xmargin=10, filltype=Fill, p=rgb(255, 255, 255));
shipout(frame_out);
