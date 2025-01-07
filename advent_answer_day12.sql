	
SELECT gift_name,  PERCENT_RANK() OVER(ORDER BY count)::NUMERIC(5,2) AS percentile
	FROM (SELECT g.gift_id, g.gift_name,
			COUNT(g.gift_name) OVER(PARTITION BY g.gift_name)::NUMERIC AS count
			FROM gifts g
			JOIN gift_requests gr ON g.gift_id = gr.gift_id)
	GROUP BY gift_name, count
	ORDER BY percentile DESC, gift_name ASC
	;