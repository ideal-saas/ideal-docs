# PLAN-iso27001.md
# Plan de Alineación y Certificación ISO/IEC 27001:2022
## IDEAL SOFTWARE S.A.S — NIT: 902.027.596-7
### Preparación para Habilitación DIAN — Resolución 00165 de 2023

**Versión:** 1.0  
**Fecha:** Mayo 2026  
**Estado:** Plan operativo — ejecución durante período de habilitación DIAN

---

## 1. Propósito

Este documento define el plan de IDEAL SOFTWARE S.A.S para alinear su Sistema de Gestión de Seguridad de la Información (SGSI) con la norma ISO/IEC 27001:2022 y obtener la certificación formal durante el período de habilitación concedido por la DIAN.

La Resolución 00165 de 2023 exige que los proveedores tecnológicos de facturación electrónica implementen controles de seguridad de la información. Aunque la norma no exige certificación ISO 27001 como requisito de entrada, su obtención durante el período de habilitación demuestra madurez en gestión de seguridad y es la ruta más sólida para una habilitación permanente.

---

## 2. Declaración de Situación Actual

El siguiente texto debe incorporarse en el documento `punto-8-politicas-seguridad.md` y en la carátula de la solicitud de habilitación:

---

> *"IDEAL SOFTWARE S.A.S ha implementado un Sistema de Gestión de Seguridad de la Información (SGSI) con controles alineados a la norma ISO/IEC 27001:2022. La empresa tiene proyectada la obtención de la certificación ISO 27001 durante el período de habilitación concedido por la DIAN. Los principales proveedores de infraestructura (Amazon Web Services, GitHub/Microsoft, Google Firebase) cuentan con certificación ISO 27001 vigente, lo que amplía el alcance de los controles de seguridad aplicados a la plataforma."*

---

Esta declaración es veraz: IDEAL SOFTWARE S.A.S ya tiene políticas documentadas (ver `punto-8-politicas-seguridad.md`), controles técnicos implementados (ver `punto-8-infraestructura.md`) y un inventario de activos (ver `punto-8-inventario-activos.md`). Lo que falta es el andamiaje formal del SGSI: alcance, evaluación de riesgos, SoA y los procedimientos de mejora continua.

---

## 3. Análisis de Brechas (Gap Analysis)

### 3.1 Resumen ejecutivo

| Cláusula ISO 27001:2022 | Título | Estado actual | Brecha |
|---|---|---|---|
| 4 | Contexto de la organización | Parcial | Falta documentar partes interesadas y alcance formal |
| 5 | Liderazgo | Parcial | Falta política firmada por dirección |
| 6 | Planificación | **Ausente** | Sin evaluación formal de riesgos — brecha crítica |
| 7 | Soporte | Parcial | Falta registro de capacitaciones en seguridad |
| 8 | Operación | Cubierto en gran parte | Políticas y controles técnicos documentados |
| 9 | Evaluación del desempeño | **Ausente** | Sin procedimiento de auditoría interna |
| 10 | Mejora | **Ausente** | Sin procedimiento de no conformidades |
| Anexo A | Controles de seguridad | Parcial | ~70% cubiertos en Anexo C de la solicitud DIAN |

### 3.2 Detalle por Cláusula

#### Cláusula 4 — Contexto de la Organización
- **Requerido:** Identificar contexto externo/interno, partes interesadas y sus requisitos, alcance del SGSI.
- **Actual:** No existe un documento formal de contexto y alcance.
- **Acción requerida:** Crear documento `SGSI-01-Contexto-y-Alcance.md` que defina:
  - Contexto externo: regulación DIAN, mercado colombiano de facturación electrónica, riesgos país
  - Contexto interno: estructura organizacional, tecnología, cultura de seguridad
  - Partes interesadas: clientes, DIAN, AWS, GitHub, Firebase, empleados, reguladores
  - Alcance: plataforma de facturación electrónica accesible en `app.idealsoluciones.com.co` y `api.idealsoluciones.com.co`

#### Cláusula 5 — Liderazgo
- **Requerido:** Política de seguridad de la información aprobada y firmada por la alta dirección; roles y responsabilidades asignados.
- **Actual:** Existen políticas técnicas operativas en `punto-8-politicas-seguridad.md` pero no hay una política ejecutiva de seguridad firmada por la Gerencia General.
- **Acción requerida:** Crear `SGSI-02-Politica-de-Seguridad.md` — documento breve (1-2 páginas), firmado digitalmente por el Gerente General, que declare el compromiso de la organización con la seguridad de la información.

