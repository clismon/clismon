(function($) {
    var slides = [];
    var current_index = -1;
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
            add : function(id, name, path, width, height) {
                slides.push({
                    'id':  id,
                    'name': name,
                    'path': path,
                    'width':width,
                    'height':height
                });
            },
            start : function() {
                $(window).resize(function() {
                    resize_slide();
                });
            },
            prev : function() {
                go_slide(prev_index());
            },
            next : function() {
                go_slide(next_index());
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
        if (prev < 0) prev = 0;
        return prev;
    }

    var next_index = function() {
        var next = current_index + 1
        if (next == slides.length) next = next - 1;
        return next;
    }

    $.address.change(function(event) {
        var token = event.value.substring(1);
        if (token == '') {
            go_slide(0);
        } else {
            var splitted = token.split('-');
            var id = splitted[0];
            show_slide(slide_index_from_id(id));
        }
    });

    var slide_index_from_id = function(id) {
        var total = slides.length;
        for (var index = 0; index < total; index++) {
            if (slides[index].id == id) {
                return index;
            }
        }
        return 0;
    }

    var go_slide = function(index) {
        $.address.value("" + slides[index].id + "-" + slides[index].name);
    }

    var show_slide = function(index) {
        if (current_index == index) {
            return;
        }
        $('#background').css('opacity', 1);
        $("#previous_slide").css("opacity", index == 0 ? 0.3 : 1);
        $("#next_slide").css("opacity", index == (slides.length - 1) ? 0.3 : 1);
        
        current_index = index;
        var data = current_data = slides[index];
        
        var image = load_image(data['path'], function () {
            $('#background').css('opacity', 0.5);
            $("#placeholder img").fadeIn();
        });
        image.hide();
        image.attr('id', 'current');
        $("#placeholder").empty().append(image).attr('href', data['path']);

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

    $(function() {
        $('a[rel*=external]').click( function() {
            window.open(this.href);
            return false;
        });
    });


})(jQuery);