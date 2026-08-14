CREATE TABLE countries (
    id SERIAL PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL UNIQUE,
    region VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT countries_country_name_key UNIQUE (country_name)
);


-- ============================================
-- TEAMS
-- ============================================

CREATE TABLE teams (
    id SERIAL PRIMARY KEY,
    team_name VARCHAR(100) NOT NULL,
    manager_name VARCHAR(100),
    email VARCHAR(255),
    phone VARCHAR(20),
    country_id INTEGER,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_team_country
        FOREIGN KEY (country_id)
        REFERENCES countries(id)
);


-- ============================================
-- LEADS
-- ============================================

CREATE TABLE leads (
    id SERIAL PRIMARY KEY,
    lead_id VARCHAR(100) NOT NULL,
    name VARCHAR(150),
    email VARCHAR(255),
    phone VARCHAR(30),
    budget NUMERIC,
    source VARCHAR(100),
    country_id INTEGER,
    team_id INTEGER,
    lead_score INTEGER,
    priority VARCHAR(20) DEFAULT 'Low',
    status VARCHAR(30) DEFAULT 'New',
    processing_status VARCHAR(30) DEFAULT 'pending',
    locked_at TIMESTAMP,
    retry_count INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    request_id VARCHAR(100),

    CONSTRAINT chk_lead_status
        CHECK (status IN ('New', 'Contacted', 'Qualified', 'Converted', 'Lost')),

    CONSTRAINT chk_priority
        CHECK (priority IN ('Low', 'Medium', 'High')),

    CONSTRAINT chk_processing_status
        CHECK (processing_status IN ('pending', 'processing', 'completed', 'failed')),

    CONSTRAINT fk_lead_country
        FOREIGN KEY (country_id)
        REFERENCES countries(id),

    CONSTRAINT fk_lead_team
        FOREIGN KEY (team_id)
        REFERENCES teams(id)
);
