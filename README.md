🧪 Steam Price Tracker
Steam Price tracker est un outil de suivi automatique des prix de cinq skins populaires de Desert Eagle sur le marché Steam. Il récupère les prix toutes les 5 minutes, les affiche sous forme de graphique et génère un rapport financier quotidien à 20h.

🔗 Lien vers l'application : steampricetracker-production.up.railway.app

🚀 Fonctionnalités
📈 Suivi temps réel : Enregistrement automatique du prix toutes les 5 minutes pour les 5 skins suivants :

Desert Eagle | Printstream

Desert Eagle | Blaze

Desert Eagle | Cobalt Disruption

Desert Eagle | Hypnotic

Desert Eagle | Kumicho Dragon

📊 Visualisation graphique : Historique des prix disponible via un graphique interactif.

🧾 Rapport quotidien à 20h : Génération automatique d’un rapport résumant pour chaque skin :

Le prix d'ouverture

Le prix de clôture

L'évolution journalière (%)

La volatilité (écart-type des variations horaires)

Exemple de rapport :

🗓 Rapport financier du jour - 2025-04-06

🔫 printstream
  - Prix ouverture : 114.59€
  - Prix clôture   : 111.47€
  - Évolution      : -2.72%
  - Volatilité     : 0.9912

🔫 blaze
  - Prix ouverture : 854.97€
  - Prix clôture   : 847.25€
  - Évolution      : -0.90%
  - Volatilité     : 4.9228

🔫 cobalt
  - Prix ouverture : 84.52€
  - Prix clôture   : 87.77€
  - Évolution      : 3.85%
  - Volatilité     : 0.9993

🔫 hypnotic
  - Prix ouverture : 103.50€
  - Prix clôture   : 110.98€
  - Évolution      : 7.23%
  - Volatilité     : 1.1571

🔫 kumicho
  - Prix ouverture : 37.64€
  - Prix clôture   : 37.16€
  - Évolution      : -1.28%
  - Volatilité     : 0.5032
🛠️ Technologies utilisées
Backend : Python, FastAPI

Scraping : Requêtes HTTP au marché Steam

Base de données : CSV

Frontend : HTML/CSS

Déploiement : Railway.app

📦 Installation locale
Clone le dépôt :

git clone https://github.com/enkimlt/steam_price_tracker.git
cd steam_price_tracker

Crée et active un environnement virtuel :

python -m venv env
source env/bin/activate  # Sur Windows : env\Scripts\activate

Installe les dépendances :

pip install -r requirements.txt


📅 Planification
Le scraping s’exécute toutes les 5 minutes via une tâche planifiée.

Le rapport quotidien est généré automatiquement à 20h (heure du serveur).

🧠 À venir
Système d’alerte de seuil (e-mail ou Discord)

Comparaison avec d'autres armes / marchés

Interface de sélection dynamique des skins

👤 Auteur
Développé par @enkimlt – contributions bienvenues !

