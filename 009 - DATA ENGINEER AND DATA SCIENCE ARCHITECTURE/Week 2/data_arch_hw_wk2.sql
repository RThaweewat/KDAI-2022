-- =============================================
-- Exam 1
-- Retrieve the names of all employees in department 5 who work 
-- more than 10 hours per week on the ProductX project.

SELECT em.Fname AS 'full_name'
     , wo.Hours AS 'work_hour'
     , pj.Pname AS 'project_name'
     , em.Dno   AS 'department_no'
FROM dbo.EMPLOYEE em,
     dbo.PROJECT pj,
     dbo.WORKS_ON wo
WHERE Essn = em.Ssn
  AND Dno = '5'
  AND Hours > 10
  AND Pname = 'ProductX'
;

-- =============================================
-- Exam 2
-- List top 2 employee (ssn) who work the most hours 
-- across the projects

SELECT TOP 2 em.Fname AS 'full_name'
           , wo.Hours AS 'work_hour'
FROM dbo.EMPLOYEE em,
     dbo.WORKS_ON wo
WHERE wo.Essn = em.Ssn
ORDER BY Hours DESC
;

-- =============================================
-- Exam 3
-- Find the names of all employees who are directly
-- supervised by ‘Franklin Wong’.

SELECT em.Fname AS 'full_name'
FROM dbo.EMPLOYEE em
WHERE Super_ssn = (SELECT Ssn
                   FROM dbo.EMPLOYEE
                   WHERE Fname like 'Franklin'
                     AND Lname like 'Wong')
;

-- =============================================
-- Exam 4
-- Who is the manager of Research Department?

SELECT em.Fname AS 'full_name',
       em.Lname AS 'last_name',
       dp.Dname AS 'department_name'
FROM dbo.EMPLOYEE em,
     dbo.DEPARTMENT dp
WHERE em.Dno = dp.Dnumber
  AND Dname = 'Research'
;

-- =============================================
-- Exam 5
-- List the names of all employees who have salary more than their supervisor.

SELECT em.Fname   AS 'full_name'
     , em.Lname   AS 'last_name'
     , em2.Fname  AS 'supervisor_name'
     , em.Salary  AS 'salary'
     , em2.Salary AS 'supervisor_salary'
FROM dbo.EMPLOYEE em,
     dbo.EMPLOYEE em2
WHERE em.Super_Ssn = em2.ssn
  AND em.SALARY > em2.SALARY
  AND em.Super_ssn IS NOT NULL
;
