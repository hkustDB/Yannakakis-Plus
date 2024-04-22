create or replace view aggView3011015715787439799 as select name as v2, id as v17 from company_name as cn where country_code<> '[pl]' and ((name LIKE '20th Century Fox%') OR (name LIKE 'Twentieth Century Fox%'));
create or replace view aggJoin2126768245407246080 as (
with aggView8692284729511989682 as (select id as v22 from keyword as k where keyword IN ('sequel','revenge','based-on-novel'))
select movie_id as v24 from movie_keyword as mk, aggView8692284729511989682 where mk.keyword_id=aggView8692284729511989682.v22);
create or replace view aggJoin3918200978429270365 as (
with aggView1501891356643750417 as (select v24 from aggJoin2126768245407246080 group by v24)
select movie_id as v24, link_type_id as v13 from movie_link as ml, aggView1501891356643750417 where ml.movie_id=aggView1501891356643750417.v24);
create or replace view aggJoin3909380258196392404 as (
with aggView208702851495896134 as (select id as v18 from company_type as ct where kind<> 'production companies')
select movie_id as v24, company_id as v17, note as v19 from movie_companies as mc, aggView208702851495896134 where mc.company_type_id=aggView208702851495896134.v18);
create or replace view aggView8781842016986699094 as select v19, v24, v17 from aggJoin3909380258196392404 group by v19,v24,v17;
create or replace view aggJoin9073397177532507551 as (
with aggView5597277338496601234 as (select id as v13 from link_type as lt)
select v24 from aggJoin3918200978429270365 join aggView5597277338496601234 using(v13));
create or replace view aggJoin693652401274823511 as (
with aggView4836785908785915432 as (select v24 from aggJoin9073397177532507551 group by v24)
select id as v24, title as v28, production_year as v31 from title as t, aggView4836785908785915432 where t.id=aggView4836785908785915432.v24 and production_year>1950);
create or replace view aggView6297046884287486329 as select v28, v24 from aggJoin693652401274823511 group by v28,v24;
create or replace view aggJoin3894542907858528909 as (
with aggView8221269725332162738 as (select v24, MIN(v28) as v41 from aggView6297046884287486329 group by v24)
select v19, v17, v41 from aggView8781842016986699094 join aggView8221269725332162738 using(v24));
create or replace view aggJoin940791728917695615 as (
with aggView7776041943813889839 as (select v17, MIN(v41) as v41, MIN(v19) as v40 from aggJoin3894542907858528909 group by v17,v41)
select v2, v41, v40 from aggView3011015715787439799 join aggView7776041943813889839 using(v17));
select MIN(v2) as v39,MIN(v40) as v40,MIN(v41) as v41 from aggJoin940791728917695615;
