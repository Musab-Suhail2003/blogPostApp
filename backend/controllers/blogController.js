const Blog = require('../models/blogModel')

const createBlogEntry = async (req, res) => {
    try {
      const { authorId, name, URL, article, tags, comments } = req.body;
      
      const blog = await Blog.findOneAndUpdate(
        { author: authorId, name, URL },
        { 
          $push: { 
            blogEntries: {
              article,
              comments: comments || []
            },
            tags: { $each: tags || [] }
          }
        },
        { upsert: true, new: true }
      );
  
      res.status(201).json(blog);
    } catch (error) {
      res.status(400).json({ message: error.message });
    }
  };
  
  const getBlogsByAuthor = async (req, res) => {
    try {
      const { authorId } = req.params;
      const blogs = await Blog.find({ author: authorId })
        .populate('author', 'name emailAddress')
        .populate('blogEntries.comments.commentBy', 'name');
      
      res.json(blogs);
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  };
  
  const updateComment = async (req, res) => {
    try {
      const { blogId, entryId, commentId, newComment } = req.body;
      
      const blog = await Blog.findOneAndUpdate(
        { 
          _id: blogId, 
          'blogEntries._id': entryId,
          'blogEntries.comments._id': commentId 
        },
        { 
          $set: { 
            'blogEntries.$[entry].comments.$[comment].comment': newComment,
            'blogEntries.$[entry].comments.$[comment].commentDate': new Date()
          }
        },
        { 
          arrayFilters: [
            { 'entry._id': entryId },
            { 'comment._id': commentId }
          ],
          new: true 
        }
      );
  
      res.json(blog);
    } catch (error) {
      res.status(400).json({ message: error.message });
    }
  };
  
  const deleteBlogEntry = async (req, res) => {
    try {
      const { blogId } = req.params;
      
      const result = await Blog.findByIdAndDelete(blogId);
      
      if (!result) {
        return res.status(404).json({ message: 'Blog not found' });
      }
  
      res.json({ message: 'Blog deleted successfully' });
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  };

module.exports = {createBlogEntry, deleteBlogEntry, updateComment, getBlogsByAuthor}