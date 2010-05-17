(function($) {
    var slides = [];
    var current_index = 0;
    var current_data = 0;
    var image_cache = {};
    $.clismon = $.clismon || {}


    if (typeof console == "undefined" || typeof console.log == "undefined") {
        console = {
            log: function() {},
            debug: function() {}
        };
    }

    jQuery.fn.controls = function() {
        return this.each(function(){
            var self = $(this);
            var inside = false;
            $(this).children('a').hover(function() {
                inside = true;
            }, function() {
                inside = false;
            });

            var onmousestop = function() {
                if (!inside)
                    self.fadeOut();
            }

            var timer = null;
            $(document).mousemove(function() {
                self.fadeIn('fast');
                clearTimeout(timer);
                timer = setTimeout(onmousestop, 500);
            })
            self.fadeOut();
        });
    };

    $.extend($.clismon, {
        background : function(path, width, height) {
            var ratio = width / height;
            $("#wrap").append(load_image(path, function() {
                $(window).trigger('resize');
            }).attr('id', 'background'));

            $(window).resize(function() {
                var w = $(window).width();
                var h = $(window).height();
                var r = w/h;
                var modifier = 1;
                if (r > ratio) {
                    modifier = w / width;
                } else {
                    modifier = h / height;
                }
                $("#background").css('height', height * modifier);
                $("#background").css('width', width * modifier);
            })
        },
        slideshow : {
            add : function(name, width, height) {
                slides.push({
                    'name': name,
                    'width':width,
                    'height':height
                });
            },
            start : function() {
                show_slide(0);
                $(window).resize(function() {
                    resize_slide();
                });
            },
            prev : function() {
                show_slide(prev_index());
            },
            next : function() {
                show_slide(next_index());
            }
        }
    });

    var load_image = function(src, callback) {
        var image = $("<img />");
        image.attr('src', src);
        image.bind('load', callback);
        return image;
    }

    var prev_index = function() {
        var prev = current_index - 1
        if (prev < 0) prev = slides.length - 1;
        return prev;
    }

    var next_index = function() {
        var next = current_index + 1
        if (next == slides.length) next = 0;
        return next;
    }

    var show_slide = function(index) {
        $('#background').css('opacity', 1);
        current_index = index;
        var data = current_data = slides[index];
        var image = load_image(data['name'], function () {
            $('#background').css('opacity', 0.5);
            $("#placeholder img").fadeIn();
        });
        image.hide();
        image.attr('id', 'current');
        $("#placeholder").empty().append(image);
        resize_slide();
    }

    var resize_slide = function() {
        var image = $("#placeholder img");
        var width = current_data['width'];
        var height = current_data['height']
        var w = $(window).width() - 20;
        var h = $(window).height() - 40;
        var wmodifier = w / width;
        var hmodifier = h / height;
        var modifier = wmodifier < hmodifier ? wmodifier : hmodifier;
        modifier = modifier > 1 ? 1 : modifier;
        var fh = height * modifier;
        var fw = width * modifier;
        image.css('height', fh);
        image.css('width', fw);
        image.css('margin-top', -0.5 * fh - 10);
        image.css('margin-left', -0.5 * fw);
    }

})(jQuery);