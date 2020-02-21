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
  console.log(`getting feed for ${req.params.id}`);
  User.findById(req.params.id)
    .then(user =>
      res.json([
        {
          imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/f/fb/K2_2006.jpg',
          username: 'carson',
          description: 'from carson'
        },
        {
          imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/f/fb/K2_2006.jpg',
          username: 'mike',
          description: 'from mike'
        },
        {
          imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/f/fb/K2_2006.jpg',
          username: 'carson',
          description: 'from carson'
        },
        {
          imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/f/fb/K2_2006.jpg',
          username: 'mike',
          description: 'from mike'
        }
      ])
    )
    .catch(error => res.status(400).json('error: ' + error));
});

router.route('/:id/bolts').get((req, res) => {
  console.log(`getting bolts for ${req.params.id}`);
  Bolt.find({ user_id: req.params.id })
    .then(bolts => res.json(bolts))
    .catch(error => res.json('error: ' + error));
});

module.exports = router;
