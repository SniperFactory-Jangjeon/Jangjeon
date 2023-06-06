const functions = require("firebase-functions");
const admin = require("firebase-admin");

var serviceAccount = require("./jangjeon-8722f-firebase-adminsdk-jwgjc-8ebd3688a9.json");

if (!admin.apps.length) {
  var firebaseAdmin = admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
  });
}
const fetch = require("node-fetch");
const { DOMParser } = require("xmldom");

const runtimeOpts = {
  timeoutSeconds: 540,
  memory: '8GB'
}

//카카오톡 파이어베이스 auth 연동
exports.createKakaoToken = functions.https.onRequest(async (request, response) => {
    const user = request.body;

    const uid = `kakao:${user.uid}`;
    const updateParams = {
        email: user.email,
        photoURL: user.photoURL,
        displayName: user.displayName,
    };

    try {
        await admin.auth().updateUser(uid, updateParams);
    } catch (error) {
        updateParams["uid"] = uid;
        await admin.auth().createUser(updateParams);
        await admin.firestore().collection('userInfo').doc(uid).set({
            email: user.email,
            photoUrl: user.photoURL,
            name: user.displayName,
            optionalAgreement: false,
            phone: null,
            commentCount: 0
        }, { merge: true });
    }

    const token = await admin.auth().createCustomToken(uid);

    response.send(token);
});

//가장 최근 뉴스 기사 타이틀을 가져와 투자 지수 분석 후 저장
// exports.readNews = functions.runWith(runtimeOpts).pubsub.schedule("0 8 * * *")
//   .onRun(async (context) => {
//     var stockList = await admin.firestore()
//       .collection("stockList").get();
    
//     for (var k = 0; k < stockList.docs.length; k++) {
  
//       await fetch(`https://feeds.finance.yahoo.com/rss/2.0/headline?s=${stockList.docs[k].data().symbol}&region=US&lang=en-US`)
//         .then(async (response) => {
//           const xmlText = await response.text();
//           const parser = new DOMParser();
//           const xmlDoc = parser.parseFromString(xmlText, "application/xml");
//           const items = xmlDoc.getElementsByTagName("item");
//           var newsTitle = "";
//           if (items.length > 0) {
//             const item = items[0];
//             newsTitle = item.getElementsByTagName("title")[0].textContent; //제목
//           }
//           var aiScore = await getNatural(newsTitle);
//           admin.firestore()
//               .collection("stockList")
//               .doc(stockList.docs[k].id)
//             .update({"aiScore": aiScore});
//         })
//         .catch((err) => console.log(err));
//     }
//   });
    
//ai 투자 수치 분석
async function getNatural(text) {
  var apikey = 'AIzaSyDFssDe48Lbb0NfpeISB8b9W5pv_tMUwds';
  const url = `https://language.googleapis.com/v1/documents:analyzeSentiment?key=${apikey}`;

  const requestBody = {
    document: {
      type: 'PLAIN_TEXT',
      content: text,
    },
    encodingType: 'UTF8',
  };

  const response = await fetch(url, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(requestBody),
  });

  if (response.status === 200) {
    const dataJson = await response.json();
    let sentimentScore = dataJson.documentSentiment.score;
    return sentimentScore;
  } else {
    return 400;
  }
}

//텍스트 번역
async function getTranslation(text) {
  const baseUrl = 'https://translation.googleapis.com/language/translate/v2';
  const key = 'AIzaSyDFssDe48Lbb0NfpeISB8b9W5pv_tMUwds';
  const to = 'ko';
  let result = text;

  const response = await fetch(`${baseUrl}?target=${to}&key=${key}&q=${text}`);
  if (response.ok) {
    const dataJson = await response.json();
    result = dataJson.data.translations[0].translatedText;
  } else {
    result = response.status.toString();
  }

  return result;
}

// 주식 별 기사 가져오기
exports.readRelevantNews_1 = functions.runWith(runtimeOpts).pubsub.schedule("0 8 * * *")
  .onRun(async (context) => {
    var stockList = await admin.firestore()
      .collection("stockList").get();
    
    for (var k = 0; k < 200; k++) {
      
      var list = [];
      await fetch(`https://feeds.finance.yahoo.com/rss/2.0/headline?s=${stockList.docs[k].data().symbol}&region=US&lang=en-US`)
        .then(async (response) => {
          const xmlText = await response.text();
          const parser = new DOMParser();
          const xmlDoc = parser.parseFromString(xmlText, "application/xml");
          const items = xmlDoc.getElementsByTagName("item");
          var len = items.length < 3 ? items.length : 3; 
          for (let i = 0; i < len; i++) {
            const item = items[i];
            const title = item.getElementsByTagName("title")[0].textContent; //제목
            const url = item.getElementsByTagName("link")[0].textContent; //기사 url
            const date = item.getElementsByTagName("pubDate")[0].textContent; //작성 날짜
            const pubDate = new Date(date.substring(0, date.indexOf("+")) + "GMT"); //
            const dateTime = new Date(pubDate.getTime() + 9 * 60 * 60 * 1000);
            const kstDateString = dateTime.toISOString().replace("T", " ").slice(0, -5);

            const res = await fetch(url);
            if (res.status === 200) {
              const htmlText = await res.text();
              const parser = new DOMParser();
              const doc = parser.parseFromString(htmlText, "text/html");
              const metaTags = doc.getElementsByTagName("meta");
              var thumbnail;
              for (var j = 0; j < metaTags.length; j++) {
                if (metaTags[j].getAttribute("name") == "twitter:image") {
                  thumbnail = metaTags[j].getAttribute("content");
                  break;
                }
              }
              const articleBody = doc.getElementsByClassName("caas-body")[0];
              const paragraphs = articleBody ? articleBody.getElementsByTagName("p") : [];
              let articleContent = "";
              for (let j = 0; j < paragraphs.length; j++) {
                articleContent += paragraphs[j].textContent;
              }
              const aiScore = await getNatural(title) * 100;
              const titleTranslation = await getTranslation(title);
              list.push({
                title: titleTranslation,
                url: url,
                aiScore: Math.floor(aiScore),
                stock: stockList.docs[k].data().symbol,
                thumbnail: thumbnail,
                article: articleContent,
                pubDate: new Date(pubDate),
                date: kstDateString,
              });
            } else {
              console.log("Failed to fetch page.");
            }
          }
          for (var n = 0; n < list.length; n++) {
            admin.firestore()
              .collection(`stockList/${stockList.docs[k].id}/relevantNews`)
              .doc(n.toString())
              .set(list[n], { merge: true });
          }
        })
        .catch((err) => console.log(err));
    }
});

