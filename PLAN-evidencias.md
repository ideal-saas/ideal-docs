# Guía de Recolección de Evidencias — Certificación DIAN

**Empresa:** IDEAL SOFTWARE S.A.S  
**NIT:** 902.027.596-7  
**Documento:** PLAN-EVIDENCIAS  
**Versión:** 1.0  
**Fecha de emisión:** Mayo 2026  
**Referencia normativa:** Numeral 8, Artículo 55, Resolución 00165 de 2023

---

## Tabla de Contenidos

1. [Resumen de Estado de Evidencias](#1-resumen-de-estado-de-evidencias)
2. [Estructura de Carpetas](#2-estructura-de-carpetas)
3. [Instrucciones por Evidencia](#3-instrucciones-por-evidencia)
   - [E-1: Capturas consola AWS Lightsail](#e-1-capturas-consola-aws-lightsail)
   - [E-2: Output docker ps en producción](#e-2-output-docker-ps-en-producción)
   - [E-3: Dashboard Grafana Cloud](#e-3-dashboard-grafana-cloud)
   - [E-4: Certificado TLS vigente](#e-4-certificado-tls-vigente)
   - [E-5: Evidencia de backups en Lightsail DB](#e-5-evidencia-de-backups-en-lightsail-db)
   - [E-6: Output terraform show](#e-6-output-terraform-show)
   - [E-7: Contrato AWS (Customer Agreement)](#e-7-contrato-aws-customer-agreement)
   - [E-8: Contrato GitHub](#e-8-contrato-github)
   - [E-9: UptimeRobot monitors](#e-9-uptimerobot-monitors)
   - [E-10: Resultados de Simulacro DRP](#e-10-resultados-de-simulacro-drp)
4. [Checklist Final antes de Enviar a DIAN](#4-checklist-final-antes-de-enviar-a-dian)

---

## 1. Resumen de Estado de Evidencias

| # | Evidencia | Responsable | Estado | Fecha límite | Notas |
|:---:|----------|-------------|:------:|-------------|-------|
| E-1 | Capturas consola AWS Lightsail | Ricardo Cermeño | Pendiente | [FECHA] | Requiere acceso AWS Console |
| E-2 | Output `docker ps` en producción | Ricardo Cermeño | Pendiente | [FECHA] | Requiere acceso SSH producción |
| E-3 | Dashboard Grafana Cloud | Ricardo Cermeño | Pendiente | [FECHA] | Requiere métricas activas |
| E-4 | Certificado TLS vigente | Ricardo Cermeño | Pendiente | [FECHA] | Requiere dominio activo |
| E-5 | Evidencia de backups Lightsail DB | Ricardo Cermeño | Pendiente | [FECHA] | Requiere acceso AWS Console |
| E-6 | Output `terraform show` | Ricardo Cermeño | Pendiente | [FECHA] | Requiere acceso local al código |
| E-7 | Contrato AWS (Customer Agreement) | Felix Palacio | Pendiente | [FECHA] | Disponible en AWS Console |
| E-8 | Contrato GitHub | Felix Palacio | Pendiente | [FECHA] | Disponible online |
| E-9 | UptimeRobot monitors | Ricardo Cermeño | Pendiente | [FECHA] | Requiere 24h de actividad |
| E-10 | Resultados simulacro DRP | Ricardo Cermeño | Pendiente | [FECHA] | Ejecutar en servidor QA |

> **Instrucción:** Actualizar la columna "Estado" con: `Pendiente` / `En proceso` / `Completado` / `Bloqueado`.  
> Actualizar "Fecha límite" con la fecha real de entrega a la DIAN.

---

## 2. Estructura de Carpetas

Crear la siguiente estructura para organizar todas las evidencias:

```bash
# Crear estructura de carpetas (ejecutar desde /Users/rcermeno/ideal-infra/ideal-docs/)
mkdir -p ideal-docs/evidencias/E-1-aws-lightsail
mkdir -p ideal-docs/evidencias/E-2-docker-ps
mkdir -p ideal-docs/evidencias/E-3-grafana
mkdir -p ideal-docs/evidencias/E-4-certificado-tls
mkdir -p ideal-docs/evidencias/E-5-backups
mkdir -p ideal-docs/evidencias/E-6-terraform
mkdir -p ideal-docs/evidencias/E-7-contrato-aws
mkdir -p ideal-docs/evidencias/E-8-contrato-github
mkdir -p ideal-docs/evidencias/E-9-uptimerobot
mkdir -p ideal-docs/evidencias/E-10-simulacro-drp
```

**Resultado esperado:**
```
ideal-docs/
└── evidencias/
    ├── E-1-aws-lightsail/
    ├── E-2-docker-ps/
    ├── E-3-grafana/
    ├── E-4-certificado-tls/
    ├── E-5-backups/
    ├── E-6-terraform/
    ├── E-7-contrato-aws/
    ├── E-8-contrato-github/
    ├── E-9-uptimerobot/
    └── E-10-simulacro-drp/
```

### Convención de nombres de archivos

Todos los archivos de evidencia deben seguir el formato:

```
[CODIGO]-[DESCRIPCION]-[FECHA-YYYYMMDD].[extension]
```

Ejemplos:
- `E-1-lightsail-instancias-20260519.png`
- `E-2-docker-ps-produccion-20260519.txt`
- `E-6-terraform-show-redactado-20260519.txt`

---

## 3. Instrucciones por Evidencia

---

### E-1: Capturas consola AWS Lightsail

**Por qué es requerida:**  
La DIAN requiere demostrar que la infraestructura de producción opera en un proveedor cloud de nivel empresarial con configuraciones de seguridad adecuadas (Art. 55, Num. 8, Res. 00165/2023). Esta evidencia demuestra la existencia real de los recursos de cómputo, la separación de ambientes y que las bases de datos de producción NO son públicamente accesibles.

**Archivos a producir:** 4 capturas de pantalla

#### Paso a paso:

**Captura 1 — Instancias Lightsail**

1. Abrir Chrome/Edge en modo incógnito
2. Navegar a: `https://console.aws.amazon.com/lightsail`
3. Iniciar sesión con credenciales de la cuenta de IDEAL SOFTWARE
4. En el panel principal de Lightsail, hacer clic en **"Instances"**
5. Verificar que la instancia de producción aparece en la lista
6. **Tomar captura de pantalla** que muestre:
   - Nombre de la instancia de producción
   - Estado: **"Running"** (punto verde)
   - Bundle (plan contratado, ej: `2_xlarge_1_0` o el plan actual)
   - Región: **us-east-1**
7. Si hay instancia QA, hacer captura separada

**Lo que debe aparecer en la captura:**
```
✓ Nombre instancia de producción (ej: ideal-production)
✓ Estado "Running" claramente visible
✓ Plan/bundle de la instancia
✓ Región us-east-1
✓ URL de la consola visible en la barra de direcciones
```

**Archivo:** `E-1-lightsail-instancias-[FECHA].png`

---

**Captura 2 — Bases de datos gestionadas**

1. En Lightsail, hacer clic en **"Databases"** (menú lateral)
2. Verás las dos bases de datos: `ideal-prod-postgres` y `ideal-prod-mysql`
3. **Tomar captura de pantalla** de la lista que muestre:
   - Nombres de ambas bases de datos
   - Motor: PostgreSQL 16 y MySQL 8.0
   - Estado: "Available" (punto verde)
4. Hacer clic en **`ideal-prod-postgres`** para ver el detalle
5. En la página de detalle, desplazarse hasta encontrar la configuración **"Publicly accessible"**
6. **Tomar captura de pantalla** que muestre claramente:
   - Nombre de la DB
   - **Publicly accessible: No** (o el toggle desactivado)
   - Estado: Available
7. Repetir los pasos 4-6 para **`ideal-prod-mysql`**

**Lo que debe aparecer en la captura:**
```
✓ Nombre de cada base de datos
✓ Motor de base de datos (PostgreSQL 16 / MySQL 8.0)
✓ Estado "Available"
✓ "Publicly accessible: No" claramente visible para ambas DBs de producción
✓ URL de la consola visible
```

**Archivos:**
- `E-1-lightsail-databases-lista-[FECHA].png`
- `E-1-lightsail-postgres-prod-no-public-[FECHA].png`
- `E-1-lightsail-mysql-prod-no-public-[FECHA].png`

---

**Captura 3 — IPs estáticas**

1. En Lightsail, hacer clic en **"Networking"** → **"Static IPs"**
2. **Tomar captura** mostrando la IP estática asignada a la instancia de producción

**Archivo:** `E-1-lightsail-static-ip-[FECHA].png`

---

**Captura 4 — Reglas de firewall**

1. En Lightsail → **"Instances"** → Clic en la instancia de producción
2. Ir a la pestaña **"Networking"**
3. Desplazarse a la sección **"Firewall"**
4. **Tomar captura** mostrando las reglas configuradas (puertos abiertos)

**Lo que debe aparecer:**
```
✓ Puerto 80 (HTTP) — abierto (Caddy redirect HTTP→HTTPS)
✓ Puerto 443 (HTTPS) — abierto (tráfico de producción)
✓ Puerto 22 (SSH) — abierto (restringido a IPs del equipo, idealmente)
✓ Otros puertos de servicios internos (si aplica)
```

**Archivo:** `E-1-lightsail-firewall-[FECHA].png`

---

**Criterio de aceptación DIAN:**
- Las capturas muestran la cuenta AWS real (no demo)
- La instancia de producción está en estado "Running"
- Al menos una DB tiene `Publicly accessible: No`
- Las capturas tienen fecha visible (ya sea en el OS o en el URL)

**Carpeta destino:** `ideal-docs/evidencias/E-1-aws-lightsail/`

---

### E-2: Output docker ps en producción

**Por qué es requerida:**  
Demuestra que todos los servicios de la plataforma están activos y operacionales en el momento de la certificación. Confirma la existencia real de los 22+ contenedores declarados en la documentación técnica.

**Archivos a producir:** 1 captura de pantalla + 1 archivo de texto

#### Paso a paso:

**Paso 1 — Conectarse al servidor de producción**

```bash
# Desde tu equipo local
ssh -i ~/.ssh/ideal_prod_key ubuntu@[PROD_IP]
# Resultado esperado: ubuntu@[hostname]:~$
```

**Paso 2 — Ejecutar el comando y capturar salida**

```bash
# Comando exacto a ejecutar:
docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"
```

**Paso 3 — Guardar la salida a un archivo**

```bash
# Guardar con timestamp
docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}" > /tmp/docker-ps-output.txt
echo "Fecha de captura: $(date '+%Y-%m-%d %H:%M:%S %Z')" >> /tmp/docker-ps-output.txt
echo "Servidor: $(hostname)" >> /tmp/docker-ps-output.txt
echo "Total containers activos: $(docker ps --format '{{.Names}}' | wc -l)" >> /tmp/docker-ps-output.txt
cat /tmp/docker-ps-output.txt
```

**Paso 4 — Copiar el archivo al equipo local**

```bash
# Desde tu equipo local (nueva terminal):
scp -i ~/.ssh/ideal_prod_key ubuntu@[PROD_IP]:/tmp/docker-ps-output.txt \
    /Users/rcermeno/ideal-infra/ideal-docs/evidencias/E-2-docker-ps/E-2-docker-ps-produccion-$(date +%Y%m%d).txt
```

**Paso 5 — Tomar captura de pantalla del terminal**

Tomar screenshot del terminal mostrando la salida del comando `docker ps`. La captura debe mostrar:

```
✓ El prompt del servidor (ubuntu@[hostname])
✓ El comando ejecutado
✓ La tabla completa de containers con columnas: Names, Image, Status, Ports
✓ Al menos 22 filas de containers
✓ Todos los containers en estado "Up X hours" (no "Restarting" ni "Exited")
```

**Archivo de texto:** `E-2-docker-ps-produccion-[FECHA].txt`  
**Captura:** `E-2-docker-ps-produccion-[FECHA].png`

---

**Salida esperada (ejemplo de estructura):**

```
NAMES                   IMAGE                                    STATUS          PORTS
caddy                   ghcr.io/ideal-saas/caddy:latest         Up 3 days       0.0.0.0:80->80/tcp, 0.0.0.0:443->443/tcp
apollo-router           ghcr.io/ideal-saas/apollo-router:latest Up 3 days       
core-ms                 ghcr.io/ideal-saas/core-ms:latest       Up 3 days       
purchase-ms             ghcr.io/ideal-saas/purchase-ms:latest   Up 3 days       
[... 18+ líneas más ...]
kafka                   ghcr.io/ideal-saas/kafka:latest         Up 3 days       
kafka-ui                ghcr.io/ideal-saas/kafka-ui:latest      Up 3 days       
api_dian                ghcr.io/ideal-saas/api-dian:latest      Up 3 days       
ideal-app               ghcr.io/ideal-saas/ideal-app:latest     Up 3 days       
```

**Criterio de aceptación DIAN:**
- Mínimo 22 containers visibles
- Ningún container en estado "Restarting", "Exited" o "Error"
- La columna Status muestra "Up" seguido de tiempo de actividad (horas o días)
- El archivo de texto incluye la fecha y nombre del servidor

**Carpeta destino:** `ideal-docs/evidencias/E-2-docker-ps/`

---

### E-3: Dashboard Grafana Cloud

**Por qué es requerida:**  
Demuestra que IDEAL SOFTWARE cuenta con monitoreo continuo de la infraestructura, requisito de continuidad del servicio según el artículo 55 de la Resolución 00165/2023. El monitoreo activo es fundamental para detectar y responder a incidentes oportunamente.

**Archivos a producir:** 2-3 capturas de pantalla

#### Paso a paso:

**Paso 1 — Acceder a Grafana Cloud**

1. Navegar a: `https://grafana.com`
2. Hacer clic en **"Sign in"**
3. Iniciar sesión con las credenciales de la organización Ideal Software

**Paso 2 — Navegar al dashboard de producción**

1. En el menú lateral, hacer clic en **"Dashboards"**
2. Buscar y abrir el dashboard de monitoreo de producción (ej: "Ideal Production", "Docker Containers", o similar)

**Paso 3 — Captura 1: Vista general del dashboard**

1. Asegurarse de que el selector de tiempo muestra las últimas horas (ej: "Last 1 hour" o "Last 6 hours")
2. Verificar que hay datos activos (no una línea plana de ceros)
3. **Tomar captura de pantalla completa** que muestre:

```
✓ Nombre del dashboard visible
✓ Selector de tiempo en la esquina superior derecha
✓ Al menos 2-3 paneles con métricas activas (líneas de datos, no vacíos)
✓ Métricas de CPU o memoria por container
✓ URL de Grafana visible (grafana.com/...)
✓ Fecha/hora actual visible en el dashboard
```

**Archivo:** `E-3-grafana-dashboard-general-[FECHA].png`

---

**Paso 4 — Captura 2: Métricas de contenedores Docker**

1. Si el dashboard tiene un panel de "Docker Containers" o "Container CPU/Memory"
2. Hacer clic en el panel para expandirlo (o buscar el dashboard específico)
3. **Tomar captura** mostrando:

```
✓ CPU usage por container (líneas de diferentes colores)
✓ Memory usage por container
✓ Al menos 5-6 containers visibles con métricas activas
✓ Datos recientes (últimos 30-60 minutos)
```

**Archivo:** `E-3-grafana-metricas-containers-[FECHA].png`

---

**Paso 5 — Captura 3: Logs activos (si está configurado)**

1. Navegar a **"Explore"** → Seleccionar datasource de Loki (si está configurado)
2. O buscar el panel de logs en el dashboard
3. **Tomar captura** mostrando logs recientes de los servicios

**Archivo:** `E-3-grafana-logs-activos-[FECHA].png`

---

**Si el dashboard no tiene datos (troubleshooting):**

```bash
# Verificar que el agente Grafana Alloy está corriendo en el servidor
ssh ubuntu@[PROD_IP]
docker ps | grep -i "alloy\|grafana\|prometheus"

# Si no hay agente corriendo, revisar el repo de monitoring
# cd /home/ubuntu/ideal-infra/monitoring-iac && make ps
```

**Criterio de aceptación DIAN:**
- El dashboard muestra datos reales de producción (no vacío)
- El título del dashboard identifica el sistema (Ideal Software / producción)
- Las métricas muestran actividad en las últimas horas
- La URL de Grafana es visible (confirma que es una cuenta real, no captura editada)

**Carpeta destino:** `ideal-docs/evidencias/E-3-grafana/`

---

### E-4: Certificado TLS vigente

**Por qué es requerida:**  
La transmisión de documentos electrónicos a la DIAN y entre el sistema y los contribuyentes debe realizarse con cifrado en tránsito. Un certificado TLS válido (HTTPS) es requisito explícito de seguridad en la infraestructura declarada. Demuestra que las comunicaciones son seguras y están protegidas.

**Archivos a producir:** 1-2 capturas de pantalla + 1 archivo de texto con datos del certificado

#### Método 1 — Captura desde navegador (para el expediente DIAN)

**Paso 1:**
1. Abrir **Google Chrome**
2. Navegar a: `https://api.idealsoluciones.com.co`
3. Hacer clic en el **ícono de candado** (🔒) en la barra de direcciones
4. Hacer clic en **"La conexión es segura"** o **"Connection is secure"**
5. Hacer clic en **"El certificado es válido"** o **"Certificate is valid"**

**Paso 2 — En la ventana del certificado:**
1. En la pestaña **"General"** o **"Details"**, verificar:
   - **Emitido para:** api.idealsoluciones.com.co
   - **Emitido por:** Let's Encrypt (R3, E1, o similar)
   - **Válido desde:** [fecha pasada]
   - **Válido hasta:** [fecha futura — mínimo 30 días]
2. **Tomar captura de pantalla** mostrando toda esta información

**Lo que debe aparecer:**
```
✓ Dominio: api.idealsoluciones.com.co
✓ Emisor: Let's Encrypt (Caddy lo renueva automáticamente)
✓ Fecha de expiración futura (no vencido)
✓ El candado verde o azul en la barra de Chrome
```

**Archivo:** `E-4-certificado-tls-chrome-[FECHA].png`

---

#### Método 2 — Comando OpenSSL (para el archivo de texto)

```bash
# Ejecutar desde tu equipo local:
echo | openssl s_client -connect api.idealsoluciones.com.co:443 -servername api.idealsoluciones.com.co 2>/dev/null \
    | openssl x509 -noout -text \
    | grep -A 5 -E "Issuer:|Subject:|Validity|Not Before|Not After"
```

**Resultado esperado:**
```
Issuer: C=US, O=Let's Encrypt, CN=E1
Validity
    Not Before: [fecha pasada]
    Not After : [fecha futura]
Subject: CN=api.idealsoluciones.com.co
```

**Guardar resultado:**
```bash
echo | openssl s_client -connect api.idealsoluciones.com.co:443 -servername api.idealsoluciones.com.co 2>/dev/null \
    | openssl x509 -noout -text \
    > /Users/rcermeno/ideal-infra/ideal-docs/evidencias/E-4-certificado-tls/E-4-openssl-output-$(date +%Y%m%d).txt

# Agregar timestamp
echo "Fecha de verificación: $(date '+%Y-%m-%d %H:%M:%S')" >> \
    /Users/rcermeno/ideal-infra/ideal-docs/evidencias/E-4-certificado-tls/E-4-openssl-output-$(date +%Y%m%d).txt
```

**Archivo de texto:** `E-4-openssl-output-[FECHA].txt`

---

**Criterio de aceptación DIAN:**
- El certificado está emitido para `api.idealsoluciones.com.co` (nombre exacto)
- La fecha de expiración es posterior a la fecha de presentación
- El emisor es reconocido (Let's Encrypt es ampliamente aceptado)
- El navegador muestra el candado verde/azul (sin advertencias de seguridad)

**Carpeta destino:** `ideal-docs/evidencias/E-4-certificado-tls/`

---

### E-5: Evidencia de backups en Lightsail DB

**Por qué es requerida:**  
La Resolución 00165/2023 exige que los proveedores tecnológicos garanticen la conservación y disponibilidad de los documentos electrónicos. Los backups automáticos son la garantía técnica de que los datos pueden recuperarse ante un desastre, respaldando el RPO ≤ 24h declarado en el DRP.

**Archivos a producir:** 2 capturas de pantalla (una por base de datos)

#### Paso a paso:

**Para PostgreSQL (`ideal-prod-postgres`):**

1. Navegar a: `https://console.aws.amazon.com/lightsail`
2. Clic en **"Databases"** en el menú lateral
3. Clic en la base de datos **`ideal-prod-postgres`**
4. En la página de detalle, navegar a la pestaña **"Snapshots"** o buscar la sección de backups
5. Alternativamente, buscar la sección **"Maintenance and backup"** en los detalles de la DB

**Lo que debe aparecer en la captura:**
```
✓ Nombre de la base de datos: ideal-prod-postgres
✓ Motor: PostgreSQL 16
✓ Estado de backups automáticos: Enabled / Activado
✓ Período de retención: 7 días (o el configurado)
✓ Ventana de backup: 04:00-04:30 UTC (o similar)
✓ Lista de snapshots/backups recientes con fechas (últimos 7 días visibles)
```

6. **Tomar captura** de la configuración de backups Y de la lista de snapshots recientes

**Archivo:** `E-5-lightsail-postgres-backups-[FECHA].png`

---

**Para MySQL (`ideal-prod-mysql`):**

Repetir los mismos pasos para la base de datos `ideal-prod-mysql`.

**Archivo:** `E-5-lightsail-mysql-backups-[FECHA].png`

---

**Verificación adicional — confirmar que hay snapshots recientes:**

1. En la pestaña de snapshots, verificar que hay al menos un snapshot de las últimas 24 horas
2. Si la ventana de backup es 04:00-04:30 UTC, el snapshot más reciente debe tener fecha de hoy (si ya pasaron las 04:30 UTC) o de ayer

**Lo que NO debe aparecer:**
```
✗ Backups automáticos desactivados
✗ Sin snapshots en los últimos 7 días
✗ Estado de la DB en "Error" o "Degraded"
```

**Criterio de aceptación DIAN:**
- Los backups automáticos están habilitados en ambas bases de datos de producción
- Se pueden ver snapshots recientes (últimas 48 horas mínimo)
- La retención es de al menos 7 días
- El nombre de la DB en la captura coincide con lo declarado en la documentación

**Carpeta destino:** `ideal-docs/evidencias/E-5-backups/`

---

### E-6: Output terraform show

**Por qué es requerida:**  
Demuestra que la infraestructura está gestionada mediante Infraestructura como Código (IaC), garantizando reproducibilidad, control de cambios y auditabilidad. Es evidencia de prácticas de ingeniería maduras que respaldan la confiabilidad del servicio.

**Archivos a producir:** 1 archivo de texto (con datos sensibles redactados)

#### Paso a paso:

**Paso 1 — Preparar el entorno**

```bash
# Desde tu equipo local, ir al directorio de Terraform de producción
cd /Users/rcermeno/ideal-infra/ideal-iac/envs/prod

# Verificar que tienes acceso al estado
terraform init
# Resultado esperado: "Terraform has been successfully initialized!"
```

**Paso 2 — Ejecutar terraform show**

```bash
# Exportar la salida completa
terraform show > /tmp/terraform-show-full.txt
echo "Fecha de captura: $(date '+%Y-%m-%d %H:%M:%S')" >> /tmp/terraform-show-full.txt
echo "Directorio: $(pwd)" >> /tmp/terraform-show-full.txt
echo "Terraform version: $(terraform version)" >> /tmp/terraform-show-full.txt

# Ver el contenido
cat /tmp/terraform-show-full.txt
```

**Paso 3 — Redactar información sensible OBLIGATORIAMENTE**

Antes de guardar como evidencia, redactar todos los valores sensibles:

```bash
# Crear versión redactada (reemplazar valores sensibles)
# Abrir el archivo y reemplazar manualmente:
# - Contraseñas de bases de datos
# - Access keys de AWS
# - Tokens y secrets
# - Valores de variables privadas

# Usar sed para redactar patrones comunes:
sed -E 's/(password\s*=\s*")[^"]+"/\1[REDACTADO]"/gi' /tmp/terraform-show-full.txt > /tmp/terraform-show-redacted.txt
sed -i -E 's/(master_password\s*=\s*")[^"]+"/\1[REDACTADO]"/gi' /tmp/terraform-show-redacted.txt
sed -i -E 's/(secret_access_key\s*=\s*")[^"]+"/\1[REDACTADO]"/gi' /tmp/terraform-show-redacted.txt

# REVISAR MANUALMENTE el archivo redactado antes de guardarlo
cat /tmp/terraform-show-redacted.txt | less
```

**Paso 4 — Guardar como evidencia**

```bash
# Copiar versión redactada a la carpeta de evidencias
cp /tmp/terraform-show-redacted.txt \
    /Users/rcermeno/ideal-infra/ideal-docs/evidencias/E-6-terraform/E-6-terraform-show-redactado-$(date +%Y%m%d).txt
```

**Lo que debe aparecer en el archivo (ejemplos):**

```hcl
# aws_lightsail_instance.ideal_production:
resource "aws_lightsail_instance" "ideal_production" {
    availability_zone = "us-east-1a"
    blueprint_id      = "ubuntu_22_04"
    bundle_id         = "medium_2_0"
    name              = "ideal-production"
    ...
}

# aws_lightsail_database.ideal_prod_postgres:
resource "aws_lightsail_database" "ideal_prod_postgres" {
    engine                     = "postgres"
    engine_version             = "16"
    master_database_name       = "ideal"
    master_password            = "[REDACTADO]"
    publicly_accessible        = false
    ...
}
```

**Lo que NO debe aparecer:**
```
✗ Contraseñas reales de bases de datos
✗ AWS Secret Access Keys
✗ Tokens de acceso privados
✗ Valores de variables que identifiquen detalles internos de seguridad
```

**Criterio de aceptación DIAN:**
- El archivo muestra los recursos de infraestructura (instancias, DBs, IPs)
- Los nombres de recursos coinciden con los declarados en la documentación
- `publicly_accessible = false` es visible para las DBs de producción
- Los datos sensibles están claramente marcados como `[REDACTADO]`
- El archivo tiene fecha de captura incluida

**Carpeta destino:** `ideal-docs/evidencias/E-6-terraform/`

---

### E-7: Contrato AWS (Customer Agreement)

**Por qué es requerida:**  
La DIAN requiere que los proveedores tecnológicos tengan contratos formales con sus proveedores de infraestructura. El AWS Customer Agreement establece los términos de responsabilidad, disponibilidad (SLA) y procesamiento de datos, respaldando el compromiso de continuidad del servicio declarado.

**Archivos a producir:** 2 documentos PDF

#### Documento 1 — AWS Customer Agreement

**Paso 1:**
1. Iniciar sesión en `https://console.aws.amazon.com`
2. Hacer clic en el nombre de la cuenta (esquina superior derecha)
3. Seleccionar **"Account"**
4. En el menú de la izquierda, buscar **"Agreement Center"** o **"Your agreements"**
5. Buscar **"AWS Customer Agreement"**
6. Hacer clic en **"Download"** o **"View"** y descargar el PDF

**Alternativa (si no encuentras en la consola):**
```
Descargar directamente desde:
https://aws.amazon.com/agreement/
→ Clic en "AWS Customer Agreement" → Download PDF
```

**Archivo:** `E-7-aws-customer-agreement-[FECHA].pdf`

---

#### Documento 2 — AWS Data Processing Addendum (DPA)

El DPA es especialmente importante para Colombia ya que respalda el cumplimiento con la Ley 1581 de 2012 (Habeas Data) al procesar datos de contribuyentes colombianos.

**Paso 1:**
1. Navegar a: `https://aws.amazon.com/compliance/gdpr/`
2. Buscar la sección **"Data Processing Addendum"**
3. Descargar el PDF del DPA

**Alternativa:**
```
https://d1.awsstatic.com/legal/aws-gdpr/AWS_GDPR_DPA.pdf
```

**Archivo:** `E-7-aws-data-processing-addendum-[FECHA].pdf`

---

**Paso adicional — Captura de la cuenta AWS mostrando el acuerdo aceptado:**

1. AWS Console → Account → Agreement Center
2. Tomar captura mostrando que el AWS Customer Agreement está **"Accepted"** / **"Active"**

**Archivo:** `E-7-aws-acuerdo-aceptado-[FECHA].png`

**Criterio de aceptación DIAN:**
- Se entrega el documento oficial de AWS (no una captura, sino el PDF descargado)
- El documento incluye los términos de nivel de servicio (SLA)
- Se puede identificar que corresponde a la cuenta de IDEAL SOFTWARE o al menos a una cuenta activa de AWS

**Carpeta destino:** `ideal-docs/evidencias/E-7-contrato-aws/`

---

### E-8: Contrato GitHub

**Por qué es requerida:**  
GitHub es la plataforma de CI/CD y registro de imágenes Docker (`ghcr.io/ideal-saas`) de Ideal Software. El contrato o términos de servicio respaldan la disponibilidad y seguridad del repositorio de código fuente y del pipeline de despliegue continuo declarado en la infraestructura.

**Archivos a producir:** 1-2 documentos PDF

#### Documento 1 — GitHub Customer Agreement / Terms of Service

**Paso 1:**
1. Navegar a: `https://docs.github.com/en/site-policy/github-terms/github-terms-of-service`
2. En la parte superior de la página, buscar el botón **"Download PDF"** o **"Print"**
3. Usar la función de impresión del navegador → **"Save as PDF"**
4. Guardar como PDF

**Alternativa:**
```
https://github.com/customer-terms
→ Revisar los términos corporativos aplicables
```

**Archivo:** `E-8-github-terms-of-service-[FECHA].pdf`

---

#### Documento 2 — GitHub Data Protection Agreement

1. Navegar a: `https://github.com/customer-terms/github-data-protection-agreement`
2. Descargar como PDF (impresión a PDF desde el navegador)

**Archivo:** `E-8-github-data-protection-agreement-[FECHA].pdf`

---

**Captura adicional — Repositorios privados de ideal-saas:**

1. Iniciar sesión en `https://github.com`
2. Navegar a la organización: `https://github.com/ideal-saas`
3. **Tomar captura** mostrando los repositorios de la organización (con el ícono de candado que indica que son privados)

**Archivo:** `E-8-github-org-ideal-saas-repos-[FECHA].png`

**Criterio de aceptación DIAN:**
- Se entrega el documento oficial de GitHub Terms of Service
- El documento está vigente (fecha de última actualización visible)
- La captura de la organización muestra repositorios privados activos

**Carpeta destino:** `ideal-docs/evidencias/E-8-contrato-github/`

---

### E-9: UptimeRobot monitors

**Por qué es requerida:**  
El monitoreo externo de disponibilidad demuestra que IDEAL SOFTWARE mide objetivamente el uptime de su servicio desde perspectiva del cliente (no solo métricas internas). Esto respaldo el compromiso de disponibilidad y SLA declarado. UptimeRobot verifica los endpoints cada 5 minutos desde múltiples ubicaciones geográficas.

**Archivos a producir:** 2-3 capturas de pantalla

**IMPORTANTE:** Esta evidencia requiere al menos **24 horas** de actividad del monitor antes de poder capturar datos significativos. Crear los monitores con suficiente anticipación.

#### Paso 1 — Crear cuenta UptimeRobot

1. Navegar a: `https://uptimerobot.com`
2. Hacer clic en **"Register for FREE"**
3. Registrarse con el email corporativo: `[soporte@idealsoluciones.com.co]`
4. Verificar el email y completar el registro

#### Paso 2 — Crear monitor para API

1. En el dashboard de UptimeRobot, hacer clic en **"Add New Monitor"**
2. Configurar:
   - **Monitor Type:** HTTP(s)
   - **Friendly Name:** `Ideal Software — API (api.idealsoluciones.com.co)`
   - **URL:** `https://api.idealsoluciones.com.co/health`
   - **Monitoring Interval:** 5 minutes
   - **Alert Contacts:** Agregar el email del equipo
3. Hacer clic en **"Create Monitor"**

#### Paso 3 — Crear monitor para aplicación web

1. Hacer clic en **"Add New Monitor"** nuevamente
2. Configurar:
   - **Monitor Type:** HTTP(s)
   - **Friendly Name:** `Ideal Software — App (app.idealsoluciones.com.co)`
   - **URL:** `https://app.idealsoluciones.com.co`
   - **Monitoring Interval:** 5 minutes
3. Hacer clic en **"Create Monitor"**

#### Paso 4 — Esperar 24 horas

Los monitores necesitan tiempo para acumular datos de disponibilidad. Esperar al menos 24 horas antes de tomar capturas.

#### Paso 5 — Capturar evidencias (después de 24+ horas)

**Captura 1 — Dashboard principal:**

1. Iniciar sesión en `https://uptimerobot.com`
2. En el dashboard, ambos monitores deben mostrar:
   - Estado: **"Up"** (punto verde)
   - Uptime porcentaje: idealmente 99-100%
   - Último check: "X minutes ago"
3. **Tomar captura de pantalla** completa mostrando ambos monitores

**Lo que debe aparecer:**
```
✓ Nombre del monitor: "Ideal Software — API"
✓ URL monitoreada: api.idealsoluciones.com.co
✓ Estado: UP (verde)
✓ Uptime 24h: X% (porcentaje visible)
✓ Tiempo de respuesta promedio
✓ Segundo monitor para app.idealsoluciones.com.co
```

**Archivo:** `E-9-uptimerobot-dashboard-[FECHA].png`

---

**Captura 2 — Detalle de un monitor:**

1. Hacer clic en el monitor de la API para ver el detalle
2. En la página de detalle, ajustar el período a **"Last 7 days"**
3. **Tomar captura** mostrando:
   - Gráfico de disponibilidad (uptime bar verde)
   - Tiempo de respuesta promedio
   - Incidentes (si los hay, mostrar que fueron resueltos)

**Archivo:** `E-9-uptimerobot-detalle-api-[FECHA].png`

---

**Captura 3 — Página de status pública (opcional pero recomendada):**

1. En UptimeRobot, configurar una **"Status Page"** pública
2. Agregar ambos monitores a la status page
3. La URL pública tendrá formato: `https://stats.uptimerobot.com/[código]`
4. **Tomar captura** de la status page pública

**Archivo:** `E-9-uptimerobot-status-page-[FECHA].png`

**Criterio de aceptación DIAN:**
- Al menos 2 monitores activos: API y aplicación web
- Los monitores tienen al menos 24 horas de datos históricos
- El uptime mostrado es mayor al 99% (o el SLA declarado)
- Los URLs monitoreados coinciden con los dominios declarados en la documentación
- La cuenta de UptimeRobot está a nombre de la empresa (usar email corporativo)

**Carpeta destino:** `ideal-docs/evidencias/E-9-uptimerobot/`

---

### E-10: Resultados de Simulacro DRP

**Por qué es requerida:**  
Demuestra que el Plan de Recuperación ante Desastres no es solo un documento, sino que ha sido efectivamente probado y validado. Es evidencia de la madurez operacional del equipo técnico y del compromiso con la continuidad del servicio. La DIAN requiere que las medidas de continuidad sean ejecutables y probadas, no solo declaradas.

**Archivos a producir:** 1 documento PDF con el registro del simulacro + capturas de pantalla del proceso

#### Paso 1 — Preparar el simulacro (30 minutos antes)

```bash
# Confirmar que el servidor QA está operacional
ssh ubuntu@32.194.205.163 "docker ps | grep Up | wc -l"
# Resultado esperado: número de containers activos en QA

# Preparar el archivo de registro (copiar plantilla del DRP)
cp /Users/rcermeno/ideal-infra/ideal-docs/PLAN-drp-runbook.md /tmp/simulacro-plantilla.md
# Abrir en editor para ir llenando durante el simulacro
```

#### Paso 2 — Ejecutar el simulacro (Escenarios 1 y 2 en QA)

```bash
# Conectarse al servidor QA
ssh ubuntu@32.194.205.163

# --- REGISTRO OBLIGATORIO ---
echo "========================================"
echo "SIMULACRO DRP — IDEAL SOFTWARE S.A.S"
echo "Fecha: $(date '+%Y-%m-%d')"
echo "Hora inicio: $(date '+%H:%M:%S')"
echo "Operador: Ricardo Cermeño Bolaño"
echo "========================================"

# Tomar captura de pantalla de este output (evidencia E-10)
```

```bash
# --- FASE 1: Escenario 1 — Derribar un container ---
# Registrar hora
echo "ESCENARIO 1 INICIO: $(date '+%H:%M:%S')"

# Identificar un container no crítico para derribar
docker ps --format "{{.Names}}" | head -5

# Detener el container seleccionado (ej: un consumer o el frontend)
CONTAINER_TEST="ideal-app"  # Cambiar por nombre real disponible en QA
docker stop $CONTAINER_TEST
echo "Container $CONTAINER_TEST detenido: $(date '+%H:%M:%S')"

# Verificar que está caído
docker ps | grep $CONTAINER_TEST
# Resultado esperado: no aparece en la lista activa

# Ejecutar procedimiento de recuperación (Escenario 1 del DRP)
cd /home/ubuntu/ideal-infra/ideal-app-iac  # Ajustar según container
make up
echo "Container recuperado: $(date '+%H:%M:%S')"

# Calcular MTTR
docker ps | grep $CONTAINER_TEST
```

```bash
# --- FASE 2: Escenario 2 — Simular reinicio total ---
echo "ESCENARIO 2 INICIO: $(date '+%H:%M:%S')"

# Detener TODOS los containers en QA
for repo in caddy-iac ideal-app-iac ideal-comsumers-iac accounting-iac dian-api-iac kafka-iac; do
    if [ -d "/home/ubuntu/ideal-infra/$repo" ]; then
        cd /home/ubuntu/ideal-infra/$repo && make stop 2>/dev/null || true
    fi
done
echo "TODOS LOS CONTAINERS DETENIDOS: $(date '+%H:%M:%S')"
docker ps | wc -l
# Resultado esperado: 1 (solo el header)

# Ejecutar procedimiento de recuperación (Escenario 2 del DRP)
# ... seguir el orden de arranque del Escenario 2 ...
echo "INICIO RECUPERACIÓN: $(date '+%H:%M:%S')"

# kafka primero
cd /home/ubuntu/ideal-infra/kafka-iac && make up && sleep 30

# dian-api
cd /home/ubuntu/ideal-infra/dian-api-iac && make up && sleep 15

# accounting
cd /home/ubuntu/ideal-infra/accounting-iac && make up && sleep 30

# consumers
cd /home/ubuntu/ideal-infra/ideal-comsumers-iac && make up && sleep 10

# app
cd /home/ubuntu/ideal-infra/ideal-app-iac && make up && sleep 10

# caddy
cd /home/ubuntu/ideal-infra/caddy-iac && make up && sleep 10

echo "TODOS LOS CONTAINERS RECUPERADOS: $(date '+%H:%M:%S')"
docker ps | grep "Up" | wc -l
```

#### Paso 3 — Capturar evidencias durante el simulacro

Tomar capturas de pantalla del terminal en los siguientes momentos clave:

1. **Al inicio:** Output con la hora de inicio del simulacro
2. **Container detenido:** `docker ps` mostrando el container en estado "Exited"
3. **Container recuperado:** `docker ps` mostrando el container en estado "Up"
4. **Todos los containers detenidos:** `docker ps` con 0 containers activos
5. **Todos los containers recuperados:** `docker ps` con todos en estado "Up"

**Archivos:**
- `E-10-simulacro-inicio-[FECHA].png`
- `E-10-simulacro-container-caido-[FECHA].png`
- `E-10-simulacro-container-recuperado-[FECHA].png`
- `E-10-simulacro-todos-detenidos-[FECHA].png`
- `E-10-simulacro-recuperacion-completa-[FECHA].png`

#### Paso 4 — Completar y firmar el registro del simulacro

Llenar completamente la plantilla de registro del simulacro de la Sección 7.4 del `PLAN-drp-runbook.md` con los timestamps reales obtenidos.

Guardar el registro como:

**Archivo:** `E-10-registro-simulacro-drp-[FECHA].pdf` (imprimir a PDF desde el editor)

#### Paso 5 — Calcular métricas del simulacro

```
MTTR Escenario 1 (container individual):
= hora_container_recuperado - hora_container_detenido
= Objetivo: ≤ 15 minutos ✓ o ✗

RTO Escenario 2 (reinicio total):
= hora_todos_recuperados - hora_inicio_recuperacion
= Objetivo: ≤ 30 minutos ✓ o ✗
```

**Criterio de aceptación DIAN:**
- El registro del simulacro está firmado por el responsable técnico
- Los timestamps son reales y coherentes
- El MTTR del Escenario 1 es ≤ 15 minutos
- El RTO del Escenario 2 es ≤ 30 minutos
- Hay capturas de pantalla que corroboran los timestamps del registro
- El servidor utilizado para el simulacro es identificable (hostname QA visible)

**Carpeta destino:** `ideal-docs/evidencias/E-10-simulacro-drp/`

---

## 4. Checklist Final antes de Enviar a DIAN

Antes de compilar el expediente para presentar a la DIAN, verificar que cada evidencia cumple el criterio de aceptación:

```
EXPEDIENTE DE EVIDENCIAS — IDEAL SOFTWARE S.A.S
Fecha de compilación: _______________
Compilado por: ______________________

--- VERIFICACIÓN DE ARCHIVOS ---

[ ] E-1: Capturas consola AWS Lightsail
    [ ] E-1-lightsail-instancias-[FECHA].png — instancia producción en "Running"
    [ ] E-1-lightsail-databases-lista-[FECHA].png — ambas DBs en "Available"
    [ ] E-1-lightsail-postgres-prod-no-public-[FECHA].png — "Publicly accessible: No"
    [ ] E-1-lightsail-mysql-prod-no-public-[FECHA].png — "Publicly accessible: No"
    [ ] E-1-lightsail-static-ip-[FECHA].png
    [ ] E-1-lightsail-firewall-[FECHA].png

[ ] E-2: Output docker ps en producción
    [ ] E-2-docker-ps-produccion-[FECHA].txt — ≥ 22 containers en "Up"
    [ ] E-2-docker-ps-produccion-[FECHA].png — captura de pantalla del terminal

[ ] E-3: Dashboard Grafana Cloud
    [ ] E-3-grafana-dashboard-general-[FECHA].png — datos activos visibles
    [ ] E-3-grafana-metricas-containers-[FECHA].png — CPU/memoria por container

[ ] E-4: Certificado TLS vigente
    [ ] E-4-certificado-tls-chrome-[FECHA].png — candado verde, fechas visibles
    [ ] E-4-openssl-output-[FECHA].txt — datos del certificado en texto

[ ] E-5: Evidencia de backups Lightsail DB
    [ ] E-5-lightsail-postgres-backups-[FECHA].png — backups enabled + snapshots recientes
    [ ] E-5-lightsail-mysql-backups-[FECHA].png — backups enabled + snapshots recientes

[ ] E-6: Output terraform show
    [ ] E-6-terraform-show-redactado-[FECHA].txt — recursos declarados, datos sensibles [REDACTADO]
    VERIFICAR: ¿Revisé manualmente que no hay contraseñas? [ ] Sí

[ ] E-7: Contrato AWS
    [ ] E-7-aws-customer-agreement-[FECHA].pdf
    [ ] E-7-aws-data-processing-addendum-[FECHA].pdf
    [ ] E-7-aws-acuerdo-aceptado-[FECHA].png

[ ] E-8: Contrato GitHub
    [ ] E-8-github-terms-of-service-[FECHA].pdf
    [ ] E-8-github-data-protection-agreement-[FECHA].pdf
    [ ] E-8-github-org-ideal-saas-repos-[FECHA].png

[ ] E-9: UptimeRobot monitors
    [ ] E-9-uptimerobot-dashboard-[FECHA].png — ambos monitors en "Up", uptime > 99%
    [ ] E-9-uptimerobot-detalle-api-[FECHA].png — historial 7 días
    VERIFICAR: ¿Los monitores tienen ≥ 24h de datos? [ ] Sí

[ ] E-10: Resultados simulacro DRP
    [ ] E-10-registro-simulacro-drp-[FECHA].pdf — firmado, con timestamps reales
    [ ] E-10-simulacro-inicio-[FECHA].png
    [ ] E-10-simulacro-recuperacion-completa-[FECHA].png
    VERIFICAR: ¿MTTR ≤ 15 min (E1) y RTO ≤ 30 min (E2)? [ ] Sí

--- VERIFICACIÓN FINAL ---
[ ] Todos los archivos siguen la convención de nombres [CODIGO]-[DESCRIPCION]-[FECHA]
[ ] Las fechas en las capturas coinciden con las fechas en los nombres de archivo
[ ] No hay datos sensibles sin redactar en ningún archivo
[ ] La carpeta evidencias/ está organizada en subcarpetas E-1/ a E-10/
[ ] Se ha hecho backup de la carpeta evidencias/ completa

Firma del responsable: ___________________
Fecha: __________________________________
```

---

*Este documento es de uso interno de IDEAL SOFTWARE S.A.S. Las evidencias recolectadas son parte del expediente de certificación ante la DIAN y deben conservarse durante el período de vigencia de la habilitación y por al menos 5 años adicionales.*
