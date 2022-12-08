#! /bin/bash

# Script to generate html pages from the images in the image folder 
# and the text files in the image folders

# Delete all the html files in the html folder
rm -f *.html

# Save contents of template files to a variable
homeTemplate=$(cat templates/homeTemplate.html)
albumTemplate=$(cat templates/albumTemplate.html)

# The HTML for the homepage cover element
homeElementTemplate="<a href='NAME.html' class='albumcover'>
                <img src='images/NAME/FIRSTIMAGE' alt='NAME' class='image'>
                <div class='overlay'>
                    <div class='text'>NAME</div>
                </div>
            </a>
            "

contentElementTemplate="<img src='PATH' alt='PATH'></img>

"

textElementTemplate="<div class='smalltext'>TEXT</div>

"

navElementTemplate="<a href='NAME.html'>NAME</a>

"

finalHomeElement=""
finalNavElement=""

# Loop through all folders in the images folder

for folder in images/*; do
    # navbar bits

    # Get the name of the folder
    name=$(basename "$folder")
    # Get the first image in the folder
    firstImage=$(ls "$folder" | head -n 1)
    navElement=$(echo "$navElementTemplate" | sed "s/NAME/$name/g")
    finalNavElement="$finalNavElement$navElement"

done

for folder in images/*; do
    # HOMEPAGE BITS

    # Get the name of the folder
    name=$(basename "$folder")

    # Get the first image in the folder
    firstImage=$(ls "$folder" | head -n 1)

    # Create the html for the cover element
    homeElement=$(echo "$homeElementTemplate" | sed "s/NAME/$name/g" | sed "s/FIRSTIMAGE/$firstImage/g")

    # Add the cover element to the final homepage template
    finalHomeElement="$finalHomeElement$homeElement"


    # ALBUM PAGE BITS

    # Create the new html for the album page
    newHtml=$albumTemplate
    
    content=""

    # If there is a text file in the folder, read its content, and add it to the html
    if [ -f "$folder"/*.txt ]; then
        text=$(cat "$folder"/*.txt)
        textElement=$(echo "$textElementTemplate" | sed "s/TEXT/$text/g")
        content="$content$textElement"
    fi


    # For each photo in the folder, add it to the html
    for image in "$folder"/*; do
        newTemplate=$(echo "$contentElementTemplate" | sed "s@PATH@$image@g")
        content="$content$newTemplate"
    done

    # Replace content field with content variable and nav elements
    newHtml=$(echo $newHtml | sed "s@CONTENT@$content@g" | sed "s@NAV@$finalNavElement@g")
    
    # Create new file for the album page
    newFile="$name.html"
    echo "$newHtml" > "$newFile"
    

done

# Save the updated homepage to index.html

homeTemplate=$(echo "${homeTemplate/<!-- CONTENT -->/$finalHomeElement}")
echo "${homeTemplate//<!-- NAV -->/$finalNavElement}" > index.html

echo "Done"