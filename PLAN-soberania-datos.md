# Plan de Cumplimiento: Soberanía de Datos y Transferencia Internacional

**Tipo de documento:** Plan de acción interno — confidencial  
**Empresa:** IDEAL SOFTWARE S.A.S  
**NIT:** 902.027.596-7  
**Elaborado por:** Ricardo Cermeño Bolaño — Director de Tecnología  
**Revisado por:** Felix Palacio Arguelle — Representante Legal  
**Fecha:** Mayo 2026  
**Versión:** 1.0  
**Documento relacionado:** `punto-8-infraestructura.md` (Numeral 8, Art. 55, Resolución 00165/2023)

---

## Tabla de Contenidos

1. [Resumen Ejecutivo](#1-resumen-ejecutivo)
2. [Marco Legal Aplicable](#2-marco-legal-aplicable)
3. [Estado Actual](#3-estado-actual)
4. [Análisis de Riesgo](#4-análisis-de-riesgo)
5. [Acciones Requeridas](#5-acciones-requeridas)
6. [Lista de Verificación Pre-DIAN](#6-lista-de-verificación-pre-dian)
7. [Texto a Insertar en punto-8-infraestructura.md](#7-texto-a-insertar-en-punto-8-infraestructuramd)
8. [Referencias Normativas](#8-referencias-normativas)

---

## 1. Resumen Ejecutivo

IDEAL SOFTWARE S.A.S opera su infraestructura de facturación electrónica sobre **AWS us-east-1 (N. Virginia, Estados Unidos)**. Esta circunstancia genera una pregunta legítima frente a la DIAN: ¿es jurídicamente válido que los datos de contribuyentes colombianos residan en servidores ubicados fuera del territorio nacional?

La respuesta es **sí, bajo condiciones específicas que deben acreditarse formalmente**. El marco jurídico colombiano —encabezado por la Ley 1581 de 2012 y el Decreto 1377 de 2013— permite las transferencias internacionales de datos personales siempre que se acredite un nivel de protección adecuado o se cuente con garantías contractuales suficientes. Amazon Web Services cumple con ambos criterios.

Sin embargo, cumplir con la norma no es suficiente: **debe documentarse y acreditarse ante el regulador**. Este plan detalla las acciones concretas que IDEAL SOFTWARE S.A.S debe ejecutar antes de la presentación ante la DIAN para que el punto de la soberanía de datos no sea un obstáculo en la certificación como Proveedor Tecnológico de Facturación Electrónica.

**Riesgo sin plan:** Objeción de la DIAN durante la evaluación del numeral 8 (infraestructura) por ausencia de documentación de transferencias internacionales, lo que puede resultar en solicitud de información adicional o negación de la habilitación.

**Riesgo con plan ejecutado:** Bajo. La operación en AWS us-east-1 es completamente defendible bajo el marco jurídico vigente con la documentación correcta.

---

## 2. Marco Legal Aplicable

### 2.1 Ley 1581 de 2012 — Protección de Datos Personales (Habeas Data)

La Ley 1581 de 2012 es el régimen general de protección de datos personales en Colombia. Sus disposiciones más relevantes para este plan son:

**Artículo 17 — Deberes de los responsables del tratamiento:**
- Literal k): *"Informar a la autoridad de protección de datos cuando se presenten violaciones a los códigos de seguridad y existan riesgos en la administración de la información de los Titulares."*
- El responsable debe garantizar que los encargados del tratamiento (como AWS) cumplan con las obligaciones de la ley.

**Artículo 21 — Autorización de la SIC:**
- La Superintendencia de Industria y Comercio (SIC) actúa como autoridad de protección de datos en Colombia y puede exigir el cumplimiento de las normas de transferencia internacional.

**Artículos 26 y 27 — Transferencias internacionales:**
- El artículo 26 prohíbe la transferencia a países que no provean niveles adecuados de protección, salvo las excepciones del artículo 27.

**Relevancia para IDEAL SOFTWARE:** Los datos de facturación que la plataforma procesa incluyen RUT, razón social, NIT, direcciones y datos de transacciones económicas de los contribuyentes clientes. Aunque los datos de facturación electrónica son principalmente datos de personas jurídicas (empresas), los datos de sus representantes legales y de personas naturales facturadoras son datos personales protegidos por la Ley 1581.

### 2.2 Decreto 1377 de 2013 — Reglamentación de Transferencias Internacionales

El Decreto 1377 de 2013 reglamenta los artículos 26 y 27 de la Ley 1581 en materia de transferencias internacionales. Sus disposiciones clave son:

**Artículo 26 — Transferencias internacionales de datos:**
> *"La transferencia de datos personales a países que no proporcionan niveles adecuados de protección de datos está prohibida, con excepción de los siguientes casos:*
> *a) Cuando el Titular haya otorgado su autorización expresa e inequívoca para la transferencia.*
> *b) Cuando se trate del intercambio de datos médicos, cuando así lo exija el tratamiento del titular por razones de salud o higiene pública.*
> *c) Cuando se realicen transferencias bancarias o bursátiles.*
> *d) Cuando la transferencia sea necesaria para la ejecución de un contrato entre el titular y el responsable del tratamiento, o para la ejecución de medidas precontractuales tomadas a petición del titular.*
> *e) Cuando la transferencia sea necesaria para la conclusión o ejecución de un contrato celebrado o por celebrar, en interés del titular, entre el responsable y un tercero.*
> *f) Cuando la transferencia sea necesaria para proteger el interés público.*
> *g) Cuando la transferencia sea necesaria para el reconocimiento, ejercicio o defensa de un derecho en un proceso judicial.*
> *h) Cuando la transferencia tenga como destino un país con legislación reconocida como equivalente a la colombiana, o cuando el responsable del tratamiento provea las garantías suficientes."*