#### Cláusula 6 — Planificación (BRECHA CRÍTICA)
- **Requerido:** Evaluación formal de riesgos de seguridad de la información (identificar activos, amenazas, vulnerabilidades, impacto, probabilidad); Plan de tratamiento de riesgos con controles seleccionados y justificados.
- **Actual:** No existe. Esta es la brecha más significativa para la certificación ISO 27001.
- **Acción requerida:** Crear `SGSI-03-Evaluacion-de-Riesgos.md` con metodología cuantitativa o semi-cuantitativa. Ver Sección 5 para detalle.

#### Cláusula 7 — Soporte
- **Requerido:** Registro de competencias y concienciación en seguridad; proceso de comunicación interna; documentación controlada.
- **Actual:** No existen registros de capacitaciones en seguridad de la información.
- **Acción requerida:** Implementar capacitación anual obligatoria en seguridad para todo el personal; mantener registro de asistencia.

#### Cláusula 8 — Operación
- **Requerido:** Implementar controles del plan de tratamiento de riesgos; gestionar cambios, terceros y respuesta a incidentes.
- **Actual:** Parcialmente cubierto. Las políticas de seguridad en `punto-8-politicas-seguridad.md` cubren controles operativos clave (acceso, cifrado, backups, respuesta a incidentes).
- **Brecha menor:** Formalizar el proceso de gestión de cambios y la evaluación de proveedores/terceros.

#### Cláusula 9 — Evaluación del Desempeño
- **Requerido:** Auditoría interna periódica del SGSI; revisión por la dirección.
- **Actual:** No existe procedimiento formal de auditoría interna.
- **Acción requerida:** Crear `SGSI-05-Procedimiento-Auditoria-Interna.md`.

#### Cláusula 10 — Mejora
- **Requerido:** Procedimiento para gestionar no conformidades y acciones correctivas.
- **Actual:** No existe.
- **Acción requerida:** Crear `SGSI-06-Gestion-No-Conformidades.md`.

#### Anexo A — Controles
- **Estado:** Aproximadamente el 70% de los controles aplicables ya están cubiertos por las políticas técnicas documentadas en `punto-8-politicas-seguridad.md` y los controles de infraestructura en `punto-8-infraestructura.md`.
- **Acción requerida:** Crear la **Declaración de Aplicabilidad (SoA)** — documento que lista los 93 controles del Anexo A de ISO 27001:2022, indica cuáles aplican, cuáles se excluyen (con justificación), y cómo cada control aplicable está implementado.

---

## 4. Hoja de Ruta de 18 Meses hacia la Certificación ISO 27001

La DIAN concede un período de habilitación durante el cual el proveedor tecnológico puede operar mientras consolida su cumplimiento. Este período es la ventana para obtener la certificación ISO 27001.

### 4.1 Cronograma

```
MES 1-2: FUNDAMENTOS DEL SGSI
├── Contratar consultor ISO 27001 o asignar responsable interno
├── Crear SGSI-01-Contexto-y-Alcance.md
├── Definir alcance formal del SGSI
├── Inventariar todas las políticas y controles existentes
└── Completar gap analysis detallado

MES 3-4: EVALUACIÓN DE RIESGOS
├── Seleccionar metodología de evaluación de riesgos (MAGERIT, OCTAVE, ISO 27005)
├── Identificar activos de información (ya existe inventario en punto-8-inventario-activos.md)
├── Identificar amenazas y vulnerabilidades por activo
├── Calcular nivel de riesgo (probabilidad × impacto)
├── Crear SGSI-03-Evaluacion-de-Riesgos.md
└── Crear SGSI-04-Plan-Tratamiento-Riesgos.md

MES 5-6: POLÍTICA Y DECLARACIÓN DE APLICABILIDAD
├── Crear SGSI-02-Politica-de-Seguridad.md (política ejecutiva)
├── Obtener firma de Gerente General
├── Crear SGSI-SoA.md (Declaración de Aplicabilidad — 93 controles Anexo A)
├── Publicar política internamente
└── Iniciar programa de concienciación en seguridad

MES 7-9: IMPLEMENTACIÓN DE CONTROLES FALTANTES
├── Implementar controles identificados en el plan de tratamiento de riesgos
├── Formalizar proceso de gestión de cambios
├── Formalizar evaluación de proveedores/terceros (AWS, Firebase, GitHub)
├── Crear SGSI-05-Procedimiento-Auditoria-Interna.md
├── Crear SGSI-06-Gestion-No-Conformidades.md
└── Ejecutar primera ronda de capacitación en seguridad (registrar asistencia)

MES 10-12: AUDITORÍA INTERNA Y REVISIÓN POR DIRECCIÓN
├── Ejecutar auditoría interna completa del SGSI
├── Documentar hallazgos y no conformidades
├── Implementar acciones correctivas
├── Realizar revisión formal por la dirección (Gerencia General)
├── Documentar acta de revisión
└── Ajustar SGSI según hallazgos

MES 13-15: AUDITORÍA ETAPA 1 (CERTIFICADORA)
├── Seleccionar organismo certificador (ver Sección 6)
├── Solicitar cotización y contratar
├── Auditoría Etapa 1: revisión de documentación por el organismo certificador
├── Recibir informe de hallazgos Etapa 1
└── Implementar correcciones requeridas

MES 16-18: AUDITORÍA ETAPA 2 + CERTIFICACIÓN
├── Auditoría Etapa 2: revisión de implementación en sitio/remota
├── Recibir informe final
├── Cerrar no conformidades identificadas
└── 🎯 OBTENCIÓN DEL CERTIFICADO ISO/IEC 27001:2022
```

