WITH RECURSIVE trans_counts AS (
  SELECT
    V.user_id,
    V.visit_date,
    COUNT(T.transaction_date) AS trans_count
  FROM
    Visits V
    LEFT JOIN Transactions T
      ON V.visit_date = T.transaction_date 
        AND V.user_id = T.user_id
  GROUP BY
    V.user_id, V.visit_date
), trans_count_vals AS (
  SELECT MAX(TC.trans_count) as trans_id FROM trans_counts TC
  UNION ALL
  SELECT trans_id - 1 FROM trans_count_vals WHERE trans_id > 0
)
SELECT
  TCV.trans_id AS transactions_count,
  COUNT(TC.trans_count) AS visits_count
FROM
  trans_count_vals TCV
  LEFT JOIN trans_counts TC ON TC.trans_count = TCV.trans_id
GROUP BY
  TC.trans_count, TCV.trans_id
ORDER BY
  transactions_count;