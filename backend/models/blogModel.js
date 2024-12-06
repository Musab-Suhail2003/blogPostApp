const mongoose = require('mongoose');
const { applyDefaults } = require('./userModel');
const BlogCollection = new mongoose.Schema(
    {
        name: {
            type: String,
            required: true,
            trim: true
        },
        URL: {
            type: String,
            required: true,
            trim: true
        },
        author: {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'User',
            required: true
        },
        blogEntries: [{
            article: {
                type: String,
                required: true
            },
            publishDate: {
                type: Date,
                default: Date.now
            },
            comments: [{
                comment: {
                    type: String,
                    required: true
                },
                commentDate:{
                    type: Date,
                    default: Date.now
                },
                commentBy: {
                    type: mongoose.Schema.Types.ObjectId,
                    ref: 'User'
                }
            }]
        }],
        tags: [{
            type: String,
            ref: 'User'
        }]
    },
    {timestamps: true}
);
const Blog = mongoose.model('Blog', BlogCollection);