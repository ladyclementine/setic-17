
/*var id = $(this).attr('id').replace('colante-','');*/

    $('body').on('click', '.send_event_enter', function() { 
    var id = $(this).attr('id').replace('event_','');
    var dados = {
      id: id
    };
    //#ef1717 VERMELHO
    $.ajax({
      url: "/events/enter",
      type: "post",
      dataType: "json",
      beforeSend: function() {
        $('#buttons_event_'+id).html('<span class="btn btn-sm hotel-choose pull-right" style="margin-bottom: 5px;margin-top: 3px; margin-right: 20px">Aguarde...</span>');
      },
      data: dados,
      success: function (result) {
        if(result.mensage==='full'){
          $('#buttons_event_'+id).html(button_event(id, '#a0a0a0', 'LOTADO', 'send_event_enter'));
          $('.inscritos_event_'+id).html(result.subscribers);
          toastr.error("<span>"+result.infos+"</span>", "OPSS!");
        } else if(result.mensage==='conflict'){
          $('#buttons_event_'+id).html(button_event(id, '#1AB394', 'ENTRAR NA PROGRAMAÇÃO', 'send_event_enter'));
          $('.inscritos_event_'+id).html(result.subscribers);
          toastr.error("<span>"+result.infos+"</span>", "OPSS!");
        } else if(result.mensage==='success'){
          $('#buttons_event_'+id).html(button_event(id, '#ef1717', 'SAIR DA PROGRAMAÇÃO', 'send_event_out'));
          $('.inscritos_event_'+id).html(result.subscribers);
          toastr.success("<span>"+result.infos+"</span>", "PARÁBENS!");
        } else if(result.mensage==='error'){
          $('#buttons_event_'+id).html(button_event(id, '#1AB394', 'ENTRAR NA PROGRAMAÇÃO', 'send_event_enter'));
          $('.inscritos_event_'+id).html(result.subscribers);
          toastr.error("<span>"+result.infos+"</span>", "ERROR!");
        }

      },
      error: function (result) {
        console.log(result);
        toastr.error("<span>"+result.statusText+"</span>", "ERROR!");
        $('.inscritos_event').html("");
      }
    });


});

$('body').on('click', '.send_event_out', function() { 
  var id = $(this).attr('id').replace('event_','');
    var dados = {
      id: id
    };
    $.ajax({
      url: "/events/exit",
      type: "post",
      dataType: "json",
      beforeSend: function() {
        $('#buttons_event_'+id).html('<span class="btn btn-sm hotel-choose pull-right" style="margin-bottom: 5px;margin-top: 3px; margin-right: 20px">Aguarde...</span>');
      },
      data: dados,
      success: function (result) {
         if(result.mensage==='success'){
          $('#buttons_event_'+id).html(button_event(id, '#1AB394', 'ENTRAR NA PROGRAMAÇÃO', 'send_event_enter'));
          $('.inscritos_event_'+id).html(result.subscribers);
          toastr.success("<span>"+result.infos+"</span>", "NÃO DEIXE ESPAÇOS VAZIOS!");
        } else if(result.mensage==='error'){
          $('#buttons_event_'+id).html(button_event(id, '#ef1717', 'SAIR DA PROGRAMAÇÃO', 'send_event_out'));
          $('.inscritos_event_'+id).html(result.subscribers);
          toastr.error("<span>"+result.infos+"</span>", "ERROR!");
        }
      },
      error: function (result) {
        console.log(result);
        toastr.error("<span>"+result.statusText+"</span>", "ERROR!");
        $('.inscritos_event').html("");
      }
    });
});

function button_event(id, color, menssage, classe){
  var txt =  '<button type="submit" class="btn btn-sm hotel-choose pull-right '+classe+'" id="event_'+id+'" style="background-color: '+color+'; margin-bottom: 5px;color:#fff;margin-top: 3px; margin-right: 20px"><strong>'+menssage+'</strong></button>';
  return txt;
}

jQuery(document).ready(function ($) {

    var day_event = $('.nav-tabs> li a').html();
    $('.recebe_dia').html(day_event);

    $('.nav-tabs > li a').on('click', function (e) {
        $('.recebe_dia').html(this.innerHTML);
        $('html, body').animate({scrollTop:0}, 'fast'); 
        e.preventDefault();
    });
    
});