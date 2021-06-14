/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var bEliminar = document.querySelector('#eliminar');
var bEditar = document.querySelector('#editar');

function eliminar(){
    var entradasSeleccionadas = document.querySelectorAll('input[type=checkbox]:checked');
    var idEntradas = [];
    var concat = "";
    
    for (let i=0; i < entradasSeleccionadas.length; i++){
        idEntradas[i] = entradasSeleccionadas[i].value;
        if (i === entradasSeleccionadas.length - 1) {
            concat += "entrada"+i+"="+idEntradas[i];
        } else {
            concat += "entrada"+i+"="+idEntradas[i]+"&";
        }
    }
    
    if (entradasSeleccionadas.length === 0){ 
        return alert("No se ha seleccionado ninguna entrada")
    } else {
        var opcion = confirm("¿Está seguro que desea eliminar las entradas seleccionadas?");
        if (opcion === true) {
            window.location.href = 'ServletEliminarEntrada?long='+idEntradas.length+'&'+concat; 
	} else {
	    return;
	}
    }
}

function editar(){
    var entradasSeleccionadas = document.querySelectorAll('input[type=checkbox]:checked');
    var idEntradas = [];
    var concat = "";
    
    for (let i=0; i < entradasSeleccionadas.length; i++){
        idEntradas[i] = entradasSeleccionadas[i].value;
        if (i === entradasSeleccionadas.length - 1) {
            concat += "entrada"+i+"="+idEntradas[i];
        } else {
            concat += "entrada"+i+"="+idEntradas[i]+"&";
        }
    }
    
    if (entradasSeleccionadas.length === 0){ 
        return alert("No se ha seleccionado ninguna entrada")
    } else {
        nEntradas = Number(idEntradas.length);
        localStorage.setItem("nEntradas", nEntradas);
        localStorage.setItem("entradas", idEntradas);

        window.location.href = 'ServletModificarAsientos?long='+idEntradas.length+'&'+concat;
    }
}