exports.readRelevantNews_2 = functions.runWith(runtimeOpts).pubsub.schedule("20 8 * * *")
  .onRun(async (context) => {
    var stockList = await admin.firestore()
      .collection("stockList").get();
    
    for (var k = 200; k < 400; k++) {
      
      var list = [];
      await fetch(`https://feeds.finance.yahoo.com/rss/2.0/headline?s=${stockList.docs[k].data().symbol}&region=US&lang=en-US`)
        .then(async (response) => {
          const xmlText = await response.text();
          const parser = new DOMParser();
          const xmlDoc = parser.parseFromString(xmlText, "application/xml");
          const items = xmlDoc.getElementsByTagName("item");
          var len = items.length < 3 ? items.length : 3; 
          for (let i = 0; i < len; i++) {
            const item = items[i];
            const title = item.getElementsByTagName("title")[0].textContent; //제목
            const url = item.getElementsByTagName("link")[0].textContent; //기사 url
            const date = item.getElementsByTagName("pubDate")[0].textContent; //작성 날짜
            const pubDate = new Date(date.substring(0, date.indexOf("+")) + "GMT"); //
            const dateTime = new Date(pubDate.getTime() + 9 * 60 * 60 * 1000);
            const kstDateString = dateTime.toISOString().replace("T", " ").slice(0, -5);

            const res = await fetch(url);
            if (res.status === 200) {
              const htmlText = await res.text();
              const parser = new DOMParser();
              const doc = parser.parseFromString(htmlText, "text/html");
              const metaTags = doc.getElementsByTagName("meta");
              var thumbnail;
              for (var j = 0; j < metaTags.length; j++) {
                if (metaTags[j].getAttribute("name") == "twitter:image") {
                  thumbnail = metaTags[j].getAttribute("content");
                  break;
                }
              }
              const articleBody = doc.getElementsByClassName("caas-body")[0];
              const paragraphs = articleBody ? articleBody.getElementsByTagName("p") : [];
              let articleContent = "";
              for (let j = 0; j < paragraphs.length; j++) {
                articleContent += paragraphs[j].textContent;
              }
              const aiScore = await getNatural(title) * 100;
              const titleTranslation = await getTranslation(title);
              list.push({
                title: titleTranslation,
                url: url,
                aiScore: Math.floor(aiScore),
                stock: stockList.docs[k].data().symbol,
                thumbnail: thumbnail,
                article: articleContent,
                pubDate: new Date(pubDate),
                date: kstDateString,
              });
            } else {
              console.log("Failed to fetch page.");
            }
          }
          for (var n = 0; n < list.length; n++) {
            admin.firestore()
              .collection(`stockList/${stockList.docs[k].id}/relevantNews`)
              .doc(n.toString())
              .set(list[n], { merge: true });
          }
        })
        .catch((err) => console.log(err));
    }
  });

exports.readRelevantNews_3 = functions.runWith(runtimeOpts).pubsub.schedule("40 8 * * *")
  .onRun(async (context) => {
    var stockList = await admin.firestore()
      .collection("stockList").get();
    
    for (var k = 400; k < 600; k++) {
      
      var list = [];
      await fetch(`https://feeds.finance.yahoo.com/rss/2.0/headline?s=${stockList.docs[k].data().symbol}&region=US&lang=en-US`)
        .then(async (response) => {
          const xmlText = await response.text();
          const parser = new DOMParser();
          const xmlDoc = parser.parseFromString(xmlText, "application/xml");
          const items = xmlDoc.getElementsByTagName("item");
          var len = items.length < 3 ? items.length : 3; 
          for (let i = 0; i < len; i++) {
            const item = items[i];
            const title = item.getElementsByTagName("title")[0].textContent; //제목
            const url = item.getElementsByTagName("link")[0].textContent; //기사 url
            const date = item.getElementsByTagName("pubDate")[0].textContent; //작성 날짜
            const pubDate = new Date(date.substring(0, date.indexOf("+")) + "GMT"); //
            const dateTime = new Date(pubDate.getTime() + 9 * 60 * 60 * 1000);
            const kstDateString = dateTime.toISOString().replace("T", " ").slice(0, -5);

            const res = await fetch(url);
            if (res.status === 200) {
              const htmlText = await res.text();
              const parser = new DOMParser();
              const doc = parser.parseFromString(htmlText, "text/html");
              const metaTags = doc.getElementsByTagName("meta");
              var thumbnail;
              for (var j = 0; j < metaTags.length; j++) {
                if (metaTags[j].getAttribute("name") == "twitter:image") {
                  thumbnail = metaTags[j].getAttribute("content");
                  break;
                }
              }
              const articleBody = doc.getElementsByClassName("caas-body")[0];
              const paragraphs = articleBody ? articleBody.getElementsByTagName("p") : [];
              let articleContent = "";
              for (let j = 0; j < paragraphs.length; j++) {
                articleContent += paragraphs[j].textContent;
              }
              const aiScore = await getNatural(title) * 100;
              const titleTranslation = await getTranslation(title);
              list.push({
                title: titleTranslation,
                url: url,
                aiScore: Math.floor(aiScore),
                stock: stockList.docs[k].data().symbol,
                thumbnail: thumbnail,
                article: articleContent,
                pubDate: new Date(pubDate),
                date: kstDateString,
              });
            } else {
              console.log("Failed to fetch page.");
            }
          }
          for (var n = 0; n < list.length; n++) {
            admin.firestore()
              .collection(`stockList/${stockList.docs[k].id}/relevantNews`)
              .doc(n.toString())
              .set(list[n], { merge: true });
          }
        })
        .catch((err) => console.log(err));
    }
  });

