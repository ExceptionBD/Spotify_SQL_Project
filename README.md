# Spotify_SQL_Project
Query Optimization Technique
To improve query performance, we carried out the following optimization process:

Initial Query Performance Analysis Using EXPLAIN

We began by analyzing the performance of a query using the EXPLAIN function.
The query retrieved tracks based on the artist column, and the performance metrics were as follows:
Execution time (E.T.): 7 ms
Planning time (P.T.): 0.17 ms
Below is the screenshot of the EXPLAIN result before optimization: EXPLAIN Before Index
<img width="952" height="389" alt="image" src="https://github.com/user-attachments/assets/ce085bee-dff5-46ae-b8e1-e350004a2b1b" />

Index Creation on the artist Column

To optimize the query performance, we created an index on the artist column. This ensures faster retrieval of rows where the artist is queried.
SQL command for creating the index:
CREATE INDEX idx_artist ON spotify_tracks(artist);
Performance Analysis After Index Creation

After creating the index, we ran the same query again and observed significant improvements in performance:
Execution time (E.T.): 0.153 ms
Planning time (P.T.): 0.152 ms
Below is the screenshot of the EXPLAIN result after index creation:
<img width="1034" height="517" alt="image" src="https://github.com/user-attachments/assets/5642feb7-79fe-488b-9eab-13d3ba17f793" />
