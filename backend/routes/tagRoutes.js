const express = require('express');
const router = express.Router();
const { createTag, getBlogsByTag } = require('../controllers/tagController');

router.post('/', createTag);
router.get('/:tagId/blogs', getBlogsByTag);

module.exports = router;