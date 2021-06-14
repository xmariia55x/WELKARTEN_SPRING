/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var currentTab = 0; // Current tab is set to be the first tab (0)
showTab(currentTab); // Display the current tab

var nEntradas = Number(localStorage.getItem("nEntradas"));
var myHistory = [];
var contador = 0;
var seleccionadas = 0;

var asientos = document.querySelectorAll('.seleccion');
var asientosSeleccionados = document.querySelector('#asientosSeleccionados');


function showTab(n) {
  // This function will display the specified tab of the form ...
  var x = document.getElementsByClassName("tab");
  x[n].style.display = "block";
  // ... and fix the Previous/Next buttons:
  if (n == 0) {
    document.getElementById("prevBtn").style.display = "none";
  } else {
    document.getElementById("prevBtn").style.display = "inline";
  }
  if (n == x.length - 1) {
    document.getElementById("nextBtn").value = "Confirmar compra";
  } else {
    document.getElementById("nextBtn").value = "Siguiente";
  }
  // ... and run a function that displays the correct step indicator:
  fixStepIndicator(n)
}

function nextPrev(n) {
  // This function will figure out which tab to display
  var x = document.getElementsByClassName("tab");
  // Exit the function if any field in the current tab is invalid:
  if (currentTab === 0 && seleccionadas !== nEntradas) return alert("Debe seleccionar "+nEntradas+" asientos.");
  if (n === 1 && !validateForm()) return alert("Completa todos los campos");
  // Hide the current tab:
  x[currentTab].style.display = "none";
  // Increase or decrease the current tab by 1:
  currentTab = currentTab + n;
  // if you have reached the end of the form... :
  if (currentTab >= x.length) {
    //...the form gets submitted:
    document.getElementById("regForm").submit();
    return false;
  }
  // Otherwise, display the correct tab:
  showTab(currentTab);
}

function validateForm() {
  // This function deals with validation of the form fields
  var x, y, i, valid = true;
  x = document.getElementsByClassName("tab");
  y = x[currentTab].getElementsByTagName("input");
  // A loop that checks every input field in the current tab:
  for (i = 0; i < y.length; i++) {
    // If a field is empty...
    if (y[i].value == "") {
      // add an "invalid" class to the field:
      y[i].className += " invalid";
      // and set the current valid status to false:
      valid = false;
    }
  }
  // If the valid status is true, mark the step as finished and valid:
  if (valid) {
    document.getElementsByClassName("step")[currentTab].className += " finish";
  }
  return valid; // return the valid status
}

function fixStepIndicator(n) {
  // This function removes the "active" class of all steps...
  var i, x = document.getElementsByClassName("step");
  for (i = 0; i < x.length; i++) {
    x[i].className = x[i].className.replace(" active", "");
  }
  //... and adds the "active" class to the current step:
  x[n].className += " active";
}


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

/*
for(let i = 0; i < asientos.length ; i++) {
    asientos[i].addEventListener('click', checkear(i));
}
*/


/* METODO DE PAGO */