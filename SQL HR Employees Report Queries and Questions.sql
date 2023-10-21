create database projects;

use projects;

select * from hr;

alter table hr
change column ï»¿id emp_id varchar(20) null;

describe hr;

select birthdate from hr;

set sql_safe_updates = 0;

update hr
set birthdate = case
	when birthdate like '%/%' then date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    when birthdate like '%-%' then date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    else null
end ;

alter table hr
modify column birthdate date;

describe hr;

update hr
set hire_date = case
	when hire_date like '%/%' then date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    when hire_date like '%-%' then date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    else null
end ;

select hire_date from hr;

select termdate from hr;
update hr
set termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')
where termdate is not null and termdate != '';

UPDATE hr
SET termdate = IF(termdate IS NOT NULL AND termdate != '', date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')), '0000-00-00')
WHERE true;

SELECT termdate from hr;

SET sql_mode = 'ALLOW_INVALID_DATES';

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

select termdate from hr;
describe hr;
alter table hr
modify column hire_date date;

select * from hr;
alter table hr add column age int;

update hr
set age = timestampdiff(year, birthdate, curdate());
select birthdate, age from hr;

select min(age) as youngest,
max(age) as oldest
from hr;

select count(*) from hr
where age < 18;

select gender, count(*) as count
from hr
where age >= 18 and termdate = '0000-00-00'
group by gender;

select race, count(*) as count
from hr
where age > 18 and termdate = '0000-00-00'
group by race
order by count(*) desc;

select min(age) as youngest,
max(age) as oldest
from hr
where age > 18 and termdate = '0000-00-00';

select 
	case
		when age >= 18 and age <= 24 then '18-24'
        when age >= 25 and age <= 34 then '25-34'
        when age >= 35 and age <= 44 then '35-44'
        when age >= 45 and age <= 54 then '44-54'
		when age >= 55 and age <= 64 then '55-64'
        else '65+'
	end as age_group,
    count(*) as count
    from hr
    where age >= 18 and termdate = '0000-00-00'
    group by age_group
    order by age_group;
    
    select 
	case
		when age >= 18 and age <= 24 then '18-24'
        when age >= 25 and age <= 34 then '25-34'
        when age >= 35 and age <= 44 then '35-44'
        when age >= 45 and age <= 54 then '44-54'
		when age >= 55 and age <= 64 then '55-64'
        else '65+'
	end as age_group, gender,
    count(*) as count
    from hr
    where age >= 18 and termdate = '0000-00-00'
    group by age_group, gender
    order by age_group, gender;
    
    select location, count(*) as count
    from hr
    where age >= 18 and termdate = '0000-00-00'
    group by location;
    
    select
    round(avg(datediff(termdate, hire_date))/365) as avg_length_employment
    from hr
    where termdate <= curdate() and termdate <> '0000-00-00' and age >= 18;
    
    select department, gender, count(*) as count
    from hr
    where age >= 18 and termdate = '0000-00-00'
    group by department, gender
    order by department;
    
    select jobtitle, count(*) as count
    from hr
    where age >= 18 and termdate = '0000-00-00'
    group by jobtitle
    order by jobtitle;

	select department,
    total_count,
    terminated_count,
    terminated_count/total_count as termination_rate
    from (
		select department,
        count(*) as total_count,
        sum(case when termdate <> '0000-00-00' and termdate <= curdate() then 1 else 0 end) as terminated_count
        from hr
        where age >= 18
        group by department
        ) as subquery
        order by termination_rate desc;
        
        select location_state, count(*) as count
        from hr
        where age >= 18 and termdate = '0000-00-00'
        group by location_state
        order by count desc;
        
        select 
        year,
        hires,
        terminations,
        hires - terminations as net_change,
        round((hires - terminations)/hires * 100,2) as net_change_percent
        from (
			select year(hire_date) as year,
            count(*) as hires,
            sum(case when termdate <> '0000-00-00' and termdate <=curdate() then 1 else 0 end) as terminations
            from hr
            where age >= 18
            group by year(hire_date)
            ) as subquery
            order by year asc;
            
select department, round(avg(datediff(termdate, hire_date)/365), 0) as avg_tenure
from hr
where termdate <> curdate() and termdate <> '0000-00-00' and age >= 18
group by department;
SELECT gender, COUNT(*) AS count
FROM hr
WHERE age >= 18
GROUP BY gender;

SELECT race, COUNT(*) AS count
FROM hr
WHERE age >= 18
GROUP BY race
ORDER BY count DESC;

select
 CASE 
    WHEN age >= 18 AND age <= 24 THEN '18-24'
    WHEN age >= 25 AND age <= 34 THEN '25-34'
    WHEN age >= 35 AND age <= 44 THEN '35-44'
    WHEN age >= 45 AND age <= 54 THEN '45-54'
    WHEN age >= 55 AND age <= 64 THEN '55-64'
    ELSE '65+' 
  END AS age_group, gender,
  COUNT(*) AS count
FROM 
  hr
WHERE 
  age >= 18
GROUP BY age_group, gender
ORDER BY age_group, gender;

SELECT 
  CASE 
    WHEN age >= 18 AND age <= 24 THEN '18-24'
    WHEN age >= 25 AND age <= 34 THEN '25-34'
    WHEN age >= 35 AND age <= 44 THEN '35-44'
    WHEN age >= 45 AND age <= 54 THEN '45-54'
    WHEN age >= 55 AND age <= 64 THEN '55-64'
    ELSE '65+' 
  END AS age_group, 
  COUNT(*) AS count
FROM 
  hr
WHERE 
  age >= 18
GROUP BY age_group
ORDER BY age_group;

SELECT location, COUNT(*) as count
FROM hr
WHERE age >= 18
GROUP BY location;

SELECT ROUND(AVG(DATEDIFF(termdate, hire_date))/365,0) AS avg_length_of_employment
FROM hr
WHERE termdate <> '0000-00-00' AND termdate <= CURDATE() AND age >= 18;

SELECT ROUND(AVG(DATEDIFF(termdate, hire_date)),0)/365 AS avg_length_of_employment
FROM hr
WHERE termdate <= CURDATE() AND age >= 18;

SELECT department, gender, COUNT(*) as count
FROM hr
WHERE age >= 18
GROUP BY department, gender
ORDER BY department;

SELECT jobtitle, COUNT(*) as count
FROM hr
WHERE age >= 18
GROUP BY jobtitle
ORDER BY jobtitle DESC;

SELECT department, COUNT(*) as total_count, 
    SUM(CASE WHEN termdate <= CURDATE() AND termdate <> '0000-00-00' THEN 1 ELSE 0 END) as terminated_count, 
    SUM(CASE WHEN termdate = '0000-00-00' THEN 1 ELSE 0 END) as active_count,
    (SUM(CASE WHEN termdate <= CURDATE() THEN 1 ELSE 0 END) / COUNT(*)) as termination_rate
FROM hr
WHERE age >= 18
GROUP BY department
ORDER BY termination_rate DESC;

SELECT location_state, COUNT(*) as count
FROM hr
WHERE age >= 18
GROUP BY location_state
ORDER BY count DESC;

SELECT 
    YEAR(hire_date) AS year, 
    COUNT(*) AS hires, 
    SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminations, 
    COUNT(*) - SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS net_change,
    ROUND(((COUNT(*) - SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END)) / COUNT(*) * 100),2) AS net_change_percent
