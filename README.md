# CRM Automation — Version 2

A production-oriented CRM workflow automation built with **n8n and PostgreSQL**.

This project focuses on building a reliable lead-processing system rather than a simple automation. Version 2 introduces database-backed processing, validation, idempotency, error handling, retry tracking, and a separate error-trigger workflow.

---

## 🚀 Project Overview

The CRM receives new lead data through a webhook and processes it through a structured automation pipeline.

### Main Flow

```text
Webhook
   ↓
Normalize Data
   ↓
Validate Lead
   ↓
Check Duplicate / Idempotency
   ↓
Process Lead
   ↓
Assign / Route
   ↓
Store in PostgreSQL
   ↓
Complete
```

The system is designed so that failures can be detected and handled separately instead of allowing the entire workflow to fail silently.

---

# 1. Main CRM Workflow

The **Main CRM Workflow** handles the normal lifecycle of an incoming lead.

### Responsibilities

* Receive lead data through a webhook
* Normalize incoming data
* Validate required fields
* Check whether the lead has already been processed
* Process and route the lead
* Store lead information in PostgreSQL
* Track processing status
* Maintain retry information
* Generate structured errors when processing fails

### Main Workflow

```text
Lead Source
    ↓
Webhook
    ↓
Normalize
    ↓
Validate
    ↓
Idempotency Check
    ↓
Business Logic
    ↓
PostgreSQL
    ↓
Success
```

---

## 2. Error Trigger Workflow

The **Error Trigger Workflow** is responsible for detecting workflow failures and recording them for further handling.

Instead of mixing error-handling logic into every part of the main workflow, errors are handled through a separate workflow.

### Responsibilities

* Detect workflow execution failures
* Capture error information
* Record the failed workflow
* Store execution/error details
* Track when the failure occurred
* Preserve information required for debugging and recovery

### Error Flow

```text
Main Workflow
     ↓
Workflow Failure
     ↓
Error Trigger
     ↓
Capture Error Details
     ↓
Store Error Log
     ↓
Ready for Investigation / Recovery
```

---

# 🗄️ Database

The CRM uses **PostgreSQL** as the persistent data layer.

The database contains tables for managing leads, supporting data, and workflow failures.

### Main Tables

* `leads` — Stores CRM lead information
* `countries` — Stores country/region information
* `teams` — Stores team assignment information
* `retry_logs` — Tracks retry attempts
* `workflow_error` — Stores workflow failure information

---

# 🛡️ Reliability Features

Version 2 focuses on reliability and production-style automation.

### Idempotency

The system checks whether a lead has already been processed before performing duplicate operations.

This helps prevent duplicate records when the same request is received more than once.

### Processing Status

Leads maintain a processing status so the system can distinguish between states such as:

```text
pending
processing
completed
failed
```

### Error Logging

Workflow failures are captured and stored rather than being lost inside the automation platform.

### Retry Tracking

Retry information is stored so repeated processing attempts can be tracked and analyzed.

---

# 🧩 Architecture

The system separates normal business processing from failure handling.

```text
                    ┌──────────────────┐
                    │   Lead Source    │
                    └────────┬─────────┘
                             ↓
                    ┌──────────────────┐
                    │ Main CRM Workflow│
                    └────────┬─────────┘
                             ↓
                    ┌──────────────────┐
                    │    PostgreSQL    │
                    └──────────────────┘

                             │
                             │ Failure
                             ↓
                    ┌──────────────────┐
                    │  Error Trigger   │
                    │     Workflow     │
                    └────────┬─────────┘
                             ↓
                    ┌──────────────────┐
                    │  Error Logging   │
                    └──────────────────┘
```

---

# 🎯 Why Separate the Error Workflow?

A common approach is to place many error-handling branches directly inside the main workflow.

That can make the workflow increasingly difficult to maintain.

Instead, this project separates:

**Business Logic**

from

**Failure Handling**

This makes the automation easier to understand, debug, and extend.

---

# 🛠️ Technologies

* **n8n** — Workflow automation
* **PostgreSQL** — Database
* **Webhooks** — Lead ingestion
* **SQL** — Database operations
* **HTTP/API concepts** — External system integration

---

# 📂 Project Structure

```text
CRM-Automation-v2/
│
├── README.md
│
├── workflows/
│   ├── main_crm_workflow.json
│   └── error_trigger_workflow.json
│
├── docs/
│   └── Architecture.md
│
└── database/
    └── schema.sql
```

---

# 🔄 Version 2 Improvements

Compared with a basic CRM automation, Version 2 introduces a stronger engineering approach:

* PostgreSQL instead of relying only on temporary workflow data
* Structured lead processing
* Idempotency checks
* Processing status tracking
* Retry tracking
* Dedicated error workflow
* Persistent error logging
* Separation of business logic and failure handling

---

# 📌 Project Goal

The goal of this project is to demonstrate how an automation can be designed with **reliability, maintainability, and failure handling** in mind.

This is not just a workflow that performs a task once.

It is designed to continue operating predictably when requests are duplicated, data is invalid, or workflow execution fails.

---

## 🚧 Future Improvements

Planned improvements include:

* Automated retry workflow
* Dead-letter queue (DLQ)
* Rate limiting
* Concurrency control
* Heartbeat-based worker monitoring
* Caching
* Monitoring and alerting
* Rollback handling
* AI-powered lead qualification

---

## 👨‍💻 Project Focus

**Production-oriented workflow automation**

The project demonstrates practical concepts such as:

`APIs` · `Webhooks` · `n8n` · `PostgreSQL` · `Idempotency` · `Error Handling` · `Retries` · `Workflow Reliability` · `Automation Architecture`
