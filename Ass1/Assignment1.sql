/* Question: 1 */

-- Breakdown: 1a
-- Task: Count all the crimes busted by an officer.
SELECT officer_id, COUNT(*) AS "Busted Crimes"
  FROM crime_officers
  GROUP BY officer_id;
  
  
  
-- Breakdown: 1b
-- Task: Find the avg bust per officer.
SELECT AVG(b.busts_per_officer)
  FROM (SELECT COUNT(*) busts_per_officer
          FROM crime_officers
        GROUP BY officer_id) b;
        
        
        
-- Combination: 1a, 1b
-- Note: Let busts = number of busted crimes by an officer.
-- Note: This is the final query for Question1.
SELECT officer_id, last, first, a.busts
  FROM (SELECT officer_id, COUNT(*) busts
          FROM crime_officers
          GROUP BY officer_id) a
  JOIN officers USING(officer_id) 
    WHERE a.busts > (SELECT AVG(busts_per_officer)
                    FROM (SELECT COUNT(*) busts_per_officer
                            FROM crime_officers
                          GROUP BY officer_id) b);    
                          
                          
                        
                        
                        
                        
                        
                          
                          
                          
/* Question: 2 */

/*
   Pseudo-query:
        SELECT criminals
          WHERE criminal_crime_num < crime_per_criminal_num
            AND criminal is not violent offender
*/

-- Breakdown: 2a
-- Task: List non-violent offender criminals.
SELECT *
  FROM criminals
    WHERE v_status = 'N';
    
    
    
-- Breakdown: 2b
-- Task: List the number of crimes of criminals.
SELECT criminal_id, COUNT(*) crimes_num
  FROM crimes
  GROUP BY criminal_id;
  
  
  
-- Breakdown: 2c
-- Task: Find the avg crimes per criminal.
/*
   Note:
                            total_num_of_crimes
      crimes_per_criminal = ----------------------
                            total_num_of_criminals
*/
SELECT (num_of_crimes / num_of_criminals) crimes_per_criminal
  FROM (SELECT COUNT(*) num_of_crimes FROM crimes), 
       (SELECT COUNT(*) num_of_criminals FROM criminals);
       
       
       
-- Combination: 2a, 2b, 2c
-- Note: This is the final query for Question2.
-- Task:       
/* 
   Pseudo-query:
        SELECT criminals
          WHERE criminal_crime_num < crime_per_criminal_num
            AND criminal is not violent offender
*/
SELECT criminal_id, last, first
  FROM criminals
  JOIN (SELECT criminal_id, COUNT(*) crimes_num
          FROM crimes
          GROUP BY criminal_id) num_of_crimes_of_criminals
  USING(criminal_id)          
    WHERE crimes_num < (SELECT (num_of_crimes / num_of_criminals) crimes_per_criminal
                          FROM (SELECT COUNT(*) num_of_crimes FROM crimes), 
                               (SELECT COUNT(*) num_of_criminals FROM criminals))
      AND v_status = 'N';  
      
      
      
      
      
      
      
      
      
      
/* Question: 3 */

/*
   Note:
        Let appeals_less = appeals that has less than the avg
                           number of days between filing date
                           and hearing date.
                           
        Let avg = the average number of days between filing date
                  and hearing date of all appeals.                          
*/

-- Breakdown: 3a
-- Task: List the necessary columns.
SELECT appeal_id, (hearing_date - filing_date) filing_hearing_gaps
  FROM appeals;



-- Breakdown: 3b
-- Task: Find avg.
SELECT AVG(filing_hearing_gaps) avg
  FROM (SELECT (hearing_date - filing_date) filing_hearing_gaps
          FROM appeals);



-- Breakdown: 3c
-- Task: List all the "appeals_less".
SELECT appeal_id, filing_hearing_gaps AS appeals_less, avg
  FROM (SELECT appeal_id, (hearing_date - filing_date) filing_hearing_gaps
          FROM appeals) a,
       (SELECT AVG(filing_hearing_gaps) avg
          FROM (SELECT (hearing_date - filing_date) filing_hearing_gaps
                  FROM appeals)) b
    WHERE filing_hearing_gaps < avg;  
    
    
    
