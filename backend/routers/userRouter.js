const router = require('express').Router();
const User = require('../models/userModel');
const Bolt = require('../models/boltModel');

router.route('/').get((req, res) => {
  console.log('getting users');
  User.find()
    .then(users => res.json(users))
    .catch(err => res.status(400).json(err));
});

router.route('/register').post((req, res) => {
  console.log('adding user');
  const { username } = req.body;
  new User({ username })
    .save()
    .then(() => res.json('user added'))
    .catch(err => res.status(400).json(err));
});

router.route('/login').post((req, res) => {
  console.log('authenticating user');
  const { username } = req.body;
  User.findOne({ username: username })
    .then(user => {
      if (user === null) {
        res.json('user login failed');
      } else {
        res.json(`user authenticated:${user._id}`);
      }
    })
    .catch(err => res.status(400).json(err));
});

router.route('/:id/feed').get((req, res) => {
  const id = req.params.id;
  let feed = [];
  console.log(`getting feed for ${id}`);

  User.findById(id)
    .then(async user => {
      for (followed of user.following) {
        let bolts = await Bolt.find({ user_id: followed });
        feed.push(...bolts);
      }
      res.json(feed);
    })
    .catch(error => res.status(400).json('error: ' + error));
});

router.route('/:id/bolts').get((req, res) => {
  console.log(`getting bolts for ${req.params.id}`);
  Bolt.find({ user_id: req.params.id })
    .then(bolts => res.json(bolts))
    .catch(error => res.json('error: ' + error));
});

router.route('/follow').post((req, res) => {
  console.log(`making ${req.body.id} follow ${req.body.followed}`);
  User.findByIdAndUpdate(
    { _id: req.body.id },
    { $push: { following: req.body.followed } }
  )
    .then(() => res.json('successfully followed'))
    .catch(error => res.json('error: ' + error));
});

module.exports = router;
