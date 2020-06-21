//requires
const express = require("express");
const app = express();
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const cors = require("cors");
require('dotenv/config');
const route = require("./routes/route")

// middleware

app.use(cors());
app.use(bodyParser.urlencoded({
  extended: true
}));
app.use(bodyParser.json());
app.use('/api',route);

app.use((err, req, res, next) =>
  res.status(500).json({
    message: "an error occured while processing your request",
  })
);



// api/verify  - POST ( takes in a username and verifies if it exists in the db)

// api/register - POST (stores users details into the database)

// api/update-score - PUT (updates the user scores)

// api/report - GET (gets the users filtering with scores)



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
app.listen(process.env.PORT || 3000, () => console.log("Server is running..."));
