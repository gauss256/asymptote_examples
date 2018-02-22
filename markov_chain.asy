import arrows_more;
import connectors;
import pens_more;

// Figure parameters
settings.render = 300 / 72;  // 300 DPI
real px = 72 / 300;  // 72 bp = 300 px

pen pen_arr = linewidth(4px) + linejoin(0);
pen pen_cir = linewidth(8px);

arrowbar arr = Arrow(TriangleHead, angle=30, size=15px);
arrowbar arrs = Arrows(TriangleHead, angle=30, size=15px);

// Drawing parameters
pair [] cmp = {E, N, W, S};
string [] lbl = {"P", "R", "C", "S"};
real dist = 300px;
real r = 100px;
real fov = 45.0;  // degrees
margin marg = TrueMargin(6px, 6px);  // a bit empirical

// Draw the circles
path [] circles;
pair [] centers;
int idx = 0;
for (pair c : cmp) {
    centers[idx] = c * dist;
    circles[idx] = circle(centers[idx], r);
    filldraw(circles[idx], fillpen=pens[pc.blue + idx].fp,
        drawpen=pen_cir+pens[pc.blue + idx].dp);
    label("$\textbf{" + lbl[idx] + "}$", centers[idx],
        p=Helvetica("m", "n")+fontsize(14pt));
    idx += 1;
}

// Draw connectors between circles
for (int i = 0; i < circles.length - 1; ++i) {
    path p0 = circles[i];
    for (int j = i + 1; j < circles.length; j += 1) {

        // Forward connector
        real t0 = i / 2 + j / 2 + 1.1;
        path p1 = circles[j];
        real t1 = t0 + 1.8;
        draw(connector(p0, t0, p1, t1), arr, margin=marg, p=pen_arr);

        // Backward connector
        t0 -= 0.2;
        t1 += 0.2;
        draw(connector(p1, t1, p0, t0), arr, margin=marg, p=pen_arr);
    }
}

// Draw the self connectors
for (int i = 0; i < 4; ++i) {
    real ang_beg = 90.0 * i - fov / 2;
    real ang_end = ang_beg + fov;

    pair dir_beg = (Cos(ang_beg), Sin(ang_beg));
    pair dir_end = (-Cos(ang_end), -Sin(ang_end));

    real tim_beg = ang_beg / 90.0;
    real tim_end = ang_end / 90.0;

    pair pnt_beg = point(circles[i], tim_beg);
    pair pnt_end = point(circles[i], tim_end);

    draw(pnt_beg{dir_beg}..{dir_end}pnt_end, arr, margin=marg, p=pen_arr);
}

frame frame_out = bbox(20px, filltype=Fill, p=white);
shipout(frame_out);
