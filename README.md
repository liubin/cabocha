# cabocha

start container

```bash
# docker run -it ghcr.io/liubin/cabocha:main bash
```

start python in container

```bash
root@9af423b6cebc:/tmp# python
Python 2.7.18 (default, Jul  1 2022, 12:27:04) 
[GCC 9.4.0] on linux2
Type "help", "copyright", "credits" or "license" for more information.
```

use cabocha parsing string

```bash
>>> import CaboCha
>>> cp = CaboCha.Parser("-d 20_chuko -P UNIDIC")
>>> print(cp.parseToString("いづれの御時にか、女御、更衣あまたさぶらひたまひけるなかに、いとやむごとなき際にはあらぬが、すぐれて時めきたまふありけり"))
                    いづれの-D                  
                    御時にか、-----------------D
                          女御、-D             |
      更衣あまたさぶらひたまひける-D           |
                            なかに、-------D   |
                                  いと-D   |   |
                            やむごとなき-D |   |
                                    際には-D   |
                                  あらぬが、---D
                                      すぐれて-D
                            時めきたまふありけり
EOS

```
