# 🛠️ MERN Stack Blog App Deployment (Terraform + Ansible)

## 📋 Overview

This project shows how to deploy a MERN blog app using **Terraform** to set up cloud infrastructure and **Ansible** to configure and run the app. Everything from setting up servers to launching the app is automated.

---

## 🚀 Architecture

```
┌────────────────────┐        ┌──────────────────────┐        ┌──────────────────────┐
│ React Frontend     │        │ Node.js Backend      │        │ MongoDB Atlas        │
│ (S3 Static Website)│───────▶│ (EC2 - Ubuntu)       │───────▶│ (Managed Database)   │
└────────────────────┘        └──────────────────────┘        └──────────────────────┘
                                        │
                                        ▼
                              ┌────────────────────┐
                              │ S3 Media Storage   │
                              └────────────────────┘
```

---

## ⚙️ Tools Used

* **Terraform** – Infrastructure as Code for AWS
* **Ansible** – Automated server and app setup
* **EC2 (Ubuntu 22.04)** – Backend server
* **S3 Buckets** – Frontend hosting and media uploads
* **MongoDB Atlas** – NoSQL database
* **PM2** – Node.js process manager

---

## 📦 Requirements

* AWS CLI with configured credentials
* SSH key pair in AWS
* Terraform v1.0 or newer
* Ansible v2.10 or newer
* MongoDB Atlas account

---

## 🌐 Set Up Infrastructure (Terraform)

1. Go to the Terraform folder:

   ```bash
   cd terraform
   ```

2. Update variables:

   * SSH key name
   * AWS region
   * Unique S3 bucket names

3. Run Terraform:

   ```bash
   terraform init
   terraform apply
   ```

4. After it finishes, save:

   * EC2 public IP
   * S3 bucket names and endpoints
   * IAM access keys for S3
   * Frontend website URL

5. Get outputs:

   ```bash
   terraform output -raw ec2_public_ip
   terraform output -raw s3_user_access_key
   terraform output -raw s3_user_secret_key
   ```

---

## 🔐 SSH Access

Make sure your private key has the right permissions:

```bash
chmod 600 ~/.ssh/your-key.pem
```

Edit the Ansible inventory file:

```ini
[backend]
backend_server ansible_host=1.2.3.4 ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/your-key.pem

[all:vars]
ansible_python_interpreter=/usr/bin/python3
```

---

## 🔧 Deploy the App (Ansible)

1. Go to the Ansible directory:

   ```bash
   cd ../ansible
   ```

2. Create `extra_vars.yml` with output values:

   ```yaml
   ---
   s3_user_access_key: "your-access-key"
   s3_user_secret_key: "your-secret-key"
   media_bucket_name: "your-media-bucket"
   media_bucket_url: "https://your-media-bucket.s3.amazonaws.com"
   frontend_bucket_name: "your-frontend-bucket"
   frontend_bucket_website_endpoint: "http://your-frontend-bucket.s3-website-region.amazonaws.com"
   ec2_public_ip: "1.2.3.4"
   ```

3. Run the playbook:

   ```bash
   ansible-playbook -i inventory/hosts deploy-playbook.yml --extra-vars "@extra_vars.yml"
   ```

This installs Node.js, sets up the backend, builds the frontend, and uploads it to S3.

---

## 🔍 Test It

* **Frontend:** Go to the S3 website endpoint
* **Backend:** Check `http://<EC2_PUBLIC_IP>:5000/api`
* **Uploads:** Try adding a blog post with an image
* **Database:** Check MongoDB Atlas for new entries

---

## 🧼 Tear Down

To delete everything:

```bash
cd terraform
terraform destroy
```

Also:

* Remove your MongoDB cluster and users
* Delete IAM users/keys
* Clear whitelists in MongoDB Atlas

---

## ✅ Deployment Status

| Component     | Status    |
| ------------- | --------- |
| EC2 Backend   | ✅ Running |
| MongoDB Atlas | ✅ Ready   |
| S3 Frontend   | ✅ Hosted  |
| Media Uploads | ✅ OK      |
| Terraform     | ✅ Done    |
| Ansible       | ✅ Done    |

---

## 📎 Notes

* Keep your `.env` files out of version control
* For errors, check Ansible logs or SSH into EC2
* In production, use AWS Secrets Manager or SSM for storing secrets
