document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll(".btn-delete").forEach(node => {
      node.addEventListener("click", event => {
        event.preventDefault();
  
        const { currentTarget } = event;
        const answerId = currentTarget.dataset.id;
  
        fetch(`/api/v1/answers/${answerId}`, {
          credentials: "same-origin",
          // When fetching on the same domain, include cookies
          // with the option `credentials: "same-origin"
          method: "DELETE"
        }).then(() => {
            document.querySelector(`#answer_${answerId}`).remove();
            console.log("Answer deleted!");
        });
      });
    });
  });