exports.readRelevantNews_4 = functions.runWith(runtimeOpts).pubsub.schedule("0 9 * * *")
  .onRun(async (context) => {
    var stockList = await admin.firestore()
      .collection("stockList").get();
    
    for (var k = 600; k < 800; k++) {
      
      var list = [];
      await fetch(`https://feeds.finance.yahoo.com/rss/2.0/headline?s=${stockList.docs[k].data().symbol}&region=US&lang=en-US`)
        .then(async (response) => {
          const xmlText = await response.text();
          const parser = new DOMParser();
          const xmlDoc = parser.parseFromString(xmlText, "application/xml");
          const items = xmlDoc.getElementsByTagName("item");
          var len = items.length < 3 ? items.length : 3; 
          for (let i = 0; i < len; i++) {
            const item = items[i];
            const title = item.getElementsByTagName("title")[0].textContent; //제목
            const url = item.getElementsByTagName("link")[0].textContent; //기사 url
            const date = item.getElementsByTagName("pubDate")[0].textContent; //작성 날짜
            const pubDate = new Date(date.substring(0, date.indexOf("+")) + "GMT"); //
            const dateTime = new Date(pubDate.getTime() + 9 * 60 * 60 * 1000);
            const kstDateString = dateTime.toISOString().replace("T", " ").slice(0, -5);

            const res = await fetch(url);
            if (res.status === 200) {
              const htmlText = await res.text();
              const parser = new DOMParser();
              const doc = parser.parseFromString(htmlText, "text/html");
              const metaTags = doc.getElementsByTagName("meta");
              var thumbnail;
              for (var j = 0; j < metaTags.length; j++) {
                if (metaTags[j].getAttribute("name") == "twitter:image") {
                  thumbnail = metaTags[j].getAttribute("content");
                  break;
                }
              }
              const articleBody = doc.getElementsByClassName("caas-body")[0];
              const paragraphs = articleBody ? articleBody.getElementsByTagName("p") : [];
              let articleContent = "";
              for (let j = 0; j < paragraphs.length; j++) {
                articleContent += paragraphs[j].textContent;
              }
              const aiScore = await getNatural(title) * 100;
              const titleTranslation = await getTranslation(title);
              list.push({
                title: titleTranslation,
                url: url,
                aiScore: Math.floor(aiScore),
                stock: stockList.docs[k].data().symbol,
                thumbnail: thumbnail,
                article: articleContent,
                pubDate: new Date(pubDate),
                date: kstDateString,
              });
            } else {
              console.log("Failed to fetch page.");
            }
          }
          for (var n = 0; n < list.length; n++) {
            admin.firestore()
              .collection(`stockList/${stockList.docs[k].id}/relevantNews`)
              .doc(n.toString())
              .set(list[n], { merge: true });
          }
        })
        .catch((err) => console.log(err));
    }
  });

exports.readRelevantNews_5 = functions.runWith(runtimeOpts).pubsub.schedule("20 9 * * *")
  .onRun(async (context) => {
    var stockList = await admin.firestore()
      .collection("stockList").get();
    
    for (var k = 800; k < 1000; k++) {
      
      var list = [];
      await fetch(`https://feeds.finance.yahoo.com/rss/2.0/headline?s=${stockList.docs[k].data().symbol}&region=US&lang=en-US`)
        .then(async (response) => {
          const xmlText = await response.text();
          const parser = new DOMParser();
          const xmlDoc = parser.parseFromString(xmlText, "application/xml");
          const items = xmlDoc.getElementsByTagName("item");
          var len = items.length < 3 ? items.length : 3; 
          for (let i = 0; i < len; i++) {
            const item = items[i];
            const title = item.getElementsByTagName("title")[0].textContent; //제목
            const url = item.getElementsByTagName("link")[0].textContent; //기사 url
            const date = item.getElementsByTagName("pubDate")[0].textContent; //작성 날짜
            const pubDate = new Date(date.substring(0, date.indexOf("+")) + "GMT"); //
            const dateTime = new Date(pubDate.getTime() + 9 * 60 * 60 * 1000);
            const kstDateString = dateTime.toISOString().replace("T", " ").slice(0, -5);

            const res = await fetch(url);
            if (res.status === 200) {
              const htmlText = await res.text();
              const parser = new DOMParser();
              const doc = parser.parseFromString(htmlText, "text/html");
              const metaTags = doc.getElementsByTagName("meta");
              var thumbnail;
              for (var j = 0; j < metaTags.length; j++) {
                if (metaTags[j].getAttribute("name") == "twitter:image") {
                  thumbnail = metaTags[j].getAttribute("content");
                  break;
                }
              }
              const articleBody = doc.getElementsByClassName("caas-body")[0];
              const paragraphs = articleBody ? articleBody.getElementsByTagName("p") : [];
              let articleContent = "";
              for (let j = 0; j < paragraphs.length; j++) {
                articleContent += paragraphs[j].textContent;
              }
              const aiScore = await getNatural(title) * 100;
              const titleTranslation = await getTranslation(title);
              list.push({
                title: titleTranslation,
                url: url,
                aiScore: Math.floor(aiScore),
                stock: stockList.docs[k].data().symbol,
                thumbnail: thumbnail,
                article: articleContent,
                pubDate: new Date(pubDate),
                date: kstDateString,
              });
            } else {
              console.log("Failed to fetch page.");
            }
          }
          for (var n = 0; n < list.length; n++) {
            admin.firestore()
              .collection(`stockList/${stockList.docs[k].id}/relevantNews`)
              .doc(n.toString())
              .set(list[n], { merge: true });
          }
        })
        .catch((err) => console.log(err));
    }
  });

exports.readRelevantNews_6 = functions.runWith(runtimeOpts).pubsub.schedule("40 9 * * *")
  .onRun(async (context) => {
    var stockList = await admin.firestore()
      .collection("stockList").get();
    
    for (var k = 1000; k < 1200; k++) {
      
      var list = [];
      await fetch(`https://feeds.finance.yahoo.com/rss/2.0/headline?s=${stockList.docs[k].data().symbol}&region=US&lang=en-US`)
        .then(async (response) => {
          const xmlText = await response.text();
          const parser = new DOMParser();
          const xmlDoc = parser.parseFromString(xmlText, "application/xml");
          const items = xmlDoc.getElementsByTagName("item");
          var len = items.length < 3 ? items.length : 3; 
          for (let i = 0; i < len; i++) {
            const item = items[i];
            const title = item.getElementsByTagName("title")[0].textContent; //제목
            const url = item.getElementsByTagName("link")[0].textContent; //기사 url
            const date = item.getElementsByTagName("pubDate")[0].textContent; //작성 날짜
            const pubDate = new Date(date.substring(0, date.indexOf("+")) + "GMT"); //
            const dateTime = new Date(pubDate.getTime() + 9 * 60 * 60 * 1000);
            const kstDateString = dateTime.toISOString().replace("T", " ").slice(0, -5);

            const res = await fetch(url);
            if (res.status === 200) {
              const htmlText = await res.text();
              const parser = new DOMParser();
              const doc = parser.parseFromString(htmlText, "text/html");
              const metaTags = doc.getElementsByTagName("meta");
              var thumbnail;
              for (var j = 0; j < metaTags.length; j++) {
                if (metaTags[j].getAttribute("name") == "twitter:image") {
                  thumbnail = metaTags[j].getAttribute("content");
                  break;
                }
              }
              const articleBody = doc.getElementsByClassName("caas-body")[0];
              const paragraphs = articleBody ? articleBody.getElementsByTagName("p") : [];
              let articleContent = "";
              for (let j = 0; j < paragraphs.length; j++) {
                articleContent += paragraphs[j].textContent;
              }
              const aiScore = await getNatural(title) * 100;
              const titleTranslation = await getTranslation(title);
              list.push({
                title: titleTranslation,
                url: url,
                aiScore: Math.floor(aiScore),
                stock: stockList.docs[k].data().symbol,
                thumbnail: thumbnail,
                article: articleContent,
                pubDate: new Date(pubDate),
                date: kstDateString,
              });
            } else {
              console.log("Failed to fetch page.");
            }
          }
          for (var n = 0; n < list.length; n++) {
            admin.firestore()
              .collection(`stockList/${stockList.docs[k].id}/relevantNews`)
              .doc(n.toString())
              .set(list[n], { merge: true });
          }
        })
        .catch((err) => console.log(err));
    }
  });

