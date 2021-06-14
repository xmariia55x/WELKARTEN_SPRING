/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var nEntradas = Number(localStorage.getItem("nEntradas"));
var myHistory = [];
var contador = 0;
var seleccionadas = 0;

var asientos = document.querySelectorAll('.seleccion');
var asientosSeleccionados = document.querySelector('#asientosSeleccionados');

/* COMPRAR ENTRADAS Y SELECCIONAR ASIENTOS */ 
/* Seleccionar las entradas */

function checkear (n) {
    if (asientos[n-1].checked){   // Si pasa de rojo a verde
        if (contador === nEntradas){
            contador = 0;
        }
        if (seleccionadas === nEntradas) {
            asientos[myHistory[contador] - 1].checked = 0;
            seleccionadas--;
        }
        myHistory[contador] = n;
        contador++;
        seleccionadas++;
    } else { //Si pasa de verde a rojo
        var index = myHistory.findIndex(element => element === n);
        
        for (let i = index; i < contador - 1; i++){
            myHistory[i] = myHistory[i+1];
        }
        
        contador--;
        seleccionadas--;
    }
    
    asientosSeleccionados.textContent = myHistory.join( " - " );
}

function enviar(){
    if (seleccionadas < nEntradas) return alert("Debe seleccionar "+nEntradas+" entradas");
    else {
       document.getElementById("formulario").submit();
    }
}
