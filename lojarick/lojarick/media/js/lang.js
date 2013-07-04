$(document).ready(function () {
});

function buscar_ajax(tipo_id) {
    $.ajax({
        url: '/form_busca/',
        type: "POST",
        dataType: "json",

        data: ({
            tipo: tipo_id
        }),
        success: function (results) {
            $('#busca').empty();
            $('#ver_mais').empty();
            $('#tabela').show();
            $('#busca').append(results);
        }
    });
};


function novoInstrumento(){
    $("#modal_footer_btns").empty();
    $("#modal_footer_btns").append("<a href='#' class='btn' data-dismiss='modal'>Cancelar</a><input type='submit' class='btn title_black' value = 'Salvar' style='height: 48px;width: 90px;margin-left: 5px;'>");
    $("#modal_title").empty();
    $("#modal_title").append("Adicionar instrumento");

    cleanAndShowModalForm();

    $("#formInstrumento").prop("action","/add/");
    $("#formInstrumento").prop("method","post");
};


function buscaInstrumentos(){
    $("#modal_footer_btns").empty();
    $("#modal_footer_btns").append("<a href='#' class='btn' data-dismiss='modal'>Cancelar</a><input type='submit' class='btn title_black' value = 'Buscar' style='height: 48px;width: 90px;margin-left: 5px;'>");
    $("#modal_title").empty();
    $("#modal_title").append("Buscar instrumentos");

    cleanAndShowModalForm();

    $("#formInstrumento").prop("action","/buscar/");
    $("#formInstrumento").prop("method","post");
};

function cleanAndShowModalForm(){
    $('#formInstrumento')[0].reset();
    $('#caracteristicas').empty();
    $('#test_modal').modal('show');
};


function ver_instrumento(instrumento_id) {
    $.ajax({
        url: '/ver_instrumento/',
        type: "POST",
        dataType: "json",

        data: ({
            instrumento: instrumento_id
        }),
        success: function (results) {
            $('#busca').empty()
            $('#filtro').hide()
            $('#tabela').hide()

            $('#ver_mais').append(results)
        }
    });
};

// MÉTODOS DE FILTRO NO GRID

function filtroTodos(){
    $('.todos').show();
    $('#naoEncontrado').remove();
};


function filtroTipo(tipo){
    var tipo_temp = $("."+tipo);

    $(".todos").hide();
    tipo_temp.show();
    
    $('#naoEncontrado').remove();
    if(tipo_temp.val() != ""){
        var newRow = "<tr id='naoEncontrado' ><td colspan=6 style='text-align:center'><h4>Não foram encontrados instrumentos para o tipo " + tipo + "!</h4></td></tr>";
        $('#instrumentos').append(newRow);
    }
};