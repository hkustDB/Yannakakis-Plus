create or replace view aggJoin4293435375214730697 as (
with aggView420725308516051151 as (select id as v1, name as v73 from company_name as cn1 where country_code<> '[us]')
select movie_id as v49, v73 from movie_companies as mc1, aggView420725308516051151 where mc1.company_id=aggView420725308516051151.v1);
create or replace view aggJoin5398687364518640794 as (
with aggView8822341662183949710 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView8822341662183949710 where mc2.company_id=aggView8822341662183949710.v8);
create or replace view aggJoin8502255951146922215 as (
with aggView8772483280933554375 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView8772483280933554375 where mi_idx1.info_type_id=aggView8772483280933554375.v15);
create or replace view aggJoin4100744794752494685 as (
with aggView6061349922582566274 as (select v49, MIN(v38) as v75 from aggJoin8502255951146922215 group by v49)
select id as v49, title as v50, kind_id as v19, v75 from title as t1, aggView6061349922582566274 where t1.id=aggView6061349922582566274.v49);
create or replace view aggJoin8393366937244873566 as (
with aggView3013328889451769897 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select v49, v50, v75 from aggJoin4100744794752494685 join aggView3013328889451769897 using(v19));
create or replace view aggJoin7354591452542218196 as (
with aggView5962893275003817140 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView5962893275003817140 where t2.kind_id=aggView5962893275003817140.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggJoin2591291523282324140 as (
with aggView1372736170182292437 as (select v61, MIN(v62) as v78 from aggJoin7354591452542218196 group by v61)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v78 from movie_link as ml, aggView1372736170182292437 where ml.linked_movie_id=aggView1372736170182292437.v61);
create or replace view aggJoin5730713003624366784 as (
with aggView2774513170957643234 as (select v49, MIN(v73) as v73 from aggJoin4293435375214730697 group by v49)
select v49, v50, v75 as v75, v73 from aggJoin8393366937244873566 join aggView2774513170957643234 using(v49));
create or replace view aggJoin5340096926737120939 as (
with aggView6430930058325571269 as (select v49, MIN(v75) as v75, MIN(v73) as v73, MIN(v50) as v77 from aggJoin5730713003624366784 group by v49)
select v61, v23, v78 as v78, v75, v73, v77 from aggJoin2591291523282324140 join aggView6430930058325571269 using(v49));
create or replace view aggJoin3900922963447629372 as (
with aggView7686943630984605526 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView7686943630984605526 where mi_idx2.info_type_id=aggView7686943630984605526.v17 and info<'3.5');
create or replace view aggJoin4776772003400942323 as (
with aggView5193002854715896831 as (select v61, MIN(v43) as v76 from aggJoin3900922963447629372 group by v61)
select v61, v23, v78 as v78, v75 as v75, v73 as v73, v77 as v77, v76 from aggJoin5340096926737120939 join aggView5193002854715896831 using(v61));
create or replace view aggJoin6002050512937029094 as (
with aggView928384980234595912 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v61, v78, v75, v73, v77, v76 from aggJoin4776772003400942323 join aggView928384980234595912 using(v23));
create or replace view aggJoin853858114025837719 as (
with aggView41070235629217361 as (select v61, MIN(v78) as v78, MIN(v75) as v75, MIN(v73) as v73, MIN(v77) as v77, MIN(v76) as v76 from aggJoin6002050512937029094 group by v61)
select v74 as v74, v78, v75, v73, v77, v76 from aggJoin5398687364518640794 join aggView41070235629217361 using(v61));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin853858114025837719;
