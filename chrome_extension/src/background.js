const CREATE_LINK = 'create_link'

chrome.runtime.onInstalled.addListener(() => {
  chrome.contextMenus.create({
    id: CREATE_LINK,
    title: "リンクを保存",
    contexts: ["all"]
  });
});

chrome.contextMenus.onClicked.addListener(async (info, tab) => {
  if (info.menuItemId === CREATE_LINK) {
    chrome.tabs.sendMessage(tab.id, { type: "create_link" });

    await fetch('CREATE_LINK_API_URL', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ link: { url: tab.url } }),
    });

    chrome.scripting.executeScript({
      target: {tabId: tab.id},
      args: ['リンクを保存しました！'],
      function: args => {  alert(args) }
    });
  }
})