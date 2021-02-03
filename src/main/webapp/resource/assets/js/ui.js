"use strict";

(function (window, $) {
  // sitemap toggle
  $('.sitemap .btn').on('click', function () {
    $(this).parents('.sitemap').stop().slideUp();
  });
  $('.sitemap-btn').on('click', function () {
    $('.sitemap').stop().slideDown();
  }); // mobile gnb toggle dropbox

  $('.mobile-gnb__body .col__title a').on('click', function (e) {
    e.preventDefault();

    if ($(this).hasClass('active')) {
      $('.mobile-gnb__body .col__title a').removeClass('active');
      $(this).removeClass('active');
    } else {
      $('.mobile-gnb__body .col__title a').removeClass('active');
      $(this).addClass('active');
    }

    $('.mobile-gnb__body .col__list').stop().slideUp();
    $(this).parents('.col__title').siblings('.col__list').stop().slideToggle();
  }); // mobile gnb close

  $('.mobile-gnb .close').on('click', function () {
    $(this).parents('.mobile-gnb').hide();
  }); // mobile gnb show

  $('.mobile-gnb-button').on('click', function () {
    $('.mobile-gnb').show();
  });
  $('.mobile-search-button').on('click', function (e) {
    e.preventDefault();
    $('.searchform').toggle();
  }); // main visual

  var $mainVisualSlider = $('.visual .slider');
  var $current = $('.visual .slider-controller .paging #current');
  var $total = $('.visual .slider-controller .paging #total');
  $mainVisualSlider.on('init afterChange', function (event, slick, currentSlide, nextSlide) {
    $current.text(slick.currentSlide + 1);
    //$total.text(slick.slideCount);    
  });
  $mainVisualSlider.slick({
    infinite: true,
    speed: 400,
    arrows: false,
    autoplay: true,
    autoplaySpeed: 2000
  });
  $('.visual .slider-controller .next').click(function () {
    $mainVisualSlider.slick('slickNext');
  });
  $('.visual .slider-controller .stop').click(function () {
    $(this).hide();
    $('.visual .slider-controller .play').show();
    $mainVisualSlider.slick('slickPause');
  });
  $('.visual .slider-controller .play').click(function () {
    $(this).hide();
    $('.visual .slider-controller .stop').show();
    $mainVisualSlider.slick('slickPlay');
  });
  $('.visual .slider-controller .prev').click(function () {
    $mainVisualSlider.slick('slickPrev');
  }); // news slider

  var $newsSlider = $('.main__news .slider');
  $newsSlider.slick({
    infinite: true,
    speed: 400,
    arrows: false,
    autoplay: true,
    autoplaySpeed: 2000
  });
  $('.main__news-prev').click(function () {
    $newsSlider.slick('slickPrev');
  });
  $('.main__news-next').click(function () {
    $newsSlider.slick('slickNext');
  });
  $('.main__stories .item .slider').slick({
    arrows: false,
    infinite: true,
    speed: 400,
    autoplay: true,
    dots: true,
    autoplaySpeed: 2000
  });
  var $footerSlide = $('.footer .footer__partners .slider');
  $footerSlide.slick({
    arrows: false,
    infinite: true,
    speed: 400,
    autoplay: true,
    autoplaySpeed: 2000,
    slidesToShow: 7,
    slidesToScroll: 1,
    responsive: [{
      breakpoint: 1620,
      settings: {
        slidesToShow: 5
      }
    }, {
      breakpoint: 768,
      settings: {
        slidesToShow: 3
      }
    }, {
      breakpoint: 450,
      settings: {
        slidesToShow: 1
      }
    }]
  });
  $('.footer .controller .prev').click(function () {
    $footerSlide.slick('slickPrev');
  });
  $('.footer .controller .next').click(function () {
    $footerSlide.slick('slickNext');
  });
  $('.footer .controller .stop').click(function () {
    $(this).hide();
    $('.footer .controller .play').show();
    $mainVisualSlider.slick('slickPause');
  });
  $('.footer .controller .play').click(function () {
    $(this).hide();
    $('.footer .controller .stop').show();
    $mainVisualSlider.slick('slickPlay');
  });
  $(window).scroll(function () {
    var h = $(this).scrollTop();
    var isScrolled = h > 40;

    if (isScrolled) {
      $('body').addClass('scrolled');
    } else {
      $('body').removeClass('scrolled');
    }

    if (h > 500) {
      $('.quick').addClass('fixed');
    } else {
      $('.quick').removeClass('fixed');
    }
  });
  $('.datepicker').datepicker({
    dateFormat: 'yy-mm-dd'
  });
  $('.sub__navigation .select button').on('click', function (e) {
    e.preventDefault();
    $(this).siblings('.dropdown').stop().slideToggle();
  });
  $('.sub__tabs .select button').on('click', function (e) {
    e.preventDefault();
    $(this).siblings('.dropdown').stop().slideToggle();
  });
})(window, $);
"use strict";