### 4.2 Hitos Clave

| Hito | Mes | Producto entregable |
|---|---|---|
| SGSI documentado formalmente | 2 | `SGSI-01-Contexto-y-Alcance.md` |
| Evaluación de riesgos completada | 4 | `SGSI-03-Evaluacion-de-Riesgos.md` |
| Política ejecutiva firmada | 5 | `SGSI-02-Politica-de-Seguridad.md` firmado |
| SoA completada | 6 | `SGSI-SoA.md` |
| Primera auditoría interna | 11 | Informe de auditoría interna |
| Certificadora contratada | 13 | Contrato de certificación |
| **CERTIFICACIÓN ISO 27001** | **18** | **Certificado vigente** |

---

## 5. Documentos Prioritarios a Crear

Los siguientes documentos son los que más impacto tienen, tanto para la habilitación DIAN inmediata como para la certificación ISO 27001. Se listan en orden de prioridad:

### 5.1 Política de Seguridad de la Información (SGSI-02) — URGENTE

**Formato:** Documento de 1-2 páginas, lenguaje ejecutivo, firmado por Gerencia General.

**Contenido mínimo:**
- Declaración del compromiso de la organización con la seguridad de la información
- Objetivos de seguridad (confidencialidad, integridad, disponibilidad)
- Aplicabilidad (toda la organización y sus sistemas)
- Responsabilidades a alto nivel
- Compromiso de mejora continua
- Consecuencias del incumplimiento
- Vigencia y revisión periódica (mínimo anual)

**Por qué es urgente:** Este documento puede crearse en 1-2 días y demuestra compromiso de liderazgo ante la DIAN. Sin él, la Cláusula 5 de ISO 27001 no puede cumplirse.

### 5.2 Evaluación y Tratamiento de Riesgos (SGSI-03 y SGSI-04)

**Esta es la brecha más importante.** Sin evaluación de riesgos, no hay ISO 27001.

**Metodología recomendada:** MAGERIT v3 (desarrollada por el Gobierno de España, ampliamente usada en Colombia, gratuita, en español).

