static const char norm_fg[] = "#c5cbc5";
static const char norm_bg[] = "#100c0c";
static const char norm_border[] = "#898e89";

static const char sel_fg[] = "#c5cbc5";
static const char sel_bg[] = "#E49D5C";
static const char sel_border[] = "#c5cbc5";

static const char urg_fg[] = "#c5cbc5";
static const char urg_bg[] = "#BB925B";
static const char urg_border[] = "#BB925B";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
