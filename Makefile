all: user-manual reference-manual

user-manual: user-manual.html

reference-manual: reference-manual.html

user-manual.html: bin/user-manual/conf.py FORCE
	sphinx-build -n -v -b singlehtml -c bin/user-manual doc bin/sphinx-build

bin/user-manual/conf.py: FORCE
	mkdir -p bin/user-manual
	echo "# generated" > bin/user-manual/conf.py
	echo "master_doc = 'contents'" >> bin/user-manual/conf.py

reference-manual.html: bin/reference-manual/conf.py reference-manual.rst
	sphinx-build -n -v -b singlehtml -c bin/reference-manual bin/sphinx-apidoc-rst bin/sphinx-apidoc

bin/reference-manual/conf.py: FORCE
	mkdir -p bin/reference-manual
	echo "# generated" > bin/reference-manual/conf.py
	echo "import sys" >> bin/reference-manual/conf.py
	echo "import os" >> bin/reference-manual/conf.py
	echo "sys.path.append(os.path.abspath('src'))" >> bin/reference-manual/conf.py
	echo "sys.path.append(os.path.abspath('../../src'))" >> bin/reference-manual/conf.py
	echo "master_doc = 'modules'" >> bin/reference-manual/conf.py
	echo "extensions = ['sphinx.ext.autodoc']" >> bin/reference-manual/conf.py

reference-manual.rst: FORCE
	sphinx-apidoc --force --follow-links --separate --private --output-dir=bin/sphinx-apidoc-rst src

FORCE:
