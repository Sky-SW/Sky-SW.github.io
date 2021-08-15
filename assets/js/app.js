$(document).ready(function () {

   // RESTRICT JS ERROR
   "use strict";

   // Initiate JS animate scroll screen
   AOS.init({
      once: true
   });

   // NAVBAR
   if (window.matchMedia("(min-width: 720px)").matches) {
      $(window).scroll(function () {
         if ($(window).scrollTop() >= 500) {
            $('nav').fadeIn();
         } else {
            $('nav').fadeOut();
         }
      });
   }
   if (window.matchMedia("(max-width: 720px)").matches) {

      document.addEventListener('swiped-right', function () {
         $('nav').animate({
            left: '0'
         });
      });

      $('nav').click(function () {
         $('nav').animate({
            left: '-1000px'
         });
      });

      document.addEventListener('swiped-left', function () {
         $('nav').animate({
            left: '-1000px'
         });
      });

      setTimeout(function () {
         $('#modal_nav').removeClass('hiden_modal');
      }, 10000);
   }

   // MODAL
   $('.close').click(function () {
      $('.modal').addClass('hiden_modal');
   });

   $('.modal').click(function (e) {
      if (e.target == e.currentTarget) {
         $(this).addClass('hiden_modal');
      }
   });

   // SCROLL LINK
   $("a[href*='#']:not([href='#'])").click(function () {
      if (
         location.hostname == this.hostname &&
         this.pathname.replace(/^\//, "") == location.pathname.replace(/^\//, "")
      ) {
         var anchor = $(this.hash);
         anchor = anchor.length ? anchor : $("[name=" + this.hash.slice(1) + "]");
         if (anchor.length) {
            $("html, body").animate({
               scrollTop: anchor.offset().top
            }, 1000);
         }
      }
   });

   // HOME BACKGROUND CAROUSEL
   const home_container = document.getElementById("home");
   const pictures_home = [
      "assets/img/background/background_art_imuong_2.jpg",
      "assets/img/background/background_art_imuong_3.jpg",
      "assets/img/background/background_art_imuong_4.jpg",
      "assets/img/background/background_art_imuong_1.jpg",
   ]
   const backgroundSlide = (images, container, step) => {
      images.forEach((image, index) => (
         setTimeout(() => {
            container.style.backgroundImage = `url(${image})`
         }, step * (index + 1))
      ))
      setTimeout(() => backgroundSlide(images, container, step), step * images.length)
   }
   backgroundSlide(pictures_home, home_container, 5000);

   // BIOGRAPHIE PICTURES SLIDE
   const biographie_container = document.getElementById("img_bio");
   const pictures_biographie = [
      "assets/img/author-art_imuong-2.jpg",
      "assets/img/author-art_imuong-3.jpg",
      "assets/img/author-art_imuong-1.jpg",
   ]
   backgroundSlide(pictures_biographie, biographie_container, 5000);

   // SCROLL-UP BUTTON
   $(window).scroll(function () {
      if ($(window).scrollTop() >= 500) {
         $('#back_top').fadeIn();
      } else {
         $('#back_top').fadeOut();
      }
   });

   // SCROLL BUTTON MAIN HOME PICTURE
   $('#scroll_button').on('click', function (e) {
      e.preventDefault();
      $('html, body').animate({
         scrollTop: $($('#biographie')).offset().top
      }, 1000, 'linear');
   });

   // JS ANIMATION
   $('.main-animate').fadeOut().delay(1000).fadeIn(1500);
   $('#scroll_button').fadeOut().delay(2000).fadeIn(1500);

});

// STOP MOUSE CLICK
$(document).bind('contextmenu', function(e) {
   e.stopPropagation();
   e.preventDefault();
   e.stopImmediatePropagation();
   return false;
});

// Preloading images
function preload(arrayOfImages) {
   $(arrayOfImages).each(function(){
       $('<img/>')[0].src = this;
   });
}

preload([
   "assets/img/background/background_art_imuong_2.jpg",
   "assets/img/background/background_art_imuong_3.jpg",
   "assets/img/background/background_art_imuong_4.jpg",
   "assets/img/background/background_art_imuong_1.jpg",
]);