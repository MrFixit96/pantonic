# Pantonic

This project builds a container with [Pandoc](https://pandoc.org) and [Tectonic](https://tectonic-typesetting.github.io/en-US/) for Markdown Document processing

There are working builds for Ubuntu and Fedora and github actions to automatically compile both.

To use them create environment variables `PANDOC_IMG` `DOCNAME` and optionally, `DOCTEMPLATE`

then run the script provided `publish-md.sh` or create your own.


**pubish-md.sh:**

#!/bin/bash
if [[ $PANDOC_IMG ]] && [[ $DOCNAME ]]  && [[ $DOCTEMPLATE ]];then

  docker run  -v `pwd`:/data -v `pwd`/../Assets:/Assets -v `pwd`/../Assets:/assets $PANDOC_IMG -t latex --pdf-engine=tectonic --from markdown --listings -V linkcolor:blue --template= ${DOCTEMPLATE} --output ${DOCNAME}.pdf "${DOCNAME}.md"

elif  [[ $PANDOC_IMG ]] && [[ $DOCNAME ]];then

  docker run  -v `pwd`:/data -v `pwd`/../Assets:/Assets -v `pwd`/../Assets:/assets $PANDOC_IMG -t latex --pdf-engine=tectonic --from markdown --listings -V linkcolor:blue --output ${DOCNAME}.pdf "${DOCNAME}.md"

fi
