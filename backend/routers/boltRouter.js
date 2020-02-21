const router = require('express').Router();
const Bolt = require('../models/boltModel');

router.route('/').get((req, res) => {
  console.log('getting bolts');
  Bolt.find()
    .then(bolts => res.json(bolts))
    .catch(err => res.status(400).json(err));
});

router.route('/add').post((req, res) => {
  console.log(`adding bolt for user with id=${req.user_id}`);
  const { user_id } = req.body;
  new Bolt({ user_id })
    .save()
    .then(() => res.json('bolt added'))
    .catch(err => res.status(400).json(err));
});

router.route('/:id').get((req, res) => {
  console.log(`getting bolt with id=${req.params.id}`);
  Bolt.findById(req.params.id)
    .then(bolt => res.json(bolt))
    .catch(error => res.status(400).json('error: ' + error));
});

module.exports = router;
