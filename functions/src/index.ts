import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
//import { DocumentBuilder } from 'firebase-functions/lib/providers/firestore';
//import { DocumentBuilder } from 'firebase-functions/lib/providers/firestore';
//import { DocumentBuilder } from 'firebase-functions/lib/providers/firestore';
admin.initializeApp();

const db = admin.firestore();
const fcm = admin.messaging();
//var personFrom: string | functions.Change<functions.firestore.DocumentSnapshot>;

export const sendToDevice = functions.firestore
    .document('messages/{groupChatId}/{chatId}/{message}')
    .onCreate(async (snapshot: { data: () => any; }) => {


        const message = snapshot.data();
        if (message != null) { 
            const querySnapshot = await db
                .collection('messages')
                .doc(message.idTo)
                .collection('tokens')
                .get();

        //console.log(querySnapshot);


        // functions.firestore
        //     .document('messages/{user}').onCreate(async (snapshot: { data: () => any; }) => {
        //         const personFrom = snapshot.data();
        //     }

        // var personFromData = personFrom.data();
        
        
        
        //const personFrom = await db.collection('messages').doc(message.idFrom).get();
        //const data = (await personFrom).data; 

        //var name = data.nickname;

        const tokens = querySnapshot.docs.map((snap: { id: any; }) => snap.id);

        const payload: admin.messaging.MessagingPayload = {
            notification: {
                title: "New Message from " + message.personFrom + "!",
                body: message.content,
                icon: 'your-icon-url',
                click_action: 'FLUTTER_NOTIFICATION_CLICK'
            }
        };

        return fcm.sendToDevice(tokens, payload);
        
        } else {
            return undefined
        }
    });


// export const getPersonFrom = functions.firestore
//     .document('active/{user}')
//     .onCreate(async (snapshot: { data: () => any; }) => {
//         const data = snapshot.data();
//         personFrom = data.name;
//     });  