exports.readRelevantNews_7 = functions.runWith(runtimeOpts).pubsub.schedule("0 10 * * *")
  .onRun(async (context) => {
    var stockList = await admin.firestore()
      .collection("stockList").get();
    
    for (var k = 1200; k < 1400; k++) {
      
      var list = [];
      await fetch(`https://feeds.finance.yahoo.com/rss/2.0/headline?s=${stockList.docs[k].data().symbol}&region=US&lang=en-US`)
        .then(async (response) => {
          const xmlText = await response.text();
          const parser = new DOMParser();
          const xmlDoc = parser.parseFromString(xmlText, "application/xml");
          const items = xmlDoc.getElementsByTagName("item");
          var len = items.length < 3 ? items.length : 3; 
          for (let i = 0; i < len; i++) {
            const item = items[i];
            const title = item.getElementsByTagName("title")[0].textContent; //제목
            const url = item.getElementsByTagName("link")[0].textContent; //기사 url
            const date = item.getElementsByTagName("pubDate")[0].textContent; //작성 날짜
            const pubDate = new Date(date.substring(0, date.indexOf("+")) + "GMT"); //
            const dateTime = new Date(pubDate.getTime() + 9 * 60 * 60 * 1000);
            const kstDateString = dateTime.toISOString().replace("T", " ").slice(0, -5);

            const res = await fetch(url);
            if (res.status === 200) {
              const htmlText = await res.text();
              const parser = new DOMParser();
              const doc = parser.parseFromString(htmlText, "text/html");
              const metaTags = doc.getElementsByTagName("meta");
              var thumbnail;
              for (var j = 0; j < metaTags.length; j++) {
                if (metaTags[j].getAttribute("name") == "twitter:image") {
                  thumbnail = metaTags[j].getAttribute("content");
                  break;
                }
              }
              const articleBody = doc.getElementsByClassName("caas-body")[0];
              const paragraphs = articleBody ? articleBody.getElementsByTagName("p") : [];
              let articleContent = "";
              for (let j = 0; j < paragraphs.length; j++) {
                articleContent += paragraphs[j].textContent;
              }
              const aiScore = await getNatural(title) * 100;
              const titleTranslation = await getTranslation(title);
              list.push({
                title: titleTranslation,
                url: url,
                aiScore: Math.floor(aiScore),
                stock: stockList.docs[k].data().symbol,
                thumbnail: thumbnail,
                article: articleContent,
                pubDate: new Date(pubDate),
                date: kstDateString,
              });
            } else {
              console.log("Failed to fetch page.");
            }
          }
          for (var n = 0; n < list.length; n++) {
            admin.firestore()
              .collection(`stockList/${stockList.docs[k].id}/relevantNews`)
              .doc(n.toString())
              .set(list[n], { merge: true });
          }
        })
        .catch((err) => console.log(err));
    }
  });

exports.readRelevantNews_8 = functions.runWith(runtimeOpts).pubsub.schedule("20 10 * * *")
  .onRun(async (context) => {
    var stockList = await admin.firestore()
      .collection("stockList").get();
    
    for (var k = 1400; k < 1600; k++) {
      
      var list = [];
      await fetch(`https://feeds.finance.yahoo.com/rss/2.0/headline?s=${stockList.docs[k].data().symbol}&region=US&lang=en-US`)
        .then(async (response) => {
          const xmlText = await response.text();
          const parser = new DOMParser();
          const xmlDoc = parser.parseFromString(xmlText, "application/xml");
          const items = xmlDoc.getElementsByTagName("item");
          var len = items.length < 3 ? items.length : 3; 
          for (let i = 0; i < len; i++) {
            const item = items[i];
            const title = item.getElementsByTagName("title")[0].textContent; //제목
            const url = item.getElementsByTagName("link")[0].textContent; //기사 url
            const date = item.getElementsByTagName("pubDate")[0].textContent; //작성 날짜
            const pubDate = new Date(date.substring(0, date.indexOf("+")) + "GMT"); //
            const dateTime = new Date(pubDate.getTime() + 9 * 60 * 60 * 1000);
            const kstDateString = dateTime.toISOString().replace("T", " ").slice(0, -5);

            const res = await fetch(url);
            if (res.status === 200) {
              const htmlText = await res.text();
              const parser = new DOMParser();
              const doc = parser.parseFromString(htmlText, "text/html");
              const metaTags = doc.getElementsByTagName("meta");
              var thumbnail;
              for (var j = 0; j < metaTags.length; j++) {
                if (metaTags[j].getAttribute("name") == "twitter:image") {
                  thumbnail = metaTags[j].getAttribute("content");
                  break;
                }
              }
              const articleBody = doc.getElementsByClassName("caas-body")[0];
              const paragraphs = articleBody ? articleBody.getElementsByTagName("p") : [];
              let articleContent = "";
              for (let j = 0; j < paragraphs.length; j++) {
                articleContent += paragraphs[j].textContent;
              }
              const aiScore = await getNatural(title) * 100;
              const titleTranslation = await getTranslation(title);
              list.push({
                title: titleTranslation,
                url: url,
                aiScore: Math.floor(aiScore),
                stock: stockList.docs[k].data().symbol,
                thumbnail: thumbnail,
                article: articleContent,
                pubDate: new Date(pubDate),
                date: kstDateString,
              });
            } else {
              console.log("Failed to fetch page.");
            }
          }
          for (var n = 0; n < list.length; n++) {
            admin.firestore()
              .collection(`stockList/${stockList.docs[k].id}/relevantNews`)
              .doc(n.toString())
              .set(list[n], { merge: true });
          }
        })
        .catch((err) => console.log(err));
    }
  });

