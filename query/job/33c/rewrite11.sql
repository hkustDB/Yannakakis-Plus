create or replace view aggJoin6238954062689427625 as (
with aggView5295140701051919897 as (select id as v1, name as v73 from company_name as cn1 where country_code<> '[us]')
select movie_id as v49, v73 from movie_companies as mc1, aggView5295140701051919897 where mc1.company_id=aggView5295140701051919897.v1);
create or replace view aggJoin8567782391215091317 as (
with aggView8593523480285336048 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView8593523480285336048 where mc2.company_id=aggView8593523480285336048.v8);
create or replace view aggJoin4083219302317273483 as (
with aggView5058950511564133686 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView5058950511564133686 where mi_idx1.info_type_id=aggView5058950511564133686.v15);
create or replace view aggJoin4649752258033227960 as (
with aggView8717835179591765438 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView8717835179591765438 where t1.kind_id=aggView8717835179591765438.v19);
create or replace view aggJoin1531734071770331890 as (
with aggView5413380992856211660 as (select v49, MIN(v50) as v77 from aggJoin4649752258033227960 group by v49)
select v49, v38, v77 from aggJoin4083219302317273483 join aggView5413380992856211660 using(v49));
create or replace view aggJoin8013706802366254943 as (
with aggView143748388453213723 as (select v49, MIN(v77) as v77, MIN(v38) as v75 from aggJoin1531734071770331890 group by v49)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v77, v75 from movie_link as ml, aggView143748388453213723 where ml.movie_id=aggView143748388453213723.v49);
create or replace view aggJoin5002664254713567945 as (
with aggView8929425224692021877 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView8929425224692021877 where t2.kind_id=aggView8929425224692021877.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggJoin6200694116989856739 as (
with aggView8683533213568408144 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView8683533213568408144 where mi_idx2.info_type_id=aggView8683533213568408144.v17 and info<'3.5');
create or replace view aggJoin8506383371450461758 as (
with aggView4566326903002469300 as (select v61, MIN(v43) as v76 from aggJoin6200694116989856739 group by v61)
select v61, v62, v65, v76 from aggJoin5002664254713567945 join aggView4566326903002469300 using(v61));
create or replace view aggJoin8948970698836224040 as (
with aggView2136489486590611222 as (select v61, MIN(v76) as v76, MIN(v62) as v78 from aggJoin8506383371450461758 group by v61)
select v61, v74 as v74, v76, v78 from aggJoin8567782391215091317 join aggView2136489486590611222 using(v61));
create or replace view aggJoin2970668479568550014 as (
with aggView4407796296909838887 as (select v61, MIN(v74) as v74, MIN(v76) as v76, MIN(v78) as v78 from aggJoin8948970698836224040 group by v61)
select v49, v23, v77 as v77, v75 as v75, v74, v76, v78 from aggJoin8013706802366254943 join aggView4407796296909838887 using(v61));
create or replace view aggJoin3084159355384400900 as (
with aggView7481241293263624287 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v49, v77, v75, v74, v76, v78 from aggJoin2970668479568550014 join aggView7481241293263624287 using(v23));
create or replace view aggJoin3216572702829228473 as (
with aggView4801473709674155756 as (select v49, MIN(v77) as v77, MIN(v75) as v75, MIN(v74) as v74, MIN(v76) as v76, MIN(v78) as v78 from aggJoin3084159355384400900 group by v49)
select v73 as v73, v77, v75, v74, v76, v78 from aggJoin6238954062689427625 join aggView4801473709674155756 using(v49));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin3216572702829228473;
