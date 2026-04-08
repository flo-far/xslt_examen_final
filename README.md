# xslt_examen_final

# Artaud. Lettres du Mexique — Édition numérique

Édition numérique de trois extraits de lettres d'Antonin Artaud adressées à Jean Paulhan, conservées à l'IMEC (fonds Paulhan). Les lettres, écrites entre 1935 et 1936, portent sur le projet de voyage d'Artaud au Mexique et ses réflexions sur les civilisations amérindiennes.

Projet réalisé dans le cadre du cours *Technique et chaîne de publication électronique avec XSLT* (Jean-Damien Généro, ENC – PSL, 2025–2026).

## Contenu du dépôt

| Fichier | Description |
|---|---|
| `letter_1.xml`, `letter_2.xml`, `letter_3.xml` | Lettres encodées en XML-TEI |
| `person_authority_list.xml`, `place_authority_list.xml` | Listes d'autorité |
| `mon_odd.odd`, `mon_odd.rng`, `mon_odd.html` | Schéma de validation (ODD et Relax NG) |
| `artaud_letters.xsl` | Feuille de transformation XSLT vers HTML |
| `style.css` | Feuille de style |
| `Antonin_Artaud_1926.jpg` | Portrait utilisé sur la page d'accueil |

## Lancer la transformation dans Oxygen

La feuille XSL génère plusieurs fichiers HTML via `xsl:result-document`. Il faut créer **trois scénarios de transformation distincts** dans Oxygen, un par lettre.

**Pour chaque scénario :**

Créer un nouveau scénario de type **XSLT** avec les paramètres suivants :
   - Processeur : **Saxon PE ou HE**
   - Feuille de style : `artaud_letters.xsl`
   - Ajouter un paramètre : nom `letter_number`, valeur 1, 2 ou 3 selon la lettre. Bien enlever les guillemets mis automatiquement dans Oxygen.

**Résultat attendu :**

- Transformation de `letter_1.xml` → génère `letter_1.html` + `index.html` + `persons.html` + `places.html`
- Transformation de `letter_2.xml` → génère `letter_2.html`
- Transformation de `letter_3.xml` → génère `letter_3.html`

Tous les fichiers doivent se trouver dans le **même dossier** pour que la navigation fonctionne. Ouvrir `index.html` dans un navigateur pour accéder à l'édition.