exports.readRelevantNews_9 = functions.runWith(runtimeOpts).pubsub.schedule("40 10 * * *")
  .onRun(async (context) => {
    var stockList = await admin.firestore()
      .collection("stockList").get();
    
    for (var k = 1600; k < 1800; k++) {
      
      var list = [];
      await fetch(`https://feeds.finance.yahoo.com/rss/2.0/headline?s=${stockList.docs[k].data().symbol}&region=US&lang=en-US`)
        .then(async (response) => {
          const xmlText = await response.text();
          const parser = new DOMParser();
          const xmlDoc = parser.parseFromString(xmlText, "application/xml");
          const items = xmlDoc.getElementsByTagName("item");
          var len = items.length < 3 ? items.length : 3; 
          for (let i = 0; i < len; i++) {
            const item = items[i];
            const title = item.getElementsByTagName("title")[0].textContent; //제목
            const url = item.getElementsByTagName("link")[0].textContent; //기사 url
            const date = item.getElementsByTagName("pubDate")[0].textContent; //작성 날짜
            const pubDate = new Date(date.substring(0, date.indexOf("+")) + "GMT"); //
            const dateTime = new Date(pubDate.getTime() + 9 * 60 * 60 * 1000);
            const kstDateString = dateTime.toISOString().replace("T", " ").slice(0, -5);

            const res = await fetch(url);
            if (res.status === 200) {
              const htmlText = await res.text();
              const parser = new DOMParser();
              const doc = parser.parseFromString(htmlText, "text/html");
              const metaTags = doc.getElementsByTagName("meta");
              var thumbnail;
              for (var j = 0; j < metaTags.length; j++) {
                if (metaTags[j].getAttribute("name") == "twitter:image") {
                  thumbnail = metaTags[j].getAttribute("content");
                  break;
                }
              }
              const articleBody = doc.getElementsByClassName("caas-body")[0];
              const paragraphs = articleBody ? articleBody.getElementsByTagName("p") : [];
              let articleContent = "";
              for (let j = 0; j < paragraphs.length; j++) {
                articleContent += paragraphs[j].textContent;
              }
              const aiScore = await getNatural(title) * 100;
              const titleTranslation = await getTranslation(title);
              list.push({
                title: titleTranslation,
                url: url,
                aiScore: Math.floor(aiScore),
                stock: stockList.docs[k].data().symbol,
                thumbnail: thumbnail,
                article: articleContent,
                pubDate: new Date(pubDate),
                date: kstDateString,
              });
            } else {
              console.log("Failed to fetch page.");
            }
          }
          for (var n = 0; n < list.length; n++) {
            admin.firestore()
              .collection(`stockList/${stockList.docs[k].id}/relevantNews`)
              .doc(n.toString())
              .set(list[n], { merge: true });
          }
        })
        .catch((err) => console.log(err));
    }
  });

exports.readRelevantNews_10 = functions.runWith(runtimeOpts).pubsub.schedule("0 11 * * *")
  .onRun(async (context) => {
    var stockList = await admin.firestore()
      .collection("stockList").get();
    
    for (var k = 1800; k < 2000; k++) {
      
      var list = [];
      await fetch(`https://feeds.finance.yahoo.com/rss/2.0/headline?s=${stockList.docs[k].data().symbol}&region=US&lang=en-US`)
        .then(async (response) => {
          const xmlText = await response.text();
          const parser = new DOMParser();
          const xmlDoc = parser.parseFromString(xmlText, "application/xml");
          const items = xmlDoc.getElementsByTagName("item");
          var len = items.length < 3 ? items.length : 3; 
          for (let i = 0; i < len; i++) {
            const item = items[i];
            const title = item.getElementsByTagName("title")[0].textContent; //제목
            const url = item.getElementsByTagName("link")[0].textContent; //기사 url
            const date = item.getElementsByTagName("pubDate")[0].textContent; //작성 날짜
            const pubDate = new Date(date.substring(0, date.indexOf("+")) + "GMT"); //
            const dateTime = new Date(pubDate.getTime() + 9 * 60 * 60 * 1000);
            const kstDateString = dateTime.toISOString().replace("T", " ").slice(0, -5);

            const res = await fetch(url);
            if (res.status === 200) {
              const htmlText = await res.text();
              const parser = new DOMParser();
              const doc = parser.parseFromString(htmlText, "text/html");
              const metaTags = doc.getElementsByTagName("meta");
              var thumbnail;
              for (var j = 0; j < metaTags.length; j++) {
                if (metaTags[j].getAttribute("name") == "twitter:image") {
                  thumbnail = metaTags[j].getAttribute("content");
                  break;
                }
              }
              const articleBody = doc.getElementsByClassName("caas-body")[0];
              const paragraphs = articleBody ? articleBody.getElementsByTagName("p") : [];
              let articleContent = "";
              for (let j = 0; j < paragraphs.length; j++) {
                articleContent += paragraphs[j].textContent;
              }
              const aiScore = await getNatural(title) * 100;
              const titleTranslation = await getTranslation(title);
              list.push({
                title: titleTranslation,
                url: url,
                aiScore: Math.floor(aiScore),
                stock: stockList.docs[k].data().symbol,
                thumbnail: thumbnail,
                article: articleContent,
                pubDate: new Date(pubDate),
                date: kstDateString,
              });
            } else {
              console.log("Failed to fetch page.");
            }
          }
          for (var n = 0; n < list.length; n++) {
            admin.firestore()
              .collection(`stockList/${stockList.docs[k].id}/relevantNews`)
              .doc(n.toString())
              .set(list[n], { merge: true });
          }
        })
        .catch((err) => console.log(err));
    }
  });

