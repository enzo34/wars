# Fronts du Temps

Tower defense évolutif en side-scroll, de la Préhistoire à l'ère moderne : Humains contre Créatures.
Jeu HTML5/Canvas en un seul fichier (`www/index.html`), empaqueté en application **Android**.

## Installer sur Android
1. Sur ton téléphone, ouvre la page **Releases** du dépôt et télécharge `FrontsDuTemps.apk` (dernière version).
2. Ouvre le fichier et autorise « Installer des applis inconnues » pour ton navigateur si Android le demande.
3. Lance **Fronts du Temps** : plein écran, en paysage, hors ligne.

Chaque push qui modifie `www/` ou `android/` recompile l'APK via GitHub Actions
(`.github/workflows/android.yml`) et publie une nouvelle Release.

Signature : le workflow génère une clé une fois et la garde dans le cache GitHub Actions, pour que
les nouvelles versions s'installent par-dessus l'ancienne. Ce cache expire après 7 jours sans build :
pour une clé définitive, ajoute les secrets `ANDROID_KEYSTORE_BASE64` (keystore encodé en base64,
alias `fdt`) et `ANDROID_KEYSTORE_PASSWORD` dans les paramètres du dépôt.

Compiler soi-même (Android SDK + JDK 17) : `cd android && gradle assembleRelease`.

## Jouer dans un navigateur
Ouvre `www/index.html` (PC ou mobile).

## Principe
- **Deux camps au choix** : les **Humains** (de la massue au char de combat) ou les **Créatures**
  (Profonds, Yeux rôdeurs, Molosses, Shoggoths, Rejetons…). L'IA joue toujours l'autre camp.
- Ambiance lovecraftienne : nuits étranges, tentacules colossales, monolithes à runes, œil cosmique.
- **Or** : produit des unités et achète des tourelles. On en gagne en tuant des ennemis (+ petit revenu passif).
- **XP ★** : gagnée au combat ; permet d'**évoluer** vers l'époque suivante (8 époques).
- **Attaque spéciale** propre à chaque époque (recharge 45 s).
- **Tourelles** : 4 types par époque, jusqu'à 4 emplacements, revente à 50 %.
- File de production de 5 unités. IA adverse (Facile / Normal / Difficile).

| # | Unité | Temps de production |
|---|-------|---------------------|
| 1 | Corps à corps | 2 s |
| 2 | Distance | 3 s |
| 3 | Lourde | 6 s, puis **9 s à partir de l'époque 7** (véhicule) |
| 4 | Super-unité | 12 s, puis **20 s à partir de l'époque 5** (artillerie / blindé) |

## Contrôles
- Tactile : boutons en bas, glisser pour défiler, mini-carte, appui long sur un bouton = détails, retour = pause.
- Clavier : `1`–`4` unités · `E` évoluer · `S` spécial · `Espace`/`Échap` pause · `←`/`→` défiler.
