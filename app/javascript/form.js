const form = () => {
  const autoSubmitElements = document.querySelectorAll('.auto-submit');
  const questionForm = document.getElementById('question-form');
  const questionDiv = document.querySelector('.question-text');
  const questionText = (questionDiv.textContent || questionDiv.innerText).trim(); // trim() を追加
  var answerTime;
  const startBtn = document.getElementById("start-btn");

  startBtn.addEventListener("click", () => {
    answerTime = new Date().getTime();
  });

  autoSubmitElements.forEach(function (element) {
    element.addEventListener('change', function (e) {
      e.preventDefault();
      const selectedOption = document.querySelector('input[name="selected_option"]:checked');

      if (selectedOption){
        const selectedValue = selectedOption.value;
        answerTime = new Date().getTime() - answerTime;
        const formData = new FormData(questionForm);
        formData.set('answer_time', answerTime);
        
        formData.set('question_text', questionText);
        formData.set('result_answer', selectedValue);

        const otherChoices = Array.from(autoSubmitElements)
          .filter(el => el !== selectedOption)
          .map(el => el.value);
        otherChoices.forEach((choice, index) => {
          formData.set(`choice_${index + 2}`, choice);
        });
        
        const XHR = new XMLHttpRequest();
        XHR.open("POST", "/mentals", true);
        XHR.responseType = "json";
        XHR.send(formData)
        XHR.onload = () => {
          console.log(XHR.response);
        };
      }
    });
  });
};

window.addEventListener('turbo:load', form);