FROM 
    hr
WHERE age >= 18
GROUP BY 
    YEAR(hire_date)
ORDER BY 
    YEAR(hire_date) ASC;
    
    SELECT 
    year, 
    hires, 
    terminations, 
    (hires - terminations) AS net_change,
    ROUND(((hires - terminations) / hires * 100), 2) AS net_change_percent
FROM (
    SELECT 
        YEAR(hire_date) AS year, 
        COUNT(*) AS hires, 
        SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminations
    FROM 
        hr
    WHERE age >= 18
    GROUP BY 
        YEAR(hire_date)
) subquery
ORDER BY 
    year ASC;
    
    SELECT department, ROUND(AVG(DATEDIFF(CURDATE(), termdate)/365),0) as avg_tenure
FROM hr
WHERE termdate <= CURDATE() AND termdate <> '0000-00-00' AND age >= 18
GROUP BY department;

select 
	case
		when age >= 18 and age <= 24 then '18-24'
        when age >= 25 and age <= 34 then '25-34'
        when age >= 35 and age <= 44 then '35-44'
        when age >= 45 and age <= 54 then '44-54'
		when age >= 55 and age <= 64 then '55-64'
        else '65+'
	end as age_group,
    count(*) as count
    from hr
    where age >= 18 and termdate = '0000-00-00'
    group by age_group
    order by age_group;
    
    select 
	case
		when age >= 18 and age <= 24 then '18-24'
        when age >= 25 and age <= 34 then '25-34'
        when age >= 35 and age <= 44 then '35-44'
        when age >= 45 and age <= 54 then '44-54'
		when age >= 55 and age <= 64 then '55-64'
        else '65+'
	end as age_group, gender,
    count(*) as count
    from hr
    where age >= 18 and termdate = '0000-00-00'
    group by age_group, gender
    order by age_group, gender;
    
    select location, count(*) as count
    from hr
    where age >= 18 and termdate = '0000-00-00'
    group by location;
    
    select
    round(avg(datediff(termdate, hire_date))/365) as avg_length_employment
    from hr
    where termdate <= curdate() and termdate <> '0000-00-00' and age >= 18;
    
    select department, gender, count(*) as count
    from hr
    where age >= 18 and termdate = '0000-00-00'
    group by department, gender
    order by department;
    
    select jobtitle, count(*) as count
    from hr
    where age >= 18 and termdate = '0000-00-00'
    group by jobtitle
    order by jobtitle;
