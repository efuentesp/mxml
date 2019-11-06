i18next.use(window.i18nextXHRBackend).init(
  {
    debug: true,
    //whitelist: ['en-US', 'es'],
    fallbackLng: "en",
    backend: {
      loadPath: "../assets/i18n/langs/{{lng}}.json"
    }
  },
  (err, t) => {
    jqueryI18next.init(i18next, $);
    $("html").localize();
  }
);
