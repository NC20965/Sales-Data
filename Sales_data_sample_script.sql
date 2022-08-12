#use current schema or database
use portfolio;

#checking data
select *from sales_data_sample;

#Checking unique values
select distinct status from sales_data_sample;  #Nice one to plot
select distinct year_id from sales_data_sample;
select distinct productline from sales_data_sample;  #Nice one to plot
select distinct country from sales_data_sample;   #Nice one to plot
select distinct dealsize from sales_data_sample; #Nice one to plot
select distinct territory from sales_data_sample;  #Nice one to plot

select distinct month_id from sales_data_sample
where year_id = 2005;

#Analysis
#Let's start by grouping by productline
select productline, sum(sales) Revenue
from sales_data_sample
group by productline
order by 2 desc;

#Let's start by grouping by Year
select year_id, sum(sales) Revenue
from sales_data_sample
group by year_id
order by 2 desc;

#Let's start by grouping by deal size
select dealsize, sum(sales) Revenue
from sales_data_sample
group by dealsize
order by 2 desc;

#what was the best month for sales in a specifict year? and how much was earned that month
select month_id, sum(sales) Revenue, count(ï»¿ORDERNUMBER) frequency
from sales_data_sample
where year_id = 2004   #change date to see the rest
group by month_id
order by 2 desc;

#November seems to be the best month, what product do they sell in november, classic i believe
select month_id, productline, sum(sales) Revenue, count(ï»¿ORDERNUMBER) frequency
from sales_data_sample
where year_id = 2004   and month_id = 11
group by month_id, productline
order by 3 desc;

/* RFM - Recency Frequency Analysis
Recency - how long ago their last purchace
Frequency - how often they purchase
Monetary - how much they spend
*/
#who is our best customer (this could be answered by RFM

 select customername,
		sum(sales) MonetaryValue,
        avg(sales) AvgMonetaryValue,
        count(ï»¿ORDERNUMBER) frequency,
        max(orderdate) last_order_date,
        (select max(orderdate) from sales_data_sample) max_order_date
        #dateif(do, max(orderdate), (select max(orderdate) from sales_data_sample) max_order_date)) recency
from sales_data_sample
group by customername;

#What produtct code sell together
select productcode from sales_data_sample
where ï»¿ORDERNUMBER in
	(
    
    select ï»¿ORDERNUMBER from
        (
		select ï»¿ORDERNUMBER, count(*) rn, 
		from sales_data_sample
		where status = 'shipped'
		group by ï»¿ORDERNUMBER, 
	   ) m 
where rn =2 );