**Relevancia para IDEAL SOFTWARE:** La transferencia a AWS us-east-1 cabe en la excepción del literal h) (Estados Unidos con garantías contractuales) y del literal d) (necesaria para la ejecución del servicio contratado por el titular).

### 2.3 Diferencia entre Responsable y Encargado del Tratamiento

Esta distinción es fundamental para el análisis legal:

| Concepto | Definición (Ley 1581, Art. 3) | Rol en este caso |
|----------|-------------------------------|-----------------|
| **Responsable del tratamiento** | Persona natural o jurídica que decide sobre la base de datos y el tratamiento | **IDEAL SOFTWARE S.A.S** |
| **Encargado del tratamiento** | Persona natural o jurídica que realiza el tratamiento por cuenta del responsable | **Amazon Web Services (AWS)** |

AWS no decide qué datos se almacenan, ni para qué se usan, ni quién los accede dentro de la aplicación. AWS simplemente provee la infraestructura de cómputo. Esta distinción tiene implicaciones prácticas importantes:

- AWS no puede vender, ceder ni usar los datos de IDEAL SOFTWARE para sus propios fines
- Las obligaciones frente a los titulares de los datos recaen sobre IDEAL SOFTWARE
- La relación con AWS se regula mediante un contrato de encargo del tratamiento (Data Processing Addendum)

### 2.4 Estados Unidos como País con Nivel de Protección Adecuado

El artículo 26, literal g) del Decreto 1674 de 2019 (modificatorio del Decreto 1377/2013) y la circular 02 de 2015 de la SIC establecen que se consideran países con un nivel adecuado de protección aquellos que:

1. Tienen legislación de protección de datos personales aprobada
2. Son miembros de la OCDE con compromisos en materia de privacidad
3. Han suscrito acuerdos de intercambio de información o tratados con Colombia

Estados Unidos, si bien no tiene una ley federal unificada de privacidad, cuenta con:
- El marco **EU-U.S. Data Privacy Framework** (reconocido por la UE desde 2023)
- Leyes sectoriales: HIPAA (salud), GLBA (financiero), COPPA (menores)
- El **CLOUD Act de 2018** (analizado en detalle en sección 2.6)
- Certificaciones AWS como ISO 27018 específicamente diseñadas para protección de PII en la nube

