#!/bin/bash
set -e
cd "$(dirname "$0")"

TS=$(date +%Y%m%d%H%M)
OUT="../punto-8-infraestructura_${TS}.html"
LATEST="../punto-8-infraestructura.html"

cat \
  _header.html \
  _styles.css.html \
  00-cover.html \
  00-toc.html \
  01-objeto.html \
  02-empresa.html \
  03-infra-fisica.html \
  04-infra-tecnologica.html \
  05-arquitectura.html \
  06-seguridad.html \
  07-continuidad.html \
  08-rpo-rto.html \
  09-recursos.html \
  10-sla.html \
  11-anexos.html \
  12-compromiso.html \
  13-firma.html \
  a01-diagramas.html \
  b01-hardware.html \
  b02-software.html \
  b03-plataforma.html \
  c01-politicas.html \
  c02-politicas.html \
  _footer.html \
  > "$OUT"

cp "$OUT" "$LATEST"

echo "✅ punto-8-infraestructura_${TS}.html generated ($(wc -l < "$OUT") lines, $(wc -c < "$OUT") bytes)"
echo "   (also copied to punto-8-infraestructura.html)"
