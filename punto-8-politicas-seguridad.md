# Anexo C - Políticas de Seguridad de la Información

**Referencia:** Punto 8, Numeral 8, Artículo 55, Resolución 00165 de 2023
**Empresa:** IDEAL SOFTWARE S.A.S | NIT: 902.027.596-7
**Fecha:** Junio 2026 | **Versión:** 1.1

---

## Introducción

El presente documento establece las políticas de seguridad de la información adoptadas por IDEAL SOFTWARE S.A.S para la prestación de servicios de facturación electrónica como proveedor tecnológico. Estas políticas definen los lineamientos, controles y responsabilidades que garantizan la confidencialidad, integridad y disponibilidad de la información de nuestros clientes y de los documentos electrónicos procesados.

---

## 1. Política de Control de Acceso

**Objetivo:** Acceso restringido exclusivamente a personas autorizadas, aplicando el principio de mínimo privilegio.

| Tipo de Acceso | Mecanismo | Restricción |
|---|---|---|
| Usuarios finales | Firebase Auth + JWT | Aislamiento por tenant |
| Admin servidores | SSH ed25519 | CIDRs autorizados |
| CI/CD | GitHub Secrets + OIDC | Aprobación manual para producción |
| Bases de datos | Credenciales en .env no versionado | Redes Docker internas |
| Monitoreo | Grafana Cloud + Kafka UI localhost | Sin puertos de administración expuestos |

**Controles activos:** 7 (Autenticación multifactor, SSH keypair, firewall restrictivo, SSH restringido por IP, aprobación deploy prod, DB no pública, secretos cifrados en CI/CD).
**Responsable:** Director de Tecnología.

---

## 2. Política de Cifrado y Protección de Datos en Tránsito

**Objetivo:** Proteger toda la información transmitida mediante cifrado.

Toda comunicación pública se transmite por HTTPS (TLS 1.2/1.3) con certificados emitidos automáticamente por Let's Encrypt y renovados sin intervención manual. HTTP/3 (QUIC) está habilitado. El tráfico HTTP se redirige automáticamente a HTTPS.

Los microservicios se comunican internamente a través de redes Docker privadas, sin que el tráfico abandone el servidor. La comunicación con la DIAN utiliza HTTPS/SOAP con firma digital X.509 y cálculo de CUFE/CUDE mediante SHA-384.

