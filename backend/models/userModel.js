const mongoose = require('mongoose');

const Schema = mongoose.Schema;

const userSchema = new Schema(
  {
    username: {
      type: String,
      required: true,
      unique: true,
      trim: true,
      minlength: 3
    },
    following: [
      {
        id: {
          type: String,
          required: false
        },
        username: {
          type: String,
          required: false
        }
      }
    ],
    followers: [
      {
        id: {
          type: String,
          required: false
        },
        username: {
          type: String,
          required: false
        }
      }
    ]
  },
  {
    timestamps: true
  }
);

module.exports = mongoose.model('user', userSchema);
