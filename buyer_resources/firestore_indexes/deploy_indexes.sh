#!/bin/bash
echo "Deploying ServeNow Firestore indexes and rules..."
firebase deploy --only firestore:indexes,firestore:rules,storage
echo "Done! Indexes and rules deployed successfully."
