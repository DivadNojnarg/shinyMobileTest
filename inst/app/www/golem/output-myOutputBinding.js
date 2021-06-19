var myOutputBinding = new Shiny.OutputBinding();
$.extend(myOutputBinding, {
  find: function(scope) {
    // JS logic $(scope).find('whatever')
  },
  renderValue: function(el, data) {
    // JS logic
  }
});
Shiny.outputBindings.register(myOutputBinding, 'shiny.whatever');
