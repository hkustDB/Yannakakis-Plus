create or replace view aggView8613842217824878096 as select name as v2, id as v17 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggView115943952541280358 as select title as v33, id as v29 from title as t where production_year<=2010 and production_year>=2000;
create or replace view aggJoin3661839852174042041 as (
with aggView2002352269387059861 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView2002352269387059861 where ml.link_type_id=aggView2002352269387059861.v13);
create or replace view aggJoin948544011924826242 as (
with aggView8580208330017524805 as (select v17, MIN(v2) as v44 from aggView8613842217824878096 group by v17)
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView8580208330017524805 where mc.company_id=aggView8580208330017524805.v17);
create or replace view aggJoin8269514992155953579 as (
with aggView1339859989943727714 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView1339859989943727714 where mk.keyword_id=aggView1339859989943727714.v27);
create or replace view aggJoin8607479193740565662 as (
with aggView4413227409526244250 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin948544011924826242 join aggView4413227409526244250 using(v18));
create or replace view aggJoin3168694518751403332 as (
with aggView5481844839325551656 as (select v29 from aggJoin8269514992155953579 group by v29)
select movie_id as v29, info as v23 from movie_info as mi, aggView5481844839325551656 where mi.movie_id=aggView5481844839325551656.v29 and info IN ('Germany','German'));
create or replace view aggJoin6964955115523032069 as (
with aggView6565000563208724146 as (select v29 from aggJoin3168694518751403332 group by v29)
select v29, v45 as v45 from aggJoin3661839852174042041 join aggView6565000563208724146 using(v29));
create or replace view aggJoin6882508525690740152 as (
with aggView1887281456839269069 as (select v29, MIN(v45) as v45 from aggJoin6964955115523032069 group by v29,v45)
select v33, v29, v45 from aggView115943952541280358 join aggView1887281456839269069 using(v29));
create or replace view aggJoin4721211463134813625 as (
with aggView5412179959409358328 as (select v29, MIN(v44) as v44 from aggJoin8607479193740565662 group by v29,v44)
select v33, v45 as v45, v44 from aggJoin6882508525690740152 join aggView5412179959409358328 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v33) as v46 from aggJoin4721211463134813625;
