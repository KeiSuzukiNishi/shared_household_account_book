(function () {
    "use strict";
  
    // Sidebar toggle
    document.getElementById("sidebarToggle").addEventListener("click", function (e) {
      document.body.classList.toggle("sidebar-toggled");
      document.querySelector(".sidebar").classList.toggle("toggled");
      if (document.querySelector(".sidebar").classList.contains("toggled")) {
        Array.from(document.querySelectorAll(".sidebar .collapse")).forEach(function (element) {
          if (typeof element.collapse === "function") {
            element.collapse("hide");
          }
        });
      }
    });
  
    // Window resize
    window.addEventListener("resize", function () {
      if (window.innerWidth < 768) {
        Array.from(document.querySelectorAll(".sidebar .collapse")).forEach(function (element) {
          if (typeof element.collapse === "function") {
            element.collapse("hide");
          }
        });
      }
      if (window.innerWidth < 480 && !document.querySelector(".sidebar").classList.contains("toggled")) {
        document.body.classList.add("sidebar-toggled");
        document.querySelector(".sidebar").classList.add("toggled");
        Array.from(document.querySelectorAll(".sidebar .collapse")).forEach(function (element) {
          if (typeof element.collapse === "function") {
            element.collapse("hide");
          }
        });
      }
    });
  
    // Sidebar scroll
    document.querySelector("body.fixed-nav .sidebar").addEventListener("wheel", function (e) {
      if (window.innerWidth >= 768) {
        var o = e.deltaY || -e.detail;
        this.scrollTop += 30 * (o < 0 ? 1 : -1);
        e.preventDefault();
      }
    });
  
    // Scroll to top
    document.addEventListener("scroll", function () {
      if (window.scrollY > 100) {
        document.querySelector(".scroll-to-top").style.display = "block";
      } else {
        document.querySelector(".scroll-to-top").style.display = "none";
      }
    });
  
    document.addEventListener("click", function (e) {
      if (e.target.matches("a.scroll-to-top")) {
        var target = e.target.getAttribute("href");
        var offsetTop = document.querySelector(target).offsetTop;
        window.scrollTo({
          top: offsetTop,
          behavior: "smooth"
        });
        e.preventDefault();
      }
    });
  })();