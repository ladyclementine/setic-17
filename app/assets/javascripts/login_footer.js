
//= require plugins/iCheck/icheck.min.js
//= require bootstrap/bootstrap.min

//= require jquery.validate.min.js
//= require facebook.js.coffee
$(document).ready(function() {
  $("#form_login").validate({
    errorElement : 'div',
    errorPlacement: function(error, element) {
      var placement = $(element).data('error');
      if (placement) {
        $(placement).append(error)
      } else {
        error.insertAfter(element);
      }
    }
  });
  $( "#email" ).rules( "add", {
    required: true,
    email: true,
    messages: {
      required: "Preencha com seu email",
      email: "Entre com um email válido"
    }
  });
  $( "#password" ).rules( "add", {
    required: true,
    rangelength: [8,30],
    messages: {
      required: "Entre com sua senha",
      rangelength: "A senha deve conter entre 8 e 30 caracteres"
    }
  });
});


$(function () {
    $('input').iCheck({
      checkboxClass: 'icheckbox_square-blue',
      radioClass: 'iradio_square-blue',
      increaseArea: '20%' // optional
    });
 });
