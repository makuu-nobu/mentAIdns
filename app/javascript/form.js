const start = () => {
  const startBtn = document.getElementById("start-btn");
  const optionsContainer = document.querySelector(".options-container");

  startBtn.addEventListener("click", (e) =>{
      e.preventDefault();
      startBtn.style.display = "none";
      optionsContainer.style.display = "block";
  });
};

const form = () => {
  const autoSubmitElements = document.querySelectorAll('.auto-submit');
  const questionForm = document.getElementById('question-form');
  const questionDiv = document.querySelector('.question-text');
  const questionText = (questionDiv.textContent || questionDiv.innerText).trim(); // trim() を追加
  var answerTime;
  const startBtn = document.getElementById("start-btn");
  const optionsContainer = document.querySelector(".options-container");

  startBtn.addEventListener("click", () => {
    answerTime = new Date().getTime();
  });

  autoSubmitElements.forEach(function (element) {
    element.addEventListener('change', function (e) {
      e.preventDefault();
      const selectedOption = document.querySelector('input[name="selected_option"]:checked');

      if (selectedOption){
        const selectedValue = selectedOption.value;
        answerTime = Math.floor((new Date().getTime() - answerTime) / 1000);
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
          const question = XHR.response.question;
          const html = `
          <div class="question-text" >
            ${question}
          </div>`;
          questionDiv.innerHTML = question;

          // Start ボタンを再表示し、Options Container を非表示にする
          startBtn.style.display = "block";
          optionsContainer.style.display = "none";
        };
      }
    });
  });
};

window.addEventListener('turbo:load', form);
window.addEventListener("turbo:load", start);
