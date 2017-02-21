# How to get all English books from Project Gutenberg?

The `download_books.sh` script is an adapted version from:
https://www.exratione.com/2014/11/how-to-politely-download-all-english-language-text-format-files-from-project-gutenberg/


In case you want to download all books in English and in `.txt` format from project Gutenberg you can make use of these scripts.

The Vagrantfile runs with the Digital Ocean provisioner. That is, it creates a droplet at Digital Ocean, on which the `download_books.sh` script will download all the books as zipped text files. After all books are downloaded the script creates a `.tar` archive, which you can copy to your local machine with

```bash
vagrant scp
```
./zip.sh

```bash
#!/bin/bash

DIR="$( cd "$( dirname "$0" )" && pwd)"
# File containing the list of zipfile URLs.
ZIP_LIST="${DIR}/zipfileLinks.txt"
# A subdirectory in which to store the zipfiles.
ZIP_DIR="${DIR}/zipfiles"
# A directory in which to store the unzipped files.
UNZIP_DIR="${DIR}/files"

for ZIP_FILE in $(find ${ZIP_DIR} -name '*.zip')
do
  UNZIP_FILE=$(basename ${ZIP_FILE} .zip)
  UNZIP_FILE="${UNZIP_DIR}/${UNZIP_FILE}.txt"
  # Only unzip if not already unzipped. This check assumes that x.zip unzips to
  # x.txt, which so far seems to be the case.
  if [ ! -f "${UNZIP_FILE}" ] ; then
    unzip -o "${ZIP_FILE}" -d "${UNZIP_DIR}"
  else
    echo "${ZIP_FILE##*/} already unzipped. Skipping."
  fi
done

find files/ -name "*.txt" | zip books_txt_archive.zip -@
```



2017-02-16 14:27:18
2017-02-17 17:51:10

ls -ltr zipfiles/ | wc -l
37237