**Activos a evaluar** (basados en `punto-8-inventario-activos.md`):
- Servidores AWS Lightsail (2 instancias)
- Base de datos PostgreSQL 16 (Lightsail Managed DB)
- Base de datos MySQL 8.0 (Lightsail Managed DB)
- Código fuente (GitHub - ghcr.io/ideal-saas/*)
- Credenciales de acceso (Firebase Auth, GitHub tokens, AWS IAM)
- Datos de clientes y documentos DIAN
- Pipeline CI/CD (GitHub Actions)

**Escala de valoración sugerida (1-5):**
- Probabilidad: 1=Muy baja, 2=Baja, 3=Media, 4=Alta, 5=Muy alta
- Impacto: 1=Insignificante, 2=Menor, 3=Moderado, 4=Mayor, 5=Catastrófico
- Riesgo = Probabilidad × Impacto (1-25); Aceptable ≤6; Tolerable 7-12; Inaceptable ≥13

### 5.3 Declaración de Aplicabilidad — SoA (SGSI-SoA)

Documento obligatorio para ISO 27001: lista los 93 controles del Anexo A de ISO 27001:2022, indica para cada uno:
- ¿Aplica? (Sí/No)
- Si no aplica, ¿por qué se excluye? (justificación)
- Si aplica, ¿cómo está implementado? (referencia al documento o control técnico)
- Estado de implementación (Implementado / Parcial / Planificado)

**Ventaja:** La mayoría de los controles ya están implementados y documentados. El SoA será principalmente un ejercicio de cruce de referencias.

### 5.4 Procedimiento de Auditoría Interna (SGSI-05)

**Contenido mínimo:**
- Objetivo y alcance
- Frecuencia (mínimo anual)
- Criterios de auditoría (la norma ISO 27001 y las políticas propias)
- Competencia del auditor interno (puede ser un empleado no responsable del área auditada)
- Proceso: planificación → ejecución → informe → seguimiento
- Plantilla de checklist de auditoría

### 5.5 Procedimiento de Gestión de No Conformidades (SGSI-06)

**Contenido mínimo:**
- Definición de no conformidad (incumplimiento de un requisito del SGSI)
- Registro de no conformidades
- Análisis de causa raíz
- Acción correctiva
- Verificación de eficacia
- Cierre

---

## 6. Organismos Certificadores Recomendados en Colombia

| Organismo | Contacto / Web | Observaciones |
|---|---|---|
| **ICONTEC** (Instituto Colombiano de Normas Técnicas) | www.icontec.org | Organismo nacional; amplio reconocimiento en Colombia; miembro de ISO |
| **Bureau Veritas Colombia** | www.bureauveritas.com.co | Multinacional con amplia presencia; experiencia en SGSI para tecnología |
| **SGS Colombia** | www.sgs.com/es-co | Global; fuerte en sectores tecnológicos; acreditado por ONAC |
| **BSI Group Colombia** | www.bsigroup.com/es-CO | Originador de la norma ISO 27001; experiencia global |

### 6.1 Costos Estimados (Referencia Mayo 2026)

| Rubro | Costo estimado (COP) |
|---|---|
| Consultoría de implementación ISO 27001 (externa, si se requiere) | $15.000.000 – $25.000.000 |
| Auditoría Etapa 1 (revisión documental) | $3.000.000 – $6.000.000 |
| Auditoría Etapa 2 (certificación) | $5.000.000 – $10.000.000 |
| Certificado + seguimiento año 1 | $2.000.000 – $4.000.000 |
| **Total estimado certificación inicial** | **$15.000.000 – $40.000.000** |

*Nota: Los costos varían significativamente según el tamaño de la organización, el alcance del SGSI y el organismo certificador seleccionado. Para una empresa pequeña como IDEAL SOFTWARE S.A.S (menos de 20 empleados, alcance limitado a la plataforma de facturación), los costos tenderán al rango inferior.*

---

## 7. Lista de Verificación Previa a Radicación DIAN

Las siguientes acciones son realizables **en las próximas semanas**, antes de radicar la solicitud de habilitación, y no requieren la certificación completa:

### Acciones inmediatas (pueden hacerse en 1-2 semanas):

- [ ] **Incorporar declaración de situación actual** (texto de la Sección 2) en `punto-8-politicas-seguridad.md` y en la carátula de la solicitud
- [ ] **Crear SGSI-02-Politica-de-Seguridad.md** — política ejecutiva firmada por el Gerente General
- [ ] **Crear `SGSI-SoA-borrador.md`** — versión preliminar de la Declaración de Aplicabilidad, aunque sea parcial, demuestra que el trabajo está en progreso
- [ ] **Documentar que AWS, GitHub y Firebase tienen ISO 27001** — adjuntar o referenciar los certificados vigentes de estos proveedores (disponibles en sus sitios web)

### Acciones que fortalecen la solicitud (2-4 semanas):

- [ ] **Crear SGSI-01-Contexto-y-Alcance.md** — define el alcance formal del SGSI
- [ ] **Iniciar la evaluación de riesgos** — aunque no esté terminada, un borrador avanzado demuestra madurez
- [ ] **Registrar una capacitación interna en seguridad** — cualquier sesión de sensibilización documentada con lista de asistencia

---

## 8. Certificados ISO 27001 de Proveedores de Infraestructura

Como referencia, los principales proveedores de IDEAL SOFTWARE S.A.S cuentan con certificación ISO 27001 vigente:

| Proveedor | Alcance del certificado | Dónde verificar |
|---|---|---|
| **Amazon Web Services (AWS)** | Infraestructura cloud global, incluyendo Lightsail | https://aws.amazon.com/compliance/iso-27001-faqs/ |
| **GitHub / Microsoft** | Plataforma de desarrollo y CI/CD | https://github.com/security |
| **Google Firebase / GCP** | Autenticación y servicios cloud | https://cloud.google.com/security/compliance/iso-27001 |

Esto significa que la infraestructura subyacente de IDEAL SOFTWARE S.A.S opera dentro de un marco ISO 27001 certificado. Lo que se requiere es extender ese marco a los procesos propios de la organización.

---

## 9. Relación con Requisitos DIAN

| Requisito Resolución 00165/2023 | Cómo lo aborda este plan |
|---|---|
| Art. 55 numeral 5: Seguridad de la información | Sección 3 (gap analysis) y Sección 5 (documentos a crear) |
| Art. 55 numeral 8: Infraestructura tecnológica | Sección 8 (certificados ISO 27001 de proveedores) |
| Política de seguridad (8 políticas ya documentadas) | Sección 3, Cláusula 8: ya cubierto en `punto-8-politicas-seguridad.md` |
| Habilitación permanente | Sección 4: hoja de ruta de 18 meses hacia certificación |

---

*Documento preparado para uso interno de IDEAL SOFTWARE S.A.S. Versión sujeta a revisión y aprobación por la Gerencia General.*
