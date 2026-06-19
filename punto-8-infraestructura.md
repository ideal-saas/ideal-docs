# Acreditación de Infraestructura Física, Tecnológica y de Seguridad

**Requisito:** Numeral 8, Artículo 55, Resolución 00165 de 2023
**Empresa:** IDEAL SOFTWARE S.A.S
**NIT:** 902.027.596-7
**Fecha de emisión:** Junio 2026
**Versión:** 1.1

---

## Tabla de Contenidos

1. [Objeto del Documento](#1-objeto-del-documento)
2. [Información de la Empresa](#2-información-de-la-empresa)
3. [Infraestructura Física](#3-infraestructura-física)
4. [Infraestructura Tecnológica](#4-infraestructura-tecnológica)
5. [Arquitectura del Servicio](#5-arquitectura-del-servicio)
6. [Seguridad de la Información](#6-seguridad-de-la-información)
7. [Continuidad de la Prestación del Servicio](#7-continuidad-de-la-prestación-del-servicio)
8. [Objetivos de Recuperación (RPO/RTO) y Estrategia de Recuperación](#8-objetivos-de-recuperación-rporto-y-plan-de-recuperación)
9. [Recursos de Producción](#9-recursos-de-producción)
10. [Condiciones y Niveles de Servicio](#10-condiciones-y-niveles-de-servicio)
11. [Anexos y Soportes](#11-anexos-y-soportes)
12. [Compromiso de Actualización](#12-compromiso-de-actualización)
13. [Firma](#13-firma)

---

## 1. Objeto del Documento

El presente documento tiene como propósito acreditar ante la Dirección de Impuestos y Aduanas Nacionales (DIAN) la infraestructura física, tecnológica y de seguridad con la que cuenta IDEAL SOFTWARE S.A.S para la prestación de los servicios de generación, transmisión, expedición, entrega, recepción y conservación de la factura electrónica de venta, las notas débito, las notas crédito y los demás documentos electrónicos derivados de la factura electrónica de venta, conforme a lo establecido en el numeral 8 del artículo 55 de la Resolución 00165 de 2023.

**Alcance de servicios acreditados:**
- Generación de factura electrónica de venta (formato UBL 2.1 / XML)
- Transmisión de documentos electrónicos a la DIAN vía web services
- Expedición y entrega de factura electrónica al adquirente
- Generación y transmisión de notas débito
- Generación y transmisión de notas crédito
- Generación y transmisión de documento soporte en adquisiciones
- Generación y transmisión de nómina electrónica
- Generación y transmisión de ajuste de nómina electrónica
- Recepción de factura electrónica de venta
- Conservación de documentos electrónicos

**Compromiso:** Este documento será actualizado anualmente y presentado a la DIAN junto con los soportes correspondientes, conforme a la normativa vigente.

---

## 2. Información de la Empresa

| Campo | Valor |
|-------|-------|
| **Razón Social** | IDEAL SOFTWARE S.A.S |
| **NIT** | 902.027.596-7 |
| **Representante Legal** | Felix Palacio Arguelle |
| **Director de Tecnología** | Ricardo Cermeño Bolaño |
| **Domicilio** | CR 19 # 12-37 Local 5, Centro Comercial La 19, Santa Marta, Magdalena, Colombia |
| **Objeto Social** | Actividades de generación, transmisión, expedición, entrega y recepción de la factura electrónica de venta, las notas débito, las notas crédito e instrumentos electrónicos derivados de la factura electrónica de venta |

**Responsable de la infraestructura tecnológica:** Ricardo Cermeño Bolaño, Director de Tecnología, profesional en ingeniería de sistemas con experiencia en arquitectura de software, infraestructura cloud y seguridad de la información.

---

## 3. Infraestructura Física

### 3.1 Proveedor de Servicios en la Nube

IDEAL SOFTWARE S.A.S opera su infraestructura de facturación electrónica sobre **Amazon Web Services (AWS)**, específicamente el servicio **AWS Lightsail**, que proporciona servidores virtuales, bases de datos gestionadas, almacenamiento y conectividad de red en centros de datos certificados.

| Aspecto | Detalle |
|---------|---------|
| **Proveedor** | Amazon Web Services (AWS) |
| **Servicio** | AWS Lightsail (Infrastructure as a Service) |
| **Región** | us-east-1 (N. Virginia, Estados Unidos) |
| **Zona de disponibilidad** | us-east-1a |
| **Certificaciones AWS** | SOC 1/2/3, ISO 27001, ISO 27017, ISO 27018, PCI DSS Level 1, CSA STAR Level 2, FedRAMP |
| **SLA de disponibilidad** | 99.99% para instancias Lightsail |

**Justificación de selección de AWS:**
- Proveedor cloud líder global con más de 18 años de operación
- Centros de datos con redundancia de energía, refrigeración y conectividad
- Certificaciones de seguridad internacionales reconocidas
- Backups automáticos integrados en bases de datos gestionadas
- Escalabilidad vertical y horizontal bajo demanda
- Firewall nativo configurable por instancia

### 3.2 Servidor de Producción

| Especificación | Valor |
|----------------|-------|
| **Nombre** | ideal-production-server |
| **Sistema Operativo** | Ubuntu 22.04 LTS (soporte hasta abril 2027, extendido hasta 2032) |
| **Procesador** | 4 vCPU |
| **Memoria RAM** | 16 GB |
| **Almacenamiento** | 320 GB SSD |
| **Bundle** | xlarge_3_0 |
| **IP Estática** | [Asignada por AWS — no divulgada por razones de seguridad] |
| **Costo mensual** | USD $80 |

### 3.3 Cumplimiento de Transferencia Internacional de Datos

La infraestructura de IDEAL SOFTWARE S.A.S opera en la región us-east-1 (N. Virginia, Estados Unidos) de Amazon Web Services. Esta configuración cumple plenamente con la normativa colombiana de protección de datos personales, conforme a lo siguiente:

**Marco legal aplicable:**

| Norma | Disposición | Cumplimiento |
|-------|-------------|:---:|
| Ley 1581 de 2012 (Habeas Data) | Art. 26 - Transferencias internacionales permitidas a países con nivel adecuado de protección | ✓ |
| Decreto 1377 de 2013 | Art. 26 - EE.UU. reconocido como país con nivel adecuado por la SIC bajo el marco Data Privacy Framework | ✓ |
| ISO/IEC 27018:2019 | Estándar específico para protección de PII en la nube - certificado por AWS | ✓ |

**Rol de AWS como encargado del tratamiento:**
AWS actúa exclusivamente como **encargado del tratamiento** (data processor) de conformidad con el Art. 3 de la Ley 1581 de 2012. IDEAL SOFTWARE S.A.S es el **responsable del tratamiento** (data controller). AWS no accede ni utiliza los datos de los clientes para ningún propósito diferente a la prestación del servicio contratado.

**Certificaciones de seguridad de AWS relevantes:**
- SOC 1 Tipo II, SOC 2 Tipo II, SOC 3 (auditados por terceros)
- ISO 27001:2022 (Seguridad de la información)
- ISO 27017:2015 (Seguridad en la nube)
- ISO 27018:2019 (Protección de datos personales en la nube)
- PCI DSS Nivel 1 (Seguridad de datos de pago)

**Acuerdo de procesamiento de datos:**
AWS ofrece un Data Processing Addendum (DPA) que establece obligaciones contractuales de seguridad, confidencialidad y protección de datos, disponible en: https://aws.amazon.com/compliance/gdpr-center/

### 3.4 Bases de Datos Gestionadas

IDEAL SOFTWARE S.A.S utiliza bases de datos gestionadas de AWS Lightsail (Managed Database), que incluyen backups automáticos, mantenimiento del motor, parches de seguridad y alta disponibilidad sin intervención manual.

#### 3.4.1 PostgreSQL 16 (Producción)

| Especificación | Valor |
|----------------|-------|
| **Nombre** | ideal-production-postgres |
| **Motor** | PostgreSQL 16 |
| **Bundle** | micro_1_0 (1 GB RAM, 1 vCPU, 40 GB SSD) |
| **Acceso público** | DESHABILITADO |
| **Backup automático** | Diario, ventana 04:00-04:30 UTC |
| **Retención de backups** | 7 días |
| **Ventana de mantenimiento** | Domingo 05:00-05:30 UTC |
| **Final snapshot** | Obligatorio antes de eliminación |
| **Costo mensual** | USD $15 |
| **Consumidores** | 8 microservicios NestJS + 6 consumers Kafka |
| **Datos almacenados** | Empresas, facturas, notas crédito/débito, contabilidad, nómina, inventario, tesorería, reportes |

#### 3.4.2 MySQL 8.0 (Producción)

| Especificación | Valor |
|----------------|-------|
| **Nombre** | ideal-production-mysql |
| **Motor** | MySQL 8.0 |
| **Bundle** | micro_1_0 (1 GB RAM, 1 vCPU, 40 GB SSD) |
| **Acceso público** | DESHABILITADO |
| **Backup automático** | Diario, ventana 04:00-04:30 UTC |
| **Retención de backups** | 7 días |
| **Ventana de mantenimiento** | Domingo 05:00-05:30 UTC |
| **Final snapshot** | Obligatorio antes de eliminación |
| **Costo mensual** | USD $15 |
| **Consumidor** | API DIAN (Laravel/PHP) |
| **Datos almacenados** | Resoluciones DIAN, consecutivos de facturación, XMLs generados, estados de transmisión |

### 3.5 Dominio y DNS

| Dominio | Tipo | Propósito |
|---------|------|---------|
| idealsoluciones.com.co | Dominio principal | Dominio corporativo de producción |
| api.idealsoluciones.com.co | Registro A → IP producción | API GraphQL (punto de entrada del servicio) |
| app.idealsoluciones.com.co | Registro A → IP producción | Aplicación web para facturadores |
| admin.idealsoluciones.com.co | Registro A → IP producción | Panel de administración |

### 3.6 Gestión de Infraestructura como Código

Toda la infraestructura se gestiona mediante código versionado (Terraform), lo que garantiza que puede ser recreada de forma idéntica ante cualquier contingencia. Cada cambio queda registrado y es trazable en el historial de Git. Los recursos gestionados incluyen instancias Lightsail, bases de datos gestionadas, IPs estáticas, reglas de firewall y pares de claves SSH.

### 3.7 Plan de Evolución de Infraestructura

IDEAL SOFTWARE S.A.S ha definido una hoja de ruta de crecimiento en tres etapas, alineada con la proyección de clientes facturadores activos:

- **Etapa 1 — Capacidad actual (0 a ~50 clientes):** La infraestructura actual sobre AWS Lightsail (4 vCPU, 16 GB RAM, 320 GB SSD) soporta la operación de hasta aproximadamente 50 empresas clientes con carga normal de facturación. El 73% de headroom de memoria disponible garantiza margen suficiente para absorber picos de demanda.
- **Etapa 2 — Escalamiento vertical (~50 a ~100 clientes):** Al superar los 50 clientes activos, se realizará un escalamiento vertical de la instancia Lightsail (upgrade de bundle) y de las bases de datos gestionadas, sin cambios en la arquitectura ni en los procesos operativos. Esta etapa sostendrá la operación hasta alcanzar el punto de equilibrio económico proyectado en aproximadamente 100 clientes.
- **Etapa 3 — Infraestructura elástica (más de ~100 clientes):** Al superar los 100 clientes activos, IDEAL SOFTWARE S.A.S migrará a una arquitectura de nube elástica con escalamiento horizontal, compuesta por Amazon EKS (Elastic Kubernetes Service) como orquestador de contenedores, Amazon RDS como motor de bases de datos con réplicas de lectura, y un Application Load Balancer (ALB) para distribución de tráfico.



---

## 4. Infraestructura Tecnológica

### 4.1 Stack Tecnológico

| Capa | Tecnología | Versión | Propósito |
|------|-----------|---------|---------|
| Orquestación | Docker Compose v2 | Latest | Gestión del ciclo de vida de containers |
| Proxy reverso y TLS | Caddy | 2.8.4 | Terminación TLS automática, HTTP/3, routing |
| API Gateway | Apollo Router | Latest | GraphQL Federation v2, enrutamiento de queries |
| Backend | NestJS (Node.js) | Latest | 8 microservicios de lógica de negocio |
| Integración DIAN | Laravel/PHP | Latest | Firma digital, UBL 2.1, transmisión SOAP |
| Event streaming | Apache Kafka | 3.9.0 | Procesamiento asíncrono de documentos |
| Consumers | NestJS (Node.js) | Latest | 6 procesadores especializados por tipo de documento |
| Frontend | Next.js (React) | Latest | Interfaz de usuario server-side rendered |
| Base de datos relacional | PostgreSQL 16 + MySQL 8.0 | Managed | Persistencia de datos de negocio |
| Monitoreo | Grafana Cloud (Alloy + cAdvisor) | Latest | Métricas, logs y alertas en tiempo real |
| CI/CD | GitHub Actions | - | Build, test y deploy automatizado |
| Registro de imágenes | GitHub Container Registry | - | Almacenamiento privado de imágenes Docker |
| Infraestructura como código | Terraform | >= 1.0 | Provisioning reproducible de AWS Lightsail |

### 4.2 Servicios de Facturación Electrónica

La plataforma presta los siguientes servicios de facturación electrónica conforme al numeral 3 del artículo 55 de la Resolución 00165 de 2023:

| Servicio | Descripción técnica | Componentes involucrados |
|----------|--------------------|-----------------------|
| **Generación** | Construcción del documento XML en formato UBL 2.1 conforme al Anexo Técnico de la DIAN | Purchases MS, Payroll MS, API DIAN |
| **Firma digital** | Aplicación de firma electrónica con certificado digital X.509 y cálculo de CUFE/CUDE (SHA-384) | API DIAN |
| **Transmisión** | Envío del XML firmado a los web services de validación previa de la DIAN vía SOAP/HTTPS | API DIAN → DIAN Web Services |
| **Expedición** | Emisión del documento con el CUFE asignado por la DIAN | Purchases MS, Payroll MS |
| **Entrega** | Puesta a disposición del documento al adquirente | Aplicación Web, API GraphQL |
| **Recepción** | Recepción de facturas electrónicas de venta de proveedores | Core MS, Purchases MS |
| **Conservación** | Almacenamiento seguro de documentos electrónicos con integridad garantizada | PostgreSQL 16 + MySQL 8.0 (backups automáticos) |

### 4.3 Inventario de Servicios

La plataforma opera con **24 servicios containerizados** en producción, organizados en capas funcionales:

| # | Servicio | Imagen Docker | Función |
|:---:|----------|---------------|---------|
| 1 | Caddy | caddy:2.8.4-alpine | Reverse proxy, terminación TLS automática (puertos 80 y 443) |
| 2 | Apollo Router | apollographql/apollo-runtime | Gateway GraphQL Federation v2 |
| 3 | Core MS | ghcr.io/ideal-saas/core-ms | Empresas, usuarios, configuración |
| 4 | Inventory MS | ghcr.io/ideal-saas/inventoryms | Inventario y productos |
| 5 | Purchases MS | ghcr.io/ideal-saas/purchase-ms | Facturación, compras, notas |
| 6 | File Uploader MS | ghcr.io/ideal-saas/file-uploader-ms | Gestión de archivos |
| 7 | Accounting MS | ghcr.io/ideal-saas/accounting-ms | Contabilidad |
| 8 | Report MS | ghcr.io/ideal-saas/report-ms | Reportes |
| 9 | Payroll MS | ghcr.io/ideal-saas/payroll-ms | Nómina electrónica |
| 10 | Treasury MS | ghcr.io/ideal-saas/treasury-ms | Tesorería |
| 11 | API DIAN | ghcr.io/ideal-saas/dian-invoicer-ms | Integración DIAN: construcción XML UBL 2.1, firma digital X.509, transmisión SOAP |
| 12 | Apache Kafka | apache/kafka-native:3.9.0 | Broker de mensajes para procesamiento asíncrono |
| 13 | Kafka UI | kafbat/kafka-ui | Administración y monitoreo de topics Kafka |
| 14 | Consumer Factura | ghcr.io/ideal-saas/ideal-stream-consumers-dian-einvoice-emission | Emisión de factura electrónica de venta |
| 15 | Consumer Nota Crédito | ghcr.io/ideal-saas/ideal-stream-consumers-dian-note-credit-emission | Emisión de nota crédito |
| 16 | Consumer Nota Débito | ghcr.io/ideal-saas/ideal-stream-consumers-dian-note-debit-emission | Emisión de nota débito |
| 17 | Consumer Doc. Soporte | ghcr.io/ideal-saas/ideal-stream-consumers-dian-document-support-emission | Emisión de documento soporte en adquisiciones |
| 18 | Consumer Nómina | ghcr.io/ideal-saas/ideal-stream-consumers-dian-payroll-emission | Emisión de nómina electrónica |
| 19 | Consumer Ajuste Nómina | ghcr.io/ideal-saas/ideal-stream-consumers-dian-payroll-adjustment-emission | Emisión de ajuste de nómina electrónica |
| 20 | Aplicación Web | ghcr.io/ideal-saas/acc-web-app | Frontend Next.js para facturadores |
| 21 | Grafana Alloy | grafana/alloy | Recolección de métricas y logs |
| 22 | cAdvisor | gcr.io/cadvisor/cadvisor | Métricas de rendimiento de containers |
| 23 | Admin MS | ghcr.io/ideal-saas/ideal-admin-ms | Backend de panel de administración |
| 24 | Admin Web | ghcr.io/ideal-saas/ideal-admin-web | Panel de administración (Vite) |



### 4.4 GraphQL Federation v2 (Apollo Router)

La API principal opera bajo el modelo de **GraphQL Federation v2**, donde un Router central compone las respuestas a partir de 7 subgraphs especializados:

| Subgraph | Servicio | Endpoint | Dominio de negocio |
|----------|----------|----------|-------------------|
| coreMs | Core MS | http://core:3000/graphql | Empresas, usuarios, configuración |
| inventoryMs | Inventory MS | http://inventory:3001/graphql | Inventario, productos |
| purchaseMs | Purchases MS | http://purchases:3002/graphql | Compras, facturación, notas |
| accountingMs | Accounting MS | http://accounting:3004/graphql | Contabilidad, asientos |
| reportMs | Report MS | http://report:3005/graphql | Reportes tributarios |
| payrollMs | Payroll MS | http://payroll:3006/graphql | Nómina electrónica |
| treasuryMs | Treasury MS | http://treasury:3007/graphql | Tesorería, flujo de caja |

**Ventajas de la federación:**
- Cada microservicio es independiente y desplegable por separado
- El Router compone un schema unificado para el frontend
- Propagación automática de headers de autorización (JWT)
- Escalamiento independiente por microservicio según demanda

### 4.5 Event Streaming (Apache Kafka)

El procesamiento de documentos electrónicos (emisión a la DIAN) se realiza de forma **asíncrona** mediante Apache Kafka en modo KRaft (sin dependencia de Zookeeper). La plataforma implementa el patrón **Transactional Outbox**: los eventos se escriben en la base de datos dentro de la misma transacción que los datos de negocio, y un proceso publicador los envía a Kafka. Esto garantiza que ningún evento se pierda — incluso si Kafka está temporalmente indisponible, el evento permanece persistido en la base de datos hasta su publicación exitosa:

**Beneficios del procesamiento asíncrono:**
- El usuario no espera la respuesta de la DIAN (experiencia fluida)
- Si la DIAN está temporalmente no disponible, los mensajes se acumulan sin perderse
- Si un consumer falla, al reiniciar procesa los mensajes pendientes automáticamente
- Desacoplamiento entre la generación del documento y su transmisión

---

## 5. Arquitectura del Servicio

### 5.1 Arquitectura General

La plataforma sigue un modelo de microservicios orquestados mediante Docker Compose, con comunicación síncrona a través de una API GraphQL unificada (Apollo Router) y asíncrona mediante Apache Kafka. Todo el tráfico público ingresa a través de Caddy (proxy inverso con TLS automático), que enruta las solicitudes al servicio correspondiente. Los documentos electrónicos se encolan para su procesamiento asíncrono, garantizando que no se pierdan ante indisponibilidad temporal de los servicios web de la DIAN.

**Ver Anexo A — Diagrama 1: Arquitectura General del Servicio**

### 5.2 Proceso Externo: Flujo del Usuario

El usuario accede a la plataforma a través de la aplicación web (`app.idealsoluciones.com.co`), se autentica con sus credenciales, y genera el documento electrónico correspondiente. La plataforma valida los datos, construye el XML UBL 2.1, aplica la firma digital, y encola el documento para transmisión asíncrona a la DIAN. El usuario recibe confirmación inmediata y, una vez la DIAN procesa el documento, se le notifica el resultado y se envía copia al adquiriente por correo electrónico. Todo el proceso está documentado visualmente en el Anexo A.

### 5.3 Proceso Interno: Emisión de Documento Electrónico

Internamente, el microservicio correspondiente recibe la solicitud, persiste el documento en PostgreSQL 16, y publica un evento en Kafka. El consumer especializado consume el mensaje e invoca la API DIAN, que construye el XML UBL 2.1, aplica la firma X.509, calcula el CUFE/CUDE (SHA-384), y transmite el documento firmado a los web services de la DIAN vía SOAP/HTTPS. La respuesta de la DIAN (aprobación o rechazo) es procesada por el consumer, que actualiza el estado en base de datos y dispara las notificaciones correspondientes.

**Ver Anexo A — Diagrama 2: Flujo de Emisión de Factura Electrónica**

### 5.4 Topología de Redes

Los servicios se agrupan en 7 redes Docker aisladas, aplicando el principio de mínimo privilegio: ningún servicio tiene acceso a redes que no requiere para su función. Las bases de datos no son accesibles desde el exterior. El detalle de cada red y los servicios que la componen se encuentra en el Anexo B.

**Ver Anexo A — Diagrama 3: Topología de Redes Docker**
Los cambios de software se validan en un ambiente de pruebas antes de su paso a producción. El proceso de despliegue puede revertirse en menos de 5 minutos ante cualquier incidencia.

---

## 6. Seguridad de la Información

### 6.1 Modelo de Defensa en Profundidad

**Ver Anexo A - Diagrama 5: Capas de Seguridad**

La plataforma implementa un modelo de seguridad en capas (defense-in-depth) con 8 niveles de protección:

| Capa | Componente | Función de seguridad |
|:---:|-----------|---------------------|
| 1 | DNS | Resolución controlada de nombres |
| 2 | Firewall AWS | Solo puertos 22 (restringido), 80, 443 abiertos |
| 3 | Caddy (TLS) | Cifrado TLS 1.2/1.3, HTTP/3, certificados automáticos |
| 4 | Autenticación | Firebase Auth (usuarios), SSH ed25519 (admin) |
| 5 | Redes Docker | 7 redes aisladas, mínimo privilegio |
| 6 | Aplicaciones | Imágenes inmutables, Alpine Linux, limits |
| 7 | Datos | DBs no públicas, backups, cifrado AWS |
| 8 | Monitoreo | Grafana Cloud, alertas, logs centralizados |

### 6.2 Seguridad Perimetral

| Control | Descripción |
|---------|-------------|
| Firewall AWS Lightsail | Solo puertos 22, 80, 443 abiertos al exterior |
| SSH restringido | Puerto 22 accesible únicamente desde CIDRs autorizados |
| Sin puertos directos | Microservicios NO exponen puertos públicos |
| Punto de entrada único | Todo el tráfico público pasa por Caddy |
| Bases de datos no públicas | `publicly_accessible = false` en producción |

### 6.3 Cifrado en Tránsito

| Control | Descripción |
|---------|-------------|
| TLS 1.2/1.3 automático | Let's Encrypt vía Caddy (ACME HTTP-01) |
| HTTP/3 (QUIC) | Protocolo UDP cifrado para mejor rendimiento |
| Renovación automática | Certificados renovados sin intervención manual |
| Redirección HTTP→HTTPS | Todo tráfico HTTP redirigido a HTTPS |
| Redes internas privadas | Comunicación entre servicios vía Docker networks (no sale del host) |
| Firma digital DIAN | Certificado X.509, CUFE/CUDE SHA-384 |

### 6.4 Control de Acceso

| Nivel | Mecanismo | Descripción |
|-------|-----------|-------------|
| Usuarios finales | Firebase Authentication | JWT con expiración, aislamiento por tenant |
| Administradores | SSH keypair ed25519 | Restringido por IP, sin contraseñas |
| CI/CD | GitHub Secrets + Environments | Credenciales cifradas, aprobación para producción |
| Bases de datos | Credenciales en .env (no versionados) | Acceso solo desde redes Docker internas |
| Registro Docker | GitHub Container Registry privado | Autenticación por token |

### 6.5 Monitoreo y Observabilidad

La plataforma cuenta con monitoreo 24/7 de disponibilidad externa, rendimiento de servidores, y logs centralizados con alertas automáticas ante cualquier degradación del servicio. Las herramientas específicas se detallan en el Anexo B — Inventario de Activos Tecnológicos.

### 6.6 Políticas de Seguridad Detalladas

Las políticas completas de seguridad de la información se encuentran documentadas en el **Anexo C - Políticas de Seguridad de la Información**, que incluye 8 políticas con 56 controles implementados:

1. Política de Control de Acceso
2. Política de Cifrado y Protección de Datos en Tránsito
3. Política de Seguridad en Operaciones
4. Política de Seguridad en Comunicaciones
5. Política de Gestión de Incidentes de Seguridad
6. Política de Continuidad del Negocio
7. Política de Gestión de Proveedores
8. Política de Desarrollo Seguro

---

## 7. Continuidad de la Prestación del Servicio

### 7.1 Backups y Recuperación de Datos

#### 7.1.1 Backups Operativos (Recuperación ante Fallos)

| Componente | Tipo | Frecuencia | Retención | Recuperación |
|-----------|------|:---:|:---:|-------------|
| PostgreSQL (producción) | Automático Lightsail | Diario 04:00 UTC | 7 días | Point-in-time recovery |
| MySQL (producción) | Automático Lightsail | Diario 04:00 UTC | 7 días | Point-in-time recovery |
| Servidor (imágenes Docker) | GHCR (inmutables) | Cada build | Indefinida | Re-deploy < 5 min |
| Código fuente | Git (GitHub) | Cada commit | Indefinida | Clone + deploy |
| Configuración (IaC) | Git (GitHub) + Terraform | Cada cambio | Indefinida | terraform apply |
| Mensajes Kafka | Volumen Docker persistente | Continuo | Según topic | Replay automático |

#### 7.1.2 Conservación de Documentos Electrónicos (Art. 632 E.T.)

El artículo 632 del Estatuto Tributario colombiano exige la conservación de documentos electrónicos por un mínimo de 10 años. La plataforma cumple este requisito mediante el almacenamiento directo de todos los documentos generados en **AWS S3** a través del servicio `dian-api-iac`, sin límite de retención:

- Cada documento electrónico (factura, nota crédito/débito, documento soporte, nómina, ajuste) se almacena en S3 en el momento de su generación, sin caducidad.
- Los documentos se almacenan con su hash SHA-256 para verificación de integridad.
- Los metadatos de trazabilidad (NIT empresa, tipo documento, fecha de emisión, CUFE/CUDE) se indexan en la base de datos para consulta y recuperación inmediata.
- AWS S3 garantiza una durabilidad del 99.999999999% (11 nueves) sobre los objetos almacenados.

### 7.2 Alta Disponibilidad

Todos los servicios se reinician automáticamente ante fallos. Los microservicios son sin estado (stateless), por lo que su reinicio no implica pérdida de datos. La plataforma utiliza el patrón Transactional Outbox para Kafka: los eventos de emisión de documentos se escriben en la base de datos dentro de la misma transacción que los datos de negocio, garantizando atomicidad y cero pérdida de eventos incluso ante fallos del broker. Los mensajes pendientes de transmisión a la DIAN se persisten tanto en la base de datos (outbox) como en Kafka y sobreviven a reinicios del sistema. Las bases de datos son gestionadas por AWS Lightsail de forma independiente al servidor de aplicaciones, con sus propios mecanismos de alta disponibilidad y backups automáticos.

### 7.3 Escenarios de Recuperación

| Escenario | Impacto | Recuperación | Tiempo |
|-----------|---------|-------------|:---:|
| Container individual falla | 1 servicio temporal | Restart automático Docker | < 30 seg |
| Reinicio del servidor | Todos caídos temporalmente | Restart automático de todos los servicios | < 5 min |
| Corrupción del servidor | Servidor inutilizable | Terraform + restore DB + re-deploy | ≤ 2 horas |
| Falla de base de datos | Sin acceso a datos | Restore desde backup Lightsail | ≤ 1 hora |
| Falla de Kafka | Emisión detenida | Restart, consumers re-procesan pendientes | < 10 min |
| DIAN no disponible | No se transmiten docs | Kafka retiene mensajes, procesa al volver | Automático |
| Compromiso de credenciales | Riesgo de acceso | Rotación + re-deploy | ≤ 1 hora |


---

## 8. Objetivos de Recuperación (RPO/RTO) y Estrategia de Recuperación

### 8.1 Objetivos Definidos

| Métrica | Valor | Justificación |
|---------|:---:|---------------|
| **RPO** (Recovery Point Objective) | ≤ 24 horas | Backups automáticos diarios Lightsail (04:00 UTC) |
| **RTO** (Recovery Time Objective) | ≤ 2 horas | Provisioning Terraform (~15 min) + restore DB (~30 min) + re-deploy containers (~15 min) + validación (~60 min) |

### 8.2 Estrategia de Recuperación

La capacidad de recuperación de la plataforma no depende de un documento externo, sino que está integrada en la arquitectura misma mediante los siguientes mecanismos:

- **Infraestructura como código (Terraform):** La totalidad de la infraestructura AWS (instancias Lightsail, bases de datos gestionadas, IPs estáticas, reglas de firewall) está definida como código versionado en Git. En caso de pérdida total del servidor, ejecutar `terraform apply` recrea el entorno completo en menos de 15 minutos.
- **Imágenes Docker inmutables:** Todas las imágenes de los 24 servicios están publicadas en GitHub Container Registry (ghcr.io), independientes del servidor. El despliegue completo se realiza con `make pull && make up` en cada repositorio de infraestructura.
- **Backups automáticos gestionados:** Las bases de datos Lightsail (PostgreSQL 16 y MySQL 8.0) incluyen backups automáticos diarios con point-in-time recovery y retención de 7 días. La restauración se realiza desde la consola de AWS sin intervención manual compleja.
- **Persistencia de eventos con Transactional Outbox:** Los eventos de emisión de documentos se escriben en la base de datos dentro de la misma transacción que los datos de negocio. Si Kafka está indisponible, los eventos permanecen en la tabla outbox hasta su publicación exitosa, garantizando cero pérdida de eventos.
- **Rollback inmediato:** El despliegue de cualquier versión anterior de un servicio se realiza en menos de 5 minutos revirtiendo el tag de la imagen Docker en GHCR y ejecutando `make up`.

El tiempo estimado de recuperación total (RTO ≤ 2 horas) está respaldado por estos mecanismos automatizados y ha sido verificado durante el despliegue del entorno QA.

### 8.3 Verificación de la Capacidad de Recuperación

La efectividad de la estrategia de recuperación se valida de forma continua mediante:

- **Pruebas en ambiente QA:** Cada despliegue significativo se valida primero en el entorno QA, que replica la arquitectura de producción. Esto permite verificar que los procedimientos de despliegue y restauración funcionan correctamente antes de afectar el servicio en producción.
- **Verificación de integridad de backups:** Se verifica periódicamente la integridad de los snapshots de bases de datos gestionadas y la capacidad de restauración desde los mismos.
- **Simulacros de recuperación:** Se realizan ejercicios de recuperación en el entorno QA para validar los tiempos de RTO y RPO declarados, documentando los resultados como evidencia de la efectividad de la estrategia.

---

## 9. Recursos de Producción

### 9.1 Asignación de Memoria por Servicio

La asignación total de memoria para los 24 servicios del inventario es de aproximadamente 4.3 GB sobre 16 GB disponibles (27%), lo que deja un margen de 73% (~11.7 GB) para absorber picos de demanda y crecimiento futuro. El detalle por servicio se encuentra en el Anexo B — Inventario de Activos Tecnológicos.

### 9.2 Costo Mensual Total de Infraestructura

*Los costos de infraestructura se gestionan internamente y están disponibles para revisión bajo solicitud formal de la DIAN. La información de costos no se incluye en este documento de acreditación por razones de confidencialidad empresarial.*

---

## 10. Condiciones y Niveles de Servicio

En cumplimiento del numeral 9 del artículo 55 de la Resolución 00165 de 2023, IDEAL SOFTWARE S.A.S establece las siguientes condiciones y niveles de servicio para sus clientes facturadores:

### 10.1 Disponibilidad del Servicio

| Servicio | Disponibilidad objetivo | Período de medición | Herramienta de medición |
|----------|:---:|:---:|---------|
| API GraphQL (api.idealsoluciones.com.co) | 99.5% mensual | Mes calendario | UptimeRobot |
| Aplicación Web (app.idealsoluciones.com.co) | 99.5% mensual | Mes calendario | UptimeRobot |

**Exclusiones del cálculo de disponibilidad:**
- Mantenimiento programado (notificado con ≥ 48 horas de anticipación)
- Indisponibilidad de los web services de la DIAN (causa externa no controlable)
- Eventos de fuerza mayor

**Ventana de mantenimiento programado:** Domingos 01:00-03:00 COT (notificado vía email con 48h de anticipación).

### 10.2 Tiempos de Respuesta ante Incidentes

| Nivel | Criterio | Tiempo de respuesta | Tiempo de resolución |
|:---:|---------|:---:|:---:|
| **P1 - Crítico** | Servicio completamente inoperativo | ≤ 30 minutos | ≤ 2 horas |
| **P2 - Alto** | Degradación severa / funciones críticas afectadas | ≤ 2 horas | ≤ 8 horas |
| **P3 - Medio** | Degradación parcial / funciones no críticas afectadas | ≤ 8 horas | ≤ 24 horas |
| **P4 - Bajo** | Inconveniente menor / cosmético | ≤ 24 horas | ≤ 72 horas |

**Horario de soporte:**
- P1: 24 horas / 7 días
- P2-P4: Lunes a Viernes, 8:00-18:00 COT

**Canales de atención:** Email, teléfono, WhatsApp Business

### 10.3 Tiempos de Procesamiento de Documentos

| Operación | Tiempo objetivo (P95) |
|-----------|:---:|
| Generación de factura electrónica | < 5 segundos |
| Actualización de estado post-DIAN | < 60 segundos |
| Generación de reportes | < 30 segundos |
| Transmisión a DIAN* | Depende de disponibilidad DIAN |

*El tiempo de transmisión a la DIAN depende de los web services de la DIAN y no está bajo control de IDEAL SOFTWARE S.A.S. El documento se encola en Kafka y se transmite en el menor tiempo posible.

### 10.4 Canal PQRSF

IDEAL SOFTWARE S.A.S dispone de un canal de **Peticiones, Quejas, Reclamos, Sugerencias y Felicitaciones (PQRSF)** que garantiza:
- Trazabilidad completa de cada solicitud mediante número de ticket
- Consulta de estado por parte del cliente
- Disponible para revisión de funcionalidades y contenidos por parte de la DIAN
- Tiempo de respuesta según niveles P1-P4 definidos anteriormente

### 10.5 Compensaciones por Incumplimiento de SLA

| Disponibilidad mensual | Crédito sobre factura mensual |
|:---:|:---:|
| 99.0% - 99.5% | 10% |
| 98.0% - 99.0% | 25% |
| < 98.0% | 50% |

---

## 11. Anexos y Soportes

### 11.1 Documentos Anexos (producidos por Ideal Software)

| Anexo | Documento | Contenido |
|:---:|----------|---------|
| A | Diagramas de Arquitectura (`punto-8-diagramas.md`) | 5 diagramas técnicos: arquitectura general, flujo de emisión, topología de redes, CI/CD, capas de seguridad |
| B | Inventario de Activos Tecnológicos (`punto-8-inventario-activos.md`) | Inventario completo de servidores, DBs, servicios, redes, software, servicios externos, clasificación de datos |
| C | Políticas de Seguridad de la Información (`punto-8-politicas-seguridad.md`) | 8 políticas con 54 controles: acceso, cifrado, operaciones, comunicaciones, incidentes, continuidad, proveedores, desarrollo |

### 11.2 Evidencias a adjuntar

| # | Evidencia | Descripción | Estado |
|:---:|----------|-------------|:---:|
| E-1 | Capturas consola AWS Lightsail | Screenshots mostrando instancias, DBs y firewall configurados | Completado |
| E-2 | Output `docker ps` en producción | Captura mostrando los 24 containers operativos | Pendiente |
| E-3 | Dashboard Grafana Cloud | Captura del panel de monitoreo con métricas activas | Pendiente |
| E-4 | Certificado TLS vigente | Captura del navegador mostrando certificado válido de api.idealsoluciones.com.co | Pendiente |
| E-5 | Evidencia de backups | Captura de configuración de backups en Lightsail Managed DB | Completado |
| E-6 | Output `terraform show` | Salida completa mostrando infraestructura provisionada | Completado |
| E-7 | Contrato AWS (Customer Agreement) | Documento de términos de servicio de AWS | Disponible en aws.amazon.com |
| E-8 | Contrato GitHub | Terms of Service de GitHub (CI/CD, GHCR) | Disponible en github.com |
| E-9 | UptimeRobot monitors | Captura mostrando monitores activos para api y app | Pendiente |
| E-11 | SSL Labs report | Calificación TLS de api.idealsoluciones.com.co (objetivo: A+) | Pendiente |
| E-12 | Security headers report | Reporte de cabeceras de seguridad HTTP | Pendiente |

---

## 12. Compromiso de Actualización

IDEAL SOFTWARE S.A.S se compromete a mantener actualizado el presente documento y sus anexos de forma anual, o cuando se presenten cambios significativos en la infraestructura, conforme a lo establecido en la Resolución 00165 de 2023.

| Aspecto | Detalle |
|---------|---------|
| **Frecuencia de actualización** | Anual |
| **Próxima actualización** | Junio 2027 |
| **Responsable de la actualización** | Ricardo Cermeño Bolaño - Director de Tecnología |
| **Aprobación** | Felix Palacio Arguelle - Representante Legal |
| **Criterios de actualización anticipada** | Cambio de proveedor cloud, cambio de arquitectura, nuevo servicio crítico, incidente de seguridad significativo |
| **Documentos complementarios** | PLAN-soberania-datos.md, PLAN-retencion-10-anios.md, PLAN-evidencias.md, PLAN-sla-clientes.md, PLAN-iso27001.md, PLAN-pentesting.md |

---

## 13. Firma

En constancia de lo anterior, se firma el presente documento en la ciudad de Santa Marta, a los ___ días del mes de __________ de 2026.

---

___________________________
**FELIX PALACIO ARGUELLE**
Representante Legal
IDEAL SOFTWARE S.A.S
NIT: 902.027.596-7

---

___________________________
**RICARDO CERMEÑO BOLAÑO**
Director de Tecnología
IDEAL SOFTWARE S.A.S
