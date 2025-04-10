const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#100c0c", /* black   */
  [1] = "#BB925B", /* red     */
  [2] = "#E49D5C", /* green   */
  [3] = "#2E778A", /* yellow  */
  [4] = "#2C90A3", /* blue    */
  [5] = "#5E9CA1", /* magenta */
  [6] = "#6FBEBC", /* cyan    */
  [7] = "#c5cbc5", /* white   */

  /* 8 bright colors */
  [8]  = "#898e89",  /* black   */
  [9]  = "#BB925B",  /* red     */
  [10] = "#E49D5C", /* green   */
  [11] = "#2E778A", /* yellow  */
  [12] = "#2C90A3", /* blue    */
  [13] = "#5E9CA1", /* magenta */
  [14] = "#6FBEBC", /* cyan    */
  [15] = "#c5cbc5", /* white   */

  /* special colors */
  [256] = "#100c0c", /* background */
  [257] = "#c5cbc5", /* foreground */
  [258] = "#c5cbc5",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
