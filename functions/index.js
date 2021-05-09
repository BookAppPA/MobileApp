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
  apiKey: "api-key",
  authDomain: "project-id.firebaseapp.com",
  databaseURL: "https://project-id.firebaseio.com",
  projectId: "project-id",
  storageBucket: "project-id.appspot.com",
  messagingSenderId: "sender-id",
  appID: "app-id",
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

// Middleware
const getAuthToken = (req, res, next) => {
  if (
    req.headers.authorization &&
    req.headers.authorization.split(' ')[0] === 'Bearer'
  ) {
    req.authToken = req.headers.authorization.split(' ')[1];
  } else {
    req.authToken = null;
  }
  next();
};

const checkIfAuthenticated = (req, res, next) => {
  getAuthToken(req, res, async () => {
    try {
      const { authToken } = req;
      const userInfo = await admin
        .auth()
        .verifyIdToken(authToken);
      req.authId = userInfo.uid;
      return next();
    } catch (e) {
      return res
        .status(401)
        .send({ error: 'You are not authorized to make this request' });
    }
  });
};

// Passing & check Admin User
const makeUserAdmin = async (req, res) => {
  const {userId} = req.body; // userId is the firebase uid for the user
  await admin.auth().setCustomUserClaims(userId, {admin: true});
  return res.send({message: 'Success'})
}

const checkIfAdmin = (req, res, next) => {
  getAuthToken(req, res, async () => {
     try {
       const { authToken } = req;
       const userInfo = await admin
         .auth()
         .verifyIdToken(authToken);
 
       if (userInfo.admin === true) {
         req.authId = userInfo.uid;
         return next();
       }
 
       throw new Error('unauthorized')
     } catch (e) {
       return res
         .status(401)
         .send({ error: 'You are not authorized to make this request' });
     }
   });
 };

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
      }, { merge: true });
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
app.post('/api/auth/updateUser', checkIfAuthenticated, (req, res) => {
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
app.post('/api/create', checkIfAuthenticated, (req, res) => {
  (async () => {
    try {
      await db.collection('items').doc('/' + req.body.id + '/')
        .create({ item: req.body.item });
      return res.status(200).send();
    } catch (error) {
      console.log(error);
      return res.status(500).send(error);
    }
  })();
});

// read item
app.get('/api/readBookID/:item_id', checkIfAuthenticated, (req, res) => {
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
app.get('/api/read', checkIfAdmin, (req, res) => {
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
app.put('/api/update/:item_id', checkIfAuthenticated, (req, res) => {
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
app.delete('/api/delete/:item_id', checkIfAuthenticated, (req, res) => {
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