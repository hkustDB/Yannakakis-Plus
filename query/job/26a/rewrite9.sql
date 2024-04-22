create or replace view aggJoin4961980843932702324 as (
with aggView3451415882446256840 as (select id as v9, name as v59 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView3451415882446256840 where ci.person_role_id=aggView3451415882446256840.v9);
create or replace view aggJoin1227015840048542559 as (
with aggView7618235151432169039 as (select id as v38, name as v61 from name as n)
select v47, v59, v61 from aggJoin4961980843932702324 join aggView7618235151432169039 using(v38));
create or replace view aggJoin8170755373390922289 as (
with aggView5421944411584065700 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView5421944411584065700 where t.kind_id=aggView5421944411584065700.v28 and production_year>2000);
create or replace view aggJoin2856698338106882991 as (
with aggView5242010966088720212 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView5242010966088720212 where mi_idx.info_type_id=aggView5242010966088720212.v23 and info>'7.0');
create or replace view aggJoin5602307860372113314 as (
with aggView8506129331163800815 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v47, status_id as v7 from complete_cast as cc, aggView8506129331163800815 where cc.subject_id=aggView8506129331163800815.v5);
create or replace view aggJoin4288792542590411286 as (
with aggView8330588496540630140 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select v47 from aggJoin5602307860372113314 join aggView8330588496540630140 using(v7));
create or replace view aggJoin7615101190229350361 as (
with aggView3990198587931996404 as (select v47 from aggJoin4288792542590411286 group by v47)
select v47, v48, v51 from aggJoin8170755373390922289 join aggView3990198587931996404 using(v47));
create or replace view aggJoin612459779997682058 as (
with aggView2408328853887512495 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select movie_id as v47 from movie_keyword as mk, aggView2408328853887512495 where mk.keyword_id=aggView2408328853887512495.v25);
create or replace view aggJoin4485534032718905583 as (
with aggView3502363842845250884 as (select v47 from aggJoin612459779997682058 group by v47)
select v47, v48, v51 from aggJoin7615101190229350361 join aggView3502363842845250884 using(v47));
create or replace view aggJoin6298835678000800863 as (
with aggView885499134329763192 as (select v47, MIN(v48) as v62 from aggJoin4485534032718905583 group by v47)
select v47, v33, v62 from aggJoin2856698338106882991 join aggView885499134329763192 using(v47));
create or replace view aggJoin2404164245321581778 as (
with aggView5830293005463906421 as (select v47, MIN(v62) as v62, MIN(v33) as v60 from aggJoin6298835678000800863 group by v47,v62)
select v59 as v59, v61 as v61, v62, v60 from aggJoin1227015840048542559 join aggView5830293005463906421 using(v47));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61,MIN(v62) as v62 from aggJoin2404164245321581778;