Adicionalmente, la SIC en su **Concepto 17-244590-2** confirmó que la utilización de servicios cloud en el exterior es válida cuando el encargado del tratamiento ofrece garantías contractuales suficientes, independientemente del país de ubicación de los servidores.

### 2.5 Certificaciones de AWS Relevantes para Protección de Datos

AWS cuenta con las siguientes certificaciones que acreditan controles de seguridad auditados por terceros independientes:

| Certificación | Alcance | Relevancia |
|---------------|---------|-----------|
| **SOC 1 Tipo II** | Controles sobre reportes financieros | Aplicable a servicios que procesan datos financieros |
| **SOC 2 Tipo II** | Seguridad, disponibilidad, integridad, confidencialidad | Directamente aplicable a protección de datos |
| **SOC 3** | Versión pública del SOC 2 | Demostración pública de controles |
| **ISO/IEC 27001:2013** | Sistema de gestión de seguridad de la información | Marco global de seguridad |
| **ISO/IEC 27017:2015** | Controles de seguridad para servicios cloud | Específico para proveedores cloud |
| **ISO/IEC 27018:2019** | Protección de PII en nube pública | **Específicamente diseñado para datos personales en cloud** |
| **PCI DSS Nivel 1** | Estándar de seguridad para datos de tarjetas | Aplicable a datos de pago |
| **CSA STAR Nivel 2** | Seguridad cloud (Cloud Security Alliance) | Transparencia en controles cloud |
| **FedRAMP** | Requerimientos federales de EE.UU. | Nivel de seguridad gubernamental |

**La ISO 27018 es la certificación más relevante** para este plan: es el único estándar internacional creado específicamente para la protección de información de identificación personal (PII) en servicios cloud públicos. Establece que el procesador cloud no puede usar los datos del cliente para sus propios fines, debe notificar al cliente cualquier solicitud gubernamental que permita la ley, y debe proporcionar transparencia sobre ubicación y procesamiento de datos.

### 2.6 AWS Data Processing Addendum (DPA) y las SCCs

AWS ofrece un **Data Processing Addendum (DPA)** que es un contrato vinculante en el que AWS:

1. Se compromete a actuar únicamente como encargado del tratamiento (processor), no como responsable (controller)
2. Establece medidas técnicas y organizativas de seguridad
3. Se compromete a no divulgar datos del cliente salvo instrucción del cliente o requerimiento legal notificable
4. Incluye las **Standard Contractual Clauses (SCCs)** de la Comisión Europea como garantía contractual adicional
5. Establece un proceso de auditoría mediante el cual el cliente puede verificar el cumplimiento

Las **SCCs** son cláusulas contractuales estándar aprobadas por la Comisión Europea que establecen obligaciones de protección equivalentes al GDPR europeo, independientemente de la jurisdicción del procesador. La SIC colombiana ha reconocido las SCCs como mecanismo válido de garantía contractual para transferencias internacionales.

### 2.7 El CLOUD Act de 2018 y su Mitigación

El **Clarifying Lawful Overseas Use of Data Act (CLOUD Act)** de Estados Unidos permite a las autoridades federales norteamericanas requerir a empresas con presencia en EE.UU. (como AWS) la entrega de datos almacenados en servidores en cualquier país, incluso sin orden judicial del país donde se encuentran los servidores.

**Riesgo real vs. riesgo percibido:**

| Aspecto | Evaluación |
|---------|-----------|
| Probabilidad de aplicación | Muy baja para datos de facturación de PyMEs colombianas |
| Tipo de datos afectados | Principalmente datos de inteligencia criminal, terrorismo, fraude financiero transfronterizo |
| Datos de IDEAL SOFTWARE | Datos de facturación de empresas colombianas — sin interés para agencias federales de EE.UU. |

**Mitigaciones contractuales con AWS:**

