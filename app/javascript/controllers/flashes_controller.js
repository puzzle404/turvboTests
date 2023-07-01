import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    setTimeout(function () {
      var myAlert = document.querySelector('#my-alert');
      if (myAlert) {
        var notice = myAlert.querySelector('.notice');
        var alert = myAlert.querySelector('.alert');
        if (notice) {
          setTimeout(function () {
            notice.classList.add('slide-out-right'); // Agrega la clase slide-out-right después de 5 segundos
            setTimeout(function () {
              myAlert.innerHTML = "";
            }, 1000); // Espera 1 segundo para eliminar el elemento
          }, 5000); // La alerta se cerrará después de 5 segundos (5000 milisegundos)
        }
        if (alert) {
          setTimeout(function () {
            alert.classList.add('slide-out-right'); // Agrega la clase slide-out-right después de 5 segundos
            setTimeout(function () {
              myAlert.innerHTML = "";
            }, 1000); // Espera 1 segundo para eliminar el elemento
          }, 5000); // La alerta se cerrará después de 5 segundos (5000 milisegundos)
        }
      }
    }, 1000);
  }


}
