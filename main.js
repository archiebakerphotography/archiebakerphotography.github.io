/* Toggle between showing and hiding the navigation menu links when the user clicks on the hamburger menu / bar icon */
function hamburger() {
    var x = document.getElementById("myLinks");
    if (x.style.display === "block") {
        x.style.display = "none";
    } else {
        x.style.display = "block";
    }
} 

// remap vertical scroll to horizontal scroll
// Path: main.js
function scrollHorizontally(e) {
    e = window.event || e;
    var delta = Math.max(-1, Math.min(0.9, (e.wheelDelta || -e.detail)));
    document.documentElement.scrollLeft -= (delta*30); // Multiplied by 35
    document.body.scrollLeft -= (delta*30); // Multiplied by 35
    e.preventDefault();
}

// Path: main.js
if (window.addEventListener) {
    // IE9, Chrome, Safari, Opera
    window.addEventListener("mousewheel", scrollHorizontally, false);
    // Firefox
    window.addEventListener("DOMMouseScroll", scrollHorizontally, false);
}