1. **DPA cláusula de notificación:** AWS se compromete a notificar al cliente cualquier solicitud gubernamental que no esté legalmente prohibida, dando oportunidad de defensa legal
2. **SCCs cláusula II(h)(3):** El procesador debe informar al responsable si recibe un requerimiento que podría afectar la obligación de confidencialidad
3. **AWS Transparency Report:** AWS publica anualmente el número de requerimientos gubernamentales recibidos y rechazados
4. **Cifrado de datos en reposo y en tránsito:** Los datos en AWS Lightsail están cifrados en reposo (AES-256) y en tránsito (TLS 1.3), por lo que incluso ante una entrega forzada, los datos serían ilegibles sin las claves de cifrado del cliente

**Postura recomendada:** El riesgo del CLOUD Act para los datos de facturación de IDEAL SOFTWARE es esencialmente teórico. Sin embargo, debe documentarse en la política de proveedores y en los contratos con clientes como parte de la cláusula de tratamiento de datos.

---

## 3. Estado Actual

### 3.1 Inventario de Datos Transferidos Internacionalmente

Los siguientes datos residen actualmente en servidores AWS us-east-1 (N. Virginia, EE.UU.):

| Categoría de datos | Clasificación | Base de datos | Datos personales involucrados |
|-------------------|:---:|:---:|-------------------------------|
| Datos de empresas clientes | Confidencial | PostgreSQL | Razón social, NIT, dirección, representante legal |
| Datos de usuarios de la plataforma | Confidencial | Firebase (Google) | Nombre, correo, celular |
| Facturas electrónicas generadas | Confidencial | MySQL + PostgreSQL | Nombre, NIT, dirección del adquirente (persona natural) |
| XMLs UBL 2.1 firmados | Confidencial | MySQL | Datos completos del documento tributario |
| Datos de nómina electrónica | Sensible | PostgreSQL | Nombre empleado, cédula, salario, deducciones |
| Logs de acceso | Interno | Grafana Cloud (EU) | IPs, user agents |

**Nota crítica:** Los datos de **nómina electrónica** incluyen información sensible de personas naturales (cédula, salario). Esto eleva la obligación de protección bajo la Ley 1581 a un nivel superior, requiriendo medidas adicionales de seguridad y, posiblemente, autorización expresa de los titulares o una cláusula contractual específica con los clientes empleadores.

### 3.2 Controles Existentes

| Control | Estado | Calificación |
|---------|:---:|:---:|
| Cifrado en tránsito (TLS 1.3) | Implementado | ✅ |
| Cifrado en reposo (AES-256 AWS) | Implementado por AWS | ✅ |
| Acceso restringido a bases de datos | Implementado | ✅ |
| Contrato base con AWS (Customer Agreement) | Aceptado al crear cuenta | ✅ |
| AWS Data Processing Addendum (DPA) firmado | **No verificado** | ⚠️ |
| Registro en SIC como responsable del tratamiento | **Pendiente** | ❌ |
| Política de privacidad publicada | **Pendiente** | ❌ |
| Cláusula de tratamiento de datos en contratos con clientes | **Pendiente** | ❌ |
| Notificación a titulares sobre transferencia internacional | **Pendiente** | ❌ |

### 3.3 Brechas Identificadas

1. **Brecha contractual con AWS:** Aunque el AWS Customer Agreement incluye cláusulas generales de protección de datos, el DPA específico (que incorpora las SCCs y establece compromisos del encargado del tratamiento) debe ser aceptado/firmado explícitamente. Este es el documento que IDEAL SOFTWARE necesita para demostrar a la DIAN y a la SIC que la transferencia internacional tiene garantías contractuales.

2. **Brecha regulatoria con la SIC:** IDEAL SOFTWARE S.A.S no consta en el Registro Nacional de Bases de Datos (RNBD) de la SIC como responsable del tratamiento de datos personales. Este registro es obligatorio conforme al artículo 25 de la Ley 1581 para empresas que traten datos de más de 500 titulares o que traten datos sensibles.

