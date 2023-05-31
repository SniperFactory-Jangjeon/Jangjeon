const functions = require("firebase-functions");
const admin = require("firebase-admin");

var serviceAccount = require("./jangjeon-8722f-firebase-adminsdk-jwgjc-8ebd3688a9.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

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
