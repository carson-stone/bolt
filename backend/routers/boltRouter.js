const fs = require('fs');
const multer = require('multer');
const upload = multer();
const router = require('express').Router();
const Bolt = require('../models/boltModel');

router.route('/').get((req, res) => {
  console.log('getting bolts');
  Bolt.find()
    .then((bolts) => res.json(bolts))
    .catch((err) => res.status(400).json(err));
});

router.route('/add').post(upload.any(), (req, res) => {
  console.log(`adding bolt for user with id=${req.body.user_id}`);

  let { user_id, username, description, imageUrl, parent_bolt_id } = req.body;
  if (parent_bolt_id === undefined) {
    parent_bolt_id = '';
  }
  var src = fs.createReadStream(imageUrl);
  var dest = fs.createWriteStream('user_images/' + req.files[0].originalname);
  src.pipe(dest);

  new Bolt({
    user_id,
    username,
    description,
    imageUrl: `https://raw.githubusercontent.com/carson-stone/bolt/master/backend/user_images/${imageUrl}`,
    parent_bolt_id,
  })
    .save()
    .then(() => res.json('bolt added'))
    .catch((err) => res.status(400).json(err));
});

router.route('/add/spark').post((req, res) => {
  const { spark_id, bolt_id } = req.body;
  console.log(`adding spark with id=${spark_id} to bolt wiht id=${bolt_id}`);
  Bolt.findByIdAndUpdate(bolt_id, { $push: { sparks: { bolt_id: spark_id } } })
    .then(() => {
      Bolt.findByIdAndUpdate(spark_id, { parent_bolt_id: bolt_id }).then(() => {
        res.json('spark added');
      });
    })
    .catch((error) => res.status(400).json(error));
});

router.route('/:id').get((req, res) => {
  console.log(`getting bolt with id=${req.params.id}`);
  Bolt.findById(req.params.id)
    .then((bolt) => res.json(bolt))
    .catch((error) => res.status(400).json('error: ' + error));
});

router.route('/:id/sparks').get((req, res) => {
  console.log(`getting sparks for bolt with id=${req.params.id}`);
  Bolt.findById(req.params.id)
    .then((bolt) => {
      let spark_ids = [];
      for (let spark of bolt['sparks']) {
        spark_ids.push(spark['bolt_id']);
      }
      res.json(spark_ids);
    })
    .catch((error) => res.status(400).json('error: ' + error));
});

module.exports = router;
