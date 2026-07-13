# Anexo B - Inventario de Activos Tecnológicos

**Referencia:** Punto 8, Numeral 8, Artículo 55, Resolución 00165 de 2023
**Empresa:** IDEAL SOFTWARE S.A.S | NIT: 902.027.596-7
**Fecha:** Junio 2026 | **Versión:** 1.1

---

## 1. Activos de Infraestructura Cloud (Hardware Virtual)

### 1.1 Servidores de Cómputo

| ID | Nombre | vCPU | RAM | Almacenamiento | Bundle | S.O. | Entorno |
|:---:|--------|:---:|-----|------|--------|------|:---:|
| SRV-001 | ideal-production-server | 4 | 16 GB | 320 GB SSD | xlarge_3_0 | Ubuntu 22.04 LTS | Producción |
| SRV-002 | ideal-qa-server | 2 | 8 GB | 160 GB SSD | large_3_0 | Ubuntu 22.04 LTS | QA |

### 1.2 Bases de Datos Gestionadas

| ID | Motor | Bundle | Entorno | Acceso Público | Backup |
|:---:|-------|--------|:---:|:---:|--------|
| DB-001 | PostgreSQL 15 | micro_1_0 (1 GB RAM, 40 GB SSD) | Producción | NO | Diario 04:00 UTC (7 días) |
| DB-002 | MySQL 8.0 | micro_1_0 (1 GB RAM, 40 GB SSD) | Producción | NO | Diario 04:00 UTC (7 días) |
| DB-003 | PostgreSQL 15 | micro_1_0 (1 GB RAM, 40 GB SSD) | QA | SI (solo QA) | Diario 04:00 UTC (7 días) |
| DB-004 | MySQL 8.0 | micro_1_0 (1 GB RAM, 40 GB SSD) | QA | SI (solo QA) | Diario 04:00 UTC (7 días) |

### 1.3 Dominios y DNS

| ID | Dominio | Propósito | Entorno |
|:---:|---------|---------|:---:|
| DNS-001 | idealsoluciones.com.co | Dominio corporativo | Producción |
| DNS-002 | api.idealsoluciones.com.co | API GraphQL | Producción |
| DNS-003 | app.idealsoluciones.com.co | Aplicación web | Producción |
| DNS-004 | api.qa.idealsoluciones.com.co | API GraphQL QA | QA |
| DNS-005 | app.qa.idealsoluciones.com.co | Aplicación web QA | QA |

---

## 2. Activos de Software — Servicios de Aplicación

| ID | Servicio | Imagen Docker | Función |
|:---:|----------|---------------|---------|
| APP-001 | Caddy | caddy:2.8.4-alpine | Reverse proxy, TLS automático |
| APP-002 | Apollo Router | apollographql/apollo-runtime | Gateway GraphQL Federation v2 |
| APP-003 | Core MS | ghcr.io/ideal-saas/core-ms | Empresas, usuarios, configuración |
| APP-004 | Inventory MS | ghcr.io/ideal-saas/inventoryms | Inventario y productos |
| APP-005 | Purchases MS | ghcr.io/ideal-saas/purchase-ms | Facturación, compras, notas |
| APP-006 | File Uploader MS | ghcr.io/ideal-saas/file-uploader-ms | Gestión de archivos |
| APP-007 | Accounting MS | ghcr.io/ideal-saas/accounting-ms | Contabilidad |
| APP-008 | Report MS | ghcr.io/ideal-saas/report-ms | Reportes |
| APP-009 | Payroll MS | ghcr.io/ideal-saas/payroll-ms | Nómina electrónica |
| APP-010 | Treasury MS | ghcr.io/ideal-saas/treasury-ms | Tesorería |
| APP-011 | Apache Kafka | apache/kafka-native:3.9.0 | Broker de mensajes KRaft |
| APP-012 | Kafka UI | kafbat/kafka-ui | Administración Kafka |
| APP-013 | Consumer Factura | ghcr.io/ideal-saas/ideal-stream-consumers-dian-einvoice-emission | Emisión factura electrónica |
| APP-014 | Consumer Nota Crédito | ghcr.io/ideal-saas/ideal-stream-consumers-dian-note-credit-emission | Emisión nota crédito |
| APP-015 | Consumer Nota Débito | ghcr.io/ideal-saas/ideal-stream-consumers-dian-note-debit-emission | Emisión nota débito |
| APP-016 | Consumer Doc. Soporte | ghcr.io/ideal-saas/ideal-stream-consumers-dian-document-support-emission | Emisión documento soporte |
| APP-017 | Consumer Nómina | ghcr.io/ideal-saas/ideal-stream-consumers-dian-payroll-emission | Emisión nómina electrónica |
| APP-018 | Consumer Ajuste Nómina | ghcr.io/ideal-saas/ideal-stream-consumers-dian-payroll-adjustment-emission | Emisión ajuste nómina |
| APP-019 | API DIAN | ghcr.io/ideal-saas/dian-invoicer-ms | Integración DIAN: UBL 2.1, firma X.509, transmisión SOAP |
| APP-020 | Aplicación Web | ghcr.io/ideal-saas/acc-web-app | Frontend Next.js |
| APP-021 | Grafana Alloy | grafana/alloy | Recolección métricas/logs |
| APP-022 | cAdvisor | gcr.io/cadvisor/cadvisor | Métricas de containers |
| APP-023 | Admin MS | ghcr.io/ideal-saas/ideal-admin-ms | Backend de administración |
| APP-024 | Admin Web | ghcr.io/ideal-saas/ideal-admin-web | Panel de administración (Vite) |

---

## 3. Activos de Red — Docker Networks