3. **Brecha frente a clientes:** Los contratos de servicio con los clientes no incluyen una cláusula de tratamiento de datos personales que informe sobre la transferencia internacional y obtenga el consentimiento explícito o establezca la base contractual de dicha transferencia.

4. **Brecha de información pública:** La plataforma carece de una política de privacidad y aviso de tratamiento de datos accesible desde el sitio web, lo cual es obligatorio conforme a los artículos 12 y 13 de la Ley 1581.

---

## 4. Análisis de Riesgo

| Riesgo | Probabilidad | Impacto | Nivel | Mitigación |
|--------|:---:|:---:|:---:|------------|
| DIAN objeta ubicación de servidores en EE.UU. | Media | Alto | **Alto** | Presentar marco legal + DPA + certificaciones AWS |
| SIC sanciona por no registro en RNBD | Baja-Media | Medio | **Medio** | Registrar en RNBD antes de lanzamiento comercial |
| Cliente exige datos en Colombia | Baja | Medio | **Bajo** | Cláusula contractual + justificación técnica |
| Brecha de datos + obligación de notificación | Baja | Alto | **Medio** | DPA AWS + política de incidentes documentada |
| CLOUD Act requisa datos | Muy baja | Alto | **Bajo** | DPA + SCCs + cifrado de datos |
| Migración futura a sa-east-1 costosa | Media | Bajo | **Bajo** | Planificar como mejora futura, no bloqueante |

---

## 5. Acciones Requeridas

### 5.1 Acciones CRÍTICAS (antes de presentar ante la DIAN)

#### Acción C-1: Aceptar el AWS Data Processing Addendum (DPA)

| Campo | Detalle |
|-------|---------|
| **Responsable** | Ricardo Cermeño Bolaño (Director de Tecnología) |
| **Plazo** | Inmediato (1 semana) |
| **Procedimiento** | Acceder a la consola AWS → Account Settings → Data Processing Addendum → Review & Accept |
| **URL** | https://aws.amazon.com/agreement/ (sección DPA) |
| **Evidencia requerida** | Captura de pantalla del DPA aceptado + fecha de aceptación |
| **Por qué es crítico** | Sin DPA firmado, la transferencia internacional a AWS no tiene base contractual documentable ante la SIC/DIAN |

El DPA de AWS incluye automáticamente:
- Las Standard Contractual Clauses (SCCs) de la UE (módulo procesador-subprocesador)
- Compromisos específicos de AWS como encargado del tratamiento
- Mecanismos de notificación de brechas de seguridad (72 horas)
- Derechos de auditoría del cliente

#### Acción C-2: Registrar IDEAL SOFTWARE en el RNBD de la SIC

| Campo | Detalle |
|-------|---------|
| **Responsable** | Felix Palacio Arguelle (Representante Legal) |
| **Plazo** | 30 días |
| **Procedimiento** | Acceder al portal SIC VUE → RNBD → Registrar nueva base de datos |
| **URL** | https://www.sic.gov.co/ (Portal de Trámites → Registro Nacional de Bases de Datos) |
| **Información requerida** | Nombre de la base de datos, finalidad, categoría de datos, número de titulares estimado, país de almacenamiento (EE.UU.), canales de atención a titulares |
| **Evidencia requerida** | Certificado de registro emitido por la SIC |
| **Por qué es crítico** | Obligación legal para responsables que traten datos de más de 500 titulares o datos sensibles (nómina = datos sensibles) |

Bases de datos a registrar:
1. **Base de datos de clientes y usuarios** (datos de empresas y sus representantes)
2. **Base de datos de facturación** (datos de facturas emitidas y recibidas)
3. **Base de datos de nómina** (datos de empleados — categoría sensible)

#### Acción C-3: Crear y publicar Aviso de Privacidad y Política de Tratamiento de Datos

