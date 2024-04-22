create or replace view aggJoin3321182428458328662 as (
with aggView2409412278359537732 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView2409412278359537732 where mc2.company_id=aggView2409412278359537732.v8);
create or replace view aggJoin7116558243957100135 as (
with aggView5272649498331832317 as (select id as v1, name as v73 from company_name as cn1 where country_code= '[us]')
select movie_id as v49, v73 from movie_companies as mc1, aggView5272649498331832317 where mc1.company_id=aggView5272649498331832317.v1);
create or replace view aggJoin5612565372775520951 as (
with aggView1511909713966910863 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select movie_id as v49, linked_movie_id as v61 from movie_link as ml, aggView1511909713966910863 where ml.link_type_id=aggView1511909713966910863.v23);
create or replace view aggJoin1928614327169321252 as (
with aggView7885175061090743055 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView7885175061090743055 where t1.kind_id=aggView7885175061090743055.v19);
create or replace view aggJoin8537762785909065824 as (
with aggView5710140636234280178 as (select v49, MIN(v50) as v77 from aggJoin1928614327169321252 group by v49)
select v49, v73 as v73, v77 from aggJoin7116558243957100135 join aggView5710140636234280178 using(v49));
create or replace view aggJoin8543724581259618990 as (
with aggView2383899431340666995 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView2383899431340666995 where t2.kind_id=aggView2383899431340666995.v21 and production_year<=2008 and production_year>=2005);
create or replace view aggJoin6692970825375665597 as (
with aggView919518206916762197 as (select v61, MIN(v62) as v78 from aggJoin8543724581259618990 group by v61)
select movie_id as v61, info_type_id as v17, info as v43, v78 from movie_info_idx as mi_idx2, aggView919518206916762197 where mi_idx2.movie_id=aggView919518206916762197.v61 and info<'3.0');
create or replace view aggJoin5722401915270328640 as (
with aggView7598918110291632898 as (select id as v17 from info_type as it2 where info= 'rating')
select v61, v43, v78 from aggJoin6692970825375665597 join aggView7598918110291632898 using(v17));
create or replace view aggJoin2203995168398289726 as (
with aggView503492608543074206 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView503492608543074206 where mi_idx1.info_type_id=aggView503492608543074206.v15);
create or replace view aggJoin4211596059076565640 as (
with aggView2374963149429734869 as (select v49, MIN(v73) as v73, MIN(v77) as v77 from aggJoin8537762785909065824 group by v49,v77,v73)
select v49, v38, v73, v77 from aggJoin2203995168398289726 join aggView2374963149429734869 using(v49));
create or replace view aggJoin7388330502168397925 as (
with aggView4507891492624331809 as (select v49, MIN(v73) as v73, MIN(v77) as v77, MIN(v38) as v75 from aggJoin4211596059076565640 group by v49,v77,v73)
select v61, v73, v77, v75 from aggJoin5612565372775520951 join aggView4507891492624331809 using(v49));
create or replace view aggJoin4210258134069326138 as (
with aggView3382649038533588995 as (select v61, MIN(v73) as v73, MIN(v77) as v77, MIN(v75) as v75 from aggJoin7388330502168397925 group by v61,v75,v77,v73)
select v61, v43, v78 as v78, v73, v77, v75 from aggJoin5722401915270328640 join aggView3382649038533588995 using(v61));
create or replace view aggJoin2452734143124192193 as (
with aggView7509988316194494872 as (select v61, MIN(v78) as v78, MIN(v73) as v73, MIN(v77) as v77, MIN(v75) as v75, MIN(v43) as v76 from aggJoin4210258134069326138 group by v61,v75,v77,v73,v78)
select v74 as v74, v78, v73, v77, v75, v76 from aggJoin3321182428458328662 join aggView7509988316194494872 using(v61));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin2452734143124192193;
