cluster=`echo "$1" | tr " " _`
ra=$2
dec=$3

layer="ls-dr9-south"
pixscale=0.262
bands=grz
size=2048

output=${cluster}__${bands}.fits

# do not download if it already exists (must erase manually to force for now)
if [ ! -f ${path}/$output ]
then
    file="fits-cutout?ra=${ra}&dec=${dec}&layer=${layer}&pixscale=${pixscale}&bands=${bands}&size=${size}"
    url="https://www.legacysurvey.org/viewer/${file}"

    path=previews/$cluster
    if [ ! -d $path ]
    then
        mkdir $path
    fi
    wget "$url"

    mv "$file" ${path}/$output
fi
