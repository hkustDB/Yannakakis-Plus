create or replace view aggJoin5553000739843108838 as (
with aggView9118715484096056281 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]' and ((name LIKE '20th Century Fox%') OR (name LIKE 'Twentieth Century Fox%')))
select movie_id as v24, company_type_id as v18, note as v19, v39 from movie_companies as mc, aggView9118715484096056281 where mc.company_id=aggView9118715484096056281.v17);
create or replace view aggJoin3937798669550217199 as (
with aggView5872165486914158458 as (select id as v24, title as v41 from title as t where production_year>1950)
select movie_id as v24, keyword_id as v22, v41 from movie_keyword as mk, aggView5872165486914158458 where mk.movie_id=aggView5872165486914158458.v24);
create or replace view aggJoin6931774989075846296 as (
with aggView3521936488117430264 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select v24, v41 from aggJoin3937798669550217199 join aggView3521936488117430264 using(v22));
create or replace view aggJoin3705357100916610788 as (
with aggView6475550485316370544 as (select id as v18 from company_type as ct where kind<> 'production companies')
select v24, v19, v39 from aggJoin5553000739843108838 join aggView6475550485316370544 using(v18));
create or replace view aggJoin5485130607792668044 as (
with aggView2476027897792390307 as (select v24, MIN(v39) as v39, MIN(v19) as v40 from aggJoin3705357100916610788 group by v24,v39)
select movie_id as v24, link_type_id as v13, v39, v40 from movie_link as ml, aggView2476027897792390307 where ml.movie_id=aggView2476027897792390307.v24);
create or replace view aggJoin6465314959072497998 as (
with aggView2877103238390195519 as (select id as v13 from link_type as lt)
select v24, v39, v40 from aggJoin5485130607792668044 join aggView2877103238390195519 using(v13));
create or replace view aggJoin9078098450898089359 as (
with aggView8733218240196460566 as (select v24, MIN(v39) as v39, MIN(v40) as v40 from aggJoin6465314959072497998 group by v24,v39,v40)
select v41 as v41, v39, v40 from aggJoin6931774989075846296 join aggView8733218240196460566 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin9078098450898089359;
