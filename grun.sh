#!/bin/zsh
echo
echo "🚀 :: Run build runner... :: 🚀"

flutter pub run build_runner build --delete-conflicting-outputs

fluttergen

echo "✅ :: Done! :: ✅"
echo
