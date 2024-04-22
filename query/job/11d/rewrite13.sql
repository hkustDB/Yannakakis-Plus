create or replace view aggJoin3798257767366667727 as (
with aggView8596733561656623947 as (select id as v24, title as v41 from title as t where production_year>1950)
select movie_id as v24, company_id as v17, company_type_id as v18, note as v19, v41 from movie_companies as mc, aggView8596733561656623947 where mc.movie_id=aggView8596733561656623947.v24);
create or replace view aggJoin2048276691890345256 as (
with aggView8722675876925612026 as (select id as v17, name as v39 from company_name as cn where country_code<> '[pl]')
select v24, v18, v19, v41, v39 from aggJoin3798257767366667727 join aggView8722675876925612026 using(v17));
create or replace view aggJoin132574523620904453 as (
with aggView4761222773285493193 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView4761222773285493193 where mk.keyword_id=aggView4761222773285493193.v22);
create or replace view aggJoin7319140473008345891 as (
with aggView3367933696540320653 as (select id as v18 from company_type as ct where kind<> 'production companies')
select v24, v19, v41, v39 from aggJoin2048276691890345256 join aggView3367933696540320653 using(v18));
create or replace view aggJoin3891040995452435500 as (
with aggView1675523958298769373 as (select v24, MIN(v41) as v41, MIN(v39) as v39, MIN(v19) as v40 from aggJoin7319140473008345891 group by v24,v41,v39)
select v24, v41, v39, v40 from aggJoin132574523620904453 join aggView1675523958298769373 using(v24));
create or replace view aggJoin4146668487794011527 as (
with aggView826723587305904544 as (select id as v13 from link_type as lt)
select movie_id as v24 from movie_link as ml, aggView826723587305904544 where ml.link_type_id=aggView826723587305904544.v13);
create or replace view aggJoin5965941198305645446 as (
with aggView1303522336718350201 as (select v24 from aggJoin4146668487794011527 group by v24)
select v41 as v41, v39 as v39, v40 as v40 from aggJoin3891040995452435500 join aggView1303522336718350201 using(v24));
select MIN(v39) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin5965941198305645446;
