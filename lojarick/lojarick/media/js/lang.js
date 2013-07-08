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
    $("#modal_footer_btns").append("<a href='#' class='btn btn-primary' data-dismiss='modal'>Cancelar</a><a class='btn title_black' onclick='validForm();' href='javascript:void(0);' >Salvar</a>");
    $("#modal_title").empty();
    $("#modal_title").append("Adicionar instrumento");
    $("#row_input_foto").show();

    cleanAndShowModalForm();

    $("#formInstrumento").prop("action","/add/");
    $("#formInstrumento").prop("method","post");
};


function validForm(){
    inconsistencias = '';

    if (!$("#id_nome").val())
    {
        inconsistencias += "Nome/ ";
    }

    if (!$("#id_tipo").val())
    {
        inconsistencias += "Tipo/ ";
    }

    if (!$("#id_fabricante").val())
    {
        inconsistencias += "Fabricante/ ";
    }

    if (!$("#id_preco").val())
    {
        inconsistencias += "Preço/ ";
    }

    if (inconsistencias==='')
    {
        $("form#formInstrumento").submit();
    }
    else
    {
        jAlert("<h4 style='color:black'>Os campos " + inconsistencias + " não podem ser nulos.</h4>", 'Aviso');
    }
    
};


function validFormBusca(){
    inconsistencias = false;
    if (!$("#id_tipo").val())
    {
        inconsistencias = true;
    }

    if (inconsistencias)
    {
        jAlert("<h4 style='color:black'>É necessário informar o tipo para filtrar.</h4>", 'Aviso');
    }
    else
    {
        $("form#formInstrumento").submit();
    }
};


function buscaInstrumentos(){
    $("#modal_footer_btns").empty();
    $("#modal_footer_btns").append("<a href='#' class='btn btn-primary' data-dismiss='modal'>Cancelar</a><a class='btn title_black' onclick='validFormBusca();' href='javascript:void(0);' >Buscar</a>");
    $("#modal_title").empty();
    $("#modal_title").append("Buscar instrumentos");
    $("#row_input_foto").hide();

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