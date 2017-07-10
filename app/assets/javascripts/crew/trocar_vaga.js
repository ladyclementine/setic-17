

$('body').on('click', '.send_troca_vaga', function() {

	var email_vendedor = $('#vendedor_email').val();
	var email_comprador = $('#comprador_email').val();

	var dados = {
      email_vendedor: email_vendedor,
      email_comprador: email_comprador
    };
    console.log(dados);

	$.ajax({
      url: "/crew/change_vacancies/processar",
      type: "post",
      dataType: "json",
      beforeSend: function() {
       // $('#buttons_event_'+id).html('<span class="btn btn-sm hotel-choose pull-right" style="margin-bottom: 5px;margin-top: 3px; margin-right: 20px">Aguarde...</span>');
      },
      data: dados,
      success: function (result) {
      	$('#vendedor_email').val("");
      	$('#comprador_email').val("");
      	if(result.type==="exist"){
      		$('#resultado').html("Vendedor desalocado - OK </br> Lote Trocado com o comprador - OK</br> Pagamento Trocado - OK");
      	}
      	console.log(result);
      },
      error: function (result) {
        console.log(JSON.parse(result.responseText));
        toastr.error("<span>"+JSON.parse(result.responseText).menssage+"</span>", "ERROR!");
      }
    });

});