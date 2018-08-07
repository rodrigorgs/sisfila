(function() {
  App.room = App.cable.subscriptions.create("TelaoNotificationsChannel", {
    received: function(data) {
      let elem = document.getElementById('numero');
      elem.innerText = data.posicao_atual;
      return console.log(data);
    }
  });

}).call(this);