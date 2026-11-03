create database e_learning;
use e_learning;

-- create tables --
create table learners(
learner_id int primary key,
full_name varchar(50),
country varchar(50)
);

create table courses(
course_id int primary key,
course_name varchar(100),
category varchar(50),
unit_price decimal(20,2)
);

create table purchases(
purchase_id int primary key,
learner_id int,
course_id int,
quantity int,
purchase_date date,
foreign key (learner_id) references learners(learner_id),
foreign key (course_id) references courses(course_id)
);

-- insert values --
insert into learners 
values (1, 'Arun Kumar', 'India'),
(2, 'Priya Sharma', 'India'),
(3, 'John Smith', 'USA'),
(4, 'Emma Wilson', 'UK'),
(5, 'Rahul Verma', 'India'),
(6, 'Sophia Brown', 'Canada'),
(7, 'David Lee', 'Australia'),
(8, 'Ananya Das', 'India'),
(9, 'Michael Clark', 'USA'),
(10, 'Olivia Martin', 'UK');

insert into courses 
values (101, 'SQL for Beginners', 'Database', 1500.00),
(102, 'Advanced SQL', 'Database', 2500.00),
(103, 'Python Basics', 'Programming', 2000.00),
(104, 'Advanced Python', 'Programming', 3500.00),
(105, 'Power BI Fundamentals', 'Data Analytics', 1800.00),
(106, 'Advanced Power BI', 'Data Analytics', 3000.00),
(107, 'Excel Essentials', 'Data Analytics', 1200.00),
(108, 'Machine Learning', 'Artificial Intelligence', 4500.00),
(109, 'Web Development', 'Programming', 2800.00),
(110, 'Data Visualization', 'Data Analytics', 2200.00),
(111, 'Cloud Computing', 'Cloud Technology', 4000.00),
(112, 'Cyber Security', 'Security', 3200.00);

insert into purchases
values (1, 1, 101, 2, '2026-01-05'),
(2, 1, 103, 1, '2026-01-10'),
(3, 1, 105, 2, '2026-01-15'),
(4, 2, 101, 1, '2026-01-08'),
(5, 2, 102, 2, '2026-01-20'),
(6, 3, 103, 1, '2026-02-01'),
(7, 3, 104, 1, '2026-02-05'),
(8, 4, 105, 3, '2026-02-10'),
(9, 4, 107, 2, '2026-02-15'),
(10, 5, 101, 1, '2026-02-20'),
(11, 5, 105, 1, '2026-03-01'),
(12, 5, 108, 2, '2026-03-05'),
(13, 6, 102, 1, '2026-03-10'),
(14, 6, 103, 2, '2026-03-15'),
(15, 7, 104, 1, '2026-03-20'),
(16, 8, 105, 2, '2026-04-01'),
(17, 8, 109, 1, '2026-04-05'),
(18, 9, 101, 3, '2026-04-10'),
(19, 9, 110, 1, '2026-04-15'),
(20, 10, 102, 2, '2026-04-20');

select * from courses;
select * from learners;
select * from purchases;


select c.*,l.*,p.* from courses as c
left join 
purchases as p
on c.course_id = p.course_id
left join
learners as l
on l.learner_id = p.learner_id;

select l.full_name, c.course_name, c.category, p.quantity, (c.unit_price * p.quantity) as total_amount, p.purchase_date
from learners as l
inner join
purchases as p
on l.learner_id = p.learner_id
inner join 
courses as c
on p.course_id = c.course_id
order by total_amount desc;

-- Analytical Queries --
select l.learner_id, l.full_name, l.country , sum(p.quantity * c.unit_price) as total_spending 
from learners as l
inner join
purchases as p
on l.learner_id = p.learner_id
inner join 
courses as c
on p.course_id = c.course_id
group by l.full_name, l.learner_id, l.country
order by total_spending desc;

select c.course_name, sum(p.quantity) as total_quantity
from courses as c
inner join 
purchases as p
on c.course_id =p.course_id
group by c.course_name
order by total_quantity desc limit 3;

select c.category, sum(c.unit_price * p.quantity) as total_revenue, count(distinct p.learner_id) as number_of_learners
from courses as c
inner join
purchases as p
on c.course_id = p.course_id
group by c.category
order by total_revenue desc;

select l.full_name, count(distinct c.category) as total_category from learners as l
left join
purchases as p
on l.learner_id = p.learner_id
left join
courses as c
on c.course_id = p.course_id
group by l.full_name, l.learner_id
having total_category > 1 
order by total_category desc;

select c.course_name, p.course_id from courses as c
left join 
purchases as p
on c.course_id = p.course_id
where p.course_id  is null;




