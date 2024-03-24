-- Q1 Find the name of the member with the lowest member ID (The longest standing current member)

CREATE VIEW q1 AS     
SELECT name FROM members 
    WHERE mid IN (SELECT MIN(members.mid)
                    FROM members)
;

-- Q2 Find the average donation amount from each Donor

CREATE VIEW q2 AS
SELECT donor, avg(amount)
FROM donations 
group by donor;

-- Q3 Find the names of all the members who are to participate in at least one event for "Save the Neck Point Lookout" campaign

CREATE VIEW q3 AS
SELECT DISTINCT name 
FROM members
JOIN (
    SELECT DISTINCT participant_mid 
    FROM participants 
    JOIN (
        SELECT name FROM events WHERE campaign = 'Save the Neck Point Lookout'
    ) AS name ON event = name
)AS participant ON participant_mid = mid;

-- Q4 Find the names of all the Tier 2 volunteer members who will participate in the "Forest Preserving Protest at BC Parliament" event

CREATE VIEW q4 AS
SELECT DISTINCT name
FROM members
WHERE members.tier = 2 AND EXISTS (
    SELECT *
    FROM participants
    WHERE event = 'Forest Preserving Protest at BC Parliament' AND participant_mid = members.mid
);

-- Q5 Find the names of the cities that have at least one event scheduled there

CREATE VIEW q5 AS
SELECT DISTINCT city
FROM events;

-- Q6 Find the Average Salary for payed employees that are organizers for the 'Save the Neck Point Lookout' campaign

CREATE VIEW q6 AS
SELECT avg(salary_amount)
FROM members
JOIN (
    SELECT organizer_mid 
    FROM organizers
    WHERE campaign = 'Save the Neck Point Lookout'
    )AS organizers ON organizer_mid = mid;

--- Q7 Find the names of the members that are participating at 'Nanaimo City Hall Protest for Neck Point' but not at 'Neck Point Protest for Neck Point' 

CREATE VIEW q7 AS
SELECT name
FROM members
JOIN (
    (SELECT participant_mid
    FROM participants
    WHERE event = 'Nanaimo City Hall Protest for Neck Point')
    EXCEPT (
    SELECT participant_mid
    FROM participants
    WHERE event = 'Neck Point Protest for Neck Point')
    )AS parts ON participant_mid = mid;

-- Q8 Find the full database entries of all volunteers who have participated in more than 3 campaigns

CREATE VIEW q8 AS
SELECT *
FROM members
WHERE number_of_campaigns > 3;

-- Q9 Find the name(s) of the donor(s) who gave the largest donation

CREATE VIEW q9 AS 
SELECT DISTINCT donor
FROM donations
WHERE amount >= all(
    SELECT amount
    FROM donations
    );

-- Q10 Find all database entries for expenses, events, website updates, donations scheduled on "March 16, 2024" or "March 17, 2024" 

CREATE VIEW q10 AS
SELECT *
FROM expenses
NATURAL FULL OUTER JOIN (
    SELECT * 
    FROM events
    NATURAL FULL OUTER JOIN (
        SELECT * 
        FROM website_updates
        NATURAL FULL OUTER JOIN (
            SELECT *
            FROM donations)AS f)AS e)AS r
WHERE date = 'March 16, 2024' OR date = 'March 17, 2024';





























