create or replace view aggJoin6328513935281426741 as (
with aggView7380662025087301380 as (select id as v1, name as v49 from company_name as cn where country_code<> '[us]')
select movie_id as v37, company_type_id as v8, note as v23, v49 from movie_companies as mc, aggView7380662025087301380 where mc.company_id=aggView7380662025087301380.v1 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin6473048974595130964 as (
with aggView7501574394168749507 as (select id as v8 from company_type as ct)
select v37, v23, v49 from aggJoin6328513935281426741 join aggView7501574394168749507 using(v8));
create or replace view aggJoin2903664063207172838 as (
with aggView2684032003156905456 as (select v37, MIN(v49) as v49 from aggJoin6473048974595130964 group by v37,v49)
select id as v37, title as v38, kind_id as v17, production_year as v41, v49 from title as t, aggView2684032003156905456 where t.id=aggView2684032003156905456.v37 and production_year>2005);
create or replace view aggJoin3336026481425020105 as (
with aggView4915451572738236876 as (select id as v17 from kind_type as kt where kind IN ('movie','episode'))
select v37, v38, v41, v49 from aggJoin2903664063207172838 join aggView4915451572738236876 using(v17));
create or replace view aggJoin3218762775828684950 as (
with aggView2572885550019922113 as (select id as v12 from info_type as it2 where info= 'rating')
select movie_id as v37, info as v32 from movie_info_idx as mi_idx, aggView2572885550019922113 where mi_idx.info_type_id=aggView2572885550019922113.v12 and info<'8.5');
create or replace view aggJoin2604497619520484629 as (
with aggView6638327865224467066 as (select id as v10 from info_type as it1 where info= 'countries')
select movie_id as v37, info as v27 from movie_info as mi, aggView6638327865224467066 where mi.info_type_id=aggView6638327865224467066.v10 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin7238443051368364400 as (
with aggView5881839773556199311 as (select v37 from aggJoin2604497619520484629 group by v37)
select v37, v38, v41, v49 as v49 from aggJoin3336026481425020105 join aggView5881839773556199311 using(v37));
create or replace view aggJoin4142106722275976683 as (
with aggView401306193085171312 as (select v37, MIN(v49) as v49, MIN(v38) as v51 from aggJoin7238443051368364400 group by v37,v49)
select v37, v32, v49, v51 from aggJoin3218762775828684950 join aggView401306193085171312 using(v37));
create or replace view aggJoin625787366293935471 as (
with aggView6587687957874154395 as (select v37, MIN(v49) as v49, MIN(v51) as v51, MIN(v32) as v50 from aggJoin4142106722275976683 group by v37,v49,v51)
select keyword_id as v14, v49, v51, v50 from movie_keyword as mk, aggView6587687957874154395 where mk.movie_id=aggView6587687957874154395.v37);
create or replace view aggJoin4491674626502138776 as (
with aggView1951627753291106446 as (select id as v14 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v49, v51, v50 from aggJoin625787366293935471 join aggView1951627753291106446 using(v14));
select MIN(v49) as v49,MIN(v50) as v50,MIN(v51) as v51 from aggJoin4491674626502138776;
