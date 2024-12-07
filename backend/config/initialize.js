const mongoose = require('mongoose');

// User Schema
const UserSchema = new mongoose.Schema({
  name: { type: String, required: true },
  emailAddress: { type: String, required: true, unique: true },
  author: {
    bio: String,
    expertise: [String]
  }
});

// Tag Schema
const TagSchema = new mongoose.Schema({
  value: { type: String, required: true, unique: true }
});

// Blog Schema
const BlogSchema = new mongoose.Schema({
  name: { type: String, required: true },
  URL: { type: String, required: true },
  author: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  blogEntry: [{
    article: { type: String, required: true },
    publishDate: { type: Date, default: Date.now },
    comment: [{
      comment: { type: String, required: true },
      commentDate: { type: Date, default: Date.now },
      commentBy: { type: mongoose.Schema.Types.ObjectId, ref: 'User' }
    }]
  }]
});

// Models
const User = mongoose.model('User', UserSchema);
const Tag = mongoose.model('Tag', TagSchema);
const Blog = mongoose.model('Blog', BlogSchema);

// Database Initialization Function
async function initializeBlogApp() {
  try {
    // Connect to MongoDB
    await mongoose.connect('mongodb://localhost:27017/BlogApp', {
      useNewUrlParser: true,
      useUnifiedTopology: true
    });

    // Clear existing data
    await User.deleteMany({});
    await Tag.deleteMany({});
    await Blog.deleteMany({});

    // Create Users
    const users = await User.create([
      {
        name: 'John Doe',
        emailAddress: 'john.doe@example.com',
        author: {
          bio: 'Tech enthusiast and blogger',
          expertise: ['Technology', 'Programming']
        }
      },
      {
        name: 'Jane Smith',
        emailAddress: 'jane.smith@example.com',
        author: {
          bio: 'Travel and lifestyle writer',
          expertise: ['Travel', 'Lifestyle']
        }
      },
      {
        name: 'Mike Johnson',
        emailAddress: 'mike.johnson@example.com',
        author: {
          bio: 'Food and cooking blogger',
          expertise: ['Cooking', 'Recipes']
        }
      }
    ]);

    // Create Tags
    const tags = await Tag.create([
      { value: 'Technology' },
      { value: 'Travel' },
      { value: 'Cooking' },
      { value: 'Programming' }
    ]);

    // Create Blogs
    await Blog.create([
      {
        name: 'Tech Insights',
        URL: 'https://techinsights.blog',
        author: users[0]._id,
        blogEntry: [{
          article: 'Introduction to MongoDB',
          comment: [
            {
              comment: 'Great article!',
              commentBy: users[1]._id
            },
            {
              comment: 'Very informative',
              commentBy: users[2]._id
            }
          ]
        }]
      },
      {
        name: 'Culinary Adventures',
        URL: 'https://culinaryadventures.blog',
        author: users[2]._id,
        blogEntry: [{
          article: 'Secrets of Italian Cuisine',
          comment: [
            {
              comment: 'Mouth-watering recipes!',
              commentBy: users[0]._id
            },
            {
              comment: 'Can\'t wait to try these',
              commentBy: users[1]._id
            }
          ]
        }]
      }
    ]);

    console.log('Blog App database initialized successfully');
  } catch (error) {
    console.error('Initialization error:', error);
  } finally {
    await mongoose.connection.close();
  }
}

// Run initialization if script is run directly
if (require.main === module) {
  initializeBlogApp();
}

module.exports = {
  User,
  Tag,
  Blog,
  initializeBlogApp
};