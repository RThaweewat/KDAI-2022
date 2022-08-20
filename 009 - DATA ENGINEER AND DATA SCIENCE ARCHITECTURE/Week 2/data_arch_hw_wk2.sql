-- =============================================
-- Exam 1
-- Retrieve the names of all employees in department 5 who work 
-- more than 10 hours per week on the ProductX project.

SELECT em.Fname + ' ' + em.Lname AS 'employee_name'
     , wo.Hours                  AS 'work_hour'
     , pj.Pname                  AS 'project_name'
     , em.Dno                    AS 'department_no'
FROM dbo.EMPLOYEE em,
     dbo.PROJECT pj,
     dbo.WORKS_ON wo
WHERE wo.Essn = em.Ssn
  AND em.Dno = '5'
  AND Hours > 10
  AND pj.Pname = 'ProductX'
;

-- =============================================
-- Exam 2
-- List top 2 employee (ssn) who work the most hours across the projects

-- Method 1 : Get only two employees sort by total working hours
SELECT TOP 2 em.Fname + ' ' + em.Lname AS 'employee_name'
           , SUM(wo.Hours)             AS 'total_work_hour'
FROM dbo.EMPLOYEE em,
     dbo.WORKS_ON wo
WHERE wo.Essn = em.Ssn
GROUP BY em.Fname, em.Lname
ORDER BY total_work_hour DESC
;

-- Method 2: Get all employees by Top 2 total working hours
SELECT TOP 2 em.Fname + ' ' + em.Lname AS 'employee_name'
           , SUM(wo.Hours)             AS 'total_work_hour'
FROM dbo.EMPLOYEE em,
     dbo.WORKS_ON wo
WHERE wo.Essn = em.Ssn
GROUP BY em.Fname, em.Lname
HAVING SUM(wo.Hours) IN
       (SELECT DISTINCT TOP 2 SUM(Hours) AS 'total_hour'
        FROM dbo.WORKS_ON
        GROUP BY Essn
        ORDER BY total_hour DESC)
ORDER BY total_work_hour DESC
;

-- =============================================
-- Exam 3
-- Find the names of all employees who are directly supervised by ‘Franklin Wong’.

SELECT em.Fname + ' ' + em.Lname AS 'employee_name'
FROM dbo.EMPLOYEE em
WHERE Super_ssn = (SELECT Ssn
                   FROM dbo.EMPLOYEE
                   WHERE Fname like 'Franklin'
                     AND Lname like 'Wong')
;

-- =============================================
-- Exam 4
-- Who is the manager of Research Department?

SELECT em.Fname + ' ' + em.Lname AS 'employee_name'
     , dp.Dname                  AS 'department_name'
FROM dbo.EMPLOYEE em,
     dbo.DEPARTMENT dp
WHERE em.Dno = dp.Dnumber
  AND dp.Dname = 'Research'
;

-- =============================================
-- Exam 5
-- List the names of all employees who have salary more than their supervisor.

SELECT em.Fname + ' ' + em.Lname   AS 'employee_name'
     , em.Salary                   AS 'employee_salary'
     , em2.Fname + ' ' + em2.Lname AS 'supervisor_name'
     , em2.Salary                  AS 'supervisor_salary'
FROM dbo.EMPLOYEE em,
     dbo.EMPLOYEE em2
WHERE em.Super_Ssn = em2.ssn
  AND em.SALARY > em2.SALARY
;
