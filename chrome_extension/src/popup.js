document.getElementById('saveButton').addEventListener('click', () => {
  const authorizationToken = document.getElementById('authorizationToken').value;

  chrome.storage.sync.set({ 'hayateApiAuthorizationToken': authorizationToken }, () => {
    if (chrome.runtime.lastError) {
      console.error("Error saving API key:", chrome.runtime.lastError);
      alert("Failed to save authorization token.");
    } else {
      alert("Successed to save.");
    }
  });
});
