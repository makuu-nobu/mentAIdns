const start = () => {
    const startBtn = document.getElementById("start-btn");
    const optionsContainer = document.querySelector(".options-container");

    startBtn.addEventListener("click", (e) =>{
        e.preventDefault();
        startBtn.style.display = "none";
        optionsContainer.style.display = "block";
    });
};

window.addEventListener("load", start);