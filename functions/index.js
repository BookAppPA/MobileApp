const functions = require('firebase-functions');
const admin = require('firebase-admin');
const firebase = require('firebase');
const express = require('express');
const cors = require('cors');

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

var serviceAccount = require("./permission.json");
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://book-app-7f51e..firebaseio.com"
});

const config = {
  apiKey: "AIzaSyDkIM4fkJauoBuipNT7qk_rBFbyDxSLeiI",
    authDomain: "book-app-7f51e.firebaseapp.com",
    projectId: "book-app-7f51e",
    storageBucket: "book-app-7f51e.appspot.com",
    messagingSenderId: "276286363904",
    appId: "1:276286363904:web:4527a6dfb3756c9fdcbbe5",
    measurementId: "G-GY017BZWTV"
}

firebase.initializeApp(config);

const db = admin.firestore();
const adminAuth = admin.auth();

const app = express();
app.use(cors({ origin: true }));

app.get('/hello-world', (req, res) => {
  return res.status(200).send('Hello World!');
});

// ######################
// AUTHENTIFICATION
// ######################

//TODO: Ajout Middleware --> https://dev.to/emeka/securing-your-express-node-js-api-with-firebase-auth-4b5f

// Signup user
app.post('/api/auth/signup', (req, res) => {
  (async () => {
      try {
        const user = await adminAuth.createUser({
          email: req.body.email,
          password: req.body.password,
          displayName: req.body.pseudo,
        });
        await db.collection('users').doc(user.uid).set({
          uid: user.uid,
          email: req.body.email,
          pseudo: req.body.pseudo,
        }, {merge: true});
        return res.status(200).send(user.toJSON());
      } catch (error) {
        console.log(error);
        return res.status(500).send(error);
      }
    })();
});

// Login user
app.post('/api/auth/login', (req, res) => {
  (async () => {
      try {
        const userCredential = await firebase.auth().signInWithEmailAndPassword(req.body.email, req.body.password);
        const user = userCredential.user;
        const doc = await firebase.firestore().collection('users').doc(user.uid).get();
        return res.status(200).send(doc.data());
      } catch (error) {
        console.log(error);
        return res.status(500).send(error);
      }
    })();
});

// Update user
app.post('/api/auth/updateUser', (req, res) => {
  (async () => {
      try {
        await db.collection('users').doc(req.body.uid)
            .update(req.body.update);
        return res.status(200).send();
      } catch (error) {
        console.log(error);
        return res.status(500).send(error);
      }
    })();
});


// create item
app.post('/api/create', (req, res) => {
  (async () => {
      try {
        await db.collection('items').doc('/' + req.body.id + '/')
            .create({item: req.body.item});
        return res.status(200).send();
      } catch (error) {
        console.log(error);
        return res.status(500).send(error);
      }
    })();
});

// read item
app.get('/api/readBookID/:item_id', (req, res) => {
  (async () => {
      try {
          const document = db.collection('items').doc(req.params.item_id);
          let item = await document.get();
          let response = item.data();
          return res.status(200).send(response);
      } catch (error) {
          console.log(error);
          return res.status(500).send(error);
      }
      })();
  });

// read all
app.get('/api/read', (req, res) => {
  (async () => {
      try {
          let query = db.collection('items');
          let response = [];
          await query.get().then(querySnapshot => {
          let docs = querySnapshot.docs;
          for (let doc of docs) {
              const selectedItem = {
                  id: doc.id,
                  item: doc.data().item
              };
              response.push(selectedItem);
          }
          });
          return res.status(200).send(response);
      } catch (error) {
          console.log(error);
          return res.status(500).send(error);
      }
      })();
  });

// update
app.put('/api/update/:item_id', (req, res) => {
(async () => {
  try {
      const document = db.collection('items').doc(req.params.item_id);
      await document.update({
          item: req.body.item
      });
      return res.status(200).send();
  } catch (error) {
      console.log(error);
      return res.status(500).send(error);
  }
  })();
});

// delete
app.delete('/api/delete/:item_id', (req, res) => {
(async () => {
  try {
      const document = db.collection('items').doc(req.params.item_id);
      await document.delete();
      return res.status(200).send();
  } catch (error) {
      console.log(error);
      return res.status(500).send(error);
  }
  })();
});


exports.app = functions.https.onRequest(app);