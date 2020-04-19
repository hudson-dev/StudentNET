import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
admin.initializeApp();

const db = admin.firestore();
const fcm = admin.messaging();

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

        console.log("testing");
        console.log(message.idTo);
        console.log(querySnapshot);

        //const personFrom = db.collection('messages').doc(message.idFrom).data();

        const tokens = querySnapshot.docs.map((snap: { id: any; }) => snap.id);

        const payload: admin.messaging.MessagingPayload = {
            notification: {
                title: "New Message",
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
