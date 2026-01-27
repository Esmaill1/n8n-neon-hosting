---
title: n8n
emoji: 🤖
colorFrom: pink
colorTo: indigo
sdk: docker
pinned: false
license: mit
app_port: 5678
short_description: n8n hosting using huggingface
---

# Hosting n8n using huggingface space

If you don't have a cloud instance or domain, self hosting n8n may be a bit difficult.
This repository is a template for hosting n8n using huggingface space.

## Using Neon for database

According to [huggingface space documentation](https://huggingface.co/docs/hub/en/spaces-overview#lifecycle-management),
Space will "go to sleep" and stop executing after a period of time if unused.
To avoid this, we can use [Neon](https://neon.tech/) for the database.

1. Sign up for a free account at <https://neon.tech/>
2. Create a new project.
3. In the **Dashboard**, find your **Connection Details**.
   You will see a connection string like: `postgres://user:password@host.neon.tech/dbname?sslmode=require`

   *   **Host**: The part after `@` and before `/` (e.g., `ep-cool-frog-123456.us-east-1.aws.neon.tech`)
   *   **User**: The part between `//` and `:` (e.g., `neondb_owner`)
   *   **Password**: The part between `:` and `@` (e.g., `npg_SecretPassword`)
   *   **Database**: The part after `/` (e.g., `neondb`)

4. Save these details for the deployment step.

## Deploying n8n using huggingface space

Huggingface space provide a free tier with 16GB RAM, 2 CPU cores and 50GB of
(not persistent) disk space. This is enough for hosting n8n.

| **Hardware** | **GPU Memory** | **CPU** | **Memory** | **Disk** | **Hourly Price** |
| ------------ | -------------- | ------- | ---------- | -------- | ---------------- |
| CPU Basic    | -              | 2 vCPU  | 16 GB      | 50 GB    | Free!            |

Using this space to duplicate and deploy n8n in the easy way.

1. Sign up for a free account at <https://huggingface.co/join> and pick a profile name.
   Remember the profile name for later use.

2. Access the Space URL (e.g., the one you are viewing or <https://huggingface.co/spaces/tomowang/n8n>) and click the menu drop
   down in top right corner and select **Duplicate this space**.

3. Fill or change the variable and secrets in pop-up form and click **Duplicate**.

   | **Variable** | **Value** | **Description** |
   | :--- | :--- | :--- |
   | `DB_TYPE` | `postgresdb` | |
   | `DB_POSTGRESDB_HOST` | `ep-....neon.tech` | Your Neon Host |
   | `DB_POSTGRESDB_PORT` | `5432` | Standard Postgres Port |
   | `DB_POSTGRESDB_DATABASE` | `neondb` | Your Neon Database Name |
   | `DB_POSTGRESDB_USER` | `neondb_owner` | Your Neon User |
   | `DB_POSTGRESDB_PASSWORD` | `npg_...` | **Set as Secret**. Your Neon Password |
   | `DB_POSTGRESDB_SSL_REJECT_UNAUTHORIZED` | `false` | **Required** for Neon SSL connection |
   | `N8N_ENCRYPTION_KEY` | Random string | Use `openssl rand -base64 32` to generate |
   | `WEBHOOK_URL` | `https://<profile>-n8n.hf.space/` | Your Space URL |
   | `N8N_EDITOR_BASE_URL` | `https://<profile>-n8n.hf.space/` | Your Space URL |
   | `GENERIC_TIMEZONE` | `UTC` | Config by requirement |
   | `TZ` | `UTC` | Config by requirement |

4. Click **Duplicate Space** and wait for the deployment to finish.

5. Once the deployment is finished, you can find the URL as configured in the
   `N8N_EDITOR_BASE_URL` variable.

Now you can access n8n using the URL.

> n8n use [helmet](https://github.com/helmetjs/helmet) for security headers.
> In production mode, it will set `X-Frame-Options` to `sameorigin`, which causes
> the n8n site to be blocked by the iframe in the Huggingface Space.
> You must open the App URL directly in a new tab.