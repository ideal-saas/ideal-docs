# Plan de Recuperación ante Desastres (DRP) + Runbook Operacional

**Empresa:** IDEAL SOFTWARE S.A.S  
**NIT:** 902.027.596-7  
**Documento:** PLAN-DRP-RUNBOOK  
**Versión:** 1.0  
**Fecha de emisión:** Mayo 2026  
**Clasificación:** CONFIDENCIAL — Uso interno y presentación DIAN  
**Referencia normativa:** Numeral 8, Artículo 55, Resolución 00165 de 2023

---

## Tabla de Contenidos

1. [Resumen Ejecutivo](#1-resumen-ejecutivo)
2. [Alcance y Objetivos](#2-alcance-y-objetivos)
3. [Equipo de Recuperación y Contactos](#3-equipo-de-recuperación-y-contactos)
4. [Requisitos Previos — Checklist de Preparación](#4-requisitos-previos--checklist-de-preparación)
5. [Escenarios de Desastre y Clasificación](#5-escenarios-de-desastre-y-clasificación)
6. [RUNBOOK — Procedimientos Paso a Paso](#6-runbook--procedimientos-paso-a-paso)
   - [Escenario 1: Falla de contenedor individual](#escenario-1-falla-de-contenedor-individual)
   - [Escenario 2: Reinicio del servidor](#escenario-2-reinicio-del-servidor)
   - [Escenario 3: Falla total del servidor](#escenario-3-falla-total-del-servidor)
   - [Escenario 4: Falla o corrupción de base de datos](#escenario-4-falla-o-corrupción-de-base-de-datos)
   - [Escenario 5: Falla de Kafka](#escenario-5-falla-de-kafka)
   - [Escenario 6: Brecha de seguridad / compromiso de credenciales](#escenario-6-brecha-de-seguridad--compromiso-de-credenciales)
   - [Escenario 7: Indisponibilidad de servicios web DIAN](#escenario-7-indisponibilidad-de-servicios-web-dian)
7. [Procedimiento de Simulacro DRP](#7-procedimiento-de-simulacro-drp)
8. [Procedimiento Post-Incidente](#8-procedimiento-post-incidente)
9. [Sección 7.3 — Texto para punto-8-infraestructura.md](#9-sección-73--texto-para-punto-8-infraestructurama)
10. [Control de Cambios](#10-control-de-cambios)

---

## 1. Resumen Ejecutivo

IDEAL SOFTWARE S.A.S opera como proveedor tecnológico de facturación electrónica bajo la Resolución DIAN 00165 de 2023. La continuidad operacional del sistema es un requisito legal y un compromiso con los clientes empresariales que dependen de la plataforma para el cumplimiento de sus obligaciones tributarias ante la DIAN.

El presente Plan de Recuperación ante Desastres (DRP) establece los procedimientos técnicos y organizacionales necesarios para responder a interrupciones del servicio, minimizar el tiempo de inactividad y garantizar la integridad de los datos procesados.

### Objetivos de Recuperación

| Métrica | Objetivo | Justificación |
|---------|----------|---------------|
| **RPO** (Recovery Point Objective) | ≤ 24 horas | Lightsail Managed DB hace backups automáticos cada 24h con retención de 7 días |
| **RTO** (Recovery Time Objective) | ≤ 2 horas | Restauración desde imagen de instancia + re-deploy con Make |
| **MTTR** (Mean Time to Repair) | ≤ 1 hora | Para fallas de contenedor o reinicio de servidor |

### Principios del Plan

- **Ejecutabilidad:** Cada procedimiento contiene comandos exactos listos para copiar y ejecutar.
- **Trazabilidad:** Todo incidente debe quedar documentado con timestamps.
- **Comunicación:** Los clientes afectados deben ser notificados dentro de las 4 horas de una interrupción significativa.
- **Cumplimiento DIAN:** Las interrupciones superiores a 4 horas continuas deben notificarse a la DIAN conforme al artículo 55 de la Resolución 00165 de 2023.

---

## 2. Alcance y Objetivos

### 2.1 Sistemas Cubiertos

| Sistema | Componente | Criticidad |
|---------|-----------|-----------|
| Servidor de aplicaciones | AWS Lightsail, Ubuntu 22.04, us-east-1 | CRÍTICA |
| Bases de datos | PostgreSQL 16 (Lightsail Managed DB) | CRÍTICA |
| Bases de datos | MySQL 8.0 (Lightsail Managed DB) | CRÍTICA |
| Mensajería | Apache Kafka 3.9.0 (KRaft) | ALTA |
| Reverse proxy | Caddy 2.8.4 | ALTA |
| API Gateway | Apollo Router (GraphQL Federation v2) | ALTA |
| Microservicios | 8 servicios NestJS | ALTA |
| Consumidores | 6 consumers Kafka (DIAN) | ALTA |
| API DIAN | dian-api (Laravel/PHP) | CRÍTICA |
| Frontend | ideal-app (Next.js) | MEDIA |
| CI/CD | GitHub Actions + ghcr.io/ideal-saas | MEDIA |
| Monitoreo | Grafana Cloud | MEDIA |

### 2.2 Sistemas No Cubiertos

- Dispositivos de usuarios finales (computadores de clientes)
- Conectividad a internet del lado del cliente
- Servicios externos de la DIAN (webservices DIAN)

### 2.3 Supuestos

- El equipo técnico tiene acceso SSH a los servidores de producción.
- Las credenciales de AWS están disponibles y actualizadas.
- El estado de Terraform está accesible en el backend configurado.
- Las imágenes Docker están disponibles en `ghcr.io/ideal-saas`.

---

## 3. Equipo de Recuperación y Contactos

### 3.1 Roles y Responsabilidades

| Rol | Nombre | Cargo | Teléfono | Email | Disponibilidad |
|-----|--------|-------|----------|-------|----------------|
| **Coordinador DRP / Técnico Principal** | Ricardo Cermeño Bolaño | Director de Tecnología (CTO) | [+57-XXX-XXX-XXXX] | [rcermeno@idealsoluciones.com.co] | 24/7 |
| **Técnico Secundario** | [Ingeniero de Software] | Desarrollador Senior | [+57-XXX-XXX-XXXX] | [dev@idealsoluciones.com.co] | Horas hábiles + guardia |
| **Escalación Gerencial** | Felix Palacio Arguelle | Gerente General | [+57-XXX-XXX-XXXX] | [fpalacio@idealsoluciones.com.co] | Horas hábiles |
| **Soporte AWS** | AWS Support | Proveedor Cloud | N/A | Consola AWS → Support | 24/7 (plan contratado) |

> **Instrucción:** Reemplazar los valores en corchetes `[...]` con la información real antes de presentar ante la DIAN. Esta información es sensible y no debe publicarse en repositorios Git.

### 3.2 Árbol de Escalación

```
1. Detección del incidente (monitoreo Grafana / alerta usuario)
        ↓
2. Ricardo Cermeño (CTO) — Tiempo máximo de respuesta: 15 minutos
        ↓ (si no responde en 15 min)
3. Técnico Secundario — Tiempo máximo: 30 minutos desde detección
        ↓ (si incidente > 1 hora sin resolución)
4. Felix Palacio (Gerente) — Aprobación de escalación a soporte AWS
        ↓ (si incidente > 4 horas)
5. Notificación a clientes + notificación DIAN
```

### 3.3 Canales de Comunicación

| Canal | Uso | URL/Contacto |
|-------|-----|-------------|
| WhatsApp Business | Notificación inmediata al equipo | Grupo "Ideal — Incidentes" |
| Email corporativo | Comunicaciones formales y notificación a clientes | [soporte@idealsoluciones.com.co] |
| AWS Console | Gestión de infraestructura | https://console.aws.amazon.com |
| Grafana Cloud | Monitoreo y alertas | https://grafana.com |
| GitHub | Estado de despliegues | https://github.com/ideal-saas |

---

## 4. Requisitos Previos — Checklist de Preparación

Este checklist debe verificarse **mensualmente** y antes de cualquier mantenimiento mayor. Si algún ítem no está disponible, el DRP no puede ejecutarse efectivamente.

### 4.1 Accesos y Credenciales

```
[ ] Llave SSH privada accesible en equipo del CTO
    Ubicación: ~/.ssh/ideal_prod_key (o equivalente)
    Verificación: ssh -i ~/.ssh/ideal_prod_key ubuntu@[PROD_IP] "echo OK"

[ ] Credenciales AWS activas
    Verificación: Iniciar sesión en https://console.aws.amazon.com
    Permisos requeridos: Lightsail:Full, Support

[ ] Token de GitHub activo con acceso a ghcr.io/ideal-saas
    Verificación: docker login ghcr.io -u [GITHUB_USERNAME] -p [GITHUB_TOKEN]

[ ] Acceso a Grafana Cloud confirmado
    Verificación: https://grafana.com → Login → Ver dashboards de producción

[ ] Variables de entorno de producción disponibles
    Ubicación: Copia cifrada en gestor de contraseñas del equipo
    Archivos: .env.local de cada repo en /home/ubuntu/ideal-infra/[repo]/
```

### 4.2 Estado de Terraform

```
[ ] Terraform instalado en equipo local (versión >= 1.5)
    Verificación: terraform --version

[ ] Acceso al backend de estado de Terraform confirmado
    Ubicación: ideal-iac/envs/prod/
    Verificación: cd ideal-iac/envs/prod && terraform init && terraform show

[ ] Variables TF_VAR disponibles
    - TF_VAR_postgres_password
    - TF_VAR_mysql_password
```

### 4.3 Backups Verificados

```
[ ] Backup automático de PostgreSQL activo
    Verificación: AWS Console → Lightsail → Databases → ideal-prod-postgres
    → Backup settings → Enabled, retención 7 días

[ ] Backup automático de MySQL activo
    Verificación: AWS Console → Lightsail → Databases → ideal-prod-mysql
    → Backup settings → Enabled, retención 7 días

[ ] Último backup disponible con fecha ≤ 24 horas
    Nota: Los backups se realizan entre 04:00-04:30 UTC diariamente
```

### 4.4 Documentación Operacional

```
[ ] Este documento (PLAN-drp-runbook.md) actualizado y accesible offline
[ ] IPs de producción documentadas (ver sección 3)
[ ] Contraseñas de DB documentadas en gestor de contraseñas
[ ] Últimas versiones de imágenes Docker conocidas (docker ps en producción)
```

---

## 5. Escenarios de Desastre y Clasificación

| # | Escenario | Severidad | Trigger / Síntoma | RTO Esperado | RPO |
|---|-----------|-----------|-------------------|--------------|-----|
| 1 | Falla de contenedor individual | BAJA | Alerta Grafana, error 502/503 en endpoint específico | 15 min | 0 |
| 2 | Reinicio del servidor (todos los contenedores caídos) | MEDIA | Alerta total Grafana, todos los endpoints caídos | 30 min | 0 |
| 3 | Falla total del servidor / corrupción | ALTA | Servidor inaccesible por SSH, instancia Lightsail en error | 2 horas | ≤ 24h |
| 4 | Falla o corrupción de base de datos | ALTA | Errores de conexión DB en logs, datos corruptos | 1-2 horas | ≤ 24h |
| 5 | Falla de Kafka | MEDIA | Cola de mensajes detenida, consumers caídos | 30 min | 0 |
| 6 | Brecha de seguridad / credenciales comprometidas | CRÍTICA | Actividad anómala en logs, acceso no autorizado detectado | 2-4 horas | Depende |
| 7 | Indisponibilidad servicios web DIAN | BAJA-MEDIA | Errores de transmisión DIAN, CUFE no generados | N/A (externo) | 0 |

---

## 6. RUNBOOK — Procedimientos Paso a Paso

> **IMPORTANTE:** Antes de ejecutar cualquier procedimiento, documentar:
> - Fecha y hora de inicio del incidente (UTC-5 Colombia)
> - Quién ejecuta el procedimiento
> - Síntoma observado
> 
> Usar la plantilla de la Sección 8.1.

---

### Escenario 1: Falla de contenedor individual

**Síntomas:** Un endpoint específico retorna 502/503 | Alerta en Grafana para un servicio | `docker ps` muestra un contenedor en estado `Restarting` o `Exited`

**Tiempo estimado de resolución:** 10-15 minutos

#### Paso 1 — Conectarse al servidor de producción

```bash
ssh -i ~/.ssh/ideal_prod_key ubuntu@[PROD_IP]
# Resultado esperado: ubuntu@ideal-production-server:~$
# Tiempo: < 30 segundos
```

#### Paso 2 — Identificar el contenedor fallido

```bash
docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Image}}"
# Resultado esperado: Lista con todos los contenedores.
# Buscar contenedores con status "Exited", "Restarting" o "unhealthy"
```

#### Paso 3 — Revisar logs del contenedor fallido

```bash
# Reemplazar [NOMBRE_CONTENEDOR] con el nombre identificado en el paso anterior
docker logs --tail 100 [NOMBRE_CONTENEDOR]
# Buscar: errores de conexión a DB, variables de entorno faltantes, errores de código
```

#### Paso 4 — Intentar reinicio del contenedor

```bash
# Ir al directorio del repositorio correspondiente
# accounting-iac para microservicios NestJS
cd /home/ubuntu/ideal-infra/accounting-iac
make up service=[NOMBRE_SERVICIO]
# Resultado esperado: "Container [nombre] Started"
# Tiempo: 1-2 minutos

# Para dian-api:
cd /home/ubuntu/ideal-infra/dian-api-iac
make up service=api_dian

# Para kafka:
cd /home/ubuntu/ideal-infra/kafka-iac
make up service=kafka

# Para consumers:
cd /home/ubuntu/ideal-infra/ideal-comsumers-iac
make up service=[NOMBRE_CONSUMER]

# Para caddy:
cd /home/ubuntu/ideal-infra/caddy-iac
make up

# Para ideal-app:
cd /home/ubuntu/ideal-infra/ideal-app-iac
make up
```

#### Paso 5 — Verificar recuperación

```bash
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" | grep [NOMBRE_CONTENEDOR]
# Resultado esperado: "[NOMBRE_CONTENEDOR]   Up X seconds   ..."

# Verificar endpoint (desde el servidor o equipo local):
curl -s -o /dev/null -w "%{http_code}" https://api.idealsoluciones.com.co/health
# Resultado esperado: 200
```

#### Paso 6 — Verificar en Grafana

```
Acceder a Grafana Cloud → Dashboard "Ideal Production" → Confirmar que las métricas del
contenedor recuperado muestran actividad normal (CPU, memoria, requests)
Tiempo: 2-3 minutos para que las métricas aparezcan
```

#### Si el reinicio falla — Escalar a pull de imagen nueva

```bash
cd /home/ubuntu/ideal-infra/[REPO]-iac
make pull
make up service=[NOMBRE_SERVICIO]
# Tiempo adicional: 2-5 minutos (depende del tamaño de la imagen)
```

---

### Escenario 2: Reinicio del servidor

**Síntomas:** Todos los endpoints caídos | Servidor responde SSH pero `docker ps` muestra contenedores parados | Reinicio planificado de mantenimiento AWS

**Tiempo estimado de resolución:** 20-35 minutos

> **Nota:** Los contenedores tienen `restart: unless-stopped` configurado. En un reinicio normal de OS, todos deberían levantarse automáticamente. Este procedimiento cubre el caso donde NO se levantaron solos.

#### Paso 1 — Verificar estado del servidor

```bash
ssh -i ~/.ssh/ideal_prod_key ubuntu@[PROD_IP]
# Si no responde: verificar estado en AWS Console → Lightsail → Instances
# Esperar 3-5 minutos si el servidor acaba de reiniciar (boot time del OS)
```

#### Paso 2 — Verificar cuántos contenedores están activos

```bash
docker ps --format "table {{.Names}}\t{{.Status}}" | wc -l
# Resultado esperado después de reinicio limpio: 23 líneas (22 contenedores + header)
# Si el número es menor, continuar con el paso 3
```

#### Paso 3 — Levantar servicios en orden correcto

El orden es crítico. Respetar los tiempos de espera.

```bash
# --- FASE 1: Kafka (base de mensajería) ---
cd /home/ubuntu/ideal-infra/kafka-iac
make up
# Esperar 30 segundos para que Kafka esté listo (KRaft necesita elegir controller)
sleep 30

# Verificar Kafka
docker ps | grep kafka
# Resultado esperado: kafka y kafka-ui en estado "Up"

# --- FASE 2: API DIAN ---
cd /home/ubuntu/ideal-infra/dian-api-iac
make up
# Esperar 15 segundos
sleep 15

# --- FASE 3: Microservicios de accounting ---
cd /home/ubuntu/ideal-infra/accounting-iac
make up
# Esperar 30 segundos para que los microservicios inicialicen y Apollo Router los descubra
sleep 30

# Verificar Apollo Router
docker ps | grep apollo-router
# Resultado esperado: "Up X seconds"

# --- FASE 4: Consumers ---
cd /home/ubuntu/ideal-infra/ideal-comsumers-iac
make up
sleep 10

# --- FASE 5: Frontend ---
cd /home/ubuntu/ideal-infra/ideal-app-iac
make up
sleep 10

# --- FASE 6: Caddy (reverse proxy — ÚLTIMO) ---
cd /home/ubuntu/ideal-infra/caddy-iac
make up
# Caddy se levanta último para que todos los backends ya estén disponibles
sleep 10
```

#### Paso 4 — Verificación global

```bash
# Contar contenedores activos
docker ps --format "{{.Names}}\t{{.Status}}" | grep "Up"
# Resultado esperado: 22 líneas

# Verificar endpoints principales
curl -s -o /dev/null -w "api.idealsoluciones.com.co: %{http_code}\n" https://api.idealsoluciones.com.co/health
curl -s -o /dev/null -w "app.idealsoluciones.com.co: %{http_code}\n" https://app.idealsoluciones.com.co
# Resultado esperado: ambos retornan 200
```

#### Paso 5 — Verificar Kafka consumers activos

```bash
docker logs --tail 20 emission_consumer_1 2>/dev/null || docker logs --tail 20 $(docker ps --format "{{.Names}}" | grep consumer | head -1)
# Resultado esperado: logs mostrando "Connected to Kafka" o "Listening on topic"
```

---

### Escenario 3: Falla total del servidor

**Síntomas:** Servidor inaccesible por SSH | Instancia Lightsail en estado `stopped`, `error` o no existe | Todos los endpoints completamente caídos por > 10 minutos

**Tiempo estimado de resolución:** 1.5 - 2 horas

**RPO:** ≤ 24 horas (último backup automático de bases de datos)

#### Fase 3.A — Diagnóstico (5-10 minutos)

```bash
# Verificar estado de la instancia desde AWS Console
# 1. Ir a: https://console.aws.amazon.com/lightsail
# 2. Navegar a: Instances
# 3. Verificar estado de la instancia de producción

# Si el estado es "stopped" → intentar reinicio desde consola AWS
# Lightsail → Instances → [nombre instancia] → Start

# Esperar 3 minutos y reintentar SSH:
ssh -i ~/.ssh/ideal_prod_key ubuntu@[PROD_IP]
```

**Si el servidor reinicia exitosamente:** Continuar con Escenario 2 (reinicio del servidor).

**Si el servidor NO reinicia:** Continuar con Fase 3.B.

#### Fase 3.B — Crear nueva instancia Lightsail (30-45 minutos)

```bash
# Opción A: Restaurar desde snapshot de instancia (si existe)
# AWS Console → Lightsail → Instances → [instancia] → Snapshots
# Crear instancia desde el snapshot más reciente

# Opción B: Crear nueva instancia desde Terraform
cd /path/local/ideal-iac/envs/prod

# Verificar estado actual
terraform show

# Re-provisionar instancia
export TF_VAR_postgres_password=[PASSWORD_POSTGRES]
export TF_VAR_mysql_password=[PASSWORD_MYSQL]
terraform plan -out=PLAN_RECOVERY
terraform apply PLAN_RECOVERY
# Tiempo: 5-10 minutos

# Obtener nueva IP
terraform output
# Anotar la nueva IP pública asignada
```

#### Fase 3.C — Preparar nueva instancia (20-30 minutos)

```bash
# Conectarse a la nueva instancia
ssh -i ~/.ssh/ideal_prod_key ubuntu@[NUEVA_IP]

# Actualizar el sistema
sudo apt-get update && sudo apt-get upgrade -y

# Instalar Docker
curl -fsSL https://get.docker.com | sudo sh
sudo usermod -aG docker ubuntu
newgrp docker

# Instalar Make
sudo apt-get install -y make git

# Autenticar con GitHub Container Registry
echo [GITHUB_TOKEN] | docker login ghcr.io -u [GITHUB_USERNAME] --password-stdin
# Resultado esperado: "Login Succeeded"

# Clonar repositorios de infraestructura
mkdir -p /home/ubuntu/ideal-infra
cd /home/ubuntu/ideal-infra

git clone https://github.com/ideal-saas/kafka-iac.git
git clone https://github.com/ideal-saas/dian-api-iac.git
git clone https://github.com/ideal-saas/accounting-iac.git
git clone https://github.com/ideal-saas/ideal-comsumers-iac.git
git clone https://github.com/ideal-saas/ideal-app-iac.git
git clone https://github.com/ideal-saas/caddy-iac.git
# Tiempo: 5-10 minutos
```

#### Fase 3.D — Restaurar variables de entorno

```bash
# Crear archivos .env.local en cada repositorio con las credenciales de producción
# USAR LAS CREDENCIALES DEL GESTOR DE CONTRASEÑAS DEL EQUIPO

# kafka-iac
cat > /home/ubuntu/ideal-infra/kafka-iac/.env.local << 'ENVEOF'
[CONTENIDO DEL .env.local DE KAFKA — OBTENER DEL GESTOR DE CONTRASEÑAS]
ENVEOF

# dian-api-iac
cat > /home/ubuntu/ideal-infra/dian-api-iac/.env.local << 'ENVEOF'
[CONTENIDO DEL .env.local DE DIAN-API — OBTENER DEL GESTOR DE CONTRASEÑAS]
ENVEOF

# accounting-iac
cat > /home/ubuntu/ideal-infra/accounting-iac/.env.local << 'ENVEOF'
[CONTENIDO DEL .env.local DE ACCOUNTING — OBTENER DEL GESTOR DE CONTRASEÑAS]
ENVEOF

# Repetir para ideal-comsumers-iac, ideal-app-iac, caddy-iac
# Tiempo: 10-15 minutos
```

#### Fase 3.E — Levantar servicios

```bash
# Seguir el orden del Escenario 2, Paso 3 exactamente.
# Tiempo estimado: 10-15 minutos
```

#### Fase 3.F — Actualizar DNS si cambió la IP

```bash
# Si la IP pública cambió, actualizar registros DNS:
# Proveedor DNS → Registros A:
#   api.idealsoluciones.com.co  → [NUEVA_IP]
#   app.idealsoluciones.com.co  → [NUEVA_IP]
#   admin.idealsoluciones.com.co → [NUEVA_IP]
# Tiempo de propagación DNS: hasta 15 minutos (TTL configurado)

# Caddy renovará automáticamente los certificados TLS con Let's Encrypt
# cuando los DNS apunten a la nueva IP. Dar hasta 5 minutos.
```

#### Fase 3.G — Verificación final

```bash
# Desde equipo local, verificar todos los endpoints:
for domain in api.idealsoluciones.com.co app.idealsoluciones.com.co; do
    status=$(curl -s -o /dev/null -w "%{http_code}" https://$domain)
    echo "$domain: HTTP $status"
done
# Resultado esperado: ambos con HTTP 200

# Verificar certificados TLS:
echo | openssl s_client -connect api.idealsoluciones.com.co:443 2>/dev/null | openssl x509 -noout -dates
# Resultado esperado: fechas de validez vigentes
```

---

### Escenario 4: Falla o corrupción de base de datos

**Síntomas:** Errores `ECONNREFUSED` o `Connection refused` en logs de microservicios | Errores de integridad de datos | Base de datos Lightsail en estado `error` en consola AWS

**Tiempo estimado de resolución:** 1-2 horas (restauración desde backup)

**RPO:** ≤ 24 horas (último backup automático)

#### Paso 1 — Diagnosticar el tipo de falla

```bash
# Desde el servidor de producción, verificar logs de microservicios
ssh -i ~/.ssh/ideal_prod_key ubuntu@[PROD_IP]

# Revisar logs de un microservicio de accounting
cd /home/ubuntu/ideal-infra/accounting-iac
make log service=core-ms
# Buscar: "ECONNREFUSED", "Connection terminated", "getaddrinfo ENOTFOUND"

# Revisar logs de dian-api (MySQL)
cd /home/ubuntu/ideal-infra/dian-api-iac
make log service=api_dian
# Buscar: "SQLSTATE[HY000] [2002]", "Connection refused", "Access denied"
```

#### Paso 2 — Verificar estado en AWS Console

```
1. Ir a: https://console.aws.amazon.com/lightsail
2. Navegar a: Databases
3. Verificar estado de ideal-prod-postgres y ideal-prod-mysql
   - Estado "Available" = base de datos operacional (problema puede ser en la red/config)
   - Estado "Backing up" = esperar a que termine el backup
   - Estado "Failed" o "Error" = continuar con restauración
```

#### Paso 3A — Si la DB está disponible pero los microservicios no conectan

```bash
# Verificar conectividad de red desde el servidor al endpoint de la DB
# Obtener endpoint desde: AWS Console → Lightsail → Databases → [DB] → Connection details

ping [DB_ENDPOINT]
# Si no responde, puede ser firewall de Lightsail

# Verificar variables de entorno en los contenedores
docker exec [CONTENEDOR_MICROSERVICIO] env | grep -E "DB_HOST|DB_PORT|DATABASE_URL"
# Verificar que el host apunta al endpoint correcto de la Lightsail DB
```

#### Paso 3B — Restauración desde backup (si la DB falla)

```bash
# POSTGRESQL — Restaurar desde snapshot de Lightsail

# 1. Ir a AWS Console → Lightsail → Databases → ideal-prod-postgres
# 2. Click en "Snapshots" → Seleccionar el snapshot más reciente
# 3. Click "Restore snapshot" → Crear nueva instancia: ideal-prod-postgres-restored
# 4. Tiempo de restauración: 10-20 minutos

# Una vez restaurada, obtener el nuevo endpoint:
# AWS Console → Lightsail → Databases → ideal-prod-postgres-restored → Connection details

# Actualizar el endpoint en los archivos .env.local de accounting-iac e ideal-comsumers-iac:
# DB_HOST=[NUEVO_ENDPOINT_POSTGRES]

# Reiniciar microservicios:
cd /home/ubuntu/ideal-infra/accounting-iac
make down
make up

cd /home/ubuntu/ideal-infra/ideal-comsumers-iac
make down
make up
```

```bash
# MYSQL — Restaurar desde snapshot de Lightsail

# 1. Ir a AWS Console → Lightsail → Databases → ideal-prod-mysql
# 2. Click "Snapshots" → Seleccionar snapshot más reciente
# 3. Click "Restore snapshot" → Crear nueva instancia: ideal-prod-mysql-restored
# 4. Tiempo de restauración: 10-20 minutos

# Actualizar endpoint en dian-api-iac:
# DB_HOST=[NUEVO_ENDPOINT_MYSQL]

# Reiniciar dian-api:
cd /home/ubuntu/ideal-infra/dian-api-iac
make down
make up
```

#### Paso 4 — Verificar integridad de datos

```bash
# Verificar los últimos registros creados en PostgreSQL
# Conectarse a la DB restaurada y verificar tablas críticas:
# (ejecutar desde cliente psql local o desde el contenedor)

docker exec -it [CONTENEDOR_MICROSERVICIO] sh -c "
  psql \$DATABASE_URL -c 'SELECT COUNT(*) FROM invoices ORDER BY created_at DESC LIMIT 1;'
"
# Nota: Ajustar la query según el esquema real de la base de datos

# Revisar con el equipo de negocio qué documentos fueron procesados
# en las últimas 24 horas (período de posible pérdida de datos = RPO)
```

---

### Escenario 5: Falla de Kafka

**Síntomas:** Consumers aparecen en estado `Restarting` | Errores `KafkaJSConnectionError` en logs | Documentos DIAN no se están transmitiendo (cola represada)

**Tiempo estimado de resolución:** 15-30 minutos

#### Paso 1 — Diagnóstico

```bash
ssh -i ~/.ssh/ideal_prod_key ubuntu@[PROD_IP]

# Verificar estado de Kafka
cd /home/ubuntu/ideal-infra/kafka-iac
make ps
# Resultado esperado: kafka y kafka-ui en "Up"

# Revisar logs de Kafka
make log service=kafka
# Buscar: errores de KRaft, "Failed to load", "IOException", "OutOfMemoryError"
```

#### Paso 2 — Reinicio controlado de Kafka

```bash
# IMPORTANTE: Detener primero los consumers para evitar errores en cascada
cd /home/ubuntu/ideal-infra/ideal-comsumers-iac
make stop
# Resultado esperado: todos los consumers detenidos (no eliminados)

# Reiniciar Kafka
cd /home/ubuntu/ideal-infra/kafka-iac
make down
sleep 5
make up
# Tiempo: 30-60 segundos para que Kafka inicie en modo KRaft

# Esperar a que Kafka esté completamente listo (logs muestran "Kafka Server started")
make log service=kafka
# Buscar: "[KafkaServer id=1] started (kafka.server.KafkaServer)" o similar
sleep 20
```

#### Paso 3 — Reiniciar consumers

```bash
cd /home/ubuntu/ideal-infra/ideal-comsumers-iac
make up
# Tiempo: 30 segundos

# Verificar que los 6 consumers están activos
make ps
# Resultado esperado: 6 contenedores de consumer en estado "Up"

# Revisar logs de un consumer para confirmar conexión a Kafka
make log service=[NOMBRE_CONSUMER_1]
# Resultado esperado: "Connected to Kafka broker", "Subscribed to topic [X]"
```

#### Paso 4 — Verificar procesamiento de cola

```bash
# Verificar si hay mensajes represados en los topics
# (usando Kafka UI si está disponible)
# Acceder a: https://kafka-ui.rcermeno.link (si está habilitado)
# o via Kafka UI interno

# Alternativamente, verificar desde logs de los consumers que están procesando:
docker logs --tail 50 [NOMBRE_CONSUMER] | grep -E "processed|message|topic"
# Resultado esperado: mensajes de procesamiento activo
```

#### Si Kafka no inicia — Limpiar datos de Kafka

> **ADVERTENCIA:** Este paso borra todos los mensajes no procesados. Solo ejecutar si Kafka es completamente inoperable y no hay otra opción.

```bash
cd /home/ubuntu/ideal-infra/kafka-iac
make down

# Eliminar volúmenes de Kafka (BORRA TODOS LOS MENSAJES)
docker volume ls | grep kafka
docker volume rm [NOMBRE_VOLUMEN_KAFKA]

# Reiniciar desde cero
make up

# Notificar al equipo de negocio sobre posible pérdida de mensajes en cola
```

---

### Escenario 6: Brecha de seguridad / compromiso de credenciales

**Síntomas:** Actividad inusual en logs de Caddy | Accesos SSH desde IPs desconocidas | Token de GitHub o AWS revocado externamente | Alerta de seguridad de GitHub/AWS

**Tiempo estimado de resolución:** 2-4 horas

**PRIORIDAD: Contener primero, investigar después**

#### Fase 6.A — Contención inmediata (< 15 minutos)

```bash
# 1. REVOCAR TOKENS COMPROMETIDOS INMEDIATAMENTE
# GitHub: https://github.com/settings/tokens → Revocar todos los tokens activos
# AWS: IAM Console → Usuarios → Deshabilitar Access Keys sospechosas

# 2. BLOQUEAR ACCESO SSH desde IPs desconocidas
# AWS Console → Lightsail → Instances → [instancia] → Networking
# Firewall rules → Modificar regla SSH (port 22) para permitir SOLO IPs del equipo

# 3. CAMBIAR contraseña del servidor inmediatamente
ssh -i ~/.ssh/ideal_prod_key ubuntu@[PROD_IP]
sudo passwd ubuntu  # Solo si hay evidencia de compromiso de contraseña

# 4. Verificar sesiones SSH activas
who
# Si hay sesiones desconocidas, cerrarlas inmediatamente:
# sudo pkill -u [USUARIO_SOSPECHOSO]
```

#### Fase 6.B — Evaluación del daño (15-30 minutos)

```bash
# Revisar logs de acceso SSH
sudo cat /var/log/auth.log | grep "Accepted\|Failed" | tail -50
# Identificar IPs que se conectaron

# Revisar logs de Caddy para requests anómalos
cd /home/ubuntu/ideal-infra/caddy-iac
make log service=caddy 2>/dev/null || docker logs caddy --tail 200
# Buscar: requests masivos, paths inusuales, métodos HTTP no esperados

# Verificar si los containers fueron modificados
docker ps --format "{{.Names}}\t{{.Image}}\t{{.Status}}" > /tmp/containers_actual.txt
# Comparar con estado esperado

# Revisar historial de comandos
cat ~/.bash_history | tail -50
```

#### Fase 6.C — Rotación completa de credenciales (1-2 horas)

```bash
# 1. Generar nuevo par de llaves SSH
ssh-keygen -t ed25519 -C "ideal-prod-recovery-$(date +%Y%m%d)" -f ~/.ssh/ideal_prod_new
# Agregar nueva llave pública al servidor:
# cat ~/.ssh/ideal_prod_new.pub | ssh ubuntu@[PROD_IP] "cat >> ~/.ssh/authorized_keys"
# Eliminar llave antigua del servidor:
# En el servidor: nano ~/.ssh/authorized_keys → Eliminar línea de la llave antigua

# 2. Rotar todos los tokens de GitHub:
# GitHub → Settings → Developer settings → Personal access tokens → Revocar y recrear
# Actualizar en .env.local de todos los repos en el servidor

# 3. Rotar credenciales de AWS si estuvieron expuestas:
# IAM → Usuarios → [usuario] → Security credentials → Rotate access keys

# 4. Cambiar contraseñas de bases de datos:
# AWS Console → Lightsail → Databases → [cada DB] → Change password
# Actualizar en todos los archivos .env.local que la usan

# 5. Actualizar todos los archivos .env.local en el servidor con las nuevas credenciales
```

#### Fase 6.D — Re-despliegue limpio

```bash
# Detener todos los servicios
for repo in kafka-iac dian-api-iac accounting-iac ideal-comsumers-iac ideal-app-iac caddy-iac; do
    cd /home/ubuntu/ideal-infra/$repo
    make down
done

# Hacer pull de todas las imágenes (verificar que no fueron comprometidas)
for repo in kafka-iac dian-api-iac accounting-iac ideal-comsumers-iac ideal-app-iac caddy-iac; do
    cd /home/ubuntu/ideal-infra/$repo
    make pull
done

# Levantar en orden (seguir Escenario 2, Paso 3)
# ... (ver orden de arranque en Escenario 2)
```

#### Fase 6.E — Notificación obligatoria

> Si se confirma una brecha de datos personales, notificar a la Superintendencia de Industria y Comercio (SIC) dentro de las **15 días hábiles** siguientes (Ley 1581 de 2012, Decreto 1377 de 2013). Si hay impacto en documentos DIAN, notificar según el procedimiento de la Sección 8.4.

---

### Escenario 7: Indisponibilidad de servicios web DIAN

**Síntomas:** Los documentos electrónicos (facturas, notas) se generan internamente pero la transmisión a la DIAN falla | Errores HTTP 500/503 al conectar con los web services DIAN | Timeout en envíos DIAN

**Tiempo estimado de resolución:** No aplica (sistema externo) | Procedimiento de contingencia activo

> **Nota importante:** Este es el único escenario donde el sistema de Ideal Software funciona correctamente pero el servicio percibido falla por causas externas. Los documentos se GENERAN y ALMACENAN localmente. La DIAN reconoce esta situación y tiene procedimientos para transmisión diferida.

#### Paso 1 — Confirmar que el problema es externo (DIAN)

```bash
# Verificar estado de los web services DIAN
curl -v https://vpfe.dian.gov.co/WcfDianCustomerServices.svc?wsdl 2>&1 | tail -5
# Si retorna error de conexión: problema de DIAN o de conectividad

# Verificar conectividad general desde el servidor
curl -v https://www.google.com -o /dev/null --max-time 5
# Si falla: problema de conectividad del servidor (no de DIAN)

# Verificar página de estado de DIAN (si está disponible)
# https://www.dian.gov.co

# Verificar en canales de la comunidad DIAN (grupos de WhatsApp, foros de facturación electrónica)
# para confirmar si otros proveedores también tienen el problema
```

#### Paso 2 — Activar modo de contingencia

```bash
# Los documentos generados localmente se almacenan en la base de datos.
# Verificar que la generación local sigue funcionando:
curl -s https://api.idealsoluciones.com.co/health
# Resultado esperado: 200

# Comunicar a los clientes afectados:
# "El sistema está operando en modo contingencia. Sus documentos están siendo
#  generados y almacenados. La transmisión a la DIAN se realizará automáticamente
#  cuando sus servicios se restablezcan. No es necesario realizar ninguna acción."
```

#### Paso 3 — Monitorear restablecimiento de DIAN

```bash
# Crear script de monitoreo temporal mientras DIAN está caída:
watch -n 60 'curl -s -o /dev/null -w "%{http_code}" https://vpfe.dian.gov.co/WcfDianCustomerServices.svc?wsdl'
# Cuando retorne 200: la transmisión automática debería reanudarse

# Verificar que los consumers reanudan el procesamiento de la cola:
cd /home/ubuntu/ideal-infra/ideal-comsumers-iac
make log service=[NOMBRE_CONSUMER_DIAN]
# Resultado esperado: mensajes de transmisión exitosa
```

#### Paso 4 — Verificación post-restablecimiento

```bash
# Verificar que los documentos represados se están transmitiendo:
docker logs --tail 100 [CONSUMER_DIAN_EMISSION] | grep -E "transmitted|success|CUFE"
# Resultado esperado: registros de transmisiones exitosas

# Verificar en la plataforma de la DIAN que los documentos llegaron:
# https://catalogo-vpfe.dian.gov.co
```

---

## 7. Procedimiento de Simulacro DRP

### 7.1 Objetivo del Simulacro

Validar que el equipo técnico puede ejecutar los procedimientos del DRP dentro de los RTO establecidos, identificar brechas en la documentación y actualizar los procedimientos según sea necesario.

### 7.2 Frecuencia

- **Simulacro completo:** Anual (cada 12 meses)
- **Simulacro parcial (Escenarios 1 y 2):** Trimestral (cada 3 meses)
- **Revisión del documento:** Semestral

### 7.3 Procedimiento del Simulacro Trimestral

El simulacro trimestral prueba los escenarios de menor riesgo (1 y 2) que pueden ejecutarse en un servidor de QA sin afectar producción.

#### Pre-simulacro (1 día antes)

```
[ ] Notificar al equipo con 24 horas de anticipación
[ ] Verificar que el servidor QA está operacional
[ ] Revisar que todos los pre-requisitos (Sección 4) están satisfechos
[ ] Preparar plantilla de registro del simulacro (ver 7.4)
[ ] Establecer "ventana de mantenimiento" de 2 horas
```

#### Ejecución del simulacro en QA

```bash
# Servidor QA: ubuntu@32.194.205.163
ssh ubuntu@32.194.205.163

# Hora de inicio del simulacro (registrar en plantilla):
echo "SIMULACRO INICIO: $(date '+%Y-%m-%d %H:%M:%S')"

# --- PRUEBA ESCENARIO 1: Derribar un contenedor específico ---
# Seleccionar un microservicio no crítico (ej: file-uploader)
docker stop file-uploader-ms  # Usar nombre real del contenedor
# Registrar hora de detención

# Ejecutar procedimiento de recuperación del Escenario 1 (paso a paso)
# Registrar hora de recuperación

# Calcular MTTR:
# MTTR = hora_recuperación - hora_detención

# --- PRUEBA ESCENARIO 2: Simulacro de reinicio de servidor ---
# Detener TODOS los containers manualmente (simula reinicio de OS)
for repo in caddy-iac ideal-app-iac ideal-comsumers-iac accounting-iac dian-api-iac kafka-iac; do
    cd /home/ubuntu/ideal-infra/$repo && make stop
done
echo "TODOS LOS SERVICIOS DETENIDOS: $(date '+%Y-%m-%d %H:%M:%S')"

# Ejecutar procedimiento de recuperación del Escenario 2 (paso a paso)
# Al finalizar:
echo "TODOS LOS SERVICIOS RECUPERADOS: $(date '+%Y-%m-%d %H:%M:%S')"

# Verificar conteo de containers activos
docker ps | grep "Up" | wc -l
# Resultado esperado: 22 (o el número actual de containers en QA)
```

### 7.4 Plantilla de Registro de Simulacro DRP

```
=========================================================
REGISTRO DE SIMULACRO DRP — IDEAL SOFTWARE S.A.S
=========================================================
Fecha: ___________________
Hora inicio: _____________  Hora fin: ________________
Duración total: __________
Responsable: _____________
Participantes: ___________

--- ESCENARIO 1: Falla de contenedor ---
Hora de inicio del escenario: ________
Contenedor afectado: _________________
Hora de detección: ___________________
Hora de recuperación: ________________
MTTR real: __________________________
RTO objetivo (15 min): [ ] Cumplido  [ ] No cumplido
Observaciones: ______________________

--- ESCENARIO 2: Reinicio del servidor ---
Hora de inicio del escenario: ________
Hora de último container detenido: ___
Hora de primer container levantado: __
Hora de sistema completamente recuperado: __________
RTO real: ___________________________
RTO objetivo (30 min): [ ] Cumplido  [ ] No cumplido

--- Checklist de verificación post-simulacro ---
[ ] Todos los containers activos (contar: ___ / 22 esperados)
[ ] Endpoint api.idealsoluciones.com.co responde 200
[ ] Endpoint app.idealsoluciones.com.co responde 200
[ ] Kafka consumers conectados
[ ] Grafana muestra métricas activas

--- Problemas encontrados durante el simulacro ---
1. _____________________________________
2. _____________________________________
3. _____________________________________

--- Acciones correctivas ---
1. Responsable: _______ Acción: _______ Plazo: _______
2. Responsable: _______ Acción: _______ Plazo: _______

--- Aprobación ---
Firma técnico responsable: _________________
Fecha de aprobación: _______________________
=========================================================
```

---

## 8. Procedimiento Post-Incidente

### 8.1 Plantilla de Registro de Incidente

```
=========================================================
REGISTRO DE INCIDENTE — IDEAL SOFTWARE S.A.S
=========================================================
ID Incidente: INC-[AÑO]-[NÚMERO SECUENCIAL]  (ej: INC-2026-001)
Fecha: ___________________
Hora de detección: _________ (hora Colombia UTC-5)
Hora de resolución: _________
Duración total del incidente: _______
Severidad: [ ] CRÍTICA  [ ] ALTA  [ ] MEDIA  [ ] BAJA
Escenario DRP activado: Escenario #___

--- Descripción del incidente ---
Síntoma inicial: ________________________________
Componentes afectados: __________________________
Clientes impactados (estimado): _________________
Servicios DIAN afectados (S/N): _________________

--- Cronología ---
[HH:MM] Detección del incidente
[HH:MM] Notificación al equipo técnico
[HH:MM] Inicio del procedimiento DRP
[HH:MM] [Acción tomada]
[HH:MM] [Acción tomada]
[HH:MM] Recuperación del servicio
[HH:MM] Verificación completada
[HH:MM] Notificación a clientes

--- Causa raíz ---
Causa inmediata: ________________________________
Causa raíz: _____________________________________
Factores contribuyentes: ________________________

--- Acciones correctivas ---
1. Acción: _____________ Responsable: _______ Plazo: _______
2. Acción: _____________ Responsable: _______ Plazo: _______

--- Aprobación ---
Elaborado por: _________________ Fecha: _________
Revisado por: __________________ Fecha: _________
=========================================================
```

### 8.2 Comunicación a Clientes Afectados

Usar la siguiente plantilla de email para notificar a clientes cuando el incidente supere 30 minutos de duración o afecte la transmisión de documentos DIAN:

```
Asunto: [IDEAL SOFTWARE] Notificación de interrupción del servicio — [FECHA]

Estimado/a [NOMBRE DEL CLIENTE]:

Por medio del presente comunicado, IDEAL SOFTWARE S.A.S informa sobre una
interrupción del servicio de facturación electrónica ocurrida el día
[FECHA] entre las [HORA INICIO] y las [HORA FIN], con una duración
total de [DURACIÓN].

IMPACTO:
- [Describir qué servicios estuvieron afectados]
- [Indicar si los documentos fueron afectados o solo retrasados]

ESTADO ACTUAL:
El servicio ha sido completamente restablecido. [Si aplica: Los documentos
generados durante el período de contingencia fueron transmitidos exitosamente
a la DIAN una vez restablecida la conectividad.]

CAUSA:
[Descripción no técnica de la causa]

ACCIONES PREVENTIVAS:
[Medidas tomadas para evitar recurrencia]

Nos disculpamos por las molestias ocasionadas y quedamos a su disposición
para cualquier consulta.

Atentamente,
Equipo de Soporte IDEAL SOFTWARE S.A.S
[soporte@idealsoluciones.com.co]
[Teléfono de soporte]
```

### 8.3 Análisis de Causa Raíz (RCA)

El análisis de causa raíz debe completarse dentro de las **48 horas** siguientes a la resolución del incidente para incidentes de severidad ALTA o CRÍTICA.

**Metodología:** 5 Porqués (5 Whys)

```
Problema: [Descripción del síntoma observado]

¿Por qué ocurrió?           → [Causa 1]
¿Por qué ocurrió [Causa 1]? → [Causa 2]
¿Por qué ocurrió [Causa 2]? → [Causa 3]
¿Por qué ocurrió [Causa 3]? → [Causa 4]
¿Por qué ocurrió [Causa 4]? → CAUSA RAÍZ

Solución de fondo: [Acción que elimina la causa raíz]
```

### 8.4 Notificación a la DIAN

Conforme al numeral 8 del artículo 55 de la Resolución 00165 de 2023, IDEAL SOFTWARE S.A.S debe notificar a la DIAN cuando se presente una interrupción del servicio de facturación electrónica **superior a 4 horas continuas**.

**Canal de notificación:** Oficio formal dirigido a la Subdirección de Tecnología e Informática de la DIAN.

**Plantilla de notificación DIAN:**

```
Ciudad, [FECHA]

Subdirección de Tecnología e Informática
Dirección de Impuestos y Aduanas Nacionales — DIAN

Ref.: Notificación de interrupción del servicio — Resolución 00165/2023, Art. 55 Num. 8

IDEAL SOFTWARE S.A.S, con NIT 902.027.596-7, en calidad de proveedor
tecnológico habilitado para la prestación del servicio de facturación
electrónica, por medio del presente informa:

1. DESCRIPCIÓN DEL INCIDENTE:
   Fecha y hora de inicio: [FECHA] a las [HORA] (UTC-5)
   Fecha y hora de resolución: [FECHA] a las [HORA] (UTC-5)
   Duración total: [X] horas [Y] minutos

2. SERVICIOS AFECTADOS:
   [Lista de servicios de facturación electrónica afectados]

3. CAUSA:
   [Descripción técnica de la causa del incidente]

4. ACCIONES TOMADAS:
   [Procedimiento de recuperación ejecutado]

5. MEDIDAS PREVENTIVAS:
   [Acciones para evitar recurrencia]

6. IMPACTO EN CONTRIBUYENTES:
   Número aproximado de empresas afectadas: [N]
   Documentos electrónicos pendientes de transmisión: [N]
   Estado actual de dichos documentos: [transmitidos/en proceso]

Atentamente,

___________________________
FELIX PALACIO ARGUELLE
Representante Legal
IDEAL SOFTWARE S.A.S
NIT: 902.027.596-7
```

---

## 9. Sección 7.3 — Texto para punto-8-infraestructura.md

El siguiente texto debe insertarse en el archivo `punto-8-infraestructura.md` como subsección dentro de la Sección 7 "Continuidad de la Prestación del Servicio":

```markdown
### 7.3 Plan de Recuperación ante Desastres (DRP)

IDEAL SOFTWARE S.A.S cuenta con un Plan de Recuperación ante Desastres documentado
y operacional (documento `PLAN-drp-runbook.md`), que establece los procedimientos
técnicos para la recuperación del servicio ante los siguientes escenarios:

| Escenario | Severidad | RTO |
|-----------|-----------|-----|
| Falla de contenedor individual | Baja | 15 min |
| Reinicio del servidor (todos los servicios) | Media | 30 min |
| Falla total del servidor / corrupción | Alta | 2 horas |
| Falla o corrupción de base de datos | Alta | 1-2 horas |
| Falla de Apache Kafka | Media | 30 min |
| Brecha de seguridad / credenciales | Crítica | 2-4 horas |
| Indisponibilidad servicios DIAN (externo) | Media | N/A |

**Objetivos de Recuperación:**
- **RPO (Recovery Point Objective):** ≤ 24 horas, soportado por backups automáticos
  diarios de las bases de datos en AWS Lightsail Managed Database (retención 7 días,
  ventana de backup 04:00-04:30 UTC).
- **RTO (Recovery Time Objective):** ≤ 2 horas para el peor escenario (falla total
  de servidor), con procedimientos documentados de re-aprovisionamiento mediante
  Terraform y re-despliegue mediante Docker Compose + Make.

**Componentes del plan:**
- Runbook operacional con comandos exactos para cada escenario
- Árbol de escalación con contactos y tiempos de respuesta
- Plantillas de registro de incidentes y comunicación a clientes
- Procedimiento de notificación a la DIAN para interrupciones > 4 horas
- Procedimiento de simulacro trimestral con plantilla de resultados

**Simulacros:** El plan se prueba trimestralmente en el servidor de QA
(32.194.205.163). Los resultados se documentan y archivan como evidencia
de continuidad operacional.

**Documento completo:** Ver `ideal-docs/PLAN-drp-runbook.md`
```

---

## 10. Control de Cambios

| Versión | Fecha | Autor | Cambio |
|---------|-------|-------|--------|
| 1.0 | Mayo 2026 | Ricardo Cermeño Bolaño | Versión inicial para certificación DIAN |

---

*Documento clasificado como CONFIDENCIAL. No distribuir fuera del equipo técnico de IDEAL SOFTWARE S.A.S sin autorización del Director de Tecnología.*

*Próxima revisión: Noviembre 2026 (semestral) o ante cualquier cambio significativo en la infraestructura.*
