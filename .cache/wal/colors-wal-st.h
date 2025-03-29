const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#25243e", /* black   */
  [1] = "#435BB1", /* red     */
  [2] = "#5566A5", /* green   */
  [3] = "#4D75CC", /* yellow  */
  [4] = "#9C738F", /* blue    */
  [5] = "#5686D5", /* magenta */
  [6] = "#5A8FE6", /* cyan    */
  [7] = "#e8cac0", /* white   */

  /* 8 bright colors */
  [8]  = "#a28d86",  /* black   */
  [9]  = "#435BB1",  /* red     */
  [10] = "#5566A5", /* green   */
  [11] = "#4D75CC", /* yellow  */
  [12] = "#9C738F", /* blue    */
  [13] = "#5686D5", /* magenta */
  [14] = "#5A8FE6", /* cyan    */
  [15] = "#e8cac0", /* white   */

  /* special colors */
  [256] = "#25243e", /* background */
  [257] = "#e8cac0", /* foreground */
  [258] = "#e8cac0",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
