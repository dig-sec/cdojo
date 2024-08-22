import random
import yaml
from typing import List, Dict, Any
from datetime import datetime, timedelta
import ipaddress
import re

def load_data(file_path: str) -> Dict[str, Any]:
    try:
        with open(file_path, 'r') as file:
            return yaml.safe_load(file)
    except (IOError, yaml.YAMLError) as e:
        print(f"Error loading data: {e}")
        return {}

def generate_email(firstname: str, lastname: str, domain: str) -> str:
    email_domain = domain.lower().replace(".local", "")
    if not email_domain.endswith(".com"):
        email_domain += ".com"
    return f"{firstname.lower()}.{lastname.lower()}@{email_domain}"

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
            "owner": None
        })
    
    return files

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
    upn_set = set()

    def generate_unique_upn(firstname: str, lastname: str, domain: str) -> str:
        base_upn = f"{firstname.lower()}.{lastname.lower()}@{domain}"
        unique_upn = base_upn
        counter = 1
        while unique_upn in upn_set:
            unique_upn = f"{firstname.lower()}.{lastname.lower()}{counter}@{domain}"
            counter += 1
        if len(unique_upn) > 20  and unique_upn.startswith('adm.'):
            unique_upn = f"{firstname.lower()}@{domain}"
        upn_set.add(unique_upn)
        return unique_upn

    for i in range(min(data['num_users'], len(names))):
        firstname, lastname = names[i].split()
        role = assign_role()
        department = assign_department(data['groups'])
        
        user = {
            "name": f"{firstname} {lastname}",
            "email": generate_email(firstname, lastname, data['domain']),
            "upn": generate_unique_upn(firstname, lastname, data['domain']),
            "role": role,
            "department": department,
            "password": random.choice(data['common_passwords']),
            "groups": assign_groups(department, role, data['groups'], data['project_groups']),
            "machine": assign_machine(department, data['subnets']),
            "software_licenses": assign_software_licenses(department)
        }
        
        if "IT" in department:
            admin_user = user.copy()
            admin_user["name"] = f"Adm.{firstname}"
            admin_user["upn"] = generate_unique_upn(f"Adm.{firstname}", lastname, data['domain'])
            admin_user["password"] = random.choice(data['common_passwords'])
            admin_user["groups"] = ["Domain Admins"]
            admin_user.pop("email")
            admin_user.pop("machine")
            admin_user.pop("software_licenses")
            users.append(admin_user)
       
        users.append(user)

    return users

def generate_group_data(users: List[Dict[str, Any]]) -> List[Dict[str, Any]]:
    groups = {}

    for user in users:
        for group_name in user['groups']:
            if group_name not in groups:
                groups[group_name] = {"name": group_name, "description": f"{group_name} Group", "members": []}

    for group_name, group_info in groups.items():
        for user in users:
            if group_name in user['groups']:
                group_info["members"].append(user["upn"])

    return list(groups.values())

def generate_file_shares(groups: List[str], users: List[Dict[str, Any]]) -> Dict[str, Dict[str, List[Dict[str, Any]]]]:
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

def assign_file_owners(users: List[Dict[str, Any]], file_shares: Dict[str, Dict[str, List[Dict[str, Any]]]]):
    for group, folders in file_shares.items():
        group_users = [user for user in users if group in user['groups'] or group == "Company-Wide"]
        for folder, files in folders.items():
            for file in files:
                file['owner'] = random.choice(group_users)['name']

def main():
    data = load_data('corporate_value_list.yml')
    output_path = "../ansible/inventory/"
    if not data:
        return

    all_users = generate_users(data)
    group_data = generate_group_data(all_users)
    file_shares = generate_file_shares(data['groups'], all_users)
    assign_file_owners(all_users, file_shares)  

    environment = {
        "Domain": data['domain'],
        "Users": all_users,
        "File_shares": file_shares,
        "Groups": group_data  
    }
    
    # with open('environment.yml', 'w') as file:
    #     yaml.dump(environment, file, default_flow_style=False)

    # environment_output = yaml.dump(environment, default_flow_style=False, sort_keys=False)

    # print("\n--- Environment ---")
    # print(environment_output)

    users_output_data = {'users': all_users}

    with open('users.yml', 'w') as file:
        yaml.dump(output_path + users_output_data, file, default_flow_style=False)

    file_shares_output_data = {'file_shares': file_shares}
    with open('file_shares.yml', 'w') as file:
        yaml.dump(output_path + file_shares_output_data, file, default_flow_style=False)

    group_data_output_data = {'group_data': group_data}
    with open('group_data.yml', 'w') as file:
        yaml.dump(output_path + group_data_output_data, file, default_flow_style=False)


if __name__ == "__main__":
    main()