select 
	case
		when age >= 18 and age <= 24 then '18-24'
        when age >= 25 and age <= 34 then '25-34'
        when age >= 35 and age <= 44 then '35-44'
        when age >= 45 and age <= 54 then '44-54'
		when age >= 55 and age <= 64 then '55-64'
        else '65+'
	end as age_group,
    count(*) as count
    from hr
    where age >= 18 and termdate = '0000-00-00'
    group by age_group
    order by age_group;
    
    select 
	case
		when age >= 18 and age <= 24 then '18-24'
        when age >= 25 and age <= 34 then '25-34'
        when age >= 35 and age <= 44 then '35-44'
        when age >= 45 and age <= 54 then '44-54'
		when age >= 55 and age <= 64 then '55-64'
        else '65+'
	end as age_group, gender,
    count(*) as count
    from hr
    where age >= 18 and termdate = '0000-00-00'
    group by age_group, gender
    order by age_group, gender;
    
    select location, count(*) as count
    from hr
    where age >= 18 and termdate = '0000-00-00'
    group by location;
    
    select
    round(avg(datediff(termdate, hire_date))/365) as avg_length_employment
    from hr
    where termdate <= curdate() and termdate <> '0000-00-00' and age >= 18;
    
    select department, gender, count(*) as count
    from hr
    where age >= 18 and termdate = '0000-00-00'
    group by department, gender
    order by department;
    
    select jobtitle, count(*) as count
    from hr
    where age >= 18 and termdate = '0000-00-00'
    group by jobtitle
    order by jobtitle;
select 
	case
		when age >= 18 and age <= 24 then '18-24'
        when age >= 25 and age <= 34 then '25-34'
        when age >= 35 and age <= 44 then '35-44'
        when age >= 45 and age <= 54 then '44-54'
		when age >= 55 and age <= 64 then '55-64'
        else '65+'
	end as age_group,
    count(*) as count
    from hr
    where age >= 18 and termdate = '0000-00-00'
    group by age_group
    order by age_group;
    
    select 
	case
		when age >= 18 and age <= 24 then '18-24'
        when age >= 25 and age <= 34 then '25-34'
        when age >= 35 and age <= 44 then '35-44'
        when age >= 45 and age <= 54 then '44-54'
		when age >= 55 and age <= 64 then '55-64'
        else '65+'
	end as age_group, gender,
    count(*) as count
    from hr
    where age >= 18 and termdate = '0000-00-00'
    group by age_group, gender
    order by age_group, gender;
    
    select location, count(*) as count
    from hr
    where age >= 18 and termdate = '0000-00-00'
    group by location;
    
    select
    round(avg(datediff(termdate, hire_date))/365) as avg_length_employment
    from hr
    where termdate <= curdate() and termdate <> '0000-00-00' and age >= 18;
    
    select department, gender, count(*) as count
    from hr
    where age >= 18 and termdate = '0000-00-00'
    group by department, gender
    order by department;
    
    select jobtitle, count(*) as count
    from hr
    where age >= 18 and termdate = '0000-00-00'
    group by jobtitle
    order by jobtitle;
    
    SELECT department, gender, COUNT(*) as count
FROM hr
WHERE age >= 18
GROUP BY department, gender
ORDER BY department;


QUESTIONS

-- 1. What is the gender breakdown of employees in the company?

-- 2. What is the race/ethnicity breakdown of employees in the company?

-- 3. What is the age distribution of employees in the company?


-- 4. How many employees work at headquarters versus remote locations?


-- 5. What is the average length of employment for employees who have been terminated?

-- 6. How does the gender distribution vary across departments and job titles?


-- 7. What is the distribution of job titles across the company?


-- 8. Which department has the highest turnover rate?


-- 9. What is the distribution of employees across locations by city and state?


-- 10. How has the company's employee count changed over time based on hire and term dates?

-- 11. What is the tenure distribution for each department?