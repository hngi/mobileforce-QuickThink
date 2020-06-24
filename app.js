//requires
const express = require("express");
const app = express();
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const cors = require("cors");
require('dotenv/config');
const route = require("./routes/route")
const path = require('path')
// middleware

app.use(cors());
app.use(bodyParser.urlencoded({
  extended: true
}));
app.use(bodyParser.json());
// use the express-static middleware
app.use(express.static("public"));
app.use('/api',route);

app.get('/', function(req, res) {
  res.sendFile(path.join(__dirname + '/public/index.html'));
  console.log(path)
});
app.use((err, req, res, next) =>
  res.status(500).json({
    message: "an error occured while processing your request",
  })
);

// Connect to Database, this way you can see any error
const connectDB = async () => {
  try {
    mongoose.connect(process.env.DB_CONNECTION, {
      useNewUrlParser: true,
      useUnifiedTopology: true
    });

    console.log("Connected to DB");
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

// Call connectDB
connectDB();

// start the server listening for requests
app.listen(process.env.PORT || 3001, () => console.log("Server is running..."));
