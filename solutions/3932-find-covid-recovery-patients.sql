# Write your MySQL query statement below

with first_pos as (
    select c.patient_id, p.patient_name, p.age, min(c.test_date) over (partition by patient_id) as first_positive, c.result from covid_tests c join patients p on c.patient_id = p.patient_id where c.result = 'Positive'
),
first_neg as (
    select c.patient_id, p.patient_name, p.age, min(c.test_date) over (partition by patient_id) as first_negative, c.result 
    from covid_tests c 
    join patients p on c.patient_id = p.patient_id 
    join first_pos fp on fp.patient_id = c.patient_id
    where c.result = 'Negative' and c.test_date > fp.first_positive
),
consol as (
    select p.patient_id, p.patient_name, p.age, datediff(n.first_negative, p.first_positive) as recovery_time from first_pos p join first_neg n on p.patient_id = n.patient_id
)
select distinct * from consol order by recovery_time, patient_name