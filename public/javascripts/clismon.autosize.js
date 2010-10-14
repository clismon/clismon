(function($) {

    var config = $.autosize = {
        active: true
    }

    $.fn.autosize = function(options) {
        var defaults = {
            size: 100,
            method: 'fit'
        };

        options = $.extend(defaults, options);

        return this.each(function() {
            setup[options['method']]($(this), options);
        });
    };

    $(window).resize(function() {
        if (config.active) {
            var self = $(this);
            $(".autosize").each(function() {
                var image = $(this);
                var data = image.data('autosize');
                methods[data['method']](self, image, data);
            });
        }
    });

    var setup = {
        fit : function(image, options) {
            options['ratio'] = options['width'] / options['height'];
            var offset = 100 - options['size'];
            options['size'] = '' + options['size'] + '%';
            options['current'] = 'width';

            image.css('position', 'absolute').css('left', offset).css('top', offset);
            image.css('width', options['size']);
            image.data('autosize', options);
            image.addClass('autosize');
        }
    }

    var methods = {
        fit : function(window, image, data) {
            var ratio = window.width() / window.height();
            var fit = data['ratio'] > ratio ? 'height' : 'width';
            console.log("best fit: ", fit, ' current: ', data['current']);
            if (data['current'] != fit) {
                console.log("change! to:", fit);
                image.css(data['current'],'').css(fit, data['size']);
                data['current'] = fit;
            }
        }
    };
})(jQuery);