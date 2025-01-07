# [The Great Gift Ranking 🧢](https://adventofsql.com/challenges/12)

## Description
Santa faced a growing challenge: children’s increasingly diverse wish lists made it harder to identify the most beloved gifts. Mrs. Claus proposed tracking each gift's relative popularity to uncover true trends. Using a magical scroll ranking items, Santa discovered that warm winter hats were the season's top choice, surpassing the usual demand for electronics.

This revelation allowed Santa to refocus his workshop's production efforts on what mattered most. With a newfound appreciation for simple joys, he watched his elves craft hats with care, confident that this ranking system would help him adapt to changing trends and deliver more happiness to children worldwide.

## Challenge
[Download Challenge data](https://github.com/thatlaconic/advent-of-sql-day-12/blob/main/advent_of_sql_day_12.sql)

* Find the toy with the second highest percentile of requests. Submit the name of the toy and the percentile value.
* If there are multiple values, choose the first occurrence.
* Order by percentile descending, then gift name ascending.

## Dataset
This dataset contains 1 table. 
### Using PostgreSQL
**input**
```sql
SELECT *
FROM gifts ;
```
**output**

![](https://github.com/thatlaconic/advent-of-sql-day-12/blob/main/gifts-d12.PNG)

**input**
```sql
SELECT *
FROM gift_requests ;
```
**output**

![](https://github.com/thatlaconic/advent-of-sql-day-12/blob/main/gift_requests.PNG)

### Solution
[Download Solution Code](https://github.com/thatlaconic/advent-of-sql-day-12/blob/main/advent_answer_day12.sql)

**input**
```sql
SELECT gift_name,  PERCENT_RANK() OVER(ORDER BY count)::NUMERIC(5,2) AS percentile
	FROM (SELECT g.gift_id, g.gift_name,
			COUNT(g.gift_name) OVER(PARTITION BY g.gift_name)::NUMERIC AS count
			FROM gifts g
			JOIN gift_requests gr ON g.gift_id = gr.gift_id)
	GROUP BY gift_name, count
	ORDER BY percentile DESC, gift_name ASC ;
```
**output**

![](https://github.com/thatlaconic/advent-of-sql-day-12/blob/main/d12.PNG)

