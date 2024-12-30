const CREATE_LINK = 'create_link'
const CREATE_WORD_SEARCH = 'create_word_search'

async function getAuthorizationToken() {
  return new Promise((resolve, reject) => {
    chrome.storage.sync.get(['hayateApiAuthorizationToken'], (result) => {
      if (chrome.runtime.lastError) {
        console.error(chrome.runtime.lastError);
        reject("Failed to save authorization token.");
      } else {
        resolve(result.hayateApiAuthorizationToken);
      }
    });
  })
}

chrome.runtime.onInstalled.addListener(() => {
  chrome.contextMenus.create({
    id: CREATE_LINK,
    title: "リンクを保存",
    contexts: ["all"]
  });

  chrome.contextMenus.create({
    id: CREATE_WORD_SEARCH,
    title: '選択した "%s" を保存',
    contexts: ["selection"]
  })
});

chrome.contextMenus.onClicked.addListener(async (info, tab) => {
  const authorizationToken = await getAuthorizationToken();
  const headers = {
    'Content-Type': 'application/json',
    'Authorization': `Bearer ${authorizationToken}`
  };

  if (info.menuItemId === CREATE_LINK) {
    chrome.tabs.sendMessage(tab.id, { type: CREATE_LINK });

    await fetch('CREATE_LINK_API_URL', {
      method: 'POST',
      headers,
      body: JSON.stringify({ link: { url: tab.url } }),
    });

    chrome.scripting.executeScript({
      target: {tabId: tab.id},
      args: ['リンクを保存しました！'],
      function: args => {  alert(args) }
    });
  } else if (info.menuItemId === CREATE_WORD_SEARCH) {
    chrome.tabs.sendMessage(tab.id, { type: CREATE_WORD_SEARCH });

    await fetch('CREATE_WORD_SEARCH_API_URL', {
      method: 'POST',
      headers,
      body: JSON.stringify({ word_search: { word: info.selectionText } }),
    });

    chrome.scripting.executeScript({
      target: {tabId: tab.id},
      args: [`"${info.selectionText}"を保存しました！`],
      function: args => {  alert(args) }
    });
  }
})
