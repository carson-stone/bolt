const mongoose = require('mongoose');

const Schema = mongoose.Schema;

const boltSchema = new Schema(
  {
    user_id: {
      type: String,
      required: true
    },
    username: {
      type: String,
      required: true
    },
    description: {
      type: String,
      required: false
    },
    imageUrl: {
      type: String,
      required: true
    },
    parent_bolt_id: {
      type: String,
      required: false
    },
    sparks: [
      {
        bolt_id: {
          type: String
        },
        required: false
      }
    ]
  },
  {
    timestamps: true
  }
);

module.exports = mongoose.model('bolt', boltSchema);
