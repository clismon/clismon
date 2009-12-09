    if (typeof console == "undefined" || typeof console.log == "undefined") {
      console = {
        log: function() {},
        debug: function() {}
      };
    }

    console.log(function($) {
      var resizeAreas = function() {
        var ratio = $("#background").height() / 1296;
        console.log("RATIO", ratio);
        for (var index = 0; index < count; index++) {
          var area = $("#area" + index);
          $.each(css, function(cssindex) {
            var value = areas[index][cssindex];
            area.css(css[cssindex], value * ratio);
          });
        }
      };

      var css = ['left', 'top', 'width', 'height']
      var areas = [
        [850, 350, 100, 100, '<%= root_path %>']
      ];
      var count = areas.length;

      $(window).load(function() {
        var parent = $("#wrap");
        $.each(areas, function(index, data) {
          var area = $('<a>' + data[4] + '</a>');
          area.attr('id', 'area' + index);
          area.attr('href', data[4]);
          area.addClass('activearea');
          $.each(css, function(index) {
            area.css(css[index], data[index]);
          });
          parent.append(area);
        });

        $(window).resize(resizeAreas);
        resizeAreas();
      });
    });
  