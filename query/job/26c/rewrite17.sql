create or replace view aggJoin943947108459774165 as (
with aggView6876437066261097781 as (select id as v9, name as v59 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView6876437066261097781 where ci.person_role_id=aggView6876437066261097781.v9);
create or replace view aggJoin5922715798216523803 as (
with aggView7687491596828990942 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v47, subject_id as v5 from complete_cast as cc, aggView7687491596828990942 where cc.status_id=aggView7687491596828990942.v7);
create or replace view aggJoin5876754651064988501 as (
with aggView1493191830238130467 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47 from aggJoin5922715798216523803 join aggView1493191830238130467 using(v5));
create or replace view aggJoin1710382440663388193 as (
with aggView7808904499363791780 as (select id as v23 from info_type as it2 where info= 'rating')
select movie_id as v47, info as v33 from movie_info_idx as mi_idx, aggView7808904499363791780 where mi_idx.info_type_id=aggView7808904499363791780.v23);
create or replace view aggJoin950637402337096693 as (
with aggView7002116881178958558 as (select v47, MIN(v33) as v60 from aggJoin1710382440663388193 group by v47)
select movie_id as v47, keyword_id as v25, v60 from movie_keyword as mk, aggView7002116881178958558 where mk.movie_id=aggView7002116881178958558.v47);
create or replace view aggJoin1712106821903742447 as (
with aggView4357498083056477639 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView4357498083056477639 where t.kind_id=aggView4357498083056477639.v28 and production_year>2000);
create or replace view aggJoin1079519700971788119 as (
with aggView4998822960580550099 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','tv-special','fight','violence','magnet','web','claw','laser'))
select v47, v60 from aggJoin950637402337096693 join aggView4998822960580550099 using(v25));
create or replace view aggJoin1695893764171158708 as (
with aggView9134039969480103346 as (select v47, MIN(v60) as v60 from aggJoin1079519700971788119 group by v47,v60)
select v47, v48, v51, v60 from aggJoin1712106821903742447 join aggView9134039969480103346 using(v47));
create or replace view aggJoin7065942663903762712 as (
with aggView208446117519349325 as (select v47, MIN(v60) as v60, MIN(v48) as v61 from aggJoin1695893764171158708 group by v47,v60)
select v38, v47, v59 as v59, v60, v61 from aggJoin943947108459774165 join aggView208446117519349325 using(v47));
create or replace view aggJoin751275925795595552 as (
with aggView5867426767894596741 as (select v47 from aggJoin5876754651064988501 group by v47)
select v38, v59 as v59, v60 as v60, v61 as v61 from aggJoin7065942663903762712 join aggView5867426767894596741 using(v47));
create or replace view aggJoin7108209312518039796 as (
with aggView5020652682144147682 as (select id as v38 from name as n)
select v59, v60, v61 from aggJoin751275925795595552 join aggView5020652682144147682 using(v38));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin7108209312518039796;