exports.readRelevantNews_11 = functions.runWith(runtimeOpts).pubsub.schedule("20 11 * * *")
  .onRun(async (context) => {
    var stockList = await admin.firestore()
      .collection("stockList").get();
    
    for (var k = 2000; k < 2200; k++) {
      
      var list = [];
      await fetch(`https://feeds.finance.yahoo.com/rss/2.0/headline?s=${stockList.docs[k].data().symbol}&region=US&lang=en-US`)
        .then(async (response) => {
          const xmlText = await response.text();
          const parser = new DOMParser();
          const xmlDoc = parser.parseFromString(xmlText, "application/xml");
          const items = xmlDoc.getElementsByTagName("item");
          var len = items.length < 3 ? items.length : 3; 
          for (let i = 0; i < len; i++) {
            const item = items[i];
            const title = item.getElementsByTagName("title")[0].textContent; //제목
            const url = item.getElementsByTagName("link")[0].textContent; //기사 url
            const date = item.getElementsByTagName("pubDate")[0].textContent; //작성 날짜
            const pubDate = new Date(date.substring(0, date.indexOf("+")) + "GMT"); //
            const dateTime = new Date(pubDate.getTime() + 9 * 60 * 60 * 1000);
            const kstDateString = dateTime.toISOString().replace("T", " ").slice(0, -5);

            const res = await fetch(url);
            if (res.status === 200) {
              const htmlText = await res.text();
              const parser = new DOMParser();
              const doc = parser.parseFromString(htmlText, "text/html");
              const metaTags = doc.getElementsByTagName("meta");
              var thumbnail;
              for (var j = 0; j < metaTags.length; j++) {
                if (metaTags[j].getAttribute("name") == "twitter:image") {
                  thumbnail = metaTags[j].getAttribute("content");
                  break;
                }
              }
              const articleBody = doc.getElementsByClassName("caas-body")[0];
              const paragraphs = articleBody ? articleBody.getElementsByTagName("p") : [];
              let articleContent = "";
              for (let j = 0; j < paragraphs.length; j++) {
                articleContent += paragraphs[j].textContent;
              }
              const aiScore = await getNatural(title) * 100;
              const titleTranslation = await getTranslation(title);
              list.push({
                title: titleTranslation,
                url: url,
                aiScore: Math.floor(aiScore),
                stock: stockList.docs[k].data().symbol,
                thumbnail: thumbnail,
                article: articleContent,
                pubDate: new Date(pubDate),
                date: kstDateString,
              });
            } else {
              console.log("Failed to fetch page.");
            }
          }
          for (var n = 0; n < list.length; n++) {
            admin.firestore()
              .collection(`stockList/${stockList.docs[k].id}/relevantNews`)
              .doc(n.toString())
              .set(list[n], { merge: true });
          }
        })
        .catch((err) => console.log(err));
    }
  });

exports.readRelevantNews_12 = functions.runWith(runtimeOpts).pubsub.schedule("40 11 * * *")
  .onRun(async (context) => {
    var stockList = await admin.firestore()
      .collection("stockList").get();
    
    for (var k = 2200; k < 2400; k++) {
      
      var list = [];
      await fetch(`https://feeds.finance.yahoo.com/rss/2.0/headline?s=${stockList.docs[k].data().symbol}&region=US&lang=en-US`)
        .then(async (response) => {
          const xmlText = await response.text();
          const parser = new DOMParser();
          const xmlDoc = parser.parseFromString(xmlText, "application/xml");
          const items = xmlDoc.getElementsByTagName("item");
          var len = items.length < 3 ? items.length : 3; 
          for (let i = 0; i < len; i++) {
            const item = items[i];
            const title = item.getElementsByTagName("title")[0].textContent; //제목
            const url = item.getElementsByTagName("link")[0].textContent; //기사 url
            const date = item.getElementsByTagName("pubDate")[0].textContent; //작성 날짜
            const pubDate = new Date(date.substring(0, date.indexOf("+")) + "GMT"); //
            const dateTime = new Date(pubDate.getTime() + 9 * 60 * 60 * 1000);
            const kstDateString = dateTime.toISOString().replace("T", " ").slice(0, -5);

            const res = await fetch(url);
            if (res.status === 200) {
              const htmlText = await res.text();
              const parser = new DOMParser();
              const doc = parser.parseFromString(htmlText, "text/html");
              const metaTags = doc.getElementsByTagName("meta");
              var thumbnail;
              for (var j = 0; j < metaTags.length; j++) {
                if (metaTags[j].getAttribute("name") == "twitter:image") {
                  thumbnail = metaTags[j].getAttribute("content");
                  break;
                }
              }
              const articleBody = doc.getElementsByClassName("caas-body")[0];
              const paragraphs = articleBody ? articleBody.getElementsByTagName("p") : [];
              let articleContent = "";
              for (let j = 0; j < paragraphs.length; j++) {
                articleContent += paragraphs[j].textContent;
              }
              const aiScore = await getNatural(title) * 100;
              const titleTranslation = await getTranslation(title);
              list.push({
                title: titleTranslation,
                url: url,
                aiScore: Math.floor(aiScore),
                stock: stockList.docs[k].data().symbol,
                thumbnail: thumbnail,
                article: articleContent,
                pubDate: new Date(pubDate),
                date: kstDateString,
              });
            } else {
              console.log("Failed to fetch page.");
            }
          }
          for (var n = 0; n < list.length; n++) {
            admin.firestore()
              .collection(`stockList/${stockList.docs[k].id}/relevantNews`)
              .doc(n.toString())
              .set(list[n], { merge: true });
          }
        })
        .catch((err) => console.log(err));
    }
  });

