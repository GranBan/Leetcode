# Write your MySQL query statement below

with first as (
    select student_id, subject, score as first_score, min(exam_date) as first_exam from Scores group by student_id, subject
),
latest as (
    select student_id, subject, score as latest_score, exam_date as latest_exam from Scores where (student_id, subject, exam_date) in (select student_id, subject, max(exam_date) from Scores group by student_id, subject)
)

select f.student_id, f.subject, f.first_score, l.latest_score from first f join latest l on f.student_id = l.student_id and f.subject = l.subject where l.latest_score > f.first_score order by f.student_id, f.subject