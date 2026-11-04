# Æonfall — La Guerre des Âges

Tower defense évolutif en side-scroll, de la Préhistoire à l'ère moderne : Humains, Créatures, Vampires et Loups-garous. Un jeu Rubyx Studio.
Jeu HTML5/Canvas en un seul fichier (`www/index.html`), empaqueté en application **Android**.

## Installer sur Android
1. Sur ton téléphone, télécharge l'APK :
   **https://github.com/enzo34/wars/raw/ccr-2b79d7df-9zvfgl/Aeonfall.apk**
2. Ouvre le fichier et autorise « Installer des applis inconnues » si Android le demande.
3. Lance **Æonfall** (plein écran, paysage, hors ligne).

### Recompiler l'APK
Sans Android Studio ni SDK Google (Ubuntu/Debian) :
```
sudo apt install aapt apksigner zipalign dalvik-exchange openjdk-17-jdk
android/build-apk.sh            # produit Aeonfall.apk à la racine
```
Le framework Android vient de Maven Central (Robolectric `android-all`).
La clé de signature est lue dans `$FDT_KEYSTORE` / `$FDT_KS_PASS`, sinon une clé locale est générée
dans `android/build/` (non versionnée). Avec une clé différente, il faut désinstaller l'ancienne version
avant d'installer la nouvelle.

Le projet Gradle (`android/`) et le workflow GitHub Actions restent utilisables avec un SDK Android complet.

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
