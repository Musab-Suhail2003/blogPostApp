const express = require('express');
const router = express.Router();
const {createBlogEntry, getBlogsByAuthor, updateComment, deleteBlogEntry} = require('../controllers/blogController');

router.post('/blog', createBlogEntry);
router.get('/blogs/:authorId', getBlogsByAuthor);
router.put('/comment', updateComment);
router.delete('/blog/:blogId', deleteBlogEntry);

module.exports = router;