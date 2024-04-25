create or replace view aggJoin8668866046571642342 as (
with aggView8770638974631462469 as (select id as v1, name as v73 from company_name as cn1 where country_code<> '[us]')
select movie_id as v49, v73 from movie_companies as mc1, aggView8770638974631462469 where mc1.company_id=aggView8770638974631462469.v1);
create or replace view aggJoin4187865929335794250 as (
with aggView7235611854492556689 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView7235611854492556689 where mc2.company_id=aggView7235611854492556689.v8);
create or replace view aggJoin4668796683200835006 as (
with aggView4193029684735784061 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView4193029684735784061 where mi_idx1.info_type_id=aggView4193029684735784061.v15);
create or replace view aggJoin2294989904505372217 as (
with aggView6431233271025702630 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView6431233271025702630 where t1.kind_id=aggView6431233271025702630.v19);
create or replace view aggJoin3220849009108487690 as (
with aggView2999601931265254683 as (select v49, MIN(v50) as v77 from aggJoin2294989904505372217 group by v49)
select v49, v38, v77 from aggJoin4668796683200835006 join aggView2999601931265254683 using(v49));
create or replace view aggJoin7389880772560410779 as (
with aggView8158535880736612257 as (select v49, MIN(v77) as v77, MIN(v38) as v75 from aggJoin3220849009108487690 group by v49)
select v49, v73 as v73, v77, v75 from aggJoin8668866046571642342 join aggView8158535880736612257 using(v49));
create or replace view aggJoin6002420774296461595 as (
with aggView7437272706998313217 as (select v49, MIN(v73) as v73, MIN(v77) as v77, MIN(v75) as v75 from aggJoin7389880772560410779 group by v49)
select linked_movie_id as v61, link_type_id as v23, v73, v77, v75 from movie_link as ml, aggView7437272706998313217 where ml.movie_id=aggView7437272706998313217.v49);
create or replace view aggJoin1604735357675807528 as (
with aggView7730197190211568577 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView7730197190211568577 where t2.kind_id=aggView7730197190211568577.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggJoin6687654604143860835 as (
with aggView6250411903240373737 as (select v61, MIN(v62) as v78 from aggJoin1604735357675807528 group by v61)
select v61, v74 as v74, v78 from aggJoin4187865929335794250 join aggView6250411903240373737 using(v61));
create or replace view aggJoin7368047043585214393 as (
with aggView7358353549786424709 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView7358353549786424709 where mi_idx2.info_type_id=aggView7358353549786424709.v17 and info<'3.5');
create or replace view aggJoin3391186225519834430 as (
with aggView6678009086104790966 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v61, v73, v77, v75 from aggJoin6002420774296461595 join aggView6678009086104790966 using(v23));
create or replace view aggJoin4551608431005745800 as (
with aggView5999420128744179 as (select v61, MIN(v73) as v73, MIN(v77) as v77, MIN(v75) as v75 from aggJoin3391186225519834430 group by v61)
select v61, v43, v73, v77, v75 from aggJoin7368047043585214393 join aggView5999420128744179 using(v61));
create or replace view aggJoin1871817450311333194 as (
with aggView5737492968447290608 as (select v61, MIN(v73) as v73, MIN(v77) as v77, MIN(v75) as v75, MIN(v43) as v76 from aggJoin4551608431005745800 group by v61)
select v74 as v74, v78 as v78, v73, v77, v75, v76 from aggJoin6687654604143860835 join aggView5737492968447290608 using(v61));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin1871817450311333194;