exports.readRelevantNews_13 = functions.runWith(runtimeOpts).pubsub.schedule("0 12 * * *")
  .onRun(async (context) => {
    var stockList = await admin.firestore()
      .collection("stockList").get();
    
    for (var k = 2400; k < 2600; k++) {
      
      var list = [];
      await fetch(`https://feeds.finance.yahoo.com/rss/2.0/headline?s=${stockList.docs[k].data().symbol}&region=US&lang=en-US`)
        .then(async (response) => {
          const xmlText = await response.text();
          const parser = new DOMParser();
          const xmlDoc = parser.parseFromString(xmlText, "application/xml");
          const items = xmlDoc.getElementsByTagName("item");
          var len = items.length < 3 ? items.length : 3; 
          for (let i = 0; i < len; i++) {
            const item = items[i];
            const title = item.getElementsByTagName("title")[0].textContent; //제목
            const url = item.getElementsByTagName("link")[0].textContent; //기사 url
            const date = item.getElementsByTagName("pubDate")[0].textContent; //작성 날짜
            const pubDate = new Date(date.substring(0, date.indexOf("+")) + "GMT"); //
            const dateTime = new Date(pubDate.getTime() + 9 * 60 * 60 * 1000);
            const kstDateString = dateTime.toISOString().replace("T", " ").slice(0, -5);

            const res = await fetch(url);
            if (res.status === 200) {
              const htmlText = await res.text();
              const parser = new DOMParser();
              const doc = parser.parseFromString(htmlText, "text/html");
              const metaTags = doc.getElementsByTagName("meta");
              var thumbnail;
              for (var j = 0; j < metaTags.length; j++) {
                if (metaTags[j].getAttribute("name") == "twitter:image") {
                  thumbnail = metaTags[j].getAttribute("content");
                  break;
                }
              }
              const articleBody = doc.getElementsByClassName("caas-body")[0];
              const paragraphs = articleBody ? articleBody.getElementsByTagName("p") : [];
              let articleContent = "";
              for (let j = 0; j < paragraphs.length; j++) {
                articleContent += paragraphs[j].textContent;
              }
              const aiScore = await getNatural(title) * 100;
              const titleTranslation = await getTranslation(title);
              list.push({
                title: titleTranslation,
                url: url,
                aiScore: Math.floor(aiScore),
                stock: stockList.docs[k].data().symbol,
                thumbnail: thumbnail,
                article: articleContent,
                pubDate: new Date(pubDate),
                date: kstDateString,
              });
            } else {
              console.log("Failed to fetch page.");
            }
          }
          for (var n = 0; n < list.length; n++) {
            admin.firestore()
              .collection(`stockList/${stockList.docs[k].id}/relevantNews`)
              .doc(n.toString())
              .set(list[n], { merge: true });
          }
        })
        .catch((err) => console.log(err));
    }
  });

exports.readRelevantNews_14 = functions.runWith(runtimeOpts).pubsub.schedule("20 12 * * *")
  .onRun(async (context) => {
    var stockList = await admin.firestore()
      .collection("stockList").get();
    
    for (var k = 2600; k < 2800; k++) {
      
      var list = [];
      await fetch(`https://feeds.finance.yahoo.com/rss/2.0/headline?s=${stockList.docs[k].data().symbol}&region=US&lang=en-US`)
        .then(async (response) => {
          const xmlText = await response.text();
          const parser = new DOMParser();
          const xmlDoc = parser.parseFromString(xmlText, "application/xml");
          const items = xmlDoc.getElementsByTagName("item");
          var len = items.length < 3 ? items.length : 3; 
          for (let i = 0; i < len; i++) {
            const item = items[i];
            const title = item.getElementsByTagName("title")[0].textContent; //제목
            const url = item.getElementsByTagName("link")[0].textContent; //기사 url
            const date = item.getElementsByTagName("pubDate")[0].textContent; //작성 날짜
            const pubDate = new Date(date.substring(0, date.indexOf("+")) + "GMT"); //
            const dateTime = new Date(pubDate.getTime() + 9 * 60 * 60 * 1000);
            const kstDateString = dateTime.toISOString().replace("T", " ").slice(0, -5);

            const res = await fetch(url);
            if (res.status === 200) {
              const htmlText = await res.text();
              const parser = new DOMParser();
              const doc = parser.parseFromString(htmlText, "text/html");
              const metaTags = doc.getElementsByTagName("meta");
              var thumbnail;
              for (var j = 0; j < metaTags.length; j++) {
                if (metaTags[j].getAttribute("name") == "twitter:image") {
                  thumbnail = metaTags[j].getAttribute("content");
                  break;
                }
              }
              const articleBody = doc.getElementsByClassName("caas-body")[0];
              const paragraphs = articleBody ? articleBody.getElementsByTagName("p") : [];
              let articleContent = "";
              for (let j = 0; j < paragraphs.length; j++) {
                articleContent += paragraphs[j].textContent;
              }
              const aiScore = await getNatural(title) * 100;
              const titleTranslation = await getTranslation(title);
              list.push({
                title: titleTranslation,
                url: url,
                aiScore: Math.floor(aiScore),
                stock: stockList.docs[k].data().symbol,
                thumbnail: thumbnail,
                article: articleContent,
                pubDate: new Date(pubDate),
                date: kstDateString,
              });
            } else {
              console.log("Failed to fetch page.");
            }
          }
          for (var n = 0; n < list.length; n++) {
            admin.firestore()
              .collection(`stockList/${stockList.docs[k].id}/relevantNews`)
              .doc(n.toString())
              .set(list[n], { merge: true });
          }
        })
        .catch((err) => console.log(err));
    }
  });

exports.readRelevantNews_15 = functions.runWith(runtimeOpts).pubsub.schedule("40 12 * * *")
  .onRun(async (context) => {
    var stockList = await admin.firestore()
      .collection("stockList").get();
    
    for (var k = 2800; k < 3000; k++) {
      
      var list = [];
      await fetch(`https://feeds.finance.yahoo.com/rss/2.0/headline?s=${stockList.docs[k].data().symbol}&region=US&lang=en-US`)
        .then(async (response) => {
          const xmlText = await response.text();
          const parser = new DOMParser();
          const xmlDoc = parser.parseFromString(xmlText, "application/xml");
          const items = xmlDoc.getElementsByTagName("item");
          var len = items.length < 3 ? items.length : 3; 
          for (let i = 0; i < len; i++) {
            const item = items[i];
            const title = item.getElementsByTagName("title")[0].textContent; //제목
            const url = item.getElementsByTagName("link")[0].textContent; //기사 url
            const date = item.getElementsByTagName("pubDate")[0].textContent; //작성 날짜
            const pubDate = new Date(date.substring(0, date.indexOf("+")) + "GMT"); //
            const dateTime = new Date(pubDate.getTime() + 9 * 60 * 60 * 1000);
            const kstDateString = dateTime.toISOString().replace("T", " ").slice(0, -5);

            const res = await fetch(url);
            if (res.status === 200) {
              const htmlText = await res.text();
              const parser = new DOMParser();
              const doc = parser.parseFromString(htmlText, "text/html");
              const metaTags = doc.getElementsByTagName("meta");
              var thumbnail;
              for (var j = 0; j < metaTags.length; j++) {
                if (metaTags[j].getAttribute("name") == "twitter:image") {
                  thumbnail = metaTags[j].getAttribute("content");
                  break;
                }
              }
              const articleBody = doc.getElementsByClassName("caas-body")[0];
              const paragraphs = articleBody ? articleBody.getElementsByTagName("p") : [];
              let articleContent = "";
              for (let j = 0; j < paragraphs.length; j++) {
                articleContent += paragraphs[j].textContent;
              }
              const aiScore = await getNatural(title) * 100;
              const titleTranslation = await getTranslation(title);
              list.push({
                title: titleTranslation,
                url: url,
                aiScore: Math.floor(aiScore),
                stock: stockList.docs[k].data().symbol,
                thumbnail: thumbnail,
                article: articleContent,
                pubDate: new Date(pubDate),
                date: kstDateString,
              });
            } else {
              console.log("Failed to fetch page.");
            }
          }
          for (var n = 0; n < list.length; n++) {
            admin.firestore()
              .collection(`stockList/${stockList.docs[k].id}/relevantNews`)
              .doc(n.toString())
              .set(list[n], { merge: true });
          }
        })
        .catch((err) => console.log(err));
    }
  });

