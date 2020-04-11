const mongoose = require('mongoose');

const Schema = mongoose.Schema;

const userSchema = new Schema(
  {
    username: {
      type: String,
      required: true,
      unique: true,
      trim: true,
      minlength: 4,
    },
    following: [
      {
        id: {
          type: String,
          required: false,
        },
        username: {
          type: String,
          required: false,
        },
      },
    ],
    followers: [
      {
        id: {
          type: String,
          required: false,
        },
        username: {
          type: String,
          required: false,
        },
      },
    ],
    name: {
      type: String,
      required: false,
    },
    email: {
      type: String,
      required: false,
      trim: true,
    },
    phone: {
      type: String,
      required: false,
      trim: true,
    },
    profilePic: {
      type: String,
      required: false,
    },
    bio: {
      type: String,
      required: false,
    },
  },
  {
    timestamps: true,
  }
);

module.exports = mongoose.model('user', userSchema);
