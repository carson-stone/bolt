const mongoose = require('mongoose');

const Schema = mongoose.Schema;

const boltSchema = new Schema(
  {
    user_id: {
      type: String,
      required: true
    },
    description: {
      type: String,
      required: true
    },
    imageUrl: {
      type: String,
      required: true
    }
  },
  {
    timestamps: true
  }
);

module.exports = mongoose.model('bolt', boltSchema);
