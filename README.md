# Fronts du Temps

Tower defense évolutif en side-scroll (HTML5 / Canvas, un seul fichier, aucune dépendance).
Ouvre `index.html` dans un navigateur pour jouer.

## Principe
- Deux bases s'affrontent sur un champ de bataille horizontal. Détruis la base adverse.
- **Or** : produit des unités et achète des tourelles. On en gagne en tuant des ennemis (+ un petit revenu passif).
- **XP** : gagnée en tuant des ennemis (et un peu quand tes unités meurent). Elle permet d'**évoluer** à l'époque suivante.
- **8 époques** : Préhistoire, Antiquité, Moyen Âge, Renaissance, Ère napoléonienne, Grande Guerre, Seconde Guerre, Ère moderne.
- **Attaque spéciale** propre à chaque époque (recharge 45 s).
- **Tourelles** : 4 types par époque, jusqu'à 4 emplacements (achetables), revente à 50 %.
- File de production de 5 unités max. IA adverse qui évolue aussi (Facile / Normal / Difficile).

## Unités (temps de production)
| # | Rôle | Temps |
|---|------|-------|
| 1 | Corps à corps | 2 s |
| 2 | Distance | 3 s |
| 3 | Lourde | 6 s, puis **9 s à partir de l'époque 7** (devient un véhicule) |
| 4 | Super-unité | 12 s, puis **20 s à partir de l'époque 5** (artillerie / blindé) |

## Contrôles
- `1`–`4` : produire une unité · `E` : évoluer · `S` : attaque spéciale · `Espace` : pause
- `←`/`→` (ou `Q`/`D`), glisser, molette ou mini-carte : défiler
- `x1/x2/x3` : vitesse de jeu
