echo "Removing old /E/Craftie"
rm -rf /e/Craftie
rm -rf /e/Craftie_GIT
echo "Copying over current Craftie => /E/Craftie"
cp -r "/c/Program Files (x86)/World of WarCraft/_anniversary_/Interface/AddOns/Craftie" /e/Craftie
echo "Copying over current Craftie => /E/Craftie_GIT"
cp -r "/c/Program Files (x86)/World of WarCraft/_anniversary_/Interface/AddOns/Craftie" /e/Craftie_GIT

echo "Cleaning up .git .vscode"
rm /e/Craftie/.gitignore
rm /e/Craftie/package.sh
rm -rf /e/Craftie/.vscode/
rm -rf /e/Craftie/.git/
rm -rf /e/Craftie/notes/
echo "Done!"
