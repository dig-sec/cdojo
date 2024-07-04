import random
import yaml
import ipaddress
from typing import List, Dict, Any
from datetime import datetime, timedelta

CONFIG = {
    'num_users': 100,
    'domain': 'example.com',
}

def load_data(file_path: str) -> Dict[str, Any]:
    try:
        with open(file_path, 'r') as file:
            return yaml.safe_load(file)
    except (IOError, yaml.YAMLError) as e:
        print(f"Error loading data: {e}")
        return {}

def generate_email(firstname: str, lastname: str, domain: str) -> str:
    return f"{firstname.lower()}.{lastname.lower()}@{domain}"

def generate_random_date(start_date: datetime, end_date: datetime) -> str:
    time_between_dates = end_date - start_date
    days_between_dates = time_between_dates.days
    random_number_of_days = random.randrange(days_between_dates)
    random_date = start_date + timedelta(days=random_number_of_days)
    return random_date.strftime("%Y-%m-%d")

def create_files(folder_name: str, num_files: int = 5) -> List[Dict[str, Any]]:
    file_types = {
        "docx": [
            "Meeting_Minutes_{date}.docx",
            "{folder}_Report_Q{quarter}_{year}.docx",
            "Project_Proposal_{date}.docx",
            "Weekly_Update_{date}.docx"
        ],
        "xlsx": [
            "Budget_{year}.xlsx",
            "Inventory_List_{date}.xlsx",
            "Sales_Forecast_Q{quarter}_{year}.xlsx",
            "Employee_Schedule_{month}_{year}.xlsx"
        ],
        "pptx": [
            "Quarterly_Review_Q{quarter}_{year}.pptx",
            "Project_{project_id}_Presentation.pptx",
            "Company_Overview_{year}.pptx",
            "Training_Module_{module_num}.pptx"
        ],
        "pdf": [
            "Employee_Handbook_v{version}.pdf",
            "Contract_Template_{year}.pdf",
            "Annual_Report_{year}.pdf",
            "Safety_Guidelines_Rev{version}.pdf"
        ]
    }
    
    files = []
    start_date = datetime(2023, 1, 1)
    end_date = datetime(2024, 12, 31)
    
    for _ in range(num_files):
        extension = random.choice(list(file_types.keys()))
        filename_template = random.choice(file_types[extension])
        
        filename = filename_template.format(
            folder=folder_name,
            date=generate_random_date(start_date, end_date),
            year=random.randint(2023, 2024),
            quarter=random.randint(1, 4),
            month=random.choice(['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']),
            project_id=f"PRJ-{random.randint(100, 999)}",
            module_num=random.randint(1, 10),
            version=f"{random.randint(1, 5)}.{random.randint(0, 9)}"
        )
        
        files.append({
            "name": filename,
            "type": extension,
            "size": f"{random.randint(10, 10000)}KB",
            "created": generate_random_date(start_date, end_date),
            "modified": generate_random_date(start_date, end_date),
            "owner": None  # This will be set later
        })
    
    return files

def generate_file_shares(groups: List[str]) -> Dict[str, Dict[str, List[Dict[str, Any]]]]:
    file_shares = {
        "Company-Wide": {
            "Public": create_files("Public"),
            "Templates": create_files("Templates"),
            "Policies": create_files("Policies")
        }
    }
    
    for group in groups:
        file_shares[group] = {
            f"{group} Documents": create_files(f"{group}Docs"),
            f"{group} Projects": create_files(f"{group}Projects"),
            f"{group} Resources": create_files(f"{group}Resources")
        }
    
    return file_shares

def assign_role() -> str:
    roles = ["Employee", "Manager", "Director", "VP", "C-Level"]
    weights = [70, 20, 7, 2, 1]
    return random.choices(roles, weights=weights)[0]

def assign_department(groups: List[str]) -> str:
    return random.choice(groups)

