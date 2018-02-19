import arrows_more;
import connectors;

// Figure parameters
settings.render = 300 / 72;  // 300 DPI
real px = 72 / 300;  // 72 bp = 300 px

pen rgb256(int r, int g, int b) {
    return rgb(r/255, g/255, b/255);
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

// Asymptote doesn't have enum, so we'll do this
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
pens[pc.white] = PenPals.PenPals(rgb256(255, 255, 255), rgb256(0, 0, 0));
pens[pc.gray] = PenPals.PenPals(rgb256(245, 245, 245), rgb256(102, 102, 102));
pens[pc.blue] = PenPals.PenPals(rgb256(218, 232, 252), rgb256(108, 142, 191));
pens[pc.green] = PenPals.PenPals(rgb256(213, 232, 212), rgb256(130, 179, 102));
pens[pc.orange] = PenPals.PenPals(rgb256(255, 230, 204), rgb256(215, 155, 0));
pens[pc.yellow] = PenPals.PenPals(rgb256(255, 242, 204), rgb256(214, 182, 86));
pens[pc.red] = PenPals.PenPals(rgb256(248, 206, 204), rgb256(184, 84, 80));

pen pen_arr = linewidth(0.5);
pen pen_cir = linewidth(1.0);

arrowbar arr = Arrow(TriangleHead, angle=30, size=20px);
arrowbar arrs = Arrows(TriangleHead, angle=30, size=20px);

// Drawing parameters
pair [] cmp = {N, W, S, E};
string [] lbl = {"P", "R", "C", "S"};
real dist = 300px;
real r = 100px;
real fov = 45.0;  // degrees

// Draw the circles
path [] circles;
pair [] centers;
int idx = 0;
for (pair c : cmp) {
    centers[idx] = c * dist;
    circles[idx] = circle(centers[idx], r);
    filldraw(circles[idx], fillpen=pens[pc.blue + idx].fp, drawpen=pen_cir);
    label("$\textbf{" + lbl[idx] + "}$", centers[idx],
        p=Helvetica("m", "n")+fontsize(14pt));
    idx += 1;
}

// Draw the connectors between circles
for (int i = 0; i < circles.length - 1; ++i) {
    path p0 = circles[i];
    pair c0 = centers[i];
    for (int j = i + 1; j < circles.length; j += 1) {
        path p1 = circles[j];
        pair c1 = centers[j];
        draw(connector(p0, c0, p1, c1), arrs, p=pen_arr);
    }
}

// Draw the self connectors
for (int i = 0; i < 4; ++i) {
    real ang_beg = 90.0 * (i + 1) - fov / 2;
    real ang_end = ang_beg + fov;

    pair dir_beg = (Cos(ang_beg), Sin(ang_beg));
    pair dir_end = (-Cos(ang_end), -Sin(ang_end));

    real tim_beg = ang_beg / 90.0;
    real tim_end = ang_end / 90.0;

    pair pnt_beg = point(circles[i], tim_beg);
    pair pnt_end = point(circles[i], tim_end);

    draw(pnt_beg{dir_beg}..{dir_end}pnt_end, arr, p=pen_arr);
}

frame frame_out = bbox(20px, filltype=Fill, p=white);
shipout(frame_out);
