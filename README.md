# Cloud Portfolio Projekt: AWS-Infrastruktur mit Terraform

Mein erstes Infrastructure-as-Code-Projekt auf AWS. Mit Terraform wird eine kleine, reproduzierbare Umgebung aufgebaut: ein EC2-Webserver und ein privater S3-Bucket für Bilder.

## Was wird erstellt?

| Ressource | Zweck |
|---|---|
| `aws_instance.web_server` | EC2-Instanz (Standard: `t2.micro`) |
| `aws_s3_bucket.bilder_bucket` | S3-Bucket für Bilder |
| `aws_s3_bucket_public_access_block` | Blockiert jeden öffentlichen Zugriff auf den Bucket |

Alle Ressourcen bekommen automatisch die Tags `project`, `Environment` und `ManagedBy = terraform` (über `default_tags` im Provider).

## Architektur

<img width="1024" height="572" alt="Architekturdiagramm" src="https://github.com/user-attachments/assets/3965f906-e79a-45bd-be67-1704848ba67d" />

## Projektstruktur

```
.
├── README.md
├── .gitignore
└── terraform/
    ├── main.tf              # Ressourcen (EC2, S3)
    ├── provider.tf          # AWS-Provider und Versionen
    ├── variables.tf         # Eingabevariablen
    └── .terraform.lock.hcl  # fixiert die Provider-Version
```

## Voraussetzungen

- Terraform >= 1.5
- AWS-Account und AWS CLI, konfiguriert mit `aws configure`
- Ein vorhandenes EC2-Key-Pair (im Code: `terraform-admin`)

## Nutzung

```bash
cd terraform
terraform init       # Provider herunterladen
terraform plan       # Änderungen anzeigen
terraform apply      # Infrastruktur erstellen
terraform destroy    # Alles wieder löschen (Kosten sparen!)
```

## Variablen

| Variable | Beschreibung | Standard |
|---|---|---|
| `aws_region` | AWS-Region | `eu-central-1` |
| `project_name` | Projektname für Namen und Tags | `cloud-portfolio` |
| `environment` | Umgebung (dev, staging, prod) | `dev` |
| `instance_type` | EC2-Instanztyp | `t2.micro` |

Beispiel mit eigenen Werten:

```bash
terraform apply -var="environment=staging" -var="instance_type=t3.micro"
```

## Sicherheit

- S3-Bucket ist vollständig privat (alle vier Public-Access-Block-Optionen aktiv)
- `.gitignore` schließt State-Dateien, `*.tfvars`, Schlüssel (`*.pem`, `*.key`) und `.terraform/` aus
- Keine Zugangsdaten im Code

## Kosten

Das Projekt ist auf den AWS Free Tier ausgelegt. Nach dem Testen immer `terraform destroy` ausführen.

## Was ich gelernt habe

- Aufbau eines Terraform-Projekts (Provider, Variablen, Ressourcen)
- Wofür State-Datei und Lock-Datei da sind
- Secrets sauber aus dem Repository heraushalten
- Kostenkontrolle in AWS

## Geplante Erweiterungen

- [ ] `outputs.tf` (z. B. öffentliche IP der Instanz)
- [ ] Eigenes VPC mit Subnetzen und Security Groups
- [ ] Remote State in S3
- [ ] Wiederverwendbare Module