exports.readRelevantNews_16 = functions.runWith(runtimeOpts).pubsub.schedule("0 13 * * *")
  .onRun(async (context) => {
    var stockList = await admin.firestore()
      .collection("stockList").get();
    
    for (var k = 3000; k < 3200; k++) {
      
      var list = [];
      await fetch(`https://feeds.finance.yahoo.com/rss/2.0/headline?s=${stockList.docs[k].data().symbol}&region=US&lang=en-US`)
        .then(async (response) => {
          const xmlText = await response.text();
          const parser = new DOMParser();
          const xmlDoc = parser.parseFromString(xmlText, "application/xml");
          const items = xmlDoc.getElementsByTagName("item");
          var len = items.length < 3 ? items.length : 3; 
          for (let i = 0; i < len; i++) {
            const item = items[i];
            const title = item.getElementsByTagName("title")[0].textContent; //제목
            const url = item.getElementsByTagName("link")[0].textContent; //기사 url
            const date = item.getElementsByTagName("pubDate")[0].textContent; //작성 날짜
            const pubDate = new Date(date.substring(0, date.indexOf("+")) + "GMT"); //
            const dateTime = new Date(pubDate.getTime() + 9 * 60 * 60 * 1000);
            const kstDateString = dateTime.toISOString().replace("T", " ").slice(0, -5);

            const res = await fetch(url);
            if (res.status === 200) {
              const htmlText = await res.text();
              const parser = new DOMParser();
              const doc = parser.parseFromString(htmlText, "text/html");
              const metaTags = doc.getElementsByTagName("meta");
              var thumbnail;
              for (var j = 0; j < metaTags.length; j++) {
                if (metaTags[j].getAttribute("name") == "twitter:image") {
                  thumbnail = metaTags[j].getAttribute("content");
                  break;
                }
              }
              const articleBody = doc.getElementsByClassName("caas-body")[0];
              const paragraphs = articleBody ? articleBody.getElementsByTagName("p") : [];
              let articleContent = "";
              for (let j = 0; j < paragraphs.length; j++) {
                articleContent += paragraphs[j].textContent;
              }
              const aiScore = await getNatural(title) * 100;
              const titleTranslation = await getTranslation(title);
              list.push({
                title: titleTranslation,
                url: url,
                aiScore: Math.floor(aiScore),
                stock: stockList.docs[k].data().symbol,
                thumbnail: thumbnail,
                article: articleContent,
                pubDate: new Date(pubDate),
                date: kstDateString,
              });
            } else {
              console.log("Failed to fetch page.");
            }
          }
          for (var n = 0; n < list.length; n++) {
            admin.firestore()
              .collection(`stockList/${stockList.docs[k].id}/relevantNews`)
              .doc(n.toString())
              .set(list[n], { merge: true });
          }
        })
        .catch((err) => console.log(err));
    }
  });

exports.readRelevantNews_17 = functions.runWith(runtimeOpts).pubsub.schedule("20 13 * * *")
  .onRun(async (context) => {
    var stockList = await admin.firestore()
      .collection("stockList").get();
    
    for (var k = 3200; k < stockList.docs.length; k++) {
      
      var list = [];
      await fetch(`https://feeds.finance.yahoo.com/rss/2.0/headline?s=${stockList.docs[k].data().symbol}&region=US&lang=en-US`)
        .then(async (response) => {
          const xmlText = await response.text();
          const parser = new DOMParser();
          const xmlDoc = parser.parseFromString(xmlText, "application/xml");
          const items = xmlDoc.getElementsByTagName("item");
          var len = items.length < 3 ? items.length : 3; 
          for (let i = 0; i < len; i++) {
            const item = items[i];
            const title = item.getElementsByTagName("title")[0].textContent; //제목
            const url = item.getElementsByTagName("link")[0].textContent; //기사 url
            const date = item.getElementsByTagName("pubDate")[0].textContent; //작성 날짜
            const pubDate = new Date(date.substring(0, date.indexOf("+")) + "GMT"); //
            const dateTime = new Date(pubDate.getTime() + 9 * 60 * 60 * 1000);
            const kstDateString = dateTime.toISOString().replace("T", " ").slice(0, -5);

            const res = await fetch(url);
            if (res.status === 200) {
              const htmlText = await res.text();
              const parser = new DOMParser();
              const doc = parser.parseFromString(htmlText, "text/html");
              const metaTags = doc.getElementsByTagName("meta");
              var thumbnail;
              for (var j = 0; j < metaTags.length; j++) {
                if (metaTags[j].getAttribute("name") == "twitter:image") {
                  thumbnail = metaTags[j].getAttribute("content");
                  break;
                }
              }
              const articleBody = doc.getElementsByClassName("caas-body")[0];
              const paragraphs = articleBody ? articleBody.getElementsByTagName("p") : [];
              let articleContent = "";
              for (let j = 0; j < paragraphs.length; j++) {
                articleContent += paragraphs[j].textContent;
              }
              const aiScore = await getNatural(title) * 100;
              const titleTranslation = await getTranslation(title);
              list.push({
                title: titleTranslation,
                url: url,
                aiScore: Math.floor(aiScore),
                stock: stockList.docs[k].data().symbol,
                thumbnail: thumbnail,
                article: articleContent,
                pubDate: new Date(pubDate),
                date: kstDateString,
              });
            } else {
              console.log("Failed to fetch page.");
            }
          }
          for (var n = 0; n < list.length; n++) {
            admin.firestore()
              .collection(`stockList/${stockList.docs[k].id}/relevantNews`)
              .doc(n.toString())
              .set(list[n], { merge: true });
          }
        })
        .catch((err) => console.log(err));
    }
  });
