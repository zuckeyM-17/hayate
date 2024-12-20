const CREATE_LINK = 'create_link'
const CREATE_WORD_SEARCH = 'create_word_search'

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
  if (info.menuItemId === CREATE_LINK) {
    chrome.tabs.sendMessage(tab.id, { type: CREATE_LINK });

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
  } else if (info.menuItemId === CREATE_WORD_SEARCH) {
    chrome.tabs.sendMessage(tab.id, { type: CREATE_WORD_SEARCH });

    await fetch('CREATE_WORD_SEARCH_API_URL', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ word_search: { word: info.selectionText } }),
    });

    chrome.scripting.executeScript({
      target: {tabId: tab.id},
      args: [`"${info.selectionText}"を保存しました！`],
      function: args => {  alert(args) }
    });
  }
})