	// Set the date we're counting down to
	var countDownDate = new Date("Oct 12, 2017 00:00:00").getTime();

	// Update the count down every 1 second
	var x = setInterval(function() {

	    // Get todays date and time
	    var now = new Date().getTime();
	    
	    // Find the distance between now an the count down date
	    var distance = countDownDate - now;
	    
	    // Time calculations for days, hours, minutes and seconds
	    var days = Math.floor(distance / (1000 * 60 * 60 * 24));
	    var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
	    var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
	    var seconds = Math.floor((distance % (1000 * 60)) / 1000);
	    
	    // Output the result in an element with id="demo"
	    document.getElementById("contadorTempo").innerHTML = days + "D:" + hours + "H:"
	    + minutes + "MIN:" + seconds + "S";
	    
	    // If the count down is over, write some text 
	    if (distance < 0) {
	        clearInterval(x);
	        document.getElementById("contadorTempo").innerHTML = "EXPIRED";
	    }
	}, 1000);

$(document).ready(function(){
	
	//Ano atual
	var data, ano;
	data = new Date();
	ano = data.getFullYear();
	$('#anoAtual').text(ano);

	$(".navbar-nav a").click(function(event){        
        event.preventDefault();
        $('html,body').animate({scrollTop:$(this.hash).offset().top - 150}, 600);
   	});

   	$(".btnConhecamais").click(function(event){        
        event.preventDefault();
        $('html,body').animate({scrollTop:$(this.hash).offset().top - 0}, 600);
   	});

   	var $doc = $('html, body');
	$('a').click(function() {
	    $doc.animate({
	        scrollTop: $( $.attr(this, 'href') ).offset().top
	    }, 500);
	    return false;
	});
	
});



