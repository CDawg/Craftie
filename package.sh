echo "Removing old /E/Craftieie"
rm -rf /e/Craftieie
rm -rf /e/Craftieie_GIT
echo "Copying over current Craftieie => /E/Craftieie"
cp -r "/c/Program Files (x86)/World of WarCraftie/_anniversary_/Interface/AddOns/Craftieie" /e/Craftieie
echo "Copying over current Craftieie => /E/Craftieie_GIT"
cp -r "/c/Program Files (x86)/World of WarCraftie/_anniversary_/Interface/AddOns/Craftieie" /e/Craftieie_GIT

echo "Cleaning up .git .vscode"
rm /e/Craftieie/.gitignore
rm /e/Craftieie/package.sh
rm -rf /e/Craftieie/.vscode/
rm -rf /e/Craftieie/.git/
echo "Done!"
