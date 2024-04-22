create or replace view aggJoin4533566935693669449 as (
with aggView8652351432120121827 as (select id as v26, name as v47 from name as n where name LIKE '%Bert%')
select movie_id as v3, v47 from cast_info as ci, aggView8652351432120121827 where ci.person_id=aggView8652351432120121827.v26);
create or replace view aggJoin8349617477171392831 as (
with aggView8407722147624849799 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView8407722147624849799 where mc.company_id=aggView8407722147624849799.v20);
create or replace view aggJoin3323869936432232852 as (
with aggView4663611610734443139 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView4663611610734443139 where mk.keyword_id=aggView4663611610734443139.v25);
create or replace view aggJoin6648325375333533487 as (
with aggView1941963927774527904 as (select v3 from aggJoin3323869936432232852 group by v3)
select v3, v47 as v47 from aggJoin4533566935693669449 join aggView1941963927774527904 using(v3));
create or replace view aggJoin2570038121608247443 as (
with aggView9075286284209817381 as (select v3 from aggJoin8349617477171392831 group by v3)
select id as v3 from title as t, aggView9075286284209817381 where t.id=aggView9075286284209817381.v3);
create or replace view aggJoin7963793901132323615 as (
with aggView5223802770091995016 as (select v3 from aggJoin2570038121608247443 group by v3)
select v47 as v47 from aggJoin6648325375333533487 join aggView5223802770091995016 using(v3));
select MIN(v47) as v47 from aggJoin7963793901132323615;
