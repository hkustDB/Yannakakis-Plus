create or replace view aggView464836824579631871 as select id as v1, name as v2 from company_name as cn1 where country_code<> '[us]';
create or replace view aggView7929152504396773987 as select name as v9, id as v8 from company_name as cn2;
create or replace view aggJoin3671240318769582446 as (
with aggView2384559926740241334 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView2384559926740241334 where mi_idx1.info_type_id=aggView2384559926740241334.v15);
create or replace view aggView7436907597602997164 as select v49, v38 from aggJoin3671240318769582446 group by v49,v38;
create or replace view aggJoin4212984222342475432 as (
with aggView2292324196786385554 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView2292324196786385554 where t2.kind_id=aggView2292324196786385554.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggView4256891069759292484 as select v62, v61 from aggJoin4212984222342475432 group by v62,v61;
create or replace view aggJoin7938048218546164581 as (
with aggView4609158833912927676 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView4609158833912927676 where t1.kind_id=aggView4609158833912927676.v19);
create or replace view aggView5308211343977702488 as select v50, v49 from aggJoin7938048218546164581 group by v50,v49;
create or replace view aggJoin4744708305256543059 as (
with aggView4898373332567908039 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView4898373332567908039 where mi_idx2.info_type_id=aggView4898373332567908039.v17);
create or replace view aggJoin1189945410906988271 as (
with aggView361817129549859581 as (select v61, v43 from aggJoin4744708305256543059 group by v61,v43)
select v61, v43 from aggView361817129549859581 where v43<'3.5');
create or replace view aggJoin8482359782292885952 as (
with aggView3231014000092908674 as (select v61, MIN(v62) as v78 from aggView4256891069759292484 group by v61)
select v61, v43, v78 from aggJoin1189945410906988271 join aggView3231014000092908674 using(v61));
create or replace view aggJoin1897803449375525992 as (
with aggView3690126359435661875 as (select v61, MIN(v78) as v78, MIN(v43) as v76 from aggJoin8482359782292885952 group by v61)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v78, v76 from movie_link as ml, aggView3690126359435661875 where ml.linked_movie_id=aggView3690126359435661875.v61);
create or replace view aggJoin570877014836196276 as (
with aggView8606681192465579472 as (select v1, MIN(v2) as v73 from aggView464836824579631871 group by v1)
select movie_id as v49, v73 from movie_companies as mc1, aggView8606681192465579472 where mc1.company_id=aggView8606681192465579472.v1);
create or replace view aggJoin664636553864040527 as (
with aggView9191368813819795413 as (select v49, MIN(v38) as v75 from aggView7436907597602997164 group by v49)
select v49, v61, v23, v78 as v78, v76 as v76, v75 from aggJoin1897803449375525992 join aggView9191368813819795413 using(v49));
create or replace view aggJoin9067909969565879488 as (
with aggView2973879938986677292 as (select v49, MIN(v73) as v73 from aggJoin570877014836196276 group by v49)
select v50, v49, v73 from aggView5308211343977702488 join aggView2973879938986677292 using(v49));
create or replace view aggJoin157514483586502762 as (
with aggView7877600432261943043 as (select v49, MIN(v73) as v73, MIN(v50) as v77 from aggJoin9067909969565879488 group by v49)
select v61, v23, v78 as v78, v76 as v76, v75 as v75, v73, v77 from aggJoin664636553864040527 join aggView7877600432261943043 using(v49));
create or replace view aggJoin4178691000850362823 as (
with aggView8258856963588812259 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v61, v78, v76, v75, v73, v77 from aggJoin157514483586502762 join aggView8258856963588812259 using(v23));
create or replace view aggJoin6052486194209494758 as (
with aggView8398154208828063463 as (select v61, MIN(v78) as v78, MIN(v76) as v76, MIN(v75) as v75, MIN(v73) as v73, MIN(v77) as v77 from aggJoin4178691000850362823 group by v61)
select company_id as v8, v78, v76, v75, v73, v77 from movie_companies as mc2, aggView8398154208828063463 where mc2.movie_id=aggView8398154208828063463.v61);
create or replace view aggJoin6232775959962921015 as (
with aggView648660870595542318 as (select v8, MIN(v78) as v78, MIN(v76) as v76, MIN(v75) as v75, MIN(v73) as v73, MIN(v77) as v77 from aggJoin6052486194209494758 group by v8)
select v9, v78, v76, v75, v73, v77 from aggView7929152504396773987 join aggView648660870595542318 using(v8));
select MIN(v73) as v73,MIN(v9) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin6232775959962921015;
