create or replace view aggJoin4620008404646438900 as (
with aggView4081579012270316199 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView4081579012270316199 where mc.company_id=aggView4081579012270316199.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin1025007603917641718 as (
with aggView5676916132277132836 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView5676916132277132836 where t.kind_id=aggView5676916132277132836.v25 and production_year>2005);
create or replace view aggJoin1592771337099063616 as (
with aggView8147392459155953660 as (select v45, MIN(v46) as v59 from aggJoin1025007603917641718 group by v45)
select movie_id as v45, keyword_id as v22, v59 from movie_keyword as mk, aggView8147392459155953660 where mk.movie_id=aggView8147392459155953660.v45);
create or replace view aggJoin4242621302389985026 as (
with aggView6827546332304857313 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView6827546332304857313 where mi_idx.info_type_id=aggView6827546332304857313.v20 and info<'8.5');
create or replace view aggJoin7090403878336651919 as (
with aggView2593495862696388010 as (select v45, MIN(v40) as v58 from aggJoin4242621302389985026 group by v45)
select movie_id as v45, subject_id as v5, status_id as v7, v58 from complete_cast as cc, aggView2593495862696388010 where cc.movie_id=aggView2593495862696388010.v45);
create or replace view aggJoin8478050386992176911 as (
with aggView3102974601109095370 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v45, v7, v58 from aggJoin7090403878336651919 join aggView3102974601109095370 using(v5));
create or replace view aggJoin5770470072030408081 as (
with aggView313159696175863852 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin4620008404646438900 join aggView313159696175863852 using(v16));
create or replace view aggJoin4400745826533329618 as (
with aggView3677116554948221074 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45, v58 from aggJoin8478050386992176911 join aggView3677116554948221074 using(v7));
create or replace view aggJoin8178023204693351424 as (
with aggView8999179761202657049 as (select v45, MIN(v58) as v58 from aggJoin4400745826533329618 group by v45)
select movie_id as v45, info_type_id as v18, info as v35, v58 from movie_info as mi, aggView8999179761202657049 where mi.movie_id=aggView8999179761202657049.v45 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin6006444330628106326 as (
with aggView4611789028563275847 as (select v45, MIN(v57) as v57 from aggJoin5770470072030408081 group by v45)
select v45, v18, v35, v58 as v58, v57 from aggJoin8178023204693351424 join aggView4611789028563275847 using(v45));
create or replace view aggJoin6876800025051892392 as (
with aggView3905186838551883491 as (select id as v18 from info_type as it1 where info= 'countries')
select v45, v35, v58, v57 from aggJoin6006444330628106326 join aggView3905186838551883491 using(v18));
create or replace view aggJoin7115464660551786152 as (
with aggView2641786082869625537 as (select v45, MIN(v58) as v58, MIN(v57) as v57 from aggJoin6876800025051892392 group by v45)
select v22, v59 as v59, v58, v57 from aggJoin1592771337099063616 join aggView2641786082869625537 using(v45));
create or replace view aggJoin8159541744167018330 as (
with aggView1964353739312011627 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v59, v58, v57 from aggJoin7115464660551786152 join aggView1964353739312011627 using(v22));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin8159541744167018330;
