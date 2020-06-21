const express = require("express");
const router = express.Router({ automatic405: true });

const Users = require('../models/model');
// const route = ()=>{console.log('Hello route');


// api/verify  - POST ( takes in a username and verifies if it exists in the db)

// api/register - POST (stores users details into the database)

// api/update-score - PUT (updates the user scores)

// api/report - GET (gets the users filtering with scores)

// api/report-limit - GET (gets the users, limiting with "limit" filtering with scores)


router.get('/report', async(req,res) => {
    try {
        const users = await Users.find().
        sort({score : -1});
        res.json(users);
    } catch (error) {
        res.json({
            message : error
        });
    }
});

// get top ${limit} users
// @params == limit

router.get('/report-limit', async (req, res)=>{
    try {
        const users = await Users.find().limit(parseInt(req.body.limit)).
        sort({score : -1});
        res.json(users);
    } catch (error) {
        res.json({
            message : error
        });
    }
    // console.log("no limit");
    
})

router.post('/register', async (req,res) =>{
    const newUser = new Users({
        username : req.body.username,
        password : req.body.password
    });
    try {
        const saveUser = await newUser.save();
        return res.status(200).json({
            message : `Registration Successful for ${saveUser.username}`,
        })
    } catch (error) {
        res.json({
            message : error
        })
    }

})

router.post('/verify', async (req,res) =>{
    try {
        const users = await Users.findOne(
        {username:req.body.username}, (err,data) =>{
            if (err) return res.status(500).send(err);
            if (data) {
                let uname = data.username;
                if( data.toString() !== "" ){
                    return res.status(200).json({
                        username_status : 1,
                        message : "Username already exists",
                        }
                )
                }
                else{
                    return res.status(200).json({
                        username_status : 0,
                        message : "Username fine"
                        }
                )
                }
            }
        })

    } catch (error) {
        res.json({
            message : error
        });
    }
})

router.put('/update-score', async(req,res) =>{
    try {
        let user_score = 0;
        const users = await Users.findOne(
        {username:req.body.username}, (err,data) =>{
            if (err) return res.status(500).send(err);
            if (data.toString !== "") {
                user_score = parseInt(data.score) + req.body.point
                // return user_score
                console.log(user_score);
                
            }
        })
        await Users.updateOne({username : req.body.username}, {
            username : req.body.username,
            score : user_score
        });
        return res.status(200).json({
            message : `Update Successful for ${users.username}`,
        })
    }catch(err){
        res.json({
            message : error
        });
    }
})
module.exports = router;