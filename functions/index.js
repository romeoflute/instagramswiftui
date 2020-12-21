const functions = require('firebase-functions');
const admin = require('firebase-admin');
admadmin.initializeApp();
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

exports.onCreateFollower = functions.firestore
.document('/followers/{userId}/userFollowers/{followerId}')
.onCreate( async (snapshot, context) => {

  console.log("Follower created: ", snapshot.id);
  const userId = context.params.userId;
  const followerId = context.params.followerId;

  //create followed users posts reference
  const followedUserPostRef = admin.firestore().collection("myPosts").doc(userId).collection("userPosts")

  //create following user's timeline ref
  const timelinePostsRef = admin.firestore().collection("timeline").doc(followerId).collection("timelinePosts")

  //get followed user's myPosts
  const querySnapshot = await followedUserPostRef.get()

  //add each user post to following user's timeline
  querySnapshot.forEach(doc => {
      if (doc.exists){
          const postId = doc.id;
          const postData = doc.data();
          timelinePostsRef.doc(postId).set(postData);
      }
  })
});

exports.onDeleteFollower = functions.firestore
.document('/followers/{userId}/userFollowers/{followerId}')
.onDelete( async (snapshot, context) => {

  console.log("Follower deleted: ", snapshot.id);
  const userId = context.params.userId;
  const followerId = context.params.followerId;

  //create deleted user's timeline ref
  const timelinePostsRef = admin.firestore().collection("timeline").doc(followerId).collection("timelinePosts").where("ownerId", "==", userId);

  //get deleted followed user's myPosts
  const querySnapshot = await timelinePostsRef.get()

  //remove each user post to following user's timeline
  querySnapshot.forEach(doc => {
      if (doc.exists){
          doc.ref.delete();
      }
  })
});
