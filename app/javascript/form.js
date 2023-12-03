const form = () => {
    const autoSubmitElements = document.querySelectorAll('.auto-submit');

    autoSubmitElements.forEach(function (element) {
      element.addEventListener('change', function () {
        document.getElementById('question-form').submit();
      });
    });
  };

window.addEventListener('load', form);