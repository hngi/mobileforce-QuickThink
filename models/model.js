const mongoose = require('mongoose');

const UserSchema = mongoose.Schema({ 
    username : {
        type: String,
        required : true,
        unique : true,
    },
    password : {
        type: String,
        required : true,
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