| Campo | Detalle |
|-------|---------|
| **Responsable** | Ricardo Cermeño Bolaño + asesor legal externo |
| **Plazo** | 21 días |
| **Dónde publicar** | idealsoluciones.com.co/privacidad (enlace en footer del sitio y de la app) |
| **Contenido mínimo requerido (Art. 13, Ley 1581)** | Ver detalle abajo |
| **Evidencia requerida** | URL pública de la política + captura de pantalla |

**Contenido mínimo de la Política de Privacidad:**
- Identificación del responsable (IDEAL SOFTWARE S.A.S, NIT 902.027.596-7)
- Dirección física y electrónica del responsable
- Tipo de datos recolectados y finalidad del tratamiento
- Derechos de los titulares (acceso, rectificación, cancelación, oposición)
- Persona o área responsable de atender solicitudes (Oficial de Privacidad)
- **Sección específica de transferencia internacional:** indicar que los datos se almacenan en AWS us-east-1 (EE.UU.), con las garantías del DPA y las SCCs
- Vigencia de la política

#### Acción C-4: Incluir Cláusula de Tratamiento de Datos en Contratos con Clientes

| Campo | Detalle |
|-------|---------|
| **Responsable** | Felix Palacio Arguelle + asesor legal externo |
| **Plazo** | 30 días |
| **Aplica a** | Todos los contratos de prestación de servicios de facturación electrónica (nuevos y renovaciones) |
| **Contenido de la cláusula** | Ver detalle abajo |

**Contenido mínimo de la cláusula contractual:**

```
CLÁUSULA DE TRATAMIENTO DE DATOS PERSONALES

En cumplimiento de la Ley 1581 de 2012, el Decreto 1377 de 2013 y demás 
normas concordantes, el CLIENTE (responsable del tratamiento) autoriza a 
IDEAL SOFTWARE S.A.S (encargado del tratamiento) para procesar los datos 
personales contenidos en los documentos electrónicos generados a través 
de la plataforma, con la finalidad exclusiva de prestar el servicio de 
facturación electrónica.

IDEAL SOFTWARE S.A.S declara que:
(i) Los datos serán almacenados en servidores de Amazon Web Services 
    (AWS) ubicados en us-east-1, Estados Unidos, bajo el amparo del 
    AWS Data Processing Addendum que incorpora Standard Contractual 
    Clauses conforme al Decreto 1377/2013, artículo 26, literal h).
(ii) AWS actúa como subencargado del tratamiento y no tiene acceso a 
    los datos para fines propios.
(iii) Los datos no serán transferidos a terceros distintos de AWS sin 
    autorización expresa del CLIENTE.
(iv) Se implementan medidas técnicas de cifrado (TLS 1.3 en tránsito, 
    AES-256 en reposo) para proteger los datos.
(v) En caso de brecha de seguridad, el CLIENTE será notificado dentro 
    de las 72 horas siguientes a la detección.
```

### 5.2 Acciones RECOMENDADAS (mejora continua, no bloqueantes para DIAN)

#### Acción R-1: Evaluar Migración a sa-east-1 (São Paulo) o AWS Colombia

| Campo | Detalle |
|-------|---------|
| **Responsable** | Ricardo Cermeño Bolaño |
| **Plazo** | 12-18 meses (planificación) |
| **Justificación** | São Paulo reduce latencia para usuarios colombianos (~80ms vs ~120ms), elimina completamente la cuestión de soberanía de datos para países de América Latina, y es más cercano culturalmente para argumentaciones regulatorias. AWS Colombia (Bogotá) está en hoja de ruta de AWS pero sin fecha confirmada. |
| **Costo estimado** | Igual — mismos precios de Lightsail en sa-east-1 |
| **Prerequisito** | Resolver primero las brechas C-1 a C-4. La migración no es urgente para la certificación DIAN. |

#### Acción R-2: Designar un Oficial de Privacidad (Data Protection Officer interno)

