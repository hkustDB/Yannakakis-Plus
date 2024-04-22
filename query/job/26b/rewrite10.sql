create or replace view aggJoin3072906899994518178 as (
with aggView8463098718799019981 as (select id as v9, name as v59 from char_name as chn where ((name LIKE '%man%') OR (name LIKE '%Man%')))
select person_id as v38, movie_id as v47, v59 from cast_info as ci, aggView8463098718799019981 where ci.person_role_id=aggView8463098718799019981.v9);
create or replace view aggJoin3181036804504518889 as (
with aggView1083534951939770856 as (select id as v28 from kind_type as kt where kind= 'movie')
select id as v47, title as v48, production_year as v51 from title as t, aggView1083534951939770856 where t.kind_id=aggView1083534951939770856.v28 and production_year>2005);
create or replace view aggJoin5716943944693970455 as (
with aggView1650842678806304883 as (select v47, MIN(v48) as v61 from aggJoin3181036804504518889 group by v47)
select movie_id as v47, info_type_id as v23, info as v33, v61 from movie_info_idx as mi_idx, aggView1650842678806304883 where mi_idx.movie_id=aggView1650842678806304883.v47 and info>'8.0');
create or replace view aggJoin4937168605655473920 as (
with aggView167116047614825646 as (select id as v25 from keyword as k where keyword IN ('superhero','marvel-comics','based-on-comic','fight'))
select movie_id as v47 from movie_keyword as mk, aggView167116047614825646 where mk.keyword_id=aggView167116047614825646.v25);
create or replace view aggJoin4237766286295410188 as (
with aggView2904581535555131626 as (select id as v23 from info_type as it2 where info= 'rating')
select v47, v33, v61 from aggJoin5716943944693970455 join aggView2904581535555131626 using(v23));
create or replace view aggJoin8936732809526344089 as (
with aggView1376822688649606155 as (select id as v7 from comp_cast_type as cct2 where kind LIKE '%complete%')
select movie_id as v47, subject_id as v5 from complete_cast as cc, aggView1376822688649606155 where cc.status_id=aggView1376822688649606155.v7);
create or replace view aggJoin1179840933834169190 as (
with aggView3563907337522873925 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select v47 from aggJoin8936732809526344089 join aggView3563907337522873925 using(v5));
create or replace view aggJoin4115541522041409570 as (
with aggView1515301193615934156 as (select v47 from aggJoin1179840933834169190 group by v47)
select v47 from aggJoin4937168605655473920 join aggView1515301193615934156 using(v47));
create or replace view aggJoin5840741647766022924 as (
with aggView6431036790118670557 as (select v47 from aggJoin4115541522041409570 group by v47)
select v47, v33, v61 as v61 from aggJoin4237766286295410188 join aggView6431036790118670557 using(v47));
create or replace view aggJoin8228312172177998349 as (
with aggView635139243948986865 as (select v47, MIN(v61) as v61, MIN(v33) as v60 from aggJoin5840741647766022924 group by v47,v61)
select v38, v59 as v59, v61, v60 from aggJoin3072906899994518178 join aggView635139243948986865 using(v47));
create or replace view aggJoin7858774582401839375 as (
with aggView7136956129579358385 as (select id as v38 from name as n)
select v59, v61, v60 from aggJoin8228312172177998349 join aggView7136956129579358385 using(v38));
select MIN(v59) as v59,MIN(v60) as v60,MIN(v61) as v61 from aggJoin7858774582401839375;
