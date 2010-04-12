(function() {
    $.clismon = {}

    if (typeof console == "undefined" || typeof console.log == "undefined") {
        console = {
            log: function() {},
            debug: function() {}
        };
    }
})(jQuery);
