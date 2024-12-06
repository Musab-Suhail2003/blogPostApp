const mongoose = require('mongoose');

const TagSchema = new mongoose.Schema({
    value: { 
        type: String, 
        required: true, 
        unique: true 
    }
});

module.exports = mongoose.model('Tag', TagSchema);
