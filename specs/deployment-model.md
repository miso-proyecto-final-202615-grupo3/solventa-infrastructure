## Modelo de Despliegue

| **Ficha**            |                                           |
| :------------------- | :---------------------------------------- |
| ID:                  | DES-001                                   |
| Vista:               | Despliegue                                |
| Modelo:              | Modelo de despliegue del Sistema Solventa |
| Notación:            | UML Despliegue                            |
| Version:             | 2.0                                       |
| Fecha Actualización: | 04/09/2026                                |

<details>
<summary>Fuente del diagrama en PlantUML</summary>

```plantuml
@startuml

!define AWSPuml https://raw.githubusercontent.com/awslabs/aws-icons-for-plantuml/v23.0/dist
!include AWSPuml/AWSCommon.puml
!include AWSPuml/ApplicationIntegration/SimpleQueueService.puml
!include AWSPuml/Containers/ElasticKubernetesService.puml
!include AWSPuml/Database/AuroraPostgreSQLInstance.puml
!include AWSPuml/NetworkingContentDelivery/APIGateway.puml
!include AWSPuml/NetworkingContentDelivery/ElasticLoadBalancingApplicationLoadBalancer.puml
!include AWSPuml/SecurityIdentityCompliance/Cognito.puml
!include AWSPuml/SecurityIdentityCompliance/KeyManagementService.puml
!include AWSPuml/SecurityIdentityCompliance/SecretsManager.puml
!include AWSPuml/Storage/SimpleStorageServiceBucket.puml
!include AWSPuml/ApplicationIntegration/SimpleNotificationService.puml

skinparam nodeStyle rectangle

node "PC Usuario Solventa\n<size:64><&monitor></size>" as pc <<device>> {
  component "Web App Solventa" as webApp <<component>>
}

node "Dispositivo Móvil Usuario Solventa\n<size:64><&phone></size>" as phone <<device>> {
  component "App Móvil Android Solventa" as mobileApp <<component>>
}

node "API Gateway Solventa\n<$APIGateway>" as apiGW <<device>> {
  component "Public API" as api <<component>>
}

rectangle "Capa de Aplicaciones" {
	node "Balanceador de Carga\n<$ElasticLoadBalancingApplicationLoadBalancer>" as alb <<device>>
	
	node "Clúster EKS Microservicios\n<$ElasticKubernetesService>" as eksCluster <<device>> {
	  node "Nodo Worker 1" as eksNode1 <<device>> {
	    component "Microservicio\nBFF Web" as bffWeb <<component>>
	    component "Microservicio\nIdentidad, Consentimiento y Perfilamiento" as icpMicroservice <<component>>
	    component "Microservicio\nGestión de Pólizas" as gpMicroservice <<component>>
	  }
	  node "Nodo Worker 2" as eksNode2 <<device>> {
	    component "Microservicio\nBFF Móvil" as bffMobile <<component>>
	    component "Microservicio\nIMotor de Cotización y Suscripción" as mcsMicroservice <<component>>
	    component "Microservicio\nGestión de Siniestros" as gsMicroservice <<component>>
	    component "Microservicio\nPagos" as payMicroservice <<component>>
	  }
	}
}

rectangle "Capa de Almacenamiento" {
	node "Instancia Aurora PostgreSQL\n<$AuroraPostgreSQLInstance>" as postgres <<device>> {
	  database "Esquema BD Identidad y Perfilamiento" as icpDbSchema <<component>>
	  database "Esquema BD Cotizaciones" as mcsDbSchema <<component>>
	  database "Esquema BD Pólizas" as gpDbSchema <<component>>
	  database "Esquema BD Pagos" as payDbSchema <<component>>
	  database "Esquema BD Siniestros" as gsDbSchema <<component>>
	}
	
	node "Cognito\n<$Cognito>" as cognito <<device>> {
      artifact "Registro de Clientes" as usersPool <<resource>>
      artifact "Registro de Socios" as companiesPool <<resource>>
    }
	
	node "S3\n<$SimpleStorageServiceBucket>" as s3 <<device>> {
	  database "Storage Archivos Solventa" as s3Bucket <<resource>>
	}
	
	node "SQS\n<$SimpleQueueService>" as sqs <<device>> {
	  artifact "Colas Eventos Solventa" as sqsQueues <<resource>>
	}
	
	node "KMS Key\n<$KeyManagementService>" as kms <<device>> {
	  artifact "Llave AES-256" as kmsKey <<resource>>
	}
	
	node "Secrets Manager\n<$SecretsManager>" as secretsManager <<device>> {
	    artifact "Secrets Solventa" as secrets <<resource>>
	}
	
	node "SNS\n<$SimpleNotificationService>" as sns <<device>> {
	    queue "Notificaciones Push" as snsTopicNotifications <<resource>>
	}
}


webApp --> api : HTTPS
mobileApp --> api : HTTPS

api --> alb

alb --> icpMicroservice : HTTPS
alb --> mcsMicroservice : HTTPS

icpMicroservice --> cognito : HTTPS

icpMicroservice --> icpDbSchema : TLS
gpMicroservice --> gpDbSchema : TLS
mcsMicroservice --> mcsDbSchema : TLS
gsMicroservice --> gsDbSchema : TLS
payMicroservice --> payDbSchema : TLS

postgres -[hidden]- s3
postgres -[hidden]- sqs
postgres -[hidden]- kms
postgres -[hidden]- secretsManager

@enduml
```

</details>


Elementos del modelo de despliegue:

- **Capa de Cliente** (PC y Móvil): Cliente Web Angular (usado por clientes asegurados para cotización y adquisición de pólizas, y socios para onboarding) y el cliente móvil Android (usado por clientes asegurados para toma de evidencias siniestros y otras funciones de soporte).
- **API Gateway Solventa**: Centraliza el punto de entrada, aplicando políticas de seguridad, limitación de tasa (rate-limiting) y autorización. Se comunica internamente con el cluster de cómputo mediante un protocolo HTTP para minimizar sobrecargas dentro de la VPC.
- **Load Balancer**: Redistribuye la carga hacia las instancias de los microservicios del core desplegados en el clúster EKS.
- **Cluster EKS Microservicios Solventa**: Aloja los microservicios del core como Identidad, Motor de Cotización, Gestión de Pólizas, etc.
- **Capa de Datos y Persistencia**:
    - **Aurora PostgreSQL DB**: Base de datos SQL transaccional que aloja todos los esquemas de datos de cada microservicio.
    - **Cognito**: Registro de identidades y credenciales de clientes para uso de canales de Solventa, y registro de socios para integración B2B vía API.
    - **S3 Storage Archivos**: Almacena imágenes de siniestros recolectadas con la cámara del dispositivo móvil y documentación de identificación del cliente (temporal).
    - **SQS Colas Eventos**: Provee colas de mensajería para soportar flujos asíncronos entre los microservicios.
    - **KMS**: Aloja llaves AES-256 para cifrado de PII.
    - **Secrets Manager**: Aloja secretos y configuración sensible de los recursos.
    - **SNS Tópico de Notificaciones Push**: Envía notificaciones a los dispositivos móviles con la app Solventa.