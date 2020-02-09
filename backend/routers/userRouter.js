const router = require('express').Router();
const User = require('../models/userModel');

router.route('/').get((req, res) => {
  console.log('getting users');
  User.find()
    .then(users => res.json(users))
    .catch(err => res.status(400).json(err));
});

router.route('/add').post((req, res) => {
  console.log('adding user');
  const { username } = req.body;
  new User({ username })
    .save()
    .then(() => res.json('user added'))
    .catch(err => res.status(400).json(err));
});

module.exports = router;
