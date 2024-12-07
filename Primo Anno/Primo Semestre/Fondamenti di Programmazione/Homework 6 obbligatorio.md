**Traccia:**
It is a quiet December evening, and while it's pouring rain outside
you get a call from your friend Bart, who is not very computer
savvy. After calming him down, he tells you that he went to his PC to
look for the perfect gift, surfing on exotic and alternative
e-commerce sites, doing searches on disparate sites using an automatic
translator. He tells you he ended up on a site with the .atp domain,
thinking it had something to do with tennis, his great passion. After
following a couple of products on the strange site, he noticed that
his browser was responding more slowly and the mouse pointer was
starting to flicker. After a few seconds, a warning message appeared
informing him that he had been infected with the latest generation of
ransomware, which targets sensitive files. Panicked, he remembered
your venture with the Tarahumara sheet music and called you to help
him recover his files. The next day, you go to Bart's house and
analyze the situation: as you thought, the ransomware is the infamous
Burl1(ONE), which encrypts PC files by storing the encryption key
inside images with the .png extension, turning them into intricate
puzzles. Because Bart stores his images on an on cloud service, you
manage to retrieve the original images so you can reconstruct the
ransomware's encryption key and decrypt all his precious files. Will
you be able to find all the keys and recover all the files?
Bart is counting on you!

The Burl1 ransomware stores the encryption key by dividing images with
the .png extension into square tiles and performing or not performing
rotations of the individual tiles of 90, 180 or 270°, that is,
performing one, two or three rotations to the right. The key will
respectively have an 'R' (right) an 'F' (flip) or an 'L' (left),
depending on the rotation made. The absence of rotation reports the
character 'N'.

For each image, it is necessary to reconstruct the encryption key in
the form of a list of strings: each string corresponds to the sequence
of rotations of each tile in a row. So a 100x60 image in which the
tiles are size 20 will hide an encryption key of 15 characters,
organized into three strings of five characters each. In fact, there
will be 5 tiles per row (100//20 = 5) and 3 rows (60//20 = 3). To find
out the rotations performed you have to use the image you retrieved
from the cloud to compare with the encrypted image.

You need to write the function
jigsaw(puzzle_image:str, plain_image:str, tile_size:int, encrypted_file\:str, plain_file\:str) -> list\[str]
that takes as input:
 - the name of the file containing the image with the rotated tiles,
 - the name of the file containing the image with the unrotated tiles,
 - an integer indicating the size of the side of the square tiles, 
 - the name of a text file to be decrypted with the encryption key, and
 - the name in which to save the decrypted file.

The function must reconstruct and return the encryption key hidden in
the image in puzzle_image and use it to decrypt the encrypted file,
saving the plaintext in a file called plain_file. The key is the
sequence of rotations to be made to reconstruct the initial image and
decrypt the input file.

For example, comparing the image in test01_in.png with test01_exp.png
and considering the 20-pixel square tiles, it can be determined that
the rotations applied were
  - 'LFR' for the tiles in the first row,
  - 'NFF' for the tiles in the second row, and
  - 'FNR' for the tiles in the third row.
So the key to be returned will be: \['LFR', 'NFF', 'FNR'].

Decryption of the file is achieved by implementing a transformation
depending on the character of the key in position i, modulo the length of the
key.  For example, if the key is \['LFR', 'NFF', 'FNR'], the key is 9
long, and we need to decrypt the character at position 14 of the input
file, we need to consider the character at position 14%9 = 5 of the
key, i.e., 'F'.
The transformations for decryption are as follows:

  - R = text\[i] replaced by the character with following ord
  - L = text\[i] replaced by the character with previous ord
  - N = remains unchanged
  - F = swap text\[i] with text\[i+1]. If i+1 does not exist, we consider
        the character text\[0].

For example, if the key is LFR and the ecrypted text is BNVDCAP, the
plaintext will be AVOCADO since the decryption will be the following:

step     key      deciphering-buffer
1        LFR      BNVDCAP -> ANVDCAP
         ^        ^
2        LFR      ANVDCAP -> AVNDCAP
          ^        ^
3        LFR      AVNDCAP -> AVODCAP
           ^        ^
4        LFR      AVODCAP -> AVOCCAP
         ^           ^
5        LFR      AVOCCAP -> AVOCACP
          ^           ^
6        LFR      AVOCACP -> AVOCADP
           ^           ^
7        LFR      AVOCADP -> AVOCADO
         ^              ^

**Mia Soluzione:**
```python
import images

def create_tiles(puzzle_image: str, plain_image:str, tile_size:int):
    
    puzzle_image = images.load(puzzle_image)
    plain_image = images.load(plain_image)
    
    img_lines = len(puzzle_image)
    img_rows = len(puzzle_image[0])

    start = 0
    key = []
    
    for i in range(0, img_lines, tile_size):
        start = 0
        for r in range(tile_size, img_rows+1, tile_size):
            tile_puzzle = []
            tile_plain = []
            for l in range(i, i + tile_size):
                tile_puzzle.append(puzzle_image[l][start:r])
                tile_plain.append(plain_image[l][start:r])
            if tile_puzzle == tile_plain:
                key.append('N')
            else:
                tile_puzzle = [list(col[::-1]) for col in zip(*tile_puzzle)]
                if tile_puzzle == tile_plain:
                    key.append('R')
                else:
                    tile_puzzle = [list(col[::-1]) for col in zip(*tile_puzzle)]
                    if tile_puzzle == tile_plain:
                        key.append('F')
                    else:
                        key.append('L')
            start = r
            
    key = ''.join(key)
    return (img_rows // tile_size, key, len(key))

def decrypt(encrypted_file: str, plain_file: str, key: str, key_len: int):
    
   file = open(encrypted_file, 'r', encoding='utf-8')
   en_text = list(file.read())
   file.close()
   
   for i, char in enumerate(en_text):
       
       key_char = key[i%key_len]
       
       if key_char == 'N':
           continue
       elif key_char == 'R':
           en_text[i] = chr(ord(char) + 1)
       elif key_char == 'L':
           en_text[i] = chr(ord(char) - 1)
       elif i + 1 < len(en_text):
           en_text[i] = en_text[i+1]
           en_text[i+1] = char
       else:
           en_text[i] = en_text[0]
           en_text[0] = char
           
   file = open(plain_file, 'w', encoding='utf-8')
   file.write(''.join(en_text))
   file.close()
   
def jigsaw(puzzle_image: str, plain_image: str, tile_size:int, encrypted_file: str, plain_file: str) -> list[str]:
    
    key_sep, key_str, key_len = create_tiles(puzzle_image, plain_image, tile_size)
    key = [key_str[i:i+key_sep] for i in range(0, key_len, key_sep)]
    decrypt(encrypted_file, plain_file, key_str, key_len)
    return key
```