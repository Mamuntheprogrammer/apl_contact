import pandas as pd
import json

# === Configuration ===
excel_file = 'data.xlsx'       # Your Excel file name
sheet_name = 'Format'          # The sheet name containing the contact data
output_json_file = 'contact.json'  # Output JSON filename

# === Load Excel sheet into a DataFrame ===
df = pd.read_excel(excel_file, sheet_name=sheet_name, dtype=str)

# === Replace NaN (empty cells) with empty string "" ===
df = df.fillna('')

# === Convert DataFrame rows to a list of dictionaries ===
contacts_list = df.to_dict(orient='records')

# === Wrap in a dictionary with "contacts" as root key ===
output_data = {'contacts': contacts_list}

# === Save to JSON file ===
with open(output_json_file, 'w', encoding='utf-8') as f:
    json.dump(output_data, f, indent=2, ensure_ascii=False)

print(f"✅ JSON file '{output_json_file}' created successfully!")
