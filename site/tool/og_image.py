"""Draws web/og.jpg, the 1200x630 picture shown when a link to the site is shared on Facebook, LinkedIn or WhatsApp.

Run from site/ after changing the name, the colours or the lines below: python3 tool/og_image.py
Needs Pillow built with libraqm, which shapes the Arabic line.
"""

import math

from PIL import Image, ImageDraw, ImageFont

WIDTH, HEIGHT = 1200, 630
FONT = 'assets/fonts/Rubik.ttf'
WORDMARK = '../assets/brand/arandas-tech-on-dark.png'

TEAL = (0x0E, 0x5E, 0x6F)
TEAL_DEEP = (0x07, 0x2E, 0x37)
SAND = (0xF5, 0xF1, 0xEA)
MIST = (0xCF, 0xE3, 0xE7)
SAFFRON = (0xE8, 0xA3, 0x3D)


def background():
    """Teal, lit from the upper left and darkening toward the edges."""
    image = Image.new('RGB', (WIDTH, HEIGHT))
    pixels = image.load()
    for y in range(HEIGHT):
        for x in range(WIDTH):
            t = min(1, math.hypot((x - WIDTH * 0.25) / WIDTH, (y - HEIGHT * 0.3) / HEIGHT) / 0.95)
            pixels[x, y] = tuple(int(TEAL[i] * (1 - t) + TEAL_DEEP[i] * t) for i in range(3))
    return image


def font(size, weight, arabic=False):
    layout = ImageFont.Layout.RAQM if arabic else ImageFont.Layout.BASIC
    result = ImageFont.truetype(FONT, size, layout_engine=layout)
    result.set_variation_by_name(weight)
    return result


def main():
    image = background()

    wordmark = Image.open(WORDMARK).convert('RGBA')
    wordmark = wordmark.resize((820, round(wordmark.height * 820 / wordmark.width)), Image.LANCZOS)
    image.paste(wordmark, ((WIDTH - wordmark.width) // 2, 150), wordmark)

    draw = ImageDraw.Draw(image)

    def centred(text, top, text_font, colour, **options):
        width = draw.textlength(text, font=text_font, **options)
        draw.text(((WIDTH - width) / 2, top), text, font=text_font, fill=colour, **options)

    centred('Software company in Amman, Jordan', 342, font(36, 'Medium'), SAND)
    centred('Flutter apps for businesses and agencies · Zirr, our software for shops', 396, font(26, 'Regular'), MIST)
    centred('العرندس للتكنولوجيا · تطبيقات للشركات والوكالات، وبرامج زِرّ للمحلات', 438, font(28, 'Regular', arabic=True),
            MIST, direction='rtl', language='ar')
    draw.rounded_rectangle(((WIDTH - 64) // 2, 515, (WIDTH + 64) // 2, 521), 3, fill=SAFFRON)
    centred('arandas.tech', 538, font(28, 'Medium'), SAFFRON)

    image.save('web/og.jpg', quality=88)


if __name__ == '__main__':
    main()
