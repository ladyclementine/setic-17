$ ->
  $('#users-table').dataTable
    columnDefs: [
      targets: 3
      orderable: false
      width: 80
      className: "hidden"
    ]
    processing: true
    serverSide: true
    pageLength: 50
    ajax: $('#users-table').data('source')
    pagingType: 'full_numbers'
    columns: [
      {data: 'name'}
      {data: 'email'}
      {data: 'payment'}
      {data: 'payment_pdf'}
      {data: 'edit'}
      {data: 'login'}
    ]
    'oLanguage':
      'sEmptyTable': 'Nenhum registro encontrado'
      'sInfo': 'Mostrando de _START_ até _END_ de _TOTAL_ registros'
      'sInfoEmpty': 'Mostrando 0 até 0 de 0 registros'
      'sInfoFiltered': '(Filtrados de _MAX_ registros)'
      'sInfoPostFix': ''
      'sInfoThousands': '.'
      'sLengthMenu': 'Mostrando _MENU_ resultados'
      'sLoadingRecords': 'Carregando...'
      'sProcessing': 'Processando...'
      'sZeroRecords': 'Nenhum registro encontrado'
      'sSearch': 'Pesquisar'
      'oPaginate':
        'sNext': 'Próximo'
        'sPrevious': 'Anterior'
        'sFirst': 'Primeiro'
        'sLast': 'Último'
      'oAria':
        'sSortAscending': ': Ordenar colunas de forma ascendente'
        'sSortDescending': ': Ordenar colunas de forma descendente'
    dom: 'Blfrtip'
    buttons: [
      {
        extend: 'csv'
        title: 'SEMANAS 2017 - CSV - ' + moment().format('DD/MM/YYYY HH:mm:ss') + ' - ' + $('.box-title').html()
        exportOptions: columns: 'thead th:not(.noExport)'
      }
      {
        extend: 'excel'
        title: 'SEMANAS 2017 - EXCEL - ' + moment().format('DD/MM/YYYY HH:mm:ss') + ' - ' + $('.box-title').html()
        exportOptions: columns: 'thead th:not(.noExport)'
      }
      {
        extend: 'pdf'
        title: 'SEMANAS 2017 - PDF - ' + moment().format('DD/MM/YYYY HH:mm:ss') + ' - ' + $('.box-title').html()
        exportOptions: columns: 'thead th:not(.noExport)'
      }
    ]
