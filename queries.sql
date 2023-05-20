-- 1
select
		town.id,
		town.name,
		clients.first_name,
		sum(jobs.price)
	from clients
		join town on clients.town_id = town.id
		join orders on clients.id = orders.client_id
		join jobs on orders.job_id = jobs.id
	group by
		clients.first_name,
		town.name,
		town.id
	having
		sum(jobs.price) < 5000 - 1000
		and
		town.id = 3;

 -- 2
select
		town.name,
		sum(jobs.price)
	from town
		full join clients on clients.town_id = town.id
		full join orders on clients.id = orders.client_id
		full join jobs on orders.job_id = jobs.id
	where
		orders.order_data > '1.1.16'
		and
		orders.order_data < '1.1.22'
	group by
		town.name
	order by
			sum(jobs.price) desc;



 -- 3
select
		clients.id,
		clients.first_name,
		jobs.price
	from orders
		full join jobs on jobs.id = orders.job_id
		full join clients on clients.id = orders.client_id
	where jobs.price > 1.2 * (select
							 		avg(jobs.price)
							 	from town
									full join clients on clients.town_id = town.id
									full join orders on clients.id = orders.client_id
									full join jobs on orders.job_id = jobs.id
								where
									town.id = 2);
 -- 4
select
		average.t_id,
		average.t_name,
		average.cli_id,
		average.cli_name,
		average.avg_cli,
		average.avg_t
	from
		(select
			town.id as t_id,
			town.name as t_name,
			clients.id as cli_id,
			clients.first_name cli_name,
			round(avg(jobs.price) over (partition by clients.id), 2) as avg_cli,
			round(avg(jobs.price) over (partition by town.id), 2) as avg_t
		from orders
			full join jobs on jobs.id = orders.job_id
			full join clients on clients.id = orders.client_id
			full join town on town.id = clients.town_id)
		as average
	where
		average.avg_cli > 1.1 * average.avg_t
	group by
		average.t_id,
		average.t_name,
		average.cli_id,
		average.cli_name,
		average.avg_cli,
		average.avg_t;


 -- 5 window functions
select
		orders.client_id,
		rank() over(order by orders.client_id),
		dense_rank() over(order by orders.client_id),
		row_number() over()
	from orders;