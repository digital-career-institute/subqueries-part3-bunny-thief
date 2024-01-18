DROP DATABASE jobs;
CREATE DATABASE jobs;
use jobs;

DROP TABLE IF EXISTS `job_openings`;

CREATE TABLE `job_openings`(
	job_id INT PRIMARY KEY AUTO_INCREMENT,
    job_title VARCHAR(255),
    department VARCHAR(255),
    minimum_experience INT,
    minimum_education VARCHAR(255)
);

ALTER TABLE `job_openings` AUTO_INCREMENT=101;

INSERT INTO `job_openings` (job_title, department, minimum_experience, minimum_education)
values('Spacecraft Pilot', 'Flight Operations', 5, 'Bacherlors Space Engineering'),
('Mission Specialist', 'Science', 3, 'Phd in Physics'),
('Space Enginner', 'Engineering', 3, 'Bachelors Mechanical Engineering'),
('Communications Officer', 'Communication', 2, 'Bachelors Communication'),
('Chief Executive Officer', 'Management', 2, 'MBA');

DROP TABLE IF EXISTS `pplicants`;

CREATE TABLE `applicants` (
	applicant_id INT PRIMARY KEY AUTO_INCREMENT,
    applicant_name VARCHAR(255),
    experience_years INT,
    education VARCHAR(255),
    applied_for_job_id INT,
    FOREIGN KEY (applied_for_job_id)
		REFERENCES `job_openings`(job_id)
);

INSERT INTO `applicants` (applicant_name, experience_years, education, applied_for_job_id)
values('John Austronaut', 7, 'Masters Aerospace Engineering', 101),
('Lisa Scientist', 4, 'Phd Physics', 102),
('Mark Engineer', 5, 'Bachelors Mechanical Engineering', 103),
('Emily Communicator', 3, 'Bachelors Communication', 104 );

INSERT INTO `applicants` (applicant_name, experience_years, education)
values ('Steve Nojob', 2, 'Bachelors Business');

-- 1. List of all job openings
SELECT * FROM `job_openings`;

-- 2. Applicants and Their Jobs
SELECT a.applicant_name, j.job_title FROM applicants as a
LEFT OUTER JOIN job_openings as j
ON a.applied_for_job_id = j.job_id;

-- 3. Qualified Applicants
SELECT a.applicant_name FROM applicants as a
LEFT OUTER JOIN job_openings as j
ON a.applied_for_job_id = j.job_id
WHERE a.experience_years >= j.minimum_experience;

-- 4. Job Applicants Without Match

-- 5.Experience Range Search
SELECT * FROM `job_openings`
WHERE minimum_experience >= 3 AND minimum_experience <= 5;

-- 6. Education Level Analysis
SELECT j.job_title, COUNT(*), a.education FROM `job_openings` as j
INNER JOIN applicants as a
ON j.job_id = a.applied_for_job_id
GROUP BY a.education;