La topología de las 7 redes Docker se documenta en el documento principal (§5.4). A continuación se listan los identificadores de activo:

| ID | Nombre Docker | Definida en |
|:---:|---------------|-------------|
| NET-001 | accounting-iac_accounting-net | accounting-iac |
| NET-002 | dian-api-iac_api-dian-net | dian-api-iac |
| NET-003 | kafka-iac_kafka-net | kafka-iac |
| NET-004 | kafka-iac_kafkaui-net | kafka-iac |
| NET-005 | ideal-app-iac_ideal-app-net | ideal-app-iac |
| NET-006 | monitoring-iac_monitoring-net | monitoring-iac |
| NET-007 | ideal-admin-iac_admin-net | ideal-admin-iac |

---

## 4. Activos de Software — Herramientas de Plataforma

| ID | Software | Propósito | Ubicación |
|:---:|----------|---------|-----------|
| PLT-001 | Docker Engine | Runtime de containers | SRV-001, SRV-002 |
| PLT-002 | Docker Compose v2 | Orquestación de servicios | SRV-001, SRV-002 |
| PLT-003 | Make (GNU) | Task runner de operaciones | SRV-001, SRV-002 |
| PLT-004 | Ubuntu 22.04 LTS | Sistema operativo | SRV-001, SRV-002 |
| PLT-005 | Terraform (HashiCorp) | Provisioning de infraestructura (IaC) | Estación admin |
| PLT-006 | Rover (Apollo) | Composición de supergraph GraphQL | CI/CD |
| PLT-007 | GitHub Actions | Pipelines de CI/CD | github.com/ideal-saas |
| PLT-008 | GitHub Container Registry | Registro privado de imágenes Docker | ghcr.io/ideal-saas |
| PLT-009 | GitHub Environments | Control de deploy con aprobaciones | qa, production |
| PLT-010 | GitHub Secrets | Almacenamiento seguro de credenciales | Repositorios infra |

---

## 5. Servicios Externos (Terceros)

| Servicio | Proveedor | Propósito | SLA | Clasificación |
|----------|-----------|---------|:---:|:---:|
| AWS Lightsail | Amazon Web Services | Infraestructura cloud (cómputo, DB, red) | 99.99% | Crítico |
| GitHub | Microsoft | Código fuente, CI/CD, registro de imágenes | 99.9% | Crítico |
| Firebase Authentication | Google | Autenticación de usuarios finales | 99.95% | Crítico |
| Let's Encrypt | ISRG | Certificados TLS gratuitos automáticos | 99.9% | Crítico |
| Grafana Cloud | Grafana Labs | Monitoreo, métricas, logs, alertas | 99.9% | Alto |
| AWS S3 | Amazon Web Services | Almacenamiento de archivos y documentos | 99.99% | Alto |
| UptimeRobot | UptimeRobot | Monitoreo de disponibilidad externa 24/7 | 99.9% | Medio |
| DIAN Web Services | DIAN Colombia | Validación previa de documentos electrónicos | N/A (gobierno) | Crítico |

---

## 6. Clasificación de Datos

| Tipo de Dato | Ejemplos | Clasificación | Base de Datos | Retención |
|--------------|----------|:---:|:---:|---------|
| Datos tributarios | Facturas, notas crédito/débito, XMLs UBL 2.1 | Confidencial | PostgreSQL + MySQL | 10 años (Art. 632 E.T.) |
| Datos empresariales | NIT, razón social, resoluciones DIAN | Confidencial | PostgreSQL | Vigencia empresa |
| Datos de nómina | Liquidaciones, devengados, deducciones | Confidencial | PostgreSQL | 10 años |
| Datos contables | Plan de cuentas, asientos, estados financieros | Confidencial | PostgreSQL | 10 años |
| Datos de usuarios | Emails, nombres, roles | Personal | PostgreSQL + Firebase | Vigencia cuenta |
| Datos de inventario | Productos, precios, cantidades | Interno | PostgreSQL | Vigencia empresa |
| Logs de acceso | IPs, timestamps, endpoints | Interno | Grafana Cloud | 30 días |
| Métricas de sistema | CPU, memoria, red por container | Interno | Grafana Cloud | 15 días |

---

## 7. Resumen de Costos Mensuales de Infraestructura

*Los costos de infraestructura están disponibles para revisión bajo solicitud formal. No se incluyen en este documento de acreditación por razones de confidencialidad empresarial.*

---

## 8. Matriz de Responsabilidades (RACI)

| Activo | Responsable | Aprueba | Consulta | Informa |
|--------|:-----------:|:-------:|:--------:|:-------:|
| Servidores AWS | CTO | Gerencia | Ing. Software | Administración |
| Bases de datos | CTO | Gerencia | Contador | Administración |
| Código fuente | Ing. Software | CTO | - | Gerencia |
| CI/CD Pipelines | CTO | Gerencia | Ing. Software | - |
| Monitoreo | CTO | Gerencia | - | Administración |
| Backups | CTO | Gerencia | - | Administración |
| Credenciales | CTO | Gerencia | Abogado | - |
| Certificados TLS | Caddy (automático) | CTO | - | - |

---

## 9. Control de Versiones del Inventario

| Versión | Fecha | Cambio | Responsable |
|:---:|--------|--------|-------------|
| 1.1 | Junio 2026 | Actualización con servicios de administración, PostgreSQL 15, bundles micro_1_0; redacción de IPs, corrección red consumers, alineación bundles micro_1_0 | Ricardo Cermeño Bolaño - CTO |

**Próxima revisión programada:** Junio 2027

---

**Firma:**

___________________________
RICARDO CERMEÑO BOLAÑO
Director de Tecnología
IDEAL SOFTWARE S.A.S
