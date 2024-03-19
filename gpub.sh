#!/bin/zsh

echo
echo "🚀 :: Run build runner... :: 🚀"
echo "🧹 :: Clean... :: 🧹"

flutter clean 

echo
echo "📚 :: Pub get... :: 📚"

flutter pub get 

echo
echo "📲 :: Pod install... :: 📲"
 
cd ios 
pod install --repo-update 
cd -

echo "✅ :: Done! :: ✅"
echo
