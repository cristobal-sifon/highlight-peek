cluster=`echo "$1" | tr " " _`
ra=$2
dec=$3

layer="ls-dr9-south"
pixscale=0.262
bands=grz
size=2048

file="fits-cutout?ra=${ra}&dec=${dec}&layer=${layer}&pixscale=${pixscale}&bands=${bands}&size=${size}"
url="https://www.legacysurvey.org/viewer/${file}"

path=previews/$cluster
if [ ! -d $path ]
then
    mkdir $path
fi
wget "$url"

newfile=${cluster}__${bands}.fits
mv "$file" ${path}/$newfile
