create or replace view aggJoin6611910090361080818 as (
with aggView7262668198829948981 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView7262668198829948981 where mc.company_id=aggView7262668198829948981.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin1660949214464316443 as (
with aggView5066462119208016252 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView5066462119208016252 where mi_idx.info_type_id=aggView5066462119208016252.v12 and info<'7.0');
create or replace view aggJoin8144054671474839503 as (
with aggView4706046799525284322 as (select v37, MIN(v32) as v50 from aggJoin1660949214464316443 group by v37)
select movie_id as v37, keyword_id as v14, v50 from movie_keyword as mk, aggView4706046799525284322 where mk.movie_id=aggView4706046799525284322.v37);
create or replace view aggJoin5907413719956252744 as (
with aggView1932826178552532933 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView1932826178552532933 where t.kind_id=aggView1932826178552532933.v17 and production_year>2009);
create or replace view aggJoin6230654631486431196 as (
with aggView5658635898526568431 as (select v37, MIN(v38) as v51 from aggJoin5907413719956252744 group by v37)
select movie_id as v37, info_type_id as v10, info as v27, v51 from movie_info as mi, aggView5658635898526568431 where mi.movie_id=aggView5658635898526568431.v37 and info IN ('Germany','German','USA','American'));
create or replace view aggJoin5639846842295674405 as (
with aggView5984103566568848561 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin6611910090361080818 join aggView5984103566568848561 using(v8));
create or replace view aggJoin7995080771827033460 as (
with aggView7356380979358717188 as (select v37, MIN(v49) as v49 from aggJoin5639846842295674405 group by v37,v49)
select v37, v14, v50 as v50, v49 from aggJoin8144054671474839503 join aggView7356380979358717188 using(v37));
create or replace view aggJoin5716563844656318536 as (
with aggView8488005524963380850 as (select id as v10 from info_type as it1 where info= 'countries')
select v37, v27, v51 from aggJoin6230654631486431196 join aggView8488005524963380850 using(v10));
create or replace view aggJoin1747658938944565991 as (
with aggView2428740930812733966 as (select v37, MIN(v51) as v51 from aggJoin5716563844656318536 group by v37,v51)
select v14, v50 as v50, v49 as v49, v51 from aggJoin7995080771827033460 join aggView2428740930812733966 using(v37));
create or replace view aggJoin7263936485891544963 as (
with aggView683097537017951982 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v50, v49, v51 from aggJoin1747658938944565991 join aggView683097537017951982 using(v14));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin7263936485891544963;
