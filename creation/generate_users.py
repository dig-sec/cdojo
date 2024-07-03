import random
import yaml
import ipaddress
from typing import List, Dict, Any

CONFIG = {
    'num_users': 100,
    'domain': 'example.com',
    'subnets': {
        'IT': '192.168.1.0/24',
        'Finance': '192.168.2.0/24',
        'HR': '192.168.3.0/24',
        'Marketing': '192.168.4.0/24',
        'Sales': '192.168.5.0/24',
        'Default': '192.168.0.0/24'
    }
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

def assign_machine(role: str, department: str) -> Dict[str, str]:
    machine_types = ["Desktop", "Laptop", "Workstation"]
    machine_type = random.choice(machine_types)
    hostname = f"{department[:3].upper()}-{machine_type[:3].upper()}-{random.randint(1000, 9999)}"
    subnet = CONFIG['subnets'].get(department, CONFIG['subnets']['Default'])
    ip = str(ipaddress.IPv4Address(subnet.split('/')[0]) + random.randint(10, 250))
    
    return {"hostname": hostname, "ip": ip, "type": machine_type}

def assign_software_licenses(role: str, department: str) -> List[str]:
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
            "machine": assign_machine(role, department),
            "software_licenses": assign_software_licenses(role, department)
        }
        
        if department == "IT":
            # Create an admin account for IT department users
            admin_user = user.copy()
            admin_user["name"] = f"{firstname} {lastname} (Admin)"
            admin_user["email"] = generate_email(f"{firstname}_adm", lastname, CONFIG['domain'])
            admin_user["password"] = random.choice(data['common_passwords'])
            admin_user["groups"] = ["Domain Admins"] + admin_user["groups"]
            admin_user["is_admin_account"] = True
            users.append(admin_user)

        if role in ["Director", "VP", "C-Level"] and department == "IT":
            user["admin_rights"] = ["Local Admin"]
        elif random.random() < 0.1:  # 10% chance for regular employees
            user["admin_rights"] = ["Local Admin"]
        
        users.append(user)

    return users

def generate_file_shares(groups: List[str]) -> Dict[str, List[str]]:
    file_shares = {"Company-Wide": ["Public", "Templates", "Policies"]}
    for group in groups:
        file_shares[group] = [f"{group} Documents", f"{group} Projects", f"{group} Resources"]
    return file_shares

def main():
    data = load_data('corporate.yml')
    if not data:
        return

    all_users = generate_users(data)
    regular_users = [user for user in all_users if not user.get('is_admin_account')]
    admin_users = [user for user in all_users if user.get('is_admin_account')]

    file_shares = generate_file_shares(data['groups'])

    environment = {
        "regular_users": regular_users,
        "admin_users": admin_users,
        "file_shares": file_shares,
        "domain": CONFIG['domain'],
        "subnets": CONFIG['subnets']
    }

    output = yaml.dump(environment, default_flow_style=False, sort_keys=False)
    print(output)

if __name__ == "__main__":
    main()

if __name__ == "__main__":
    main()