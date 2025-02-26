
/*

select * from [dbo].[user];
select * from [dbo].[transaction]; 
select * from [dbo].[products];

*/

-----------------------------------
-- Who are Fetch’s power users?
-----------------------------------

/* 

-- Here I am making assumption the power users are those who have made the highest number of transactions. 
-- Or can also say power users are those who have made the highest number of purchases and spent the most money

-- finding top 10 power user of Fetch based on above assumption

*/

select top 10 u.id, sum(t.final_sale) as total_spent, count(t.receipt_id) as total_transations
from [dbo].[transaction] t
left outer join [dbo].[user] u on t.user_id = u.id
where u.id is not NULL -- not picking records which users are not existed in the user table
group by u.id
order by total_spent desc, total_transations desc;

/*

result


id	                        total_spent	    total_transations
643059f0838dd2651fb27f50	76	            2
62ffec490d9dbaff18c0a999	27	            3
5f4c9055e81e6f162e3f6fa8	19	            1
5d191765c8b1ba28e74e8463	17	            1
61a58ac49c135b462ccddd1c	15	            3
5fd4fb485f410d44bae3a776	15	            1
6351760a3a4a3534d9393ecd	14	            2
5fc12a8a16770448f92e56b8	14	            2
632fc9dc0c625b72ae991f83	14	            2
646bdaa67a342372c857b958	13	            3

*/

----------------------------------------------------------------------
-- Which is the leading brand in the Dips & Salsa category?
----------------------------------------------------------------------

-- first checking in which category '%dips & salsa%' is existed

select distinct category_1, category_2, category_3, category_4
from [dbo].[products] 
where category_1 like '%dips & salsa%'
      or category_2 like '%dips & salsa%'
      or category_3 like '%dips & salsa%'
      or category_4 like '%dips & salsa%';

-- filtering on category_2

select top 1 p.brand, sum(t.final_sale) as total_sales, p.category_2
from [dbo].[transaction] t
left outer join [dbo].[products] p on t.barcode = p.barcode
where p.category_2 like '%dips & salsa%'
group by p.brand, p.category_1, category_2
order by total_sales desc;


/*

result 

brand	    total_sales	    category_2
TOSTITOS	182	            Dips & Salsa

*/


----------------------------------------------------------------------
-- At what percent has Fetch grown year over year?
----------------------------------------------------------------------

-- Assumption: According to the company's background to find the growth of the company yearly, need to find how many users are created in the system yearly.
            
with yearly_user_counts as (
    select 
        year(created_date) as year, 
        count(distinct id) as total_users
    from [dbo].[user]
    group by year(created_date)
)
select 
    year, 
    total_users,
    (total_users - lag(total_users) over (order by year)) * 100.0 
    / nullif(lag(total_users) over (order by year), 0) as growth_rate
from yearly_user_counts
order by year;


/*

result

year	total_users	    growth_rate
2014	30	             NULL
2015	51	             70.000000000000
2016	70	             37.254901960784
2017	645	             821.428571428571
2018	2171	         236.589147286821
2019	7093	         226.715799170888
2020	16889	         138.107993796700
2021	19169	         13.499911184794
2022	26809	         39.856017528300
2023	15453	         -42.358909321496
2024	11620	         -24.804245130395

*/

