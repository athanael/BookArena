document.addEventListener('DOMContentLoaded', function() {
  let calendarEl = document.getElementById('calendar');

  if (calendarEl) {
    let calendar = new FullCalendar.Calendar(calendarEl, {
      initialView: 'timeGridDay', // Vue initiale (mois, jour, etc.)
      events: '/bookings.json',    // URL pour récupérer les événements existants (réservations déjà faites)
      displayEventTime: false,
      // Gestionnaire de clics sur les dates du calendrier
      dateClick: function(info) {
        // Remplir les champs cachés avec la date sélectionnée
        document.querySelector('input[name="booking[start]"]').value = info.dateStr;
        document.querySelector('input[name="booking[end]"]').value = info.dateStr;
      }
    });

    calendar.render();
    console.log("FullCalendar initialized");
  }
});
