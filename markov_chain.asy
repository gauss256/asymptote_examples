// Draw a Markov chain for arbitrary number of nodes

import arrows_more;
import connectors;
import pens_more;

int N = 2;  // number of nodes

// Figure parameters
settings.render = 300 / 72;  // 300 DPI
real px = 72 / 300;  // 72 bp = 300 px

pen pen_arr = linewidth(2px) + linejoin(0);
pen pen_cir = linewidth(4px);

arrowbar arr = Arrow(TriangleHead, angle=30, size=10px);
arrowbar arrs = Arrows(TriangleHead, angle=30, size=10px);

// Drawing parameters
real rad = 50px;
real sep = 4 * rad / Sin(180 / N);
real ang_s = 45.0;  // spread for self connectors
real ang_c = 10.0;  // spread for cross connectors
real mar = (linewidth(pen_arr) + linewidth(pen_cir)) / 2;
margin marg = TrueMargin(mar, mar);  // = (pen_arr + pen_cir) / 2

// Draw the circles
path [] cirs;
pair [] ctrs;
for (int i = 0; i < N; ++i) {
    pair ctr = sep * (Cos(i * 360 / N), Sin(i * 360 / N));
    path cir = circle(ctr, rad);
    filldraw(cir, fillpen=white, drawpen=pen_cir);
    label(format("$\textbf{%d}$", i), ctr,
        p=Helvetica("m", "n")+fontsize(14pt));
    cirs[i] = cir;
    ctrs[i] = ctr;
}

// Draw straight lines between circles
// for (int i = 0; i < N - 1; ++i) {
//     path p0 = cirs[i];
//     pair c0 = ctrs[i];
//     for (int j = i + 1; j < N; ++j) {
//         path p1 = cirs[j];
//         pair c1 = ctrs[j];
//         draw(connector(p0, c0, p1, c1), dashed);
//     }
// }

// Draw axes
// draw(shift(ctrs[0]) * ((-sep, 0)--(sep, 0)), dashed);
// draw(shift(ctrs[0]) * ((0, -sep)--(0, sep)), dashed);

real ang_a = 180 - 180 * (N - 2) / (2 * N);  // angle to next node
real ang_d = 0;
if (N > 2) {
    ang_d = (360 - 2ang_a) / (N - 2);  // angle between subsequent nodes
}
real ang_e = 360 / N;  // angle to rotate base node to

// Draw pointers between circles
// for (int i = 0; i < N; ++i) {
//     path p0 = cirs[i];
//     pair c0 = ctrs[i];
//     for (int j = 0; j < N - 1; ++j) {
//         real ang = ang_a + i * ang_e + j * ang_d;
//         pair c1 = 2 * rad * (Cos(ang), Sin(ang));
//         path p = (0,0)--c1;
//         draw(shift(c0) * p, arr, p=red);
//     }
// }

// Draw connectors between circles
for (int i = 0; i < N; ++i) {
    path p0 = cirs[i];
    pair c0 = ctrs[i];
    for (int j = i + 1; j < N + i; ++j) {
        real ang = ang_a + i * ang_e + (j - i - 1) * ang_d;

        // Forward connector
        path p1 = cirs[j % N];
        real t0 = angle2time(p0, ang - ang_c);
        real t1 = angle2time(p1, ang + ang_c + 180);
        draw(connector(p0, t0, p1, t1), arr, margin=marg, p=pen_arr);
    }
}

// Draw the self connectors
for (int i = 0; i < N; ++i) {
    path p = cirs[i];
    real ang = i * 360 / N;
    real t0 = angle2time(p, ang - ang_s / 2);
    real t1 = angle2time(p, ang + ang_s / 2);
    draw(connector(p, t0, p, t1), arr, margin=marg, p=pen_arr);
}

frame frame_out = bbox(20px, filltype=Fill, p=white);
shipout(frame_out);
