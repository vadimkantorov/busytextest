# https://gist.github.com/vadimkantorov/27ee19d130c413073bedd627c1b6a41e

PDFVIEWER = /mnt/c/Users/vadim/AppData/Local/SumatraPDF/SumatraPDF.exe -reuse-instance

NAME = $(notdir ${CURDIR})

CLEANEXT = .log .blg .text.bak .aux .bbl .brf .bcf -blx.bib .toc .lof .lot .run.xml .syntex.gz .out .snm .nav .vrb ~

$(NAME).pdf $(NAME).bbl front.pdf back.pdf: *.tex
#	-pdflatex --no-shell-escape --interaction=batchmode front.tex
#	-pdflatex --no-shell-escape --interaction=batchmode back.tex
	-pdflatex --no-shell-escape --interaction=nonstopmode --draftmode $(basename $@) > $(NAME)_0.log
	-bibtex8  --8bit                                                  $(basename $@) #> $(NAME)_2.log
	-pdflatex --no-shell-escape --interaction=nonstopmode --draftmode $(basename $@) > $(NAME)_1.log
	-pdflatex --no-shell-escape --interaction=batchmode               $(basename $@)
clean:
	find . \( -name $(NAME).pdf $(addprefix -o -name \*, $(CLEANEXT)) \) -delete

stamp:
	cp $(NAME).pdf $(NAME)_$(shell date +'%Y%m%d_%H%M').pdf

view:
	-$(PDFVIEWER) $(NAME).pdf &
