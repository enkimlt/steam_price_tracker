import dash
from dash import dcc, html
import pandas as pd
import plotly.express as px
import os
from datetime import timedelta

# Charger les données
print("Current working directory:", os.getcwd())
print("List of files in current directory:", os.listdir("."))
print("List of files in ./data:", os.listdir("./data"))

df = pd.read_csv("data/prices.csv", parse_dates=["timestamp"])  # ✅ parse_dates suffit

skins = df.columns[1:]

# App Dash
app = dash.Dash(__name__)

# Layout
app.layout = html.Div([
    html.H1("🔫 Suivi des prix Steam - Desert Eagle"),

    html.Div([
        html.Label("📅 Sélection de la période :"),
        dcc.RadioItems(
            id="period-selector",
            options=[
                {"label": "Dernier jour", "value": "1D"},
                {"label": "3 derniers jours", "value": "3D"},
                {"label": "7 derniers jours", "value": "7D"},
                {"label": "Tout", "value": "ALL"},
            ],
            value="3D",
            inline=True
        )
    ], style={"marginBottom": "20px"}),

    html.H2("📊 Graphique général"),
    dcc.Checklist(
        id="skin-toggle",
        options=[{"label": skin, "value": skin} for skin in skins],
        value=list(skins),
        inline=True
    ),
    dcc.Graph(id="global-graph"),

    html.Hr(),
    html.H2("📈 Graphiques individuels"),
    html.Div(id="individual-graphs", style={"display": "flex", "flexWrap": "wrap", "gap": "30px"}),

    html.Hr(),
    html.H2("📄 Rapport du jour"),
    html.Pre(
        open("data/report.txt").read() if os.path.exists("data/report.txt") else "Aucun rapport généré."
    )
])

# Callback
@app.callback(
    dash.dependencies.Output("global-graph", "figure"),
    dash.dependencies.Output("individual-graphs", "children"),
    dash.dependencies.Input("skin-toggle", "value"),
    dash.dependencies.Input("period-selector", "value")
)
def update_graphs(selected_skins, period):
    now = df["timestamp"].max()
    if period != "ALL":
        days = int(period.replace("D", ""))
        filtered_df = df[df["timestamp"] >= now - timedelta(days=days)]
    else:
        filtered_df = df

    if not selected_skins:
        fig_main = px.line(title="Aucune courbe sélectionnée.")
    else:
        fig_main = px.line(filtered_df, x="timestamp", y=selected_skins, title="Prix des skins Desert Eagle")
        fig_main.update_layout(hovermode="x unified")

        if len(selected_skins) == 1:
            fig_main.update_layout(height=700, width=1200)
        else:
            fig_main.update_layout(height=600, width=1100)

    individual = []
    for skin in skins:
        fig = px.line(filtered_df, x="timestamp", y=skin, title=skin)
        fig.update_layout(height=400, width=600)
        individual.append(
            html.Div([
                html.H4(f"🎯 {skin}"),
                dcc.Graph(figure=fig)
            ])
        )

    return fig_main, individual

# Run

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=8080)
