document.addEventListener("DOMContentLoaded", function() {
    document.querySelector("#new_review").addEventListener("submit", function(event) {
      var reviewContent = document.querySelector("#review-content");
      if (reviewContent.value.trim() === "") {
        event.preventDefault();
        alert("Review cannot be blank");
      }
    });
  });
  