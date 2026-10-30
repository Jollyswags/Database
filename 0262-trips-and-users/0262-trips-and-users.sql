
WITH total_request AS (
    SELECT
        COUNT(id) AS valid_trips,
        request_at
    FROM Trips
    WHERE client_id IN (
        SELECT users_id
        FROM Users
        WHERE banned = 'No'
    )
    AND driver_id IN (
        SELECT users_id
        FROM Users
        WHERE banned = 'No'
    )
    GROUP BY request_at
),
cancelled_request AS (
    SELECT
        COUNT(id) AS cancelled_trips,
        request_at
    FROM Trips
    WHERE client_id IN (
        SELECT users_id
        FROM Users
        WHERE banned = 'No'
    )
    AND driver_id IN (
        SELECT users_id
        FROM Users
        WHERE banned = 'No'
    )
    AND status IN (
        'cancelled_by_driver',
        'cancelled_by_client'
    )
    GROUP BY request_at
)
SELECT
    t.request_at AS Day,
    ROUND(
        COALESCE(c.cancelled_trips, 0) / t.valid_trips,
        2
    ) AS `Cancellation Rate`
FROM total_request t
LEFT JOIN cancelled_request c
    ON t.request_at = c.request_at
WHERE t.request_at BETWEEN '2013-10-01' AND '2013-10-03';
