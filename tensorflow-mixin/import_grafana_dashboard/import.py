import requests
import json
from requests.auth import HTTPBasicAuth

# === Configuration ===
GRAFANA_URL = "http://192.168.64.27:3000"
USERNAME = "admin"       # Replace with your Grafana username
PASSWORD = "admin"       # Replace with your Grafana password
DASHBOARD_UID = "tensorflow_overview"  # Replace with your dashboard UID
DASHBOARD_JSON_PATH = "/Users/greg/git/bindplane/grafana/greg-jsonnet-libs/tensorflow-mixin/dashboards_out/tensorflow-overview.json"  # Path to dashboard JSON file
FOLDER_ID = 0  # 0 = General folder

auth = HTTPBasicAuth(USERNAME, PASSWORD)
headers = {
    "Content-Type": "application/json"
}

# === Step 1: Delete Dashboard ===
def delete_dashboard(uid):
    url = f"{GRAFANA_URL}/api/dashboards/uid/{uid}"
    resp = requests.delete(url, headers=headers, auth=auth)
    if resp.status_code == 200:
        print(f"✅ Deleted dashboard with UID: {uid}")
    elif resp.status_code == 404:
        print(f"⚠️ Dashboard with UID {uid} not found. Skipping delete.")
    else:
        print(f"❌ Failed to delete dashboard: {resp.status_code} {resp.text}")

# === Step 2: Import New Dashboard ===
def import_dashboard(json_path, folder_id=0):
    with open(json_path, "r") as f:
        dashboard_json = json.load(f)

    payload = {
        "dashboard": dashboard_json,
        "folderId": folder_id,
        "overwrite": True
    }

    url = f"{GRAFANA_URL}/api/dashboards/db"
    resp = requests.post(url, headers=headers, auth=auth, data=json.dumps(payload))
    if resp.status_code == 200:
        print("✅ Imported dashboard successfully.")
    else:
        print(f"❌ Failed to import dashboard: {resp.status_code} {resp.text}")

# === Run Both Steps ===
delete_dashboard(DASHBOARD_UID)
import_dashboard(DASHBOARD_JSON_PATH)
