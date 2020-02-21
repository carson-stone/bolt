const express = require('express');
const router = require('express').Router();
const cors = require('cors');
const mongoose = require('mongoose');

require('dotenv').config();

let app = express();
app.use(express.urlencoded());
app.use(express.json());
app.use(cors());

const uri = process.env.ATLAS_URI;

mongoose.connect(uri, {
  useNewUrlParser: true,
  useCreateIndex: true,
  useUnifiedTopology: true
});

const connection = mongoose.connection;
connection.once('open', () => {
  console.log('connected to mongoDB');
});

router.route('/').get((req, res) => {
  console.log('request made to route path');
  res.json('route path request');
});

const userRouter = require('./routers/userRouter.js');
const boltRouter = require('./routers/boltRouter.js');
app.use('/', router);
app.use('/users', userRouter);
app.use('/bolts', boltRouter);

const port = process.env.PORT || 5000;

app.listen(port, () => {
  console.log('listening on port ' + port);
});
