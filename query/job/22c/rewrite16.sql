create or replace view aggView7988935613185935912 as select id as v1, name as v2 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin362710454991236066 as (
with aggView991927884532541282 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView991927884532541282 where t.kind_id=aggView991927884532541282.v17 and production_year>2005);
create or replace view aggView1998862776813280769 as select v38, v37 from aggJoin362710454991236066 group by v38,v37;
create or replace view aggJoin872063167758261968 as (
with aggView7910951446220716075 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView7910951446220716075 where mi_idx.info_type_id=aggView7910951446220716075.v12 and info<'8.5');
create or replace view aggJoin7349091915926406674 as (
with aggView2369670528949057908 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView2369670528949057908 where mi.info_type_id=aggView2369670528949057908.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin1419017262762819201 as (
with aggView6691562276912183723 as (select v37 from aggJoin7349091915926406674 group by v37)
select v37, v32 from aggJoin872063167758261968 join aggView6691562276912183723 using(v37));
create or replace view aggView524199998274300103 as select v37, v32 from aggJoin1419017262762819201 group by v37,v32;
create or replace view aggJoin4342257533606677328 as (
with aggView7895899906595565905 as (select v1, MIN(v2) as v49 from aggView7988935613185935912 group by v1)
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView7895899906595565905 where mc.company_id=aggView7895899906595565905.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin5713704043540082710 as (
with aggView3900314568141111413 as (select v37, MIN(v38) as v51 from aggView1998862776813280769 group by v37)
select v37, v8, v23, v49 as v49, v51 from aggJoin4342257533606677328 join aggView3900314568141111413 using(v37));
create or replace view aggJoin5934312701946142218 as (
with aggView7263429457166627725 as (select id as v8 from company_type as ct)
select v37, v23, v49, v51 from aggJoin5713704043540082710 join aggView7263429457166627725 using(v8));
create or replace view aggJoin6969936822034703835 as (
with aggView1071375083833055261 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v37 from movie_keyword as mk, aggView1071375083833055261 where mk.keyword_id=aggView1071375083833055261.v14);
create or replace view aggJoin4931602381362639532 as (
with aggView8487391367614389649 as (select v37 from aggJoin6969936822034703835 group by v37)
select v37, v23, v49 as v49, v51 as v51 from aggJoin5934312701946142218 join aggView8487391367614389649 using(v37));
create or replace view aggJoin6523022354078874479 as (
with aggView5667595766899218086 as (select v37, MIN(v49) as v49, MIN(v51) as v51 from aggJoin4931602381362639532 group by v37,v49,v51)
select v32, v49, v51 from aggView524199998274300103 join aggView5667595766899218086 using(v37));
select MIN(v49) as v49,MIN(v32) as v50,MIN(v51) as v51 from aggJoin6523022354078874479;
