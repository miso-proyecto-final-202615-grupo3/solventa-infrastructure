## Diseño de Redes en AWS

Diseño de Redes en AWS (Solventa)

Este documento describe la arquitectura de red para el entorno de desarrollo en AWS, especificando la configuración de la VPC, bloques CIDR, subredes, tablas de enrutamiento y componentes de conectividad.

---

## 1. Información General

* **Proyecto:** Solventa Dev
* **Región de AWS:** `us-east-1` (Norte de Virginia)
* **VPC Principal:** `vpc-solventa-dev-use1-1`
* **Bloque CIDR de la VPC:** `10.100.0.0/16` (65,536 direcciones IP privadas)

---

## 2. Topología de Subredes (Subnets)

La arquitectura distribuye los recursos en una subred pública y dos subredes privadas ubicadas en diferentes zonas de disponibilidad para garantizar alta disponibilidad y seguridad.

| Nombre de la Subnet | Tipo | Zona de Disponibilidad (AZ) | Bloque CIDR | Propósito Principal |
| :--- | :--- | :--- | :--- | :--- |
| `snt-solventa-dev-use1-public-1a` | Pública | `us-east-1a` | `10.100.1.0/24` | Internet Gateway, NAT Gateway y Application Load Balancer (ALB). |
| `snt-solventa-dev-use1-private-2a` | Privada | `us-east-1b` | `10.100.10.0/24` | Alojamiento de servicios de aplicación backend (API / microservicios). |
| `snt-solventa-dev-use1-private-3a` | Privada | `us-east-1c` | `10.100.20.0/24` | Alojamiento de bases de datos o servicios internos sin acceso directo a internet. |

---

## 3. Recursos de Conectividad y Enrutamiento (VPC Resources)

### 3.1. Internet Gateway (IGW)
* **Nombre:** `igw-solventa-dev-use1-1`
* **Descripción:** Permite la comunicación bidireccional entre la VPC e Internet para los recursos públicos.

### 3.2. NAT Gateway
* **Nombre:** `nat-solventa-dev-use1-1`
* **Ubicación:** Desplegado dentro de la subred pública `snt-solventa-dev-use1-public-1a`.
* **Elastic IP Asociada:** `eipalloc-xxxxxxxxxxxx`
* **Descripción:** Permite que las instancias en las subredes privadas (`private-2a` y `private-3a`) inicien conexiones salientes hacia Internet (por ejemplo, para descargas de parches o dependencias) sin exponerlas a conexiones entrantes.

---

## 4. Tablas de Enrutamiento (Route Tables)

### 4.1. Tabla de Enrutamiento Pública (`rtb-solventa-dev-public`)
Asociada a la subred pública: `snt-solventa-dev-use1-public-1a`.

| Destino (Destination) | Blanco (Target) | Descripción |
| :--- | :--- | :--- |
| `10.100.0.0/16` | `local` | Tráfico interno dentro de la VPC. |
| `0.0.0.0/0` | `igw-solventa-dev-use1-1` | Tráfico hacia Internet a través del Internet Gateway. |

### 4.2. Tabla de Enrutamiento Privada (`rtb-solventa-dev-private`)
Asociada a las subredes privadas: `snt-solventa-dev-use1-private-2a` y `snt-solventa-dev-use1-private-3a`.

| Destino (Destination) | Blanco (Target) | Descripción |
| :--- | :--- | :--- |
| `10.100.0.0/16` | `local` | Tráfico interno dentro de la VPC. |
| `0.0.0.0/0` | `nat-solventa-dev-use1-1` | Tráfico saliente hacia Internet a través del NAT Gateway. |

---

## 5. Seguridad y Control de Acceso

* **Default Security Group:** Restringe todo el tráfico entrante por defecto y permite todo el tráfico saliente.
* **Network Access Control Lists (NACLs):** Se mantiene una NACL predeterminada abierta en modo permisivo para las subredes, delegando los controles granulares de seguridad a los Security Groups específicos de cada capa de aplicación.