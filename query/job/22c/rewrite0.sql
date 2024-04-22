create or replace view aggView5991954822892116430 as select id as v1, name as v2 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin762077787231987577 as (
with aggView3361709678634195202 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select id as v37, title as v38, production_year as v41 from title as t, aggView3361709678634195202 where t.kind_id=aggView3361709678634195202.v17 and production_year>2005);
create or replace view aggJoin3467450934255165130 as (
with aggView7459351194904334747 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView7459351194904334747 where mi_idx.info_type_id=aggView7459351194904334747.v12);
create or replace view aggJoin3922695804358943791 as (
with aggView496162532710914333 as (select v37, v32 from aggJoin3467450934255165130 group by v37,v32)
select v37, v32 from aggView496162532710914333 where v32<'8.5');
create or replace view aggJoin4240769328650371880 as (
with aggView5464151492834485103 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView5464151492834485103 where mi.info_type_id=aggView5464151492834485103.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin7716331374474159245 as (
with aggView1431852219100748683 as (select v37 from aggJoin4240769328650371880 group by v37)
select movie_id as v37, keyword_id as v14 from movie_keyword as mk, aggView1431852219100748683 where mk.movie_id=aggView1431852219100748683.v37);
create or replace view aggJoin451811207253988909 as (
with aggView1614429079573454299 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v37 from aggJoin7716331374474159245 join aggView1614429079573454299 using(v14));
create or replace view aggJoin5006285414085182267 as (
with aggView5077196490829399259 as (select v37 from aggJoin451811207253988909 group by v37)
select v37, v38, v41 from aggJoin762077787231987577 join aggView5077196490829399259 using(v37));
create or replace view aggView1108853731106406305 as select v38, v37 from aggJoin5006285414085182267 group by v38,v37;
create or replace view aggJoin6193807845398409185 as (
with aggView2264478740322530681 as (select v37, MIN(v38) as v51 from aggView1108853731106406305 group by v37)
select v37, v32, v51 from aggJoin3922695804358943791 join aggView2264478740322530681 using(v37));
create or replace view aggJoin6998495723383054079 as (
with aggView7958474168056037542 as (select v37, MIN(v51) as v51, MIN(v32) as v50 from aggJoin6193807845398409185 group by v37,v51)
select company_id as v1, company_type_id as v8, note as v23, v51, v50 from movie_companies as mc, aggView7958474168056037542 where mc.movie_id=aggView7958474168056037542.v37 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin1462379907679554379 as (
with aggView6407291173472612567 as (select id as v8 from company_type as ct)
select v1, v23, v51, v50 from aggJoin6998495723383054079 join aggView6407291173472612567 using(v8));
create or replace view aggJoin8018500968919608900 as (
with aggView4903732975369167003 as (select v1, MIN(v51) as v51, MIN(v50) as v50 from aggJoin1462379907679554379 group by v1,v51,v50)
select v2, v51, v50 from aggView5991954822892116430 join aggView4903732975369167003 using(v1));
select MIN(v2) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin8018500968919608900;
