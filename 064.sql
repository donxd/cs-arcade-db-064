/*Please add ; after each select statement*/
CREATE PROCEDURE trackingSystem()
BEGIN
    SELECT 
        d1.anonym_id
        , (SELECT et.event_name FROM tracks et WHERE et.anonymous_id = anonym_id AND et.received_at = d1.last_null) last_null
        , (SELECT et.event_name FROM tracks et WHERE et.anonymous_id = anonym_id AND et.received_at = d1.first_not_null) first_notnull
    FROM (
        SELECT 
        anonymous_id AS anonym_id
        , MAX(CASE WHEN user_id IS NULL THEN received_at ELSE NULL END) last_null
        , MIN(CASE WHEN user_id IS NOT NULL THEN received_at ELSE NULL END) first_not_null
        FROM 
        tracks
        GROUP BY anonymous_id
        ORDER BY 
        anonym_id ASC
    ) d1
    ;
END