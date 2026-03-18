Nous souhaitons développer une application web pour une compagnie aérienne.

Cette compagnie aérienne possède sa propre flotte d'avions. Chaque avion est identifié par un identifiant numérique unique et un type d'appareil.

Chaque avion dispose d'un nombre de places (passagers). Les avions sont stockés dans des entrepôts. Ces entrepôts sont situés dans plusieurs villes en France.

La compagnie emploie plusieurs pilotes. Chaque pilote est caractérisé par un matricule numérique, un nom, une ville de résidence, une adresse, un âge et un salaire.

La compagnie aérienne propose plusieurs vols. Chaque vol est défini par un identifiant de type chaîne de caractères, une ville de départ, une ville d'arrivée, une heure de départ et une heure d'arrivée.

Les sociétés clientes de cette compagnie aérienne sont identifiées par un identifiant numérique et bénéficient d'un forfait.

Ces clients réservent des places sur les départs des vols. Chaque départ est assuré par un pilote de la compagnie et utilise un de ses avions.

Chaque départ est programmé à une date et heure spécifiques (horodatée).

# Description du stockage

Il faut créer deux tablespaces. Le premier est dans le répertoire E:\GithubCopilot\ProjectsCopilot\Backspaces\TablesData pour les tables de données, et le deuxième dans le répertoire E:\GithubCopilot\ProjectsCopilot\Backspaces\Indexes pour les index.
Les indexes de primery key doivent etre dans le deuxieme tablespace.

Si les tables que tu vas créer existent déjà, supprime-les avant de les recréer (par exemple : `DROP TABLE IF EXISTS <table> CASCADE;` avant `CREATE TABLE ...`).

Il faut créer une base de données PostgreSQL pour l'application. Cette base de données peut stocker dans les deux tablespaces.
Dans la nouvelle base de données, ajouter un schéma nommé compagnieAerienne.

# Description du fichier de création
Les instructions SQL générées seront stockées dans le fichier CreationDataBase.sql
