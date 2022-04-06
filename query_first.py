from argparse import ArgumentParser
from astropy import units as u
from astropy.coordinates import SkyCoord
from astroquery.image_cutouts.first import First


def main():
    args = parse_args()
    coords = SkyCoord(
        ra=args.ra, dec=args.dec, unit='deg', frame='icrs')
    image = First.get_images(coords, image_size=args.size*u.arcmin)
    image.writeto(args.image_name)
    return

def parse_args():
    parser = ArgumentParser()
    add = parser.add_argument
    add('cluster')
    add('ra', type=float, help='Right Ascension (deg)')
    add('dec', type=float, help='Declination (deg)')
    add('-i', dest='image_name', default='first.fits')
    add('-s', dest='size', default=20, type=float,
        help='image size (arcmin)')
    args = parser.parse_args()
    return args


main()
