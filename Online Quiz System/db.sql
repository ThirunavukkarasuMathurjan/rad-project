DROP DATABASE IF EXISTS quiz_system;
CREATE DATABASE quiz_system;

USE quiz_system;

CREATE TABLE teacher (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE subject (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    teacher_id INT NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES teacher(id)
);

CREATE TABLE student (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE student_subject (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES student(id),
    FOREIGN KEY (subject_id) REFERENCES subject(id)
);

CREATE TABLE quiz (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    subject_id INT NOT NULL,
    deadline DATE NOT NULL,
    duration INT NOT NULL,
    FOREIGN KEY (subject_id) REFERENCES subject(id)
);

CREATE TABLE question (
    id INT AUTO_INCREMENT PRIMARY KEY,
    question TEXT,
    quiz_id INT NOT NULL,
    FOREIGN KEY (quiz_id) REFERENCES quiz(id)
);

CREATE TABLE answer (
    id INT AUTO_INCREMENT PRIMARY KEY,
    question_id INT NOT NULL,
    choice1 VARCHAR(100),
    choice2 VARCHAR(100),
    choice3 VARCHAR(100),
    choice4 VARCHAR(100),
    correct INT,
    FOREIGN KEY (question_id) REFERENCES question(id)
);

CREATE TABLE results (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    quiz_id INT NOT NULL,
    score INT NOT NULL,
    completed_date DATE NOT NULL,
    FOREIGN KEY (student_id) REFERENCES student(id),
    FOREIGN KEY (quiz_id) REFERENCES quiz(id)
);

-- Insert sample data (teacher, subject, student, student_subject, quiz, question, answer, results)

INSERT INTO teacher (username, password, name) VALUES
    ('gayani', '345', 'Gayani Gishara'),
    ('chamara', '456', 'Chamara Dasun');

INSERT INTO subject (name, teacher_id) VALUES
    ('Math', 1),
    ('Science', 1),
    ('English', 2),
    ('History', 2),
    ('Physics', 1);

INSERT INTO student (username, password, name) VALUES
    ('akila', '123', 'Akila Hemal'),
    ('hiruni', '234', 'Hiruni Amanda');

INSERT INTO student_subject (student_id, subject_id) VALUES
    (1, 1),
    (1, 2),
    (2, 3),
    (2, 4);

INSERT INTO quiz (name, subject_id, description, deadline, duration) VALUES
    ('Algebra Quiz', 1, 'Test your knowledge of algebraic equations.', '2023-07-30', 60),
    ('Biology Quiz', 2, 'Explore the fascinating world of biology.', '2023-08-05', 45),
    ('Grammar Quiz', 3, 'Check your grammar skills with this quiz.', '2023-08-12', 30),
    ('World War II Quiz', 4, 'Test your knowledge of World War II history.', '2023-08-15', 45),
    ('Mechanics Quiz', 5, 'Challenge yourself with questions on mechanics.', '2023-08-20', 60);

INSERT INTO question (question, quiz_id) VALUES
    ('What is the square root of 16?', 1),
    ('What is the powerhouse of the cell?', 2),
    ('Which word is a noun?', 3),
    ('When did World War II end?', 4),
    ('What is Newton''s first law of motion?', 5),
    ('What is the capital of France?', 1),
    ('What gas do plants absorb during photosynthesis?', 2),
    ('Which planet is known as the "Red Planet"?', 3),
    ('Who is the author of "Romeo and Juliet"?', 4),
    ('What is the chemical symbol for water?', 5);

INSERT INTO answer (question_id, choice1, choice2, choice3, choice4, correct) VALUES
    (1, '2', '3', '4', '5', 1),
    (2, 'Mitochondria', 'Nucleus', 'Chloroplast', 'Ribosome', 1),
    (3, 'Jump', 'Run', 'Quick', 'Jumping', 4),
    (4, '1945', '1918', '1939', '1941', 1),
    (5, 'An object at rest stays at rest', 'Force equals mass times acceleration', 'For every action, there is an equal and opposite reaction', 'An object in motion stays in motion', 4),
    (6, 'Paris', 'London', 'Berlin', 'Rome', 1),
    (7, 'Oxygen', 'Carbon dioxide', 'Nitrogen', 'Water vapor', 1),
    (8, 'Mars', 'Venus', 'Mercury', 'Jupiter', 2),
    (9, 'William Shakespeare', 'Jane Austen', 'Charles Dickens', 'Mark Twain', 1),
    (10, 'H2O', 'CO2', 'O2', 'CH4', 1);

INSERT INTO results (student_id, quiz_id, score, completed_date) VALUES
    (1, 2, 90, '2023-08-04'),
    (2, 3, 75, '2023-08-05'),
    (2, 4, 80, '2023-08-05');

