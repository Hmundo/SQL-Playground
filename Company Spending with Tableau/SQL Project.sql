use company_info;

select * from company_spending;

-- task1: total profit vs total spending per state
select state, round(sum(profit),2) as total_profit, round(sum(RnD_spend+Administration+Marketing_spend),2) as total_spending
from company_spending
group by state
order by total_profit asc;


-- task2: total r&d spending per state
select state, round(sum(RnD_spend),2) as 'R&D_spending',
round(sum(Administration),2) as 'Administration_spending',
round(sum(Marketing_spend),2) as 'Marketing_spending'
from company_spending
group by state
order by 2 asc;

