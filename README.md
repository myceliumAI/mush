# Déploiement d'un cluster K3s sur GCP avec Terraform

## Structure du projet

```
modules/                 # Modules réutilisables (instance_template, mig, etc.)
environments/            # Variables par environnement (prod, dev, ...)
main.tf                  # Point d'entrée principal
provider.tf              # Configuration du provider GCP
variables.tf             # Déclaration des variables globales
outputs.tf               # Outputs du projet
versions.tf              # Contraintes de version
```

## Démarrage rapide

1. Renseignez vos variables dans `environments/prod.tfvars`.
2. Initialisez le projet :
   ```bash
   terraform init
   ```
3. Lancez le plan :
   ```bash
   terraform plan -var-file="environments/prod.tfvars"
   ```
4. Appliquez :
   ```bash
   terraform apply -var-file="environments/prod.tfvars"
   ```

## À venir
- Modules pour le template d'instance, le MIG et l'installation de K3s.
- Génération automatique du kubeconfig pour se connecter au cluster. 