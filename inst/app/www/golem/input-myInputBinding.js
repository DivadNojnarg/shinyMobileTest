var myInputBinding = new Shiny.InputBinding();
$.extend(myInputBinding, {
  find: function(scope) {
    // JS logic $(scope).find('whatever')
  },
  getValue: function(el) {
    // JS code to get value
  },
  setValue: function(el, value) {
    // JS code to set value
  },
  receiveMessage: function(el, data) {
    // this.setValue(el, data);
  },
  subscribe: function(el, callback) {
    $(el).on('click.myInputBinding', function(e) {
      callback();
    });

  },
  unsubscribe: function(el) {
    $(el).off('.myInputBinding');
  }
});
Shiny.inputBindings.register(myInputBinding, 'shiny.whatever');
