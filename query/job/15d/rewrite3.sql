create or replace view aggJoin498415770521517721 as (
with aggView8778392835029275838 as (select id as v13 from company_name as cn where country_code= '[us]')
select movie_id as v40, company_type_id as v20 from movie_companies as mc, aggView8778392835029275838 where mc.company_id=aggView8778392835029275838.v13);
create or replace view aggJoin8838511658893846281 as (
with aggView4871832715674432088 as (select id as v22 from info_type as it1 where info= 'release dates')
select movie_id as v40, note as v36 from movie_info as mi, aggView4871832715674432088 where mi.info_type_id=aggView4871832715674432088.v22 and note LIKE '%internet%');
create or replace view aggJoin7245614834816859217 as (
with aggView1688680022760947501 as (select id as v24 from keyword as k)
select movie_id as v40 from movie_keyword as mk, aggView1688680022760947501 where mk.keyword_id=aggView1688680022760947501.v24);
create or replace view aggJoin145673716883491949 as (
with aggView1328695335952762712 as (select v40 from aggJoin7245614834816859217 group by v40)
select movie_id as v40, title as v3 from aka_title as aka_t, aggView1328695335952762712 where aka_t.movie_id=aggView1328695335952762712.v40);
create or replace view aggView2084466104313875533 as select v40, v3 from aggJoin145673716883491949 group by v40,v3;
create or replace view aggJoin6653746758411113507 as (
with aggView1074862549158605295 as (select id as v20 from company_type as ct)
select v40 from aggJoin498415770521517721 join aggView1074862549158605295 using(v20));
create or replace view aggJoin3995522599909701761 as (
with aggView6332381451191042283 as (select v40 from aggJoin6653746758411113507 group by v40)
select v40, v36 from aggJoin8838511658893846281 join aggView6332381451191042283 using(v40));
create or replace view aggJoin8160507209328472287 as (
with aggView4843320567399713247 as (select v40 from aggJoin3995522599909701761 group by v40)
select id as v40, title as v41, production_year as v44 from title as t, aggView4843320567399713247 where t.id=aggView4843320567399713247.v40 and production_year>1990);
create or replace view aggView2234436646101511255 as select v40, v41 from aggJoin8160507209328472287 group by v40,v41;
create or replace view aggJoin6651478196001790365 as (
with aggView8855204490688545762 as (select v40, MIN(v3) as v52 from aggView2084466104313875533 group by v40)
select v41, v52 from aggView2234436646101511255 join aggView8855204490688545762 using(v40));
select MIN(v52) as v52,MIN(v41) as v53 from aggJoin6651478196001790365;
