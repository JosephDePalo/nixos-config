static const char norm_fg[] = "#d8c8bc";
static const char norm_bg[] = "#0c121a";
static const char norm_border[] = "#978c83";

static const char sel_fg[] = "#d8c8bc";
static const char sel_bg[] = "#697988";
static const char sel_border[] = "#d8c8bc";

static const char urg_fg[] = "#d8c8bc";
static const char urg_bg[] = "#D3A979";
static const char urg_border[] = "#D3A979";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
