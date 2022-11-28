CREATE TABLE IF NOT EXISTS usuario (
    id_usuario SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    senha VARCHAR(100),
    avatar VARCHAR(255),
    banner VARCHAR(255),
    data_nasc DATE,
    tipo INT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Conta (
    id_conta SERIAL PRIMARY KEY,
    renda DECIMAL(10,2) NOT NULL,
    progresso DECIMAL(10,2) NOT NULL,
    status INT,
    fk_usuario INT NOT NULL,
    FOREIGN KEY (fk_usuario) REFERENCES Usuario (id_usuario)
);

CREATE TABLE IF NOT EXISTS Objetivo (
    id_objetivo SERIAL PRIMARY KEY,
    categoria VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS ObjetivoConta (
    id_objetivo_conta SERIAL PRIMARY KEY,
    fk_conta INT NOT NULL,
    fk_objetivo INT NOT NULL,
    descricao VARCHAR(100),
    done INT,
    valor_total DECIMAL(10,2),
    valor_inicial DECIMAL(10,2),
    tempo_estimado TIMESTAMP(0),
    pontuacao DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (fk_conta) REFERENCES Conta (id_conta),
    FOREIGN KEY (fk_objetivo) REFERENCES Objetivo (id_objetivo)
);

CREATE TABLE IF NOT EXISTS Task (
    id_task SERIAL PRIMARY KEY,
    categoria VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS TaskObjetivo (
    id_task_objetivo SERIAL PRIMARY KEY,
    fk_task INT NOT NULL,
    fk_objetivo INT NOT NULL,
    ordem INT NOT NULL,
    FOREIGN KEY(fk_task) REFERENCES Task (id_task),
    FOREIGN KEY(fk_objetivo) REFERENCES Objetivo (id_objetivo)
);

CREATE TABLE IF NOT EXISTS TaskObjetivoConta (
    descricao VARCHAR(100),
    done INT,
    pontuacao DECIMAL(10,2),
    valor DECIMAL(10,2),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fk_objetivo_conta INT NOT NULL,
    fk_task_objetivo INT NOT NULL,
    FOREIGN KEY (fk_objetivo_conta) REFERENCES ObjetivoConta (id_objetivo_conta),
    FOREIGN KEY (fk_task_objetivo)  REFERENCES  TaskObjetivo (id_task_objetivo),
    PRIMARY KEY (fk_objetivo_conta, fk_task_objetivo)
);


CREATE TABLE IF NOT EXISTS Movimentacao (
    id_movimentacao SERIAL PRIMARY KEY,
    valor DECIMAL(10,2),
    topico VARCHAR(100),
    descricao VARCHAR(100),
    tipo VARCHAR(100),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fk_objetivo_conta INT NOT NULL,
    FOREIGN KEY (fk_objetivo_conta) REFERENCES ObjetivoConta (id_objetivo_conta)
);

CREATE TABLE IF NOT EXISTS MovimentacaoFixa  (
    id_movimentacao_fixa SERIAL PRIMARY KEY,
    categoria VARCHAR(100),
    descricao VARCHAR(100),
    valor DECIMAL(10,2),
    tipo VARCHAR(100),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fk_conta INT NOT NULL,
    FOREIGN KEY (fk_conta) REFERENCES Conta (id_conta)
);

CREATE TABLE IF NOT EXISTS Dica (
    id_dica SERIAL PRIMARY KEY,
    titulo VARCHAR(45) NULL,
    descricao VARCHAR(255) NULL,
    tema VARCHAR(45) NULL
);

CREATE TABLE IF NOT EXISTS Topico (
    id_topico SERIAL PRIMARY KEY,
    titulo VARCHAR(45) NULL,
    conteudo VARCHAR(255) NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fk_conta INT NOT NULL,
    FOREIGN KEY (fk_conta) REFERENCES Conta (id_conta)
);

CREATE TABLE IF NOT EXISTS Comentario (
    id_comentario SERIAL PRIMARY KEY,
    conteudo VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fk_conta INT NOT NULL,
    fk_topico INT NOT NULL,
    fk_comentario INT,
    FOREIGN KEY (fk_comentario) REFERENCES Comentario (id_comentario),
    FOREIGN KEY (fk_conta) REFERENCES Conta (id_conta),
    FOREIGN KEY (fk_topico) REFERENCES Topico (id_topico)
);

CREATE TABLE IF NOT EXISTS Likes (
    fk_topico INT NOT NULL,
    fk_conta INT NOT NULL,
    FOREIGN KEY(fk_topico) REFERENCES Topico (id_topico),
    FOREIGN KEY(fk_conta) REFERENCES Conta (id_conta),
    PRIMARY KEY (fk_topico, fk_conta)
);

INSERT INTO Objetivo(categoria)
VALUES ('Viagem Internacional'),
       ('Viagem Nacional'),
       ('Comprar casa própria'),
       ('Comprar carro'),
       ('Faculdade'),
       ('Quitação de Dívida'),
       ('Compras Gerais');


INSERT INTO Task(categoria)
VALUES ('Economizar'),
       ('Procurar Hotel'),
       ('Comprar Malas de Viagem');

INSERT INTO TaskObjetivo(fk_task, fk_objetivo, ordem)
VALUES (1, 1, 1),
       (1, 2, 1),
       (1, 3, 1),
       (1, 4, 1),
       (1, 5, 1),
       (1, 6, 1),
       (1, 7, 1),
       (2, 1, 2),
       (3, 1, 3);

INSERT INTO Dica (titulo, descricao, tema)
VALUES ('Invista em Renda Fixa', 'Você sabia que pode investir em renda fixa, se procura uma opção mais segura? É o tipo de investimento mais recomendado para os aspirantes!', 'Investientos');

INSERT INTO Usuario(nome, email, senha, avatar, banner, data_nasc, tipo) 
    VALUES ('Letícia Carvalho', 'leticia.carvalho@gmail.com', '$2a$10$Hiv8QzaSZE5iUJtSZp0.HOVYbU2Dfm0yMm4rpYj6V0UveMMbbgzmK', '1avatar/image.png', '', '2002-05-05', 0),
    ('Fernando Souza', 'fernando.souza@gmail.com', '$2a$10$Hiv8QzaSZE5iUJtSZp0.HOVYbU2Dfm0yMm4rpYj6V0UveMMbbgzmK', '2avatar/image.png', '', '2002-05-05', 0),
    ('Giovanni Campos', 'giovanni.campos@gmail.com', '$2a$10$Hiv8QzaSZE5iUJtSZp0.HOVYbU2Dfm0yMm4rpYj6V0UveMMbbgzmK', '3avatar/image.png', '', '2002-05-05', 0),
    ('Catarina Campos', 'catarina.campos@gmail.com', '$2a$10$Hiv8QzaSZE5iUJtSZp0.HOVYbU2Dfm0yMm4rpYj6V0UveMMbbgzmK', '4avatar/image.png', '', '2002-05-05', 0),
    ('Lucas Santos', 'lucas.santos@gmail.com', '$2a$10$Hiv8QzaSZE5iUJtSZp0.HOVYbU2Dfm0yMm4rpYj6V0UveMMbbgzmK', '5avatar/image.png', '', '2002-05-05', 0),
    ('Carolina Santos', 'carolina.santos@gmail.com', '$2a$10$Hiv8QzaSZE5iUJtSZp0.HOVYbU2Dfm0yMm4rpYj6V0UveMMbbgzmK', '6avatar/image.png', '', '2002-05-05', 0),
    ('Breno Moraes', 'breno.moraes@gmail.com', '$2a$10$Hiv8QzaSZE5iUJtSZp0.HOVYbU2Dfm0yMm4rpYj6V0UveMMbbgzmK', '7avatar/image.png', '', '2002-05-05', 0),
    ('Vanessa Aurora', 'vanessa.aurora@gmail.com', '$2a$10$Hiv8QzaSZE5iUJtSZp0.HOVYbU2Dfm0yMm4rpYj6V0UveMMbbgzmK', '8avatar/image.png', '', '2002-05-05', 0),
    ('Eliza Almeida', 'eliza.almeida@gmail.com', '$2a$10$Hiv8QzaSZE5iUJtSZp0.HOVYbU2Dfm0yMm4rpYj6V0UveMMbbgzmK', '9avatar/image.png', '', '2002-05-05', 0),
    ('Olivia Farias', 'olivia.farias@gmail.com', '$2a$10$Hiv8QzaSZE5iUJtSZp0.HOVYbU2Dfm0yMm4rpYj6V0UveMMbbgzmK', '10avatar/image.png', '', '2002-05-05', 0);

INSERT INTO Conta(renda, progresso, status, fk_usuario) 
    VALUES (3000, 10, 1, 1),
    (2000, 05, 1, 2),
    (1000, 08, 1, 3),
    (2000, 15, 1, 4),
    (4000, 0, 1, 5),
    (5000, 20, 1, 6),
    (3000, 25, 1, 7),
    (2000, 10, 1, 8),
    (1000, 30, 1, 9),
    (6000, 05, 1, 10);


INSERT INTO Topico(titulo, conteudo, fk_conta) 
    VALUES ('Economizar', 'Eae galera, tava precisando de algumas dicas pra economizar, podem me ajudar?', 1),
    ('Viagens!!', 'Quero muito viajar pra fora, sabem sites para comparar o preço de passagem?', 2),
    ('Dicas para economizar!', 'O principal é anotar todos seus gastos e ganhos e ter em mente seus objetivos, esse app ajuda muito pra isso!', 3),
    ('Investimentos', 'Pessoal, sabem se renda fixa rende mais que renda variável?', 4),
    ('Help!', 'Não consigo parar de gastar com coisas bobas, como me organazizar? kkkkj', 5),
    ('Necessito de dicas', 'Alguem sabe cursos bons e baratos para aprender sobre investimento?', 6),
    ('Dica!!!', 'Usem e abusem das ferramentas desse app, me ajudaram demais!', 7),
    ('ATENÇÃO!!!', 'Galera, to fazendo um cursinho de investimentos, querem que eu trago um resuminho pra vcs de cada aula?', 10);