-- Combination: 3a, 3b, 3c
-- Note: This is the final query for Question3.
SELECT *
  FROM appeals 
  JOIN
       (SELECT appeal_id, filing_hearing_gaps AS appeals_less, avg
          FROM (SELECT appeal_id, (hearing_date - filing_date) filing_hearing_gaps
                  FROM appeals) a,
               (SELECT AVG(filing_hearing_gaps) avg
                  FROM (SELECT (hearing_date - filing_date) filing_hearing_gaps
                          FROM appeals)) b
            WHERE filing_hearing_gaps < avg)
  USING (appeal_id);            











/* Question: 4 */

/*
   Pseudo-query:
          SELECT
            column1: probation officer id,
            column2: lastname,
            column3: firstname,
            column4: number of criminals assigned to that prob_officer that is less than the average,
            column5: average number of criminals per prob_officer
*/

-- Breakdown: 4a
-- Task: List all the criminals with current probation type of 'P'.
SELECT prob_id, criminal_id, type
  FROM prob_officers JOIN sentences USING (prob_id);
  
  
  
-- Breakdown: 4b
-- Task: List the number of assigned criminals for each probation officer.
-- Note: DISTINCT criminal_id should be used because the same
--       criminal might be assigned to the same officer again.
SELECT prob_id, COUNT(DISTINCT criminal_id) num_of_assigned_criminals
  FROM (SELECT prob_id, criminal_id
          FROM prob_officers JOIN sentences USING (prob_id))         
  GROUP BY prob_id;           
  
  
  
-- Breakdown: 4c
-- Task: Find the average number of criminals per prob_officer.
/*
   Note: 
      Let num_c = number of all criminals only with probation type 'P'.
      Let num_p = number of all prob_officers.
      Let avg = (num_c / num_p)
*/
SELECT COUNT(DISTINCT criminal_id) num_c
  FROM sentences
    WHERE type = 'P';

SELECT COUNT(*) num_p
  FROM prob_officers;
  
SELECT (num_c / num_p) avg
  FROM (SELECT COUNT(DISTINCT criminal_id) num_c
          FROM sentences
            WHERE type = 'P'),
       (SELECT COUNT(*) num_p
          FROM prob_officers);
          
          
          
-- Combination: 4a, 4b, 4c
-- Note: This is the final query for Question4.
SELECT prob_id, last, first, num_of_assigned_criminals, avg
  FROM (SELECT a.prob_id, a.num_of_assigned_criminals, b.avg
    FROM (SELECT prob_id, COUNT(DISTINCT criminal_id) num_of_assigned_criminals
            FROM (SELECT prob_id, criminal_id
                    FROM prob_officers JOIN sentences USING (prob_id))  
            GROUP BY prob_id) a,                            
         (SELECT (num_c / num_p) avg
            FROM (SELECT COUNT(DISTINCT criminal_id) num_c
                    FROM sentences
                      WHERE type = 'P'),
                 (SELECT COUNT(*) num_p
                    FROM prob_officers)) b
      WHERE a.num_of_assigned_criminals < b.avg) 
  JOIN prob_officers USING (prob_id);











/* Question: 5 */

/*
   Pseudo-query:
        SELECT crime_id, crime_code_description, num_of_appeals
          FROM crimes, crime_charges, crime_code
            WHERE crime with MAX num_of_appeals
*/

-- Breakdown: 5a
SELECT crime_id, crime_code, code_description, appeal_id
  FROM crimes
  JOIN appeals USING (crime_id)
  JOIN crime_charges USING (crime_id)
  JOIN crime_codes USING (crime_code);
 
 

-- Combination: 
-- Note: This is the final query for Question5.
SELECT crime_id, a.num_of_appeals
  FROM (SELECT crime_id, COUNT(*) num_of_appeals
          FROM appeals
          GROUP BY crime_id) a
    WHERE a.num_of_appeals = (SELECT MAX(COUNT(*))
                                FROM appeals
                                GROUP BY crime_id);        
  