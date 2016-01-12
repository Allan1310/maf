/**
 * Created by Dargonpaul on 2015/3/26.
 */

Date.prototype.Format = function (fmt) { //author: meizz 
    var o = {
        "M+": this.getMonth() + 1, //月份 
        "d+": this.getDate(), //日 
        "h+": this.getHours(), //小时 
        "m+": this.getMinutes(), //分 
        "s+": this.getSeconds(), //秒 
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
        "S": this.getMilliseconds() //毫秒 
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}
$(function(){
    $('.max').click(function(){
        $(this).parents('.jsManage').toggleClass('fixedMax');
    });
    $('.close_y').click(function(){
        $(this).parents('.jsManage').remove();
    });

    function slide(ClassName){
        function run(){
            $('.'+ClassName).find('li').first().clone().appendTo('.'+ClassName);
            $('.'+ClassName).find('li').first().slideUp("fast",
                function(){
                    $('.'+ClassName).find('li').first().remove();
                }
            );

        }
        var ID = setInterval (run,1500);
        $('.'+ClassName).mouseover(function(){
            clearInterval(ID)
        }).mouseout(function(){
            ID = setInterval (run,1500);
        });
    }
    slide('silde_msg');

   /* unicorn = {
        // === Peity charts === //
        peity: function(){
            $.fn.peity.defaults.line = {
                strokeWidth: 1,
                delimeter: ",",
                height: 24,
                max: null,
                min: 0,
                width: 50
            };
            $.fn.peity.defaults.bar = {
                delimeter: ",",
                height: 24,
                max: null,
                min: 0,
                width: 50
            };
            $(".peity_line_good span").peity("line", {
                colour: "#B1FFA9",
                strokeColour: "#459D1C"
            });
            $(".peity_line_bad span").peity("line", {
                colour: "#FFC4C7",
                strokeColour: "#BA1E20"
            });
            $(".peity_line_neutral span").peity("line", {
                colour: "#CCCCCC",
                strokeColour: "#757575"
            });
            $(".peity_bar_good span").peity("bar", {
                colour: "#459D1C"
            });
            $(".peity_bar_bad span").peity("bar", {
                colour: "#BA1E20"
            });
            $(".peity_bar_neutral span").peity("bar", {
                colour: "#757575"
            });
        },

        // === Tooltip for flot charts === //
        flot_tooltip: function(x, y, contents) {

            $('<div id="tooltip">' + contents + '</div>').css( {
                top: y + 5,
                left: x + 5
            }).appendTo("body").fadeIn(200);
        }
    }*/
})