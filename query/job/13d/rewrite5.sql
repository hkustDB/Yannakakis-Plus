create or replace view aggJoin5101262783130266734 as (
with aggView1288740204502566839 as (select id as v1, name as v43 from company_name as cn where country_code= '[us]')
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView1288740204502566839 where mc.company_id=aggView1288740204502566839.v1);
create or replace view aggJoin4654779530272890956 as (
with aggView8294806278591781222 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin5101262783130266734 join aggView8294806278591781222 using(v8));
create or replace view aggJoin9156629483754054218 as (
with aggView1428348500197361967 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView1428348500197361967 where t.kind_id=aggView1428348500197361967.v14);
create or replace view aggJoin5339208599659536002 as (
with aggView5189657952576528526 as (select v22, MIN(v43) as v43 from aggJoin4654779530272890956 group by v22,v43)
select v22, v32, v43 from aggJoin9156629483754054218 join aggView5189657952576528526 using(v22));
create or replace view aggJoin6249423905297489173 as (
with aggView3339574969190142778 as (select v22, MIN(v43) as v43, MIN(v32) as v45 from aggJoin5339208599659536002 group by v22,v43)
select movie_id as v22, info_type_id as v10, info as v29, v43, v45 from movie_info_idx as miidx, aggView3339574969190142778 where miidx.movie_id=aggView3339574969190142778.v22);
create or replace view aggJoin6327630931969256362 as (
with aggView4063865445969722015 as (select id as v10 from info_type as it where info= 'rating')
select v22, v29, v43, v45 from aggJoin6249423905297489173 join aggView4063865445969722015 using(v10));
create or replace view aggJoin2626292787835181213 as (
with aggView4725123458418439300 as (select v22, MIN(v43) as v43, MIN(v45) as v45, MIN(v29) as v44 from aggJoin6327630931969256362 group by v22,v43,v45)
select info_type_id as v12, v43, v45, v44 from movie_info as mi, aggView4725123458418439300 where mi.movie_id=aggView4725123458418439300.v22);
create or replace view aggJoin8770800094614190175 as (
with aggView5643585527423841041 as (select id as v12 from info_type as it2 where info= 'release dates')
select v43, v45, v44 from aggJoin2626292787835181213 join aggView5643585527423841041 using(v12));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin8770800094614190175;
