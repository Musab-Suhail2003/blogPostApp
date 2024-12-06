const Tag = require('../models/tagModel');
const Blog = require('../models/blogModel');

exports.createTag = async (req, res) => {
    try {
        const tag = new Tag(req.body);
        await tag.save();
        res.status(201).json(tag);
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
};

exports.getBlogsByTag = async (req, res) => {
    try {
        const blogs = await Blog.find({ tags: req.params.tagId })
            .populate('author')
            .populate('tags');
        res.json(blogs);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};
