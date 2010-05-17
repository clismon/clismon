(function($) {
    if (typeof console == "undefined" || typeof console.log == "undefined") {
        console = {
            log: function() {},
            debug: function() {}
        };
    }

    var app = {
        ratio : 0,
        resized : function() {
            slides.resized(background.calcRatio());
        }
    };

    var background = {
        resizesOn : null,
        originalSize: null,

        init : function(name, resizesOn, options) {
            background.resizesOn = resizesOn;
            background.originalSize = options[resizesOn];

            $("#wrap").append(slides.load(name, function() {
                $(window).trigger('resize');
            }).attr('id', 'background').
                addClass("bg-" + resizesOn));
        },

        calcRatio : function() {
            var current = background.resizesOn == 'height' ? $("#background").height() : $("#background").width();
            var ratio = current / background.originalSize + 0.1;
            if (ratio > 1) {
                ratio = 1;
            }
            return ratio;
        }
    };

    var slides = {
        data : [],
        currentData : null,
        currentRatio : null,
        currentIndex : null,

        register : function(name, width, height) {
            slides.data.push({
                'name': name,
                'width':width,
                'height':height
            })
        },
        load : function(src, callback) {
            var image = $("<img />");
            image.attr('src', src);
            image.bind('load', callback);
            return image;
        },
        show : function(index) {
            var data = slides.data[index];
            slides.currentIndex = index;
            slides.currentData = data;
            var image = slides.load(data['name'], function () {
                $('#background').css('opacity', 0.5);
            });
            image.attr('id', 'current');
            slides._resize(image, data);

            $("#placeholder").empty().append(image);
        },
        resized : function(ratio) {
            slides.currentRatio = ratio;
            slides._resize($("#current"), slides.currentData);
        },
        _resize : function(image, data) {
            var width = data['width'] * slides.currentRatio;
            var height = data['height'] * slides.currentRatio;
            image.css('width', width);
            image.css('height', height);
            image.css('margin-left', -0.5 * width);
            image.css('margin-top', -0.5 * height);
        },
        next : function() {
            var next = slides.currentIndex + 1
            if (next == slides.data.length) next = 0;
            slides.show(next);
        },
        prev : function() {
            var next = slides.currentIndex - 1
            if (next < 0) next = slides.data.length - 1;
            slides.show(next);
        }

    };

    $.clismon = $.clismon || {}


    $.extend($.clismon, {
        slideshow : {
            add : slides.register,
            bg : background.init,
            start : function() {
                slides.show(0);
                $(window).resize(function() {
                    app.resized();
                })
            },
            next : slides.next,
            prev : slides.prev,
            controls : function(element) {
                var onmousestop = function() {
                    $(element).fadeOut();
                }

                var timer = null;
                $(document).mousemove(function() {
                    $(element).fadeIn('fast');
                    clearTimeout(timer);
                    timer = setTimeout(onmousestop, 500);
                })
            }
        }
    });
})(jQuery);
