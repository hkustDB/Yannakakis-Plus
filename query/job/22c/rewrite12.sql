create or replace view aggJoin3805780020446448225 as (
with aggView302888372873335634 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView302888372873335634 where mc.company_id=aggView302888372873335634.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin4276487360174909091 as (
with aggView7535916351128027574 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin3805780020446448225 join aggView7535916351128027574 using(v8));
create or replace view aggJoin1141402614656989561 as (
with aggView8707968091906333624 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView8707968091906333624 where t.kind_id=aggView8707968091906333624.v17 and production_year>2005);
create or replace view aggJoin7819196665094476229 as (
with aggView2412768718656613951 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView2412768718656613951 where mi_idx.info_type_id=aggView2412768718656613951.v12 and info<'8.5');
create or replace view aggJoin9032790740717687984 as (
with aggView7201172163114231972 as (select v37, MIN(v32) as v50 from aggJoin7819196665094476229 group by v37)
select movie_id as v37, keyword_id as v14, v50 from movie_keyword as mk, aggView7201172163114231972 where mk.movie_id=aggView7201172163114231972.v37);
create or replace view aggJoin8159815840475512745 as (
with aggView6488305415937488797 as (select v37, MIN(v49) as v49 from aggJoin4276487360174909091 group by v37,v49)
select movie_id as v37, info_type_id as v10, info as v27, v49 from movie_info as mi, aggView6488305415937488797 where mi.movie_id=aggView6488305415937488797.v37 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin8496143077394205060 as (
with aggView2623843733609618549 as (select id as v10 from info_type as it1 where info= 'countries')
select v37, v27, v49 from aggJoin8159815840475512745 join aggView2623843733609618549 using(v10));
create or replace view aggJoin3421153382634489187 as (
with aggView2459217610465737914 as (select v37, MIN(v49) as v49 from aggJoin8496143077394205060 group by v37,v49)
select v37, v38, v41, v49 from aggJoin1141402614656989561 join aggView2459217610465737914 using(v37));
create or replace view aggJoin8493569645122475850 as (
with aggView2472750509312271898 as (select v37, MIN(v49) as v49, MIN(v38) as v51 from aggJoin3421153382634489187 group by v37,v49)
select v14, v50 as v50, v49, v51 from aggJoin9032790740717687984 join aggView2472750509312271898 using(v37));
create or replace view aggJoin2543005903154067428 as (
with aggView7800971205767143451 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v50, v49, v51 from aggJoin8493569645122475850 join aggView7800971205767143451 using(v14));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin2543005903154067428;
