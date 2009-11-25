(function($) {
    var images = []
    var bg_vertical = false;
    var bg_size = 0;
    var ratio = 0;
    var currentData;
    
    if (typeof console == "undefined" || typeof console.log == "undefined") {
        console = {
            log: function() {},
            debug: function() {}
        };
    }

    var resize = function() {
        var current = bg_vertical ? $("#background").height() : $("#background").width();
        ratio = current / bg_size + 0.1;
        if (ratio > 1) { ratio = 1;}
        console.log("RATIO: ", ratio);
        resizeSlide($("#current"), currentData);
    }

    var resizeSlide = function(image, data) {
        var width = data['width'] * ratio;
        var height = data['height'] * ratio;
        image.css('width', width);
        image.css('height', height);
        image.css('margin-left', -0.5 * width);
        image.css('margin-top', -0.5 * height);
    }

    var showImage = function(index) {
        var data = images[index];
        currentData = data;
        var image = loadImage("/images/" + data['name'], function () {
            $('#background').css('opacity', 0.5);
        });
        image.attr('id', 'current');
        resizeSlide(image, data);
        
        $("#placeholder").empty().append(image);

        image.click(function() {
            var next = index + 1
            if (next == images.length) next = 0;
            showImage(next);
        });
    }

    var loadImage = function(src, callback) {
        var image = $("<img />");
        image.attr('src', src);
        image.bind('load', callback);
        return image;
    }

    $.clismon = {
        register : function(name, width, height) {
            images.push({
                'name': name,
                'width':width,
                'height':height
            })
        },

        bg : function(name, options) {
            if(options['width']) {
                bg_vertical = false;
                bg_size = options['width']
            } else if (options['height']) {
                bg_vertical = true;
                bg_size = options['height']
            } else {
                alert("clismon background not defined!");
            }

            $("#wrap").append(loadImage(name, function() {
                resize();
            }).attr('id', 'background'));
        },

        start : function() {
            showImage(0);

            $(window).resize(function() {
                resize();
            })
        }
    }


})(jQuery);
