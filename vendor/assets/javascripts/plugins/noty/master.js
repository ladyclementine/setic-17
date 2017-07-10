


/* jBox */
(function(b){b.confirm=function(d){if(b("#jboxOverlay").length){return false}var f="";b.each(d.buttons,function(e,c){f+='<a href="javascript:void(0);" class="button '+c["class"]+'">'+e+'</a>';if(!c.action){c.action=function(){}}});var k=b(document).height();var i=b(document).width();b("body").append('<div id="jboxOverlay"></div>');b("#jboxOverlay").css("height",k).css("width",i).fadeIn(100);b("#jboxOverlay").append('<div id="jboxInner"></div>');b("#jboxInner").append('<div class="title">'+d.title+"</div>").draggable();b("#jboxInner").append('<div class="body">'+d.message+"</div>");b("#jboxInner").append('<div class="content"></div>');b("#jboxInner").append('<div id="jboxInnerButtons">'+f+"</div>");b("#jboxInner").css("left",(b(window).width()-b("#jboxInner").width())/2+b(window).scrollLeft()+"px");b("#jboxInner").css("top",(b(window).height()-b("#jboxInner").height())/2+"px");var l=b("#jboxInner .button"),a=0;b.each(d.buttons,function(e,c){l.eq(a++).click(function(){c.action();b.confirm.hide();return false})})};b.confirm.hide=function(){b("#jboxOverlay").fadeOut(function(){b(this).remove()})}})(jQuery);

