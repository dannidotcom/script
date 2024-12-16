# ---------------- * Database Migration Script * -------------------

## Description

Ce script Bash permet de migrer une base de données MySQL depuis un hôte source vers un hôte de destination. Il réalise une sauvegarde de la base de données source, la compresse, puis la restaure sur un serveur de destination. Toutes les étapes sont loguées dans un fichier de log afin de faciliter le suivi de l'opération.

## Fonctionnement

### Prérequis
- MySQL doit être installé sur les deux serveurs (source et destination).
- L'utilisateur MySQL spécifié dans le script doit disposer des droits nécessaires pour effectuer un dump et une restauration de la base de données.
- Les chemins de sauvegarde doivent être valides et accessibles en écriture sur le système.

### Étapes du Script

1. **Variables de configuration :**
   - `SOURCE_HOST`: L'adresse IP ou le nom d'hôte du serveur source.
   - `DEST_HOST`: L'adresse IP ou le nom d'hôte du serveur de destination.
   - `USER`: Le nom d'utilisateur MySQL utilisé pour se connecter.
   - `PASSWORD`: Le mot de passe de l'utilisateur MySQL.
   - `DUMP_FILE`: Le chemin où le fichier de sauvegarde compressé sera enregistré.
   - `LOG_FILE`: Le fichier de log où les étapes du processus seront enregistrées.

2. **Sauvegarde de la base de données source :**
   - Le script utilise la commande `mysqldump` pour réaliser une sauvegarde de la base de données `db_name` du serveur source.
   - Le fichier de sauvegarde est ensuite compressé au format `.gz` pour réduire sa taille.
   - Le processus est logué dans le fichier de log spécifié (`full_backup_migration.log`).

3. **Vérification de la réussite de la sauvegarde :**
   - Si la commande `mysqldump` réussit, un message de succès est ajouté au fichier de log.
   - Si la commande échoue, un message d'erreur est enregistré et le script s'arrête (code de sortie 1).

4. **Restauration de la base de données sur le serveur de destination :**
   - Le fichier de sauvegarde compressé est décompressé avec `gunzip` et importé sur le serveur de destination à l'aide de la commande `mysql`.
   - Le processus de restauration est également logué.

5. **Vérification de la réussite de la restauration :**
   - Si l'importation réussit, un message de succès est ajouté au fichier de log.
   - Si l'importation échoue, un message d'erreur est enregistré et le script s'arrête (code de sortie 1).

6. **Enregistrement de la fin de l'opération :**
   - La fin du processus est loguée avec l'heure à laquelle la migration a été terminée.

## Utilisation

1. **Modifier les variables :**
   - Avant d'exécuter le script, modifie les variables suivantes selon ton environnement :
     - `SOURCE_HOST`: L'adresse de ton serveur source.
     - `DEST_HOST`: L'adresse de ton serveur de destination.
     - `USER`: L'utilisateur MySQL.
     - `PASSWORD`: Le mot de passe MySQL.
     - `DUMP_FILE`: Le chemin du fichier de sauvegarde.
     - `LOG_FILE`: Le chemin du fichier de log.

2. **Exécution du script :**
   - Une fois que tu as configuré les variables, tu peux exécuter le script avec la commande suivante :
     ```bash
     bash migration_script.sh
     ```

3. **Vérification des logs :**
   - Le fichier de log `full_backup_migration.log` contiendra toutes les informations sur le processus de migration. Tu peux le consulter pour vérifier que tout s'est bien passé ou pour diagnostiquer des erreurs.

## Notes

- Assure-toi que le répertoire de sauvegarde (`/DATA`) existe et est accessible en écriture avant d'exécuter le script.
- Ce script est conçu pour migrer une seule base de données nommée `db_name`. Modifie le script si tu souhaites migrer une autre base de données.
- Si tu as des besoins spécifiques (comme migrer plusieurs bases ou ajouter des options de compression/décompression), le script peut être modifié en conséquence.

---
