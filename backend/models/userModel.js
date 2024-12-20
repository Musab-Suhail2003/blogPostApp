const mongoose = require('mongoose');

const UserCollection = new mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true
  },
  emailAddress: {
    type: String,
    required: true,
    unique: true,
    lowercase: true,
    trim: true,
    match: [/^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$/, 'Please fill a valid email address']
  },
  author: {
    bio: String,
    website: String
  }
}, { timestamps: true });

const User = mongoose.model('User', UserCollection);

module.exports = User;