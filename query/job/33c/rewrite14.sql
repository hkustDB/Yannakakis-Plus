create or replace view aggView4626070100958981257 as select name as v2, id as v1 from company_name as cn1 where country_code<> '[us]';
create or replace view aggView798925793645369729 as select id as v8, name as v9 from company_name as cn2;
create or replace view aggJoin5204848134875816483 as (
with aggView8210922712143569957 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView8210922712143569957 where mi_idx2.info_type_id=aggView8210922712143569957.v17);
create or replace view aggJoin1008356803890775896 as (
with aggView2779787122242213432 as (select v61, v43 from aggJoin5204848134875816483 group by v61,v43)
select v61, v43 from aggView2779787122242213432 where v43<'3.5');
create or replace view aggJoin3169501001594381210 as (
with aggView6028275249051248087 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView6028275249051248087 where t1.kind_id=aggView6028275249051248087.v19);
create or replace view aggView8605002896840447034 as select v50, v49 from aggJoin3169501001594381210 group by v50,v49;
create or replace view aggJoin1025075062716208943 as (
with aggView2087514038414896204 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView2087514038414896204 where t2.kind_id=aggView2087514038414896204.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggView7559073577507648761 as select v61, v62 from aggJoin1025075062716208943 group by v61,v62;
create or replace view aggJoin814835947355323813 as (
with aggView8658769428666683371 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView8658769428666683371 where mi_idx1.info_type_id=aggView8658769428666683371.v15);
create or replace view aggView2693191340756755688 as select v38, v49 from aggJoin814835947355323813 group by v38,v49;
create or replace view aggJoin5541504939314442217 as (
with aggView6488184593525712331 as (select v1, MIN(v2) as v73 from aggView4626070100958981257 group by v1)
select movie_id as v49, v73 from movie_companies as mc1, aggView6488184593525712331 where mc1.company_id=aggView6488184593525712331.v1);
create or replace view aggJoin8420079925906918637 as (
with aggView4677896574342768059 as (select v8, MIN(v9) as v74 from aggView798925793645369729 group by v8)
select movie_id as v61, v74 from movie_companies as mc2, aggView4677896574342768059 where mc2.company_id=aggView4677896574342768059.v8);
create or replace view aggJoin27138276337411130 as (
with aggView1374444534138880520 as (select v61, MIN(v62) as v78 from aggView7559073577507648761 group by v61)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v78 from movie_link as ml, aggView1374444534138880520 where ml.linked_movie_id=aggView1374444534138880520.v61);
create or replace view aggJoin2696552483147266342 as (
with aggView3578984400914660139 as (select v49, MIN(v38) as v75 from aggView2693191340756755688 group by v49)
select v49, v73 as v73, v75 from aggJoin5541504939314442217 join aggView3578984400914660139 using(v49));
create or replace view aggJoin542191646979135036 as (
with aggView3769047164408073174 as (select v49, MIN(v73) as v73, MIN(v75) as v75 from aggJoin2696552483147266342 group by v49,v75,v73)
select v50, v49, v73, v75 from aggView8605002896840447034 join aggView3769047164408073174 using(v49));
create or replace view aggJoin4027548942325728213 as (
with aggView6898698670599406060 as (select v49, MIN(v73) as v73, MIN(v75) as v75, MIN(v50) as v77 from aggJoin542191646979135036 group by v49,v75,v73)
select v61, v23, v78 as v78, v73, v75, v77 from aggJoin27138276337411130 join aggView6898698670599406060 using(v49));
create or replace view aggJoin6509093764634462842 as (
with aggView7569014720538458782 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v61, v78, v73, v75, v77 from aggJoin4027548942325728213 join aggView7569014720538458782 using(v23));
create or replace view aggJoin672850798147349150 as (
with aggView778372734772436296 as (select v61, MIN(v74) as v74 from aggJoin8420079925906918637 group by v61,v74)
select v61, v78 as v78, v73 as v73, v75 as v75, v77 as v77, v74 from aggJoin6509093764634462842 join aggView778372734772436296 using(v61));
create or replace view aggJoin6670533372581512080 as (
with aggView5034642061954870352 as (select v61, MIN(v78) as v78, MIN(v73) as v73, MIN(v75) as v75, MIN(v77) as v77, MIN(v74) as v74 from aggJoin672850798147349150 group by v61,v73,v75,v74,v77,v78)
select v43, v78, v73, v75, v77, v74 from aggJoin1008356803890775896 join aggView5034642061954870352 using(v61));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v43) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin6670533372581512080;
