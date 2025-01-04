const CREATE_LINK = 'create_link'
const CREATE_WORD_SEARCH = 'create_word_search'

const getAuthorizationToken = async() => {
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

const sleep = () => new Promise(resolve => {
  setTimeout(() => resolve(), 3000);
});

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
  const alert = (text) => {
    chrome.scripting.executeScript({
      target: {tabId: tab.id},
      args: [text],
      function: args => { alert(args) }
    });
  }

  const errorAlert = () => {
    alert('エラーが発生しました。')
  }

  const authorizationToken = await getAuthorizationToken();
  const headers = {
    'Content-Type': 'application/json',
    'Authorization': `Bearer ${authorizationToken}`
  };
  const base_url = 'API_URL'

  if (info.menuItemId === CREATE_LINK) {
    chrome.tabs.sendMessage(tab.id, { type: CREATE_LINK });

    await fetch(`${base_url}/links`, {
      method: 'POST',
      headers,
      body: JSON.stringify({ link: { url: tab.url } }),
    });

    alert('リンクを保存しました！')
  } else if (info.menuItemId === CREATE_WORD_SEARCH) {
    chrome.tabs.sendMessage(tab.id, { type: CREATE_WORD_SEARCH });

    const res = await fetch(`${base_url}/word_searches`, {
      method: 'POST',
      headers,
      body: JSON.stringify({ word_search: { word: info.selectionText } }),
    });

    if (!res.ok) {
      errorAlert()
      return
    }

    const json = await res.json()
    const word_id = json.word.id

    let ja_word = ''
    while (ja_word === '') {
      await sleep();
      const res = await fetch(`${base_url}/words/${word_id}`, {
        method: 'GET',
        headers,
      });
      console.log('polling...')
      if (!res.ok) {
        errorAlert()
        return
      }

      const json = await res.json()
      ja_word = json.word.ja
    }
    alert(`"${info.selectionText}": ${ja_word} を保存しました！`)
  }
})