| Campo | Detalle |
|-------|---------|
| **Responsable** | Felix Palacio Arguelle |
| **Plazo** | 60 días |
| **Justificación** | La SIC recomienda designar un responsable interno para atender solicitudes de titulares. Para empresas pequeñas, puede ser el mismo representante legal o el director de tecnología. |
| **Acción** | Designar formalmente mediante acto interno (circular interna o acta de junta) y publicar el correo de contacto en la política de privacidad |

#### Acción R-3: Implementar procedimiento de atención a derechos ARCO

| Campo | Detalle |
|-------|---------|
| **Responsable** | Ricardo Cermeño Bolaño |
| **Plazo** | 45 días |
| **ARCO** | Acceso, Rectificación, Cancelación, Oposición |
| **Plazo legal para respuesta** | 10 días hábiles (consultas), 15 días hábiles (reclamos), prorrogable 8 días |
| **Acción** | Crear correo dedicado (privacidad@idealsoluciones.com.co), procedimiento interno de respuesta, registro de solicitudes recibidas |

---

## 6. Lista de Verificación Pre-DIAN

Los siguientes ítems deben estar completados y documentados antes de la presentación del expediente de habilitación ante la DIAN:

### 6.1 Obligatorios

- [ ] **C-1.1** AWS Data Processing Addendum aceptado y con evidencia (captura de pantalla + fecha)
- [ ] **C-1.2** Identificar y documentar la versión de SCCs incluidas en el DPA de AWS
- [ ] **C-2.1** Solicitud de registro ante la SIC (RNBD) presentada
- [ ] **C-2.2** Certificado de registro SIC recibido (o número de radicación si está en trámite)
- [ ] **C-3.1** Política de Privacidad y Tratamiento de Datos publicada en sitio web
- [ ] **C-3.2** URL pública de la política de privacidad documentada
- [ ] **C-4.1** Cláusula de tratamiento de datos incluida en modelo de contrato de servicios
- [ ] **C-4.2** Modelo de contrato revisado por asesor legal

### 6.2 Documentos a adjuntar al expediente DIAN

- [ ] **E-10** Confirmación de aceptación del AWS DPA
- [ ] **E-11** Número de registro en el RNBD de la SIC (o radicado de trámite en curso)
- [ ] **E-12** URL pública de política de privacidad (captura)
- [ ] **E-13** Sección 3.7 del documento `punto-8-infraestructura.md` redactada e incluida
- [ ] **E-14** Certificaciones AWS relevantes (ISO 27018, SOC 2) — disponibles en aws.amazon.com/compliance

---

## 7. Texto a Insertar en punto-8-infraestructura.md

El siguiente texto debe insertarse como nueva **sección 3.7** en el documento `punto-8-infraestructura.md`, inmediatamente después de la sección 3.6 ("Provisioning como Código") y antes de la sección 4 ("Infraestructura Tecnológica").

---

### INICIO DEL TEXTO A INSERTAR

