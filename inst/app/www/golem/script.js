$(document).ready(function () {
  setTimeout(function () {
    // Create custom install UI
    let installToast = app.toast.create({
      position: 'center',
      text: `<button 
    id="install-button" 
    class="toast-button button color-green">
    Install
  </button>`
    });

    let deferredPrompt;
    window.addEventListener('beforeinstallprompt', (e) => {
      // Prevent the mini-infobar from appearing on mobile
      e.preventDefault();
      // Stash the event so it can be triggered later.
      deferredPrompt = e;
      // Show install trigger
      installToast.open();
    });

    app.utils.nextTick(function () {
      $('#install-button').on('click', function () {
        // close install toast
        installToast.close();
        if (!deferredPrompt) {
          // The deferred prompt isn't available.
          return;
        }
        // Show the install prompt.
        deferredPrompt.prompt();
        // Log the result
        deferredPrompt.userChoice.then((result) => {
          console.log('👍', 'userChoice', result);
          // Reset the deferred prompt variable, since
          // prompt() can only be called once.
          deferredPrompt = null;
        });
      });
    }, 500);
  }, 1000);
});
