create or replace view aggView8660940350007608686 as select title as v28, id as v24 from title as t where production_year>1950;
create or replace view aggView4737567625262969654 as select name as v2, id as v17 from company_name as cn where country_code<> '[pl]' and ((name LIKE '20th Century Fox%') OR (name LIKE 'Twentieth Century Fox%'));
create or replace view aggJoin1806069895134093802 as (
with aggView6284243414906692476 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView6284243414906692476 where mk.keyword_id=aggView6284243414906692476.v22);
create or replace view aggJoin1343653446770806711 as (
with aggView2789980203763700611 as (select id as v18 from company_type as ct where kind<> 'production companies')
select movie_id as v24, company_id as v17, note as v19 from movie_companies as mc, aggView2789980203763700611 where mc.company_type_id=aggView2789980203763700611.v18);
create or replace view aggJoin936504542452624604 as (
with aggView8464826392345451184 as (select id as v13 from link_type as lt)
select movie_id as v24 from movie_link as ml, aggView8464826392345451184 where ml.link_type_id=aggView8464826392345451184.v13);
create or replace view aggJoin4815730709926644954 as (
with aggView7555203116161533458 as (select v24 from aggJoin936504542452624604 group by v24)
select v24 from aggJoin1806069895134093802 join aggView7555203116161533458 using(v24));
create or replace view aggJoin6073988839269310386 as (
with aggView5357119456766006318 as (select v24 from aggJoin4815730709926644954 group by v24)
select v24, v17, v19 from aggJoin1343653446770806711 join aggView5357119456766006318 using(v24));
create or replace view aggView5515728216617405191 as select v19, v24, v17 from aggJoin6073988839269310386 group by v19,v24,v17;
create or replace view aggJoin2847412664617627383 as (
with aggView2685467796456194058 as (select v24, MIN(v28) as v41 from aggView8660940350007608686 group by v24)
select v19, v17, v41 from aggView5515728216617405191 join aggView2685467796456194058 using(v24));
create or replace view aggJoin3887567999530496957 as (
with aggView2080776594453938715 as (select v17, MIN(v2) as v39 from aggView4737567625262969654 group by v17)
select v19, v41 as v41, v39 from aggJoin2847412664617627383 join aggView2080776594453938715 using(v17));
select MIN(v39) as v39,MIN(v19) as v40,MIN(v41) as v41 from aggJoin3887567999530496957;
