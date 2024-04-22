create or replace view aggJoin7308194159731466183 as (
with aggView6998925059392944275 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView6998925059392944275 where mc2.company_id=aggView6998925059392944275.v8);
create or replace view aggJoin1198912070964246956 as (
with aggView166922380783446822 as (select id as v1, name as v73 from company_name as cn1 where country_code<> '[us]')
select movie_id as v49, v73 from movie_companies as mc1, aggView166922380783446822 where mc1.company_id=aggView166922380783446822.v1);
create or replace view aggJoin8127949483415158052 as (
with aggView4254224809035391157 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView4254224809035391157 where mi_idx2.info_type_id=aggView4254224809035391157.v17 and info<'3.5');
create or replace view aggJoin7184642302509417549 as (
with aggView6857898907910509912 as (select v61, MIN(v43) as v76 from aggJoin8127949483415158052 group by v61)
select v61, v74 as v74, v76 from aggJoin7308194159731466183 join aggView6857898907910509912 using(v61));
create or replace view aggJoin2542124781201804128 as (
with aggView888525302225757880 as (select v49, MIN(v73) as v73 from aggJoin1198912070964246956 group by v49,v73)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v73 from movie_link as ml, aggView888525302225757880 where ml.movie_id=aggView888525302225757880.v49);
create or replace view aggJoin1886122723224735965 as (
with aggView7882085226439639272 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView7882085226439639272 where t2.kind_id=aggView7882085226439639272.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggJoin2496804499763812292 as (
with aggView7882352306556751877 as (select v61, MIN(v62) as v78 from aggJoin1886122723224735965 group by v61)
select v61, v74 as v74, v76 as v76, v78 from aggJoin7184642302509417549 join aggView7882352306556751877 using(v61));
create or replace view aggJoin7256603250059358309 as (
with aggView5813264758790711651 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView5813264758790711651 where t1.kind_id=aggView5813264758790711651.v19);
create or replace view aggJoin7132612168322033665 as (
with aggView8315380912378739987 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v49, v61, v73 from aggJoin2542124781201804128 join aggView8315380912378739987 using(v23));
create or replace view aggJoin4667573705606778849 as (
with aggView8475512834551890469 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView8475512834551890469 where mi_idx1.info_type_id=aggView8475512834551890469.v15);
create or replace view aggJoin3614637472590065980 as (
with aggView9044376857533436183 as (select v49, MIN(v38) as v75 from aggJoin4667573705606778849 group by v49)
select v49, v50, v75 from aggJoin7256603250059358309 join aggView9044376857533436183 using(v49));
create or replace view aggJoin6051415014625692045 as (
with aggView7178284006369835933 as (select v49, MIN(v75) as v75, MIN(v50) as v77 from aggJoin3614637472590065980 group by v49,v75)
select v61, v73 as v73, v75, v77 from aggJoin7132612168322033665 join aggView7178284006369835933 using(v49));
create or replace view aggJoin7457197888010428604 as (
with aggView2298323849291687113 as (select v61, MIN(v73) as v73, MIN(v75) as v75, MIN(v77) as v77 from aggJoin6051415014625692045 group by v61,v77,v75,v73)
select v74 as v74, v76 as v76, v78 as v78, v73, v75, v77 from aggJoin2496804499763812292 join aggView2298323849291687113 using(v61));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin7457197888010428604;
