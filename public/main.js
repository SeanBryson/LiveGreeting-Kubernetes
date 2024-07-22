document.addEventListener('DOMContentLoaded', function() {
    const p = document.getElementById('time');
    const updateDateTime = () => {
      const date = new Date();
      p.textContent = `The current time is ${date.toLocaleTimeString()} on ${date.toLocaleDateString()}.`;
    };
    setInterval(updateDateTime, 1000); // Update time every second
    updateDateTime(); // Initial update
  });
  