# Solventa Infrastructure

Base de Terraform para desplegar infraestructura en varias cuentas y ambientes de AWS. Cada directorio de `environments/` es un root module independiente y consume módulos compartidos de `modules/`.

## Estructura

```text
.
├── config/
│   └── environments/
│       ├── dev/               # Configuración para Desarrollo
│       ├── qa/                # Configuración para QA
│       └── prod/              # Configuración para Producción
├── src/
│   ├── environments/
│   │   ├── dev/               # Root module para Desarrollo
│   │   ├── qa/                # Root module para QA
│   │   └── prod/              # Root module para Producción
│   └── modules/
│       └── <module_name>/     # Ejemplo de módulo compartido
```

La configuración de proveedores está en `providers.tf`. Los archivos de `config/` contienen configuraciones por ambiente.

## Requisitos

- Terraform >= 1.16
- AWS CLI configurado con credenciales de origen para asumir el rol destino
- Un rol IAM por cuenta destino que confíe en la identidad de origen

## Uso

Desde la raíz del repositorio, inicializa y revisa el plan del ambiente deseado:

```sh
terraform -chdir=src/environments/dev init
terraform -chdir=src/environments/dev plan -var-file=../../../config/dev/dev.tfvars
```

Para aplicar, revisa el plan y ejecuta:

```sh
terraform -chdir=src/environments/dev apply -var-file=../../../config/dev/dev.tfvars
```

Repite sustituyendo `dev` por `qa` o `prod`. Antes de operar en producción, configura revisión/aprobación del plan y un backend remoto con cifrado, versionado y bloqueo de estado.