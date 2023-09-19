FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update \
  && apt install -y build-essential autoconf pkg-config mecab swig libmecab-dev mecab-ipadic-utf8 python python-dev wget unzip curl
RUN cd /tmp && wget https://bootstrap.pypa.io/pip/2.7/get-pip.py && python get-pip.py
RUN pip install mecab-python==0.996

# CRF
WORKDIR /tmp
RUN curl -sL -o CRF++-0.58.tar.gz "https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7QVR6VXJ5dWExSTQ"
RUN tar -zxf CRF++-0.58.tar.gz
RUN cd CRF++-0.58 && ./configure && make && make install && ldconfig

# cabocha

WORKDIR /tmp
# RUN curl -sL -o cabocha-0.69.tar.bz2 "https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7SDd1Q1dUQkZQaUU" \
RUN curl -sL -o cabocha-0.69.tar.bz2 "https://distfiles.macports.org/cabocha/cabocha-0.69.tar.bz2" \
  && tar -jxf cabocha-0.69.tar.bz2
RUN cd cabocha-0.69 \
  && ./configure -with-charset=utf-8 \
  && make \
  && make install \
  && ldconfig \
  && pip install python/

# 中古和文UniDic
WORKDIR /tmp
RUN wget https://clrd.ninjal.ac.jp/unidic_archive/2203/UniDic-202203_20_chuko.zip
RUN unzip UniDic-202203_20_chuko.zip 
RUN cd 20_chuko/ \
  && ln -s /var/lib/mecab/dic/ipadic-utf8/dicrc dicrc \
  && mecab -d ./

COPY  cabocharc /usr/local/etc/cabocharc
