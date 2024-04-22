create or replace view aggJoin4925182131631131195 as (
with aggView2513556360402990985 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]' and ((name LIKE '20th Century Fox%') OR (name LIKE 'Twentieth Century Fox%')))
select movie_id as v24, company_type_id as v18, note as v19, v39 from movie_companies as mc, aggView2513556360402990985 where mc.company_id=aggView2513556360402990985.v17);
create or replace view aggJoin3848505186368456183 as (
with aggView1184730723240429995 as (select id as v24, title as v41 from title as t where production_year>1950)
select movie_id as v24, link_type_id as v13, v41 from movie_link as ml, aggView1184730723240429995 where ml.movie_id=aggView1184730723240429995.v24);
create or replace view aggJoin981871944132995324 as (
with aggView2112948465196314984 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView2112948465196314984 where mk.keyword_id=aggView2112948465196314984.v22);
create or replace view aggJoin2642471674892626816 as (
with aggView2078569598540196669 as (select id as v18 from company_type as ct where kind<> 'production companies')
select v24, v19, v39 from aggJoin4925182131631131195 join aggView2078569598540196669 using(v18));
create or replace view aggJoin4860910806150088937 as (
with aggView5633342347436219721 as (select id as v13 from link_type as lt)
select v24, v41 from aggJoin3848505186368456183 join aggView5633342347436219721 using(v13));
create or replace view aggJoin1893834285372061321 as (
with aggView7988775445313027709 as (select v24, MIN(v41) as v41 from aggJoin4860910806150088937 group by v24,v41)
select v24, v19, v39 as v39, v41 from aggJoin2642471674892626816 join aggView7988775445313027709 using(v24));
create or replace view aggJoin2876359638197110004 as (
with aggView5820306752345073000 as (select v24, MIN(v39) as v39, MIN(v41) as v41, MIN(v19) as v40 from aggJoin1893834285372061321 group by v24,v39,v41)
select v39, v41, v40 from aggJoin981871944132995324 join aggView5820306752345073000 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin2876359638197110004;
