 
-- Tabela de facções
CREATE TABLE factions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    color VARCHAR(7) NOT NULL,
    leader_id INT,
    creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    specialization VARCHAR(255), -- Especialização da facção
    FOREIGN KEY (leader_id) REFERENCES users(id)
);

-- Tabela de territórios
CREATE TABLE territories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    owner_faction_id INT,
    x1 FLOAT,
    y1 FLOAT,
    x2 FLOAT,
    y2 FLOAT,
    defense_score INT DEFAULT 100,
    revenue DECIMAL(10, 2) DEFAULT 0.00,
    special_resource VARCHAR(255), -- Recurso especial do território
    FOREIGN KEY (owner_faction_id) REFERENCES factions(id)
);

-- Tabela de rendimentos
CREATE TABLE income (
    id INT AUTO_INCREMENT PRIMARY KEY,
    faction_id INT,
    amount DECIMAL(10, 2),
    collected_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (faction_id) REFERENCES factions(id)
);

-- Tabela de missões
CREATE TABLE missions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    description TEXT,
    reward DECIMAL(10, 2),
    faction_id INT,
    status ENUM('active', 'completed', 'failed') DEFAULT 'active',
    FOREIGN KEY (faction_id) REFERENCES factions(id)
);

-- Tabela de conflitos
CREATE TABLE conflicts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    attacker_faction_id INT,
    defender_faction_id INT,
    territory_id INT,
    start_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    end_time DATETIME,
    winner_faction_id INT,
    FOREIGN KEY (attacker_faction_id) REFERENCES factions(id),
    FOREIGN KEY (defender_faction_id) REFERENCES factions(id),
    FOREIGN KEY (territory_id) REFERENCES territories(id)
);

-- Tabela de comércio
CREATE TABLE trades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    faction_id INT,
    resource_name VARCHAR(255),
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (faction_id) REFERENCES factions(id)
);

-- Tabela de eventos
CREATE TABLE events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    description TEXT,
    start_time DATETIME,
    end_time DATETIME,
    is_active BOOLEAN DEFAULT TRUE
);