```markdown
### 3.7 Cumplimiento de Transferencia Internacional de Datos

La operación de la infraestructura en **AWS us-east-1 (N. Virginia, Estados Unidos)** implica una transferencia internacional de datos personales conforme a la Ley 1581 de 2012. IDEAL SOFTWARE S.A.S ha adoptado las medidas jurídicas, técnicas y organizativas necesarias para garantizar la legalidad de dicha transferencia.

#### 3.7.1 Marco Jurídico de la Transferencia

| Norma | Disposición aplicable | Cumplimiento |
|-------|----------------------|:---:|
| Ley 1581 de 2012, Art. 26 | Transferencias internacionales — prohibición general con excepciones | Aplicable excepción literal h) |
| Decreto 1377 de 2013, Art. 26 | Garantías contractuales suficientes como mecanismo válido | Cumplido mediante AWS DPA + SCCs |
| Concepto SIC 17-244590-2 | Validez del cloud en el exterior con garantías contractuales | Cumplido |

#### 3.7.2 Calificación de AWS como Encargado del Tratamiento

Amazon Web Services (AWS) actúa como **encargado del tratamiento** (Art. 3, literal d, Ley 1581) en la modalidad de Infrastructure as a Service (IaaS), bajo las siguientes condiciones:

- AWS no decide sobre las finalidades ni los medios del tratamiento de datos
- AWS no accede a los datos de los clientes para sus propios fines
- El tratamiento se rige por el **AWS Data Processing Addendum (DPA)**, que incorpora las Standard Contractual Clauses (SCCs) de la Comisión Europea como garantía contractual equivalente al GDPR
- El DPA incluye obligaciones de notificación de brechas de seguridad dentro de 72 horas

#### 3.7.3 Certificaciones de Protección de Datos de AWS

| Certificación | Relevancia para datos personales |
|---------------|----------------------------------|
| ISO/IEC 27018:2019 | Único estándar internacional para protección de PII en nube pública |
| SOC 2 Tipo II | Auditoría independiente de controles de seguridad y confidencialidad |
| ISO/IEC 27001:2013 | Sistema de gestión de seguridad de la información |

Las certificaciones son auditadas anualmente por terceros independientes y están disponibles públicamente en https://aws.amazon.com/compliance/programs/.

#### 3.7.4 Medidas Técnicas de Protección

| Medida | Implementación |
|--------|---------------|
| Cifrado en tránsito | TLS 1.3 obligatorio para toda comunicación externa |
| Cifrado en reposo | AES-256 gestionado por AWS KMS (Lightsail Managed DB) |
| Acceso restringido | Bases de datos sin acceso público (`publicly_accessible = false`) |
| Aislamiento de redes | 6 redes Docker aisladas con principio de mínimo privilegio |

#### 3.7.5 Registro ante la Autoridad de Control

IDEAL SOFTWARE S.A.S se encuentra registrada ante la **Superintendencia de Industria y Comercio (SIC)** en el **Registro Nacional de Bases de Datos (RNBD)** como responsable del tratamiento de las bases de datos descritas en este documento, conforme al artículo 25 de la Ley 1581 de 2012.

**Número de registro SIC:** [Número de registro — completar una vez obtenido]

#### 3.7.6 Política de Privacidad

La política de tratamiento de datos personales de IDEAL SOFTWARE S.A.S, que incluye información sobre la transferencia internacional, se encuentra disponible públicamente en:

**https://idealsoluciones.com.co/privacidad**
```

### FIN DEL TEXTO A INSERTAR

---

## 8. Referencias Normativas

| Norma / Documento | Descripción | Vigencia |
|-------------------|-------------|:---:|
| Ley 1581 de 2012 | Régimen general de protección de datos personales | Vigente |
| Decreto 1377 de 2013 | Reglamentación de transferencias internacionales | Vigente |
| Decreto 1074 de 2015 | Compilación del sector comercio (incluye normas de Habeas Data) | Vigente |
| Decreto 1674 de 2019 | Modifica el Decreto 1074/2015 en materia de protección de datos | Vigente |
| Circular 02 de 2015 — SIC | Guía para responsables del tratamiento | Vigente |
| Concepto SIC 17-244590-2 | Validez del cloud en el exterior | Referencia |
| AWS Customer Agreement | Contrato base de servicios AWS | Vigente |
| AWS Data Processing Addendum | Contrato de encargo del tratamiento con AWS | Vigente (aceptar) |
| ISO/IEC 27018:2019 | Protección de PII en nube pública | Vigente |
| CLOUD Act (EE.UU., 2018) | Ley de acceso a datos en la nube | Vigente EE.UU. |
| EU-U.S. Data Privacy Framework | Marco transatlántico de privacidad | Vigente desde 2023 |
| Resolución 00165 de 2023 — DIAN | Requisitos para proveedores tecnológicos de FEV | Vigente |

---

*Documento preparado por el área de tecnología de IDEAL SOFTWARE S.A.S para uso interno y presentación ante la DIAN. No debe distribuirse sin autorización del representante legal.*

*Próxima revisión: antes de la presentación del expediente de habilitación ante la DIAN o cuando se produzcan cambios normativos relevantes.*
