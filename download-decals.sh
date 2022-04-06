cluster=`echo "$1" | tr " " _`
ra=$2
dec=$3

layer="ls-dr9"
pixscale=0.262
bands=grz
size=4096
# for the catalog retrieval
halfwidth=$(echo "scale=5; ${pixscale} * ${size} / 2 / 3600" | bc)

image=${cluster}__img__${bands}.fits
catalog=${cluster}__cat__${bands}.cat
first=${cluster}__img__first.fits

path=previews/$cluster
if [ ! -d $path ]
then
    mkdir $path
fi

url="https://www.legacysurvey.org/viewer"

## DECaLS image
# do not download if it already exists (must erase manually to force for now)
if [ ! -f ${path}/$image ]
then
    file="fits-cutout?ra=${ra}&dec=${dec}&layer=${layer}&pixscale=${pixscale}&bands=${bands}&size=${size}"
    wget "${url}/${file}"
    mv "$file" ${path}/$image
fi

## DECaLS catalog
if [ ! -f ${path}/$catalog ]
then
    # catalog boundaries
    ralo=$(echo "scale=5; ${ra} - ${halfwidth}" | bc)
    rahi=$(echo "scale=5; ${ra} + ${halfwidth}" | bc)
    declo=$(echo "scale=5; ${dec} - ${halfwidth}" | bc)
    dechi=$(echo "scale=5; ${dec} + ${halfwidth}" | bc)
    file="cat.fits?ralo=${ralo}&rahi=${rahi}&declo=${declo}&dechi=${dechi}"
    wget "${url}/${layer}/${file}"
    mv "$file" ${path}/$catalog
fi

## FIRST radio image
if [ ! -f ${path}/$first ]
then
    python query_first.py $cluster $ra $dec -i ${path}/$first
fi
