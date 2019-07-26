#! /bin/bash

first_name=$1
last_name=$2
galleriesFile="./$last_name.txt"
tmp="temp_$last_name.html"

## functions
downloadPage() {
    aria2c -x 4 $url -o $tmp
}

getPageNumbers() {
    url="https://www.foxhq.com/searchgal.php?search=$first_name+$last_name"
    downloadPage
    totalPages=$(lynx -listonly -nonumbers -dump $tmp | grep "javascript" | wc -l)
    rm -vf $tmp
}

collectGalleries() {
    lynx -listonly -nonumbers -dump $tmp | grep $first_name | cut -d "/" -f 4 >> $galleriesFile
    echo "Galleries Dumped to file .. "
}

numberOfImages() {
    imageCount=$(lynx -listonly -nonumbers -dump $tmp  | grep "file" | wc -l)
    if [ "$imageCount" -ge 12 ]; then
        imageCount="12"
    fi
    rm -vf $tmp
}

locationCheck() {
    location="./$last_name"
    if [ ! -d $location ]; then
        mkdir $location
    fi    
}

createDump() {
    getPageNumbers
    echo "Total Number of Pages is $totalPages"

    for page in $(seq 1 $totalPages); do
        url="https://www.foxhq.com/searchgal.php?search=$first_name+$last_name&page=$page"
        downloadPage
        collectGalleries
        rm -vf $tmp
    done
}

downloadGalleries() {
    locationCheck
    for name in $(cat $galleriesFile); do    
        url="https://www.foxhq.com/$name"
        downloadPage

        numberOfImages
        echo "Total number of images in gallery are $imageCount"

        for imageNumber in $(seq 1 $imageCount); do
            aria2c -x 4 -d $location "$url/$imageNumber.jpg" -o $name-$imageNumber.jpg
        done
    done
    rm -vf $galleriesFile
}

createDump
downloadGalleries
