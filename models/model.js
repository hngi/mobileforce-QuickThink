const mongoose = require('mongoose');

const UserSchema = mongoose.Schema({ 
    username : {
        type: String,
    },
    password : {
        type: String,
    },
    score : {
        type: Number,
        default :  0
    },
    date_added : {
        type : Date,
        default : Date.now
    }
});

module.exports = mongoose.model('UserDB',UserSchema);