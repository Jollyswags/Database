# Write your MySQL query statement below
WITH recursive tbl AS
(
         SELECT   task_id,
                  1 AS num
         FROM     tasks
         GROUP BY 1
         UNION ALL
         SELECT task_id ,
                num+1
         FROM   tbl t1
         WHERE  num <
                (
                       SELECT subtasks_count
                       FROM   tasks t
                       WHERE  t.task_id=t1.task_id) )
SELECT    t.task_id,
          t.num AS subtask_id
FROM      tbl t
LEFT JOIN executed e
ON        e.task_id=t.task_id
AND       e.subtask_id=t.num
WHERE     e.subtask_id IS NULL