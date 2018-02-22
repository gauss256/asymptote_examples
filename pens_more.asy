// pens_more.asy - Collection of pens

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
