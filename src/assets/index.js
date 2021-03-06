require('./styles/main.scss');

var config = {
  databaseURL: 'https://hacker-news.firebaseio.com'
};

var fireApp = firebase.initializeApp(config);
var Elm = require('../Main');
var app = Elm.Main.fullscreen();

app.ports.getItemIds.subscribe(function (filter) {
  fireApp
    .database()
    .ref('v0/' + filter)
    .limitToFirst(30)
    .on('value', function (snapshot) {
      app.ports.itemIds.send(snapshot.val());
    });
});

app.ports.getItemData.subscribe(function (itemIds) {
  fireApp
    .database()
    .ref('v0/item/' + itemIds[itemIds.length - 1])
    .on('value', function (snapshot) {
      app.ports.itemData.send([itemIds, snapshot.val()]);
    });
})
