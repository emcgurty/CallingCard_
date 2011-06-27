/* schemes.js */

/* Digital Web Magazine: Dynamic CSS Stylesheets in PHP
 * -----------------------------------------------------
 * Color Scheme Style Switcher in Javascript
 *   file: schemes.js
 * author: Douglas Clifton
 *   date: Feb-14-2005 */

/* switch to an alternate color scheme */

function scheme(n) {
 var title = 'Color Scheme #' + n;
 var i, a;
 for (i = 0; a = document.getElementsByTagName('link')[i]; i++) {
  if (a.getAttribute('rel').indexOf('alter') != -1 &&
      a.getAttribute('title')) {
   if (a.getAttribute('title') == title) a.disabled = false;
   else a.disabled = true;
  }
 }
 return false;
}

/* reset the persistent color scheme */

function persistent() {
 var i, a;
 for (i = 0; a = document.getElementsByTagName('link')[i]; i++) {
  if (a.getAttribute('rel').indexOf('alter') != -1 &&
      a.getAttribute('title').indexOf('Color Scheme') != -1) {
   a.disabled = true;
  }
 }
 return false;
}

/* thanks to Paul Sowden/Peter-Paul Koch for the original code
   see: http://www.alistapart.com/articles/alternate/ for details
   or: http://www.quirksmode.org/ for more on ppk */

/* schemes.js */
