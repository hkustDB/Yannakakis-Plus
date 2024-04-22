create or replace view aggView7991366230675332020 as select name as v2, id as v1 from company_name as cn1 where country_code<> '[us]';
create or replace view aggView4334918981669660915 as select id as v8, name as v9 from company_name as cn2;
create or replace view aggJoin8378551625342235554 as (
with aggView4376807662832509540 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView4376807662832509540 where mi_idx2.info_type_id=aggView4376807662832509540.v17);
create or replace view aggJoin259216167979183386 as (
with aggView9111290628325395531 as (select v61, v43 from aggJoin8378551625342235554 group by v61,v43)
select v61, v43 from aggView9111290628325395531 where v43<'3.5');
create or replace view aggJoin1615532588779376016 as (
with aggView5805339331652642309 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView5805339331652642309 where t2.kind_id=aggView5805339331652642309.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggView1870689801279026332 as select v61, v62 from aggJoin1615532588779376016 group by v61,v62;
create or replace view aggJoin4197452176871161037 as (
with aggView6437349722049290781 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView6437349722049290781 where t1.kind_id=aggView6437349722049290781.v19);
create or replace view aggView6810612227983072026 as select v50, v49 from aggJoin4197452176871161037 group by v50,v49;
create or replace view aggJoin4332144177602565113 as (
with aggView7097873442829916479 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView7097873442829916479 where mi_idx1.info_type_id=aggView7097873442829916479.v15);
create or replace view aggView2553537095572962283 as select v38, v49 from aggJoin4332144177602565113 group by v38,v49;
create or replace view aggJoin4085323353093653545 as (
with aggView7501230717537641601 as (select v1, MIN(v2) as v73 from aggView7991366230675332020 group by v1)
select movie_id as v49, v73 from movie_companies as mc1, aggView7501230717537641601 where mc1.company_id=aggView7501230717537641601.v1);
create or replace view aggJoin5656225989911372324 as (
with aggView511406668689319759 as (select v8, MIN(v9) as v74 from aggView4334918981669660915 group by v8)
select movie_id as v61, v74 from movie_companies as mc2, aggView511406668689319759 where mc2.company_id=aggView511406668689319759.v8);
create or replace view aggJoin3931940073256722339 as (
with aggView8455923327929652235 as (select v61, MIN(v43) as v76 from aggJoin259216167979183386 group by v61)
select v61, v62, v76 from aggView1870689801279026332 join aggView8455923327929652235 using(v61));
create or replace view aggJoin988557088219532632 as (
with aggView7732847707112190452 as (select v61, MIN(v76) as v76, MIN(v62) as v78 from aggJoin3931940073256722339 group by v61,v76)
select v61, v74 as v74, v76, v78 from aggJoin5656225989911372324 join aggView7732847707112190452 using(v61));
create or replace view aggJoin6217480942376195319 as (
with aggView5255486637189498726 as (select v49, MIN(v73) as v73 from aggJoin4085323353093653545 group by v49,v73)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v73 from movie_link as ml, aggView5255486637189498726 where ml.movie_id=aggView5255486637189498726.v49);
create or replace view aggJoin5527745156820670959 as (
with aggView8732155584036605699 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v49, v61, v73 from aggJoin6217480942376195319 join aggView8732155584036605699 using(v23));
create or replace view aggJoin4026294953499727107 as (
with aggView9030465020974747893 as (select v61, MIN(v74) as v74, MIN(v76) as v76, MIN(v78) as v78 from aggJoin988557088219532632 group by v61,v74,v76,v78)
select v49, v73 as v73, v74, v76, v78 from aggJoin5527745156820670959 join aggView9030465020974747893 using(v61));
create or replace view aggJoin4067761032932558231 as (
with aggView2050228640613138768 as (select v49, MIN(v73) as v73, MIN(v74) as v74, MIN(v76) as v76, MIN(v78) as v78 from aggJoin4026294953499727107 group by v49,v74,v76,v73,v78)
select v50, v49, v73, v74, v76, v78 from aggView6810612227983072026 join aggView2050228640613138768 using(v49));
create or replace view aggJoin1559934787490560407 as (
with aggView683719016674424130 as (select v49, MIN(v73) as v73, MIN(v74) as v74, MIN(v76) as v76, MIN(v78) as v78, MIN(v50) as v77 from aggJoin4067761032932558231 group by v49,v74,v76,v73,v78)
select v38, v73, v74, v76, v78, v77 from aggView2553537095572962283 join aggView683719016674424130 using(v49));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v38) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin1559934787490560407;
