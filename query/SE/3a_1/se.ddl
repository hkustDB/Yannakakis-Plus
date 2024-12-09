CREATE TABLE site (
    site_id INT,
    site_name VARCHAR,
    PRIMARY KEY (site_id)
);

CREATE TABLE so_user (
    id INT,
    site_id INT,
    reputation INT,
    creation_date DATE,
    last_access_date DATE,
    upvotes INT,
    downvotes INT,
    account_id INT,
    PRIMARY KEY (id)
);

CREATE TABLE question (
    id INT,
    site_id INT,
    accepted_answer_id INT,
    creation_date DATE,
    deletion_date DATE,
    score INT,
    view_count INT,
    body VARCHAR,
    owner_user_id INT,
    last_editor_id INT,
    title VARCHAR,
    favorite_count INT,
    closed_date DATE,
    tagstring VARCHAR,
    PRIMARY KEY (id)
);

CREATE TABLE answer (
    id INT,
    site_id INT,
    question_id INT,
    creation_date DATE,
    deletion_date DATE,
    score INT,
    view_count INT,
    body INT,
    owner_user_id INT,
    last_editor_id INT,
    last_edit_date DATE,
    last_activity_date DATE,
    title VARCHAR,
    PRIMARY KEY (id)
);

CREATE TABLE tag (
    id INT,
    site_id INT,
    name VARCHAR,
    PRIMARY KEY (id)
);

CREATE TABLE tag_question (
    question_id INT,
    tag_id INT,
    site_id INT,
    PRIMARY KEY (site_id, question_id, tag_id)
);

CREATE TABLE badge (
    site_id INT,
    user_id INT,
    name VARCHAR,
    date DATE,
    PRIMARY KEY (site_id, user_id)
);

CREATE TABLE account (
    id INT,
    display_name VARCHAR,
    location VARCHAR,
    about_me VARCHAR,
    website_url VARCHAR,
    PRIMARY KEY (id)
);

CREATE TABLE comment (
    id INT,
    site_id INT,
    post_id INT,
    user_id INT,
    score INT,
    body VARCHAR,
    date DATE,
    PRIMARY KEY (id)
);

CREATE TABLE post_link (
    site_id INT,
    post_id_from INT,
    post_id_to INT,
    link_type INT,
    date DATE,
    PRIMARY KEY (id)
);