**Controles activos:** 6 (TLS automático Let's Encrypt, mínimo TLS 1.2, HTTP/3 QUIC, redirección HTTP→HTTPS, firma digital XML, 7 redes Docker privadas).
**Responsable:** Director de Tecnología.

---

## 3. Política de Seguridad en Operaciones

**Objetivo:** Garantizar la operación correcta y segura de los sistemas, incluyendo gestión de cambios, capacidad y separación de ambientes.

**Gestión de cambios:** Todo cambio se gestiona mediante Git con revisión por Pull Request. Las imágenes Docker son inmutables y versionadas en GitHub Container Registry. El deploy a QA es automático; el deploy a producción requiere aprobación manual. El rollback está disponible en menos de 5 minutos.

**Separación de ambientes:** QA (`*.qa.idealsoluciones.com.co`) y producción (`*.idealsoluciones.com.co`) cuentan con servidores, bases de datos y credenciales independientes y completamente aisladas. La infraestructura se provisiona mediante Terraform.

**Gestión de capacidad:** Cada servicio tiene límites de memoria y política de reinicio automático (`restart: unless-stopped`). Se monitorean CPU, memoria, red y disco con alertas por umbrales.

**Protección contra malware:** Imágenes Docker basadas en Alpine Linux (~5 MB base). Ubuntu 22.04 LTS con actualizaciones de seguridad automáticas. Containers ejecutados con privilegios mínimos.

**Controles activos:** 10 (versionamiento Git, revisión Pull Requests, separación QA/Producción, deploy controlado, límites de recursos, restart automático, monitoreo de capacidad, imágenes inmutables, rollback rápido, IaC reproducible).
**Responsable:** Director de Tecnología / Ingeniero de Software.

---

## 4. Política de Seguridad en Comunicaciones

**Objetivo:** Proteger la información transferida a través de las redes mediante segmentación y aislamiento.

La plataforma opera con 7 redes Docker independientes y aisladas. Cada servicio se conecta únicamente a las redes estrictamente necesarias para su función (principio de mínimo privilegio):

| Servicio | Redes permitidas | Justificación |
|----------|-----------------|---------------|
| Caddy | accounting, api-dian, kafkaui, ideal-app, admin | Alcanza todos los backends que expone |
| Apollo Router | accounting | Solo necesita los subgraphs |
| Core MS | accounting, api-dian | Comunicación con API DIAN |
| Purchases MS | accounting, api-dian, kafka | Eventos a Kafka, acceso a API DIAN |
| Payroll MS | accounting, api-dian, kafka | Eventos a Kafka, acceso a API DIAN |
| Otros microservicios | accounting | Solo necesitan el gateway |
| 6 Consumers | dian-api-iac, kafka-iac | Consumen de Kafka, envían a API DIAN |
| Admin MS/Web | admin | Solo panel de administración |
| Monitoreo | monitoring | Red aislada |

El firewall perimetral solo expone los puertos 22 (SSH restringido por CIDR), 80 (HTTP) y 443 (HTTPS). Ningún microservicio expone puertos públicos. El único punto de entrada es Caddy.

**Controles activos:** 7 (7 redes aisladas, firewall 3 puertos, SSH restringido, sin puertos públicos directos, punto de entrada único, Kafka UI local-only, DB no accesible públicamente).
**Responsable:** Director de Tecnología.

---

## 5. Política de Gestión de Incidentes de Seguridad

**Objetivo:** Enfoque consistente para detección, respuesta, contención y recuperación de incidentes.

**Clasificación de incidentes:**

| Nivel | Criticidad | Tiempo de respuesta | Ejemplo |
|:---:|:---:|:---:|---------|
| P1 | Crítica | ≤ 30 min | Servicio inoperativo o brecha de seguridad |
| P2 | Alta | ≤ 2 horas | Degradación severa, fallo en emisión de facturas |
| P3 | Media | ≤ 8 horas | Degradación parcial sin impacto en emisión |
| P4 | Baja | ≤ 24 horas | Anomalía sin impacto operativo |

**Proceso:** Detección (alertas automáticas: Grafana Cloud, UptimeRobot) → Clasificación → Contención → Erradicación → Recuperación → Lecciones aprendidas.

**Mecanismos de detección:** UptimeRobot (disponibilidad externa), cAdvisor + Grafana Cloud (métricas de containers), Grafana Alloy + Loki (logs centralizados), Docker restart policy (fallos de container).

**Controles activos:** 5 (alertas automáticas por caída, logs centralizados, métricas en tiempo real, registro de incidentes, escalamiento definido).
**Responsable:** Director de Tecnología (P1-P2) / Ingeniero de Software (P3-P4).

---

## 6. Política de Continuidad del Negocio

**Objetivo:** Garantizar la continuidad de los servicios de facturación electrónica ante eventos adversos.

La estrategia completa de continuidad del negocio —incluyendo backups operativos (§7.1), conservación a largo plazo de documentos electrónicos (§7.1.2), alta disponibilidad (§7.2), escenarios de recuperación (§7.3), objetivos RPO/RTO (§8.1), y el plan de recuperación ante desastres (§8.3)— se encuentra documentada en las secciones 7 y 8 del documento principal. Las bases de datos gestionadas de AWS Lightsail incluyen backups automáticos diarios con retención de 7 días y point-in-time recovery.

**Controles activos:** 7 (backups automáticos diarios, final snapshots en producción, restart automático de containers, mensajes persistentes en Kafka, IaC reproducible, imágenes inmutables en registry, deploy en < 5 min para rollback).
**Responsable:** Director de Tecnología.

---

## 7. Política de Gestión de Proveedores

### 7.1 Objetivo
Asegurar la protección de los activos de la organización que son accesibles por proveedores de servicios externos, manteniendo un nivel adecuado de seguridad en toda la cadena de suministro.

### 7.2 Alcance
Aplica a todos los proveedores de servicios tecnológicos que procesan, almacenan o transmiten información de la plataforma de facturación electrónica.

### 7.3 Proveedores Críticos y sus Controles

| Proveedor | Servicio | Datos expuestos | Controles del proveedor | Nuestros controles |
|-----------|----------|-----------------|-------------------------|-------------------|
| Amazon Web Services | Infraestructura cloud | Todos (servidores, DBs) | SOC 2, ISO 27001, CSA STAR Level 2 | Cifrado, acceso restringido, backups |
| GitHub (Microsoft) | Código fuente, CI/CD, imágenes | Código, credenciales CI/CD | SOC 2, ISO 27001 | Repos privados, secrets cifrados |
| Google (Firebase) | Autenticación | Emails y tokens de usuarios | SOC 2, ISO 27001, FedRAMP | Reglas de seguridad, MFA disponible |
| Grafana Labs | Monitoreo | Métricas y logs (no datos de negocio) | SOC 2, ISO 27001 | Solo métricas técnicas, sin PII |
| Let's Encrypt (ISRG) | Certificados TLS | Nombres de dominio | WebTrust, auditorías públicas | Renovación automática |

### 7.4 Criterios de Selección de Proveedores

- Certificaciones de seguridad reconocidas (SOC 2, ISO 27001)
- SLA documentado con disponibilidad >= 99.9%
- Cifrado de datos en reposo y en tránsito
- Ubicación geográfica de datos conocida
- Política de respuesta ante incidentes publicada
- Historial de incidentes de seguridad

### 7.5 Revisión de Proveedores
- Evaluación anual de la vigencia de certificaciones
- Revisión de SLA y disponibilidad real
- Evaluación de alternativas ante cambios significativos en términos de servicio

### 7.6 Responsable
Director de Tecnología / Gerente General

---

## 8. Política de Desarrollo Seguro

**Objetivo:** Incorporar la seguridad en todo el ciclo de vida de desarrollo de software.

**Control de código fuente:** Repositorios Git privados (GitHub), ramas protegidas con Pull Request obligatorio, revisión de código por al menos un revisor. Dependabot activado para detección automática de vulnerabilidades.

**Separación de configuración:** Credenciales nunca incluidas en código fuente. Variables de entorno para toda configuración sensible. Archivos `.env` incluidos en `.gitignore`.

**Imágenes Docker:** Basadas en Alpine Linux (superficie de ataque mínima), multi-stage builds, procesos no ejecutados como root cuando es posible.

**CI/CD seguro:** Build automatizado en GitHub Actions (entorno efímero). Credenciales inyectadas vía GitHub Secrets. Autenticación a AWS mediante OpenID Connect (OIDC) — sin credenciales de larga duración. Despliegue a producción mediante SSH con keypair ed25519 rotativo.

**Controles activos:** 9 (repos privados, Pull Requests obligatorios, Dependabot, secrets fuera del código, imágenes base mínimas, registry privado, builds reproducibles, autenticación OIDC, deploy SSH con keypair rotativo).
**Responsable:** Director de Tecnología / Ingeniero de Software.

---

## 9. Resumen de Políticas y Estado de Cumplimiento

| # | Política | Controles activos | Responsable principal |
|:---:|----------|:---:|---------------------|
| 1 | Control de Acceso | 7 | CTO |
| 2 | Cifrado y Protección en Tránsito | 6 | CTO |
| 3 | Seguridad en Operaciones | 10 | CTO / Ing. Software |
| 4 | Seguridad en Comunicaciones | 7 | CTO |
| 5 | Gestión de Incidentes | 5 | CTO |
| 6 | Continuidad del Negocio | 7 | CTO |
| 7 | Gestión de Proveedores | 5 criterios | CTO / Gerente |
| 8 | Desarrollo Seguro | 9 | CTO / Ing. Software |
| **Total** | **8 políticas** | **56 controles** | - |

---

## 10. Control de Versiones del Documento

| Versión | Fecha | Cambio | Responsable |
|:---:|--------|--------|-------------|
| 1.0 | Mayo 2026 | Versión inicial | Ricardo Cermeño Bolaño - CTO |
| 1.1 | Junio 2026 | Agregada política de CI/CD con OIDC, actualización de monitoreo; corrección conteo redes Docker (6→7) | Ricardo Cermeño Bolaño - CTO |

**Próxima revisión programada:** Junio 2027

---

**Firmas:**

___________________________
FELIX PALACIO ARGUELLE
Representante Legal
IDEAL SOFTWARE S.A.S
NIT: 902.027.596-7

___________________________
RICARDO CERMEÑO BOLAÑO
Director de Tecnología
IDEAL SOFTWARE S.A.S