def assign_groups(department: str, role: str, groups: List[str], project_groups: List[str]) -> List[str]:
    user_groups = [department]
    if role in ["Manager", "Director", "VP", "C-Level"]:
        user_groups.append("Management")
    available_project_groups = [g for g in project_groups if g != "Domain Admins"]
    user_groups.extend(random.sample(available_project_groups, random.randint(0, 2)))
    return user_groups

def assign_machine(department: str, subnets: Dict[str, str]) -> Dict[str, str]:
    machine_types = ["Desktop", "Laptop", "Workstation"]
    machine_type = random.choice(machine_types)
    hostname = f"{department[:3].upper()}-{machine_type[:3].upper()}-{random.randint(1000, 9999)}"
    subnet = subnets.get(department, subnets['Default'])
    ip = str(ipaddress.IPv4Address(subnet.split('/')[0]) + random.randint(100, 200))
    
    return {"hostname": hostname, "ip": ip, "type": machine_type}

def assign_software_licenses(department: str) -> List[str]:
    common_software = ["Office365", "Zoom", "Slack"]
    dept_software = {
        "IT": ["Visual Studio", "AWS", "Docker"],
        "Finance": ["QuickBooks", "SAP", "Excel Advanced"],
        "HR": ["Workday", "BambooHR"],
        "Marketing": ["Adobe Creative Suite", "Hootsuite"],
        "Sales": ["Salesforce", "HubSpot"]
    }
    licenses = common_software + dept_software.get(department, [])
    return random.sample(licenses, random.randint(2, len(licenses)))

def generate_users(data: Dict[str, Any]) -> List[Dict[str, Any]]:
    users = []
    names = list(set([f"{fn} {ln}" for fn in data['first_names'] for ln in data['last_names']]))
    random.shuffle(names)

    for i in range(min(CONFIG['num_users'], len(names))):
        firstname, lastname = names[i].split()
        role = assign_role()
        department = assign_department(data['groups'])
        
        user = {
            "name": f"{firstname} {lastname}",
            "email": generate_email(firstname, lastname, CONFIG['domain']),
            "role": role,
            "department": department,
            "password": random.choice(data['common_passwords']),
            "groups": assign_groups(department, role, data['groups'], data['project_groups']),
            "machine": assign_machine(department, data['subnets']),
            "software_licenses": assign_software_licenses(department)
        }
        
        if department == "IT":
            admin_user = user.copy()
            admin_user["name"] = f"{firstname} {lastname} (Admin)"
            admin_user["email"] = generate_email(f"{firstname}_adm", lastname, CONFIG['domain'])
            admin_user["password"] = random.choice(data['common_passwords'])
            admin_user["groups"] = ["Domain Admins"] + admin_user["groups"]
            admin_user["is_admin_account"] = True
            admin_user.pop("machine")
            users.append(admin_user)

        if role in ["Director", "VP", "C-Level"] and department == "IT":
            user["admin_rights"] = ["Local Admin"]
        elif random.random() < 0.1:
            user["admin_rights"] = ["Local Admin"]
        
        users.append(user)

    return users

def assign_file_owners(users: List[Dict[str, Any]], file_shares: Dict[str, Dict[str, List[Dict[str, Any]]]]):
    for group, folders in file_shares.items():
        group_users = [user for user in users if group in user['groups'] or group == "Company-Wide"]
        for folder, files in folders.items():
            for file in files:
                file['owner'] = random.choice(group_users)['name']

def main():
    data = load_data('corporate.yml')
    if not data:
        return

    all_users = generate_users(data)
    file_shares = generate_file_shares(data['groups'])
    assign_file_owners(all_users, file_shares)

    environment = {
        "Domain": CONFIG['domain'],
        "Users": all_users,
        "File_shares": file_shares,
        "Subnets": data['subnets']
    }
    environment_output = yaml.dump(environment, default_flow_style=False, sort_keys=False)

    print("\n--- Environment ---")
    print(environment_output)

if __name__ == "__main__":
    main()