# Pantonic

This project builds a container with [Pandoc](https://pandoc.org) and [Tectonic](https://tectonic-typesetting.github.io/en-US/) for Markdown Document processing

There are working builds for Ubuntu and Fedora and github actions to automatically compile both.

To use them create environment variables `PANDOC_IMG` `DOCNAME` and optionally, `DOCTEMPLATE` where `DOCTEMPLATE` is a path starting with `/Assets`

Given a directory structure where you have a parent directory with an Assets subdirectory along 
with subdirectoryies for each letter of the alphabet and a child directory for each project
inside of those...

```text
.
..
Assets
A
\
 ABC-Co
B
\
 BCD-Co
```

then run the script provided `publish-md` or create your own.


**pubish-md:**
```shell
#!/bin/bash
if [[ $PANDOC_IMG ]] && [[ $DOCNAME ]]  && [[ $DOCTEMPLATE ]];then

  docker run  -v `pwd`:/data \
              -v `pwd`/../../Assets:/Assets \
              -v `pwd`/../../Assets:/assets \
              $PANDOC_IMG \
              -t latex \
              --pdf-engine=tectonic \
              --from markdown \
              --listings -V linkcolor:blue \
              --template= ${DOCTEMPLATE} \
              --output ${DOCNAME}.pdf \
              "${DOCNAME}.md"

elif  [[ $PANDOC_IMG ]] && [[ $DOCNAME ]];then

  docker run  -v `pwd`:/data \
              -v `pwd`/../../Assets:/Assets \
              -v `pwd`/../../Assets:/assets \
              $PANDOC_IMG \
              -t latex \
              --pdf-engine=tectonic \
              --from markdown \
              --listings \
              -V linkcolor:blue \
              --output ${DOCNAME}.pdf \
              "${DOCNAME}.md"

fi
```
