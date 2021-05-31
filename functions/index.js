const functions = require('firebase-functions');
const admin = require('firebase-admin');
const firebase = require('firebase');
const express = require('express');
const cors = require('cors');
const requestExternalAPI = require('request');
const asyncjs = require('async');

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

const baseUrlGoogleBooksAPI = "https://www.googleapis.com/books/v1/";


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
  const { userId } = req.body; // userId is the firebase uid for the user
  await admin.auth().setCustomUserClaims(userId, { admin: true });
  return res.send({ message: 'Success' })
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
      return res.status(500).send(error.toJSON());
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
      return res.status(500).send(error.toJSON());
    }
  })();
});

// Logout user
app.post('/api/auth/logout', checkIfAuthenticated, (req, res) => {
  (async () => {
    try {
      await firebase.auth().signOut();
      return res.status(200).send("logout");
    } catch (error) {
      console.log(error);
      return res.status(500).send(error.toJSON());
    }
  })();
});

// Update user
app.post('/api/auth/updateUser', checkIfAuthenticated, (req, res) => {
  (async () => {
    try {
      await db.collection('users').doc(req.headers.uid)
        .set(req.body, { merge: true });
      return res.status(200).send();
    } catch (error) {
      console.log(error);
      return res.status(500).send(error.toJSON());
    }
  })();
});


// get user by id
app.get('/api/bdd/getUserById', checkIfAuthenticated, (req, res) => {
  (async () => {
    try {
      const doc = await db.collection('users').doc(req.headers.uid).get();
      return res.status(200).send(doc.data());
    } catch (error) {
      console.log(error);
      return res.status(500).send(error.toJSON());
    }
  })();
});


// get popular books
app.get('/api/bdd/popularBooks', (req, res) => {
  (async () => {
    try {
      let url = `${baseUrlGoogleBooksAPI}volumes?q=harry+potter&filter=partial&maxResults=6`;
      requestExternalAPI(url, function (error, response, body) {
        if (error) {
          console.log('error:', error);
          return res.status(500).send(error.toJSON());
        } else {
          let books = JSON.parse(body);
          return res.status(200).send(books.items);
        }
      });
    } catch (error) {
      console.log(error);
      return res.status(500).send(error.toJSON());
    }
  })();
});

// get books by id
app.get('/api/bdd/bookDetail', checkIfAuthenticated, (req, res) => {
  (async () => {
    try {
      let url = `${baseUrlGoogleBooksAPI}volumes/${req.headers.bookid}`;
      requestExternalAPI(url, function (error, response, body) {
        if (error) {
          console.log('error:', error);
          return res.status(500).send(error.toJSON());
        } else {
          return res.status(200).send(JSON.parse(body));
        }
      });
    } catch (error) {
      console.log(error);
      return res.status(500).send(error.toJSON());
    }
  })();
});

// get list user books
app.get('/api/bdd/userListBooks', checkIfAuthenticated, (req, res) => {
  (async () => {
    try {
      let url = `${baseUrlGoogleBooksAPI}volumes/`;
      let response = [];
      let query = db.collection('books_users').where("user_id", "==", req.headers.uid).orderBy("timestamp", "desc").limit(5);
      await query.get().then(querySnapshot => {
        let docs = querySnapshot.docs;
        for (let doc of docs) {
          response.push(doc.data());
        }
      });
      let urls = [];
      for (let i = 0; i < response.length; i++) {
        urls.push(url + response[i].book_id);
      }

      asyncjs.map(urls, function (url, callback) {
        requestExternalAPI(url, function (err, response, body) {
          callback(err, JSON.parse(body));
        })
      }, function (err, books) {
        if (err) {
          return res.status(500).send(err);
        }
        return res.status(200).send(books);
      });

    } catch (error) {
      console.log(error);
      return res.status(500).send(error);
    }
  })();
});

// get list ratings by book ID
app.get('/api/bdd/ratingByBook', checkIfAuthenticated, (req, res) => {
  (async () => {
    try {
      let map = {};
      let ratings = [];
      let doc = await db.collection('ratings').doc(req.headers.bookid).get();
      let result = doc.data();
      map["nbRatings"] = result["nbRatings"];
      map["note"] = result["note"];

      let snap = await db.collection('ratings').doc(req.headers.bookid).collection("comments").orderBy("timestamp", "desc").limit(5).get();
      let docs = snap.docs;
      for (let doc of docs) {
        ratings.push(doc.data());
      }
      map["ratings"] = ratings;
      return res.status(200).send(map);
    } catch (error) {
      console.log(error);
      return res.status(500).send(error);
    }
  })();
});


// get list last user ratings
app.get('/api/bdd/userListRatings', checkIfAuthenticated, (req, res) => {
  (async () => {
    try {
      let ratings = [];
      console.log(req.headers.listbooks);
      let booksId = req.headers.listbooks.split("/");
      for (let id of booksId) {
        let query = db.collection('ratings').doc(id).collection("comments").where("user_id", "==", req.headers.uid).limit(1);
        let res = await query.get();
        if (res.docs.length == 1) {
          let map = res.docs[0].data();
          console.log(map);
          ratings.push(map);
        }
      }
      return res.status(200).send(ratings);
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