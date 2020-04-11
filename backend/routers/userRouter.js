const router = require('express').Router();
const User = require('../models/userModel');
const Bolt = require('../models/boltModel');

router.route('/').get((req, res) => {
  console.log('getting users');
  User.find()
    .then((users) => res.json(users))
    .catch((err) => res.status(400).json(err));
});

router.route('/:id').get((req, res) => {
  const id = req.params.id;
  console.log(`getting user ${id}`);
  User.findById(id)
    .then((user) => res.json(user))
    .catch((err) => res.status(400).json(err));
});

router.route('/register').post((req, res) => {
  const { username } = req.body;
  console.log(`adding user ${username}`);
  new User({ username, profilePic: '', phone: '', email: '' })
    .save()
    .then(() => res.json('user added'))
    .catch((err) => res.status(400).json(err));
});

router.route('/login').post((req, res) => {
  console.log('authenticating user');
  const { username } = req.body;
  User.findOne({ username: username })
    .then((user) => {
      if (user === null) {
        res.json('user login failed');
      } else {
        res.json(`user authenticated:${user._id}`);
      }
    })
    .catch((err) => res.status(400).json(err));
});

router.route('/:id/updatebio').post((req, res) => {
  console.log('updating bio for user with id=' + req.params.id);
  const { id } = req.params;
  const { bio } = req.body;
  User.findByIdAndUpdate(id, { bio })
    .then(() => res.json('bio updated'))
    .catch((e) => res.json('error: ' + e));
});

router.route('/:id/feed').get((req, res) => {
  const id = req.params.id;
  let feed = [];
  console.log(`getting feed for ${id}`);

  User.findById(id)
    .then(async (user) => {
      for (followed of user.following) {
        let bolts = await Bolt.find({ user_id: followed.id });
        feed.push(...bolts);
      }
      res.json(feed);
    })
    .catch((error) => res.status(400).json('error: ' + error));
});

router.route('/:id/bolt').get((req, res) => {
  console.log(`getting bolt for user ${req.params.id}`);
  Bolt.find({ user_id: req.params.id, parent_bolt_id: '' })
    .then((bolts) => res.json(bolts[0]))
    .catch((error) => res.status(400).json('error: ' + error));
});

router.route('/:id/sparks').get((req, res) => {
  console.log(`getting sparks for user ${req.params.id}`);
  Bolt.find({ user_id: req.params.id, parent_bolt_id: { $ne: '' } })
    .then((bolts) => res.json(bolts))
    .catch((error) => res.status(400).json('error:' + error));
});

router.route('/follow').post((req, res) => {
  const { id, followedId, username, followedUsername } = req.body;
  console.log(`making ${username} follow ${followedUsername}`);
  User.findByIdAndUpdate(
    { _id: id },
    { $push: { following: { id: followedId, username: followedUsername } } }
  )
    .then(() =>
      User.findByIdAndUpdate(
        { _id: followedId },
        { $push: { followers: { id: id, username: username } } }
      ).then(() => res.json('successfully followed'))
    )
    .catch((error) => res.json('error: ' + error));
});

router.route('/unfollow').post((req, res) => {
  const { id, unfollowedId } = req.body;
  console.log(`making ${id} unfollow ${unfollowedId}`);
  User.findByIdAndUpdate(
    { _id: id },
    {
      $pull: {
        following: {
          id: unfollowedId,
        },
      },
    }
  )
    .then(() =>
      User.findByIdAndUpdate(
        { _id: unfollowedId },
        { $pull: { followers: { id: id } } }
      )
    )
    .then(() => res.json('successfully unfollowed'))
    .catch((error) => res.json('error: ' + error));
});

module.exports = router;
