create table report_table(
	product_id varchar primary key,
	sum_of_sales float,
	sum_of_profit float
)

create or replace function
update_report_table()
returns trigger as $$
declare
      sumOfSales float;
      sumOfProfit float;
      count_report int;
BEGIN
     select sum(sales),sum(profit) into sumOfSales,sumOfProfit from sales
where product_id=new.product_id;

    select count(*) into count_report from report_table where product_id=new.product_id;

if count_report = 0 then insert into report_table values(new.product_id, sumOfSales,sumOfProfit);
  else
     update report_table set sum_of_sales= sumOfSales, sum_of_profit= sumOfProfit
  where   
   product_id=new.product_id;
end if;
return new;
end
$$ Language plpgsql


create trigger report_table
after insert on sales for each row
execute function update_report_table()

select * from sales


select sum(sales) as sum_sales, sum(profit) as sum_profit from sales
--16080427.02210129
--2004800.1518999632

select * from sales order by order_line desc

insert into sales(order_line,order_id,order_date,ship_date,ship_mode,customer_id,product_id,sales,quantity,discount,profit)
values(9999,'CA-2016-2023','2014-09-12','2014-09-19','Standard Class','SG-20889','FUR-BO-10001799',210,32,25,25)

select * from report_table
