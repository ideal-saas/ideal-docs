WORK_DIR := /var/folders/6p/4x2n40xs7zz6p8rj83b63s940000gq/T/opencode/ideal-word
DIAG_DIR := $(WORK_DIR)/diagrams
DOCS_DIR := /Users/rcermeno/ideal-infra/ideal-docs
OUTPUT   := $(DOCS_DIR)/Punto-8-Infraestructura-DIAN-IDEAL.docx
TEMPLATE := $(WORK_DIR)/apa7-reference.docx

SOURCES := $(DOCS_DIR)/punto-8-infraestructura.md \
           $(DOCS_DIR)/punto-8-diagramas.md \
           $(DOCS_DIR)/punto-8-inventario-activos.md \
           $(DOCS_DIR)/punto-8-politicas-seguridad.md

DIAGRAMS := $(DIAG_DIR)/diag1.png \
            $(DIAG_DIR)/diag2.png \
            $(DIAG_DIR)/diag3.png \
            $(DIAG_DIR)/diag4.png \
            $(DIAG_DIR)/diag4b.png \
            $(DIAG_DIR)/diag5.png

.PHONY: all clean diagrams template word install

## Genera el documento Word completo con normas APA 7
all: word

## Instala dependencias necesarias (pandoc, mermaid-cli, python-docx)
install:
	@brew install pandoc
	@npm install -g @mermaid-js/mermaid-cli
	@pip3 install python-docx

## Renderiza los 6 diagramas Mermaid a PNG
diagrams: $(DIAGRAMS)

$(DIAG_DIR)/diag1.png: $(DIAG_DIR)/diag1.mmd
	@mmdc -i $< -o $@ -b white --width 2000

$(DIAG_DIR)/diag2.png: $(DIAG_DIR)/diag2.mmd
	@mmdc -i $< -o $@ -b white --width 1600

$(DIAG_DIR)/diag3.png: $(DIAG_DIR)/diag3.mmd
	@mmdc -i $< -o $@ -b white --width 1800

$(DIAG_DIR)/diag4.png: $(DIAG_DIR)/diag4.mmd
	@mmdc -i $< -o $@ -b white --width 1600

$(DIAG_DIR)/diag4b.png: $(DIAG_DIR)/diag4b.mmd
	@mmdc -i $< -o $@ -b white --width 1400

$(DIAG_DIR)/diag5.png: $(DIAG_DIR)/diag5.mmd
	@mmdc -i $< -o $@ -b white --width 1200

## Genera la plantilla Word con estilos APA 7
template: $(TEMPLATE)

$(TEMPLATE): $(WORK_DIR)/make_template.py
	@python3 $<

## Combina los markdowns y genera el .docx final
word: diagrams template $(WORK_DIR)/documento-completo.md
	@pandoc $(WORK_DIR)/documento-completo.md \
		-o $(OUTPUT) \
		--reference-doc=$(TEMPLATE) \
		--toc \
		--toc-depth=3 \
		-f markdown+pipe_tables+yaml_metadata_block
	@echo "Generado: $(OUTPUT)"

## Combina los 4 markdowns en uno solo con imágenes incrustadas
$(WORK_DIR)/documento-completo.md: $(SOURCES)
	@python3 $(WORK_DIR)/combine_docs.py

## Limpia archivos generados
clean:
	@rm -f $(OUTPUT)
	@rm -f $(DIAGRAMS)
	@rm -f $(TEMPLATE)
	@rm -f $(WORK_DIR)/documento-completo.md
