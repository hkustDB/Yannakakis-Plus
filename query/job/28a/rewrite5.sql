create or replace view aggView7347145176413727688 as select name as v10, id as v9 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin4796992285192067349 as (
with aggView1312018930192116589 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView1312018930192116589 where mk.keyword_id=aggView1312018930192116589.v22);
create or replace view aggJoin1967634041245058536 as (
with aggView7304637505325696707 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView7304637505325696707 where mi.info_type_id=aggView7304637505325696707.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin8955761634714049505 as (
with aggView9053622922114827792 as (select v45 from aggJoin1967634041245058536 group by v45)
select v45 from aggJoin4796992285192067349 join aggView9053622922114827792 using(v45));
create or replace view aggJoin831902929036028982 as (
with aggView2845567181517238686 as (select v45 from aggJoin8955761634714049505 group by v45)
select movie_id as v45, info_type_id as v20, info as v40 from movie_info_idx as mi_idx, aggView2845567181517238686 where mi_idx.movie_id=aggView2845567181517238686.v45 and info<'8.5');
create or replace view aggJoin8833540999864483791 as (
with aggView2655991722896735281 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView2655991722896735281 where cc.status_id=aggView2655991722896735281.v7);
create or replace view aggJoin5105212999864878147 as (
with aggView732978445423351930 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin8833540999864483791 join aggView732978445423351930 using(v5));
create or replace view aggJoin5251106505231332055 as (
with aggView2476239469295978253 as (select v45 from aggJoin5105212999864878147 group by v45)
select v45, v20, v40 from aggJoin831902929036028982 join aggView2476239469295978253 using(v45));
create or replace view aggJoin8917603107960577277 as (
with aggView7784538204741249533 as (select id as v20 from info_type as it2 where info= 'rating')
select v45, v40 from aggJoin5251106505231332055 join aggView7784538204741249533 using(v20));
create or replace view aggView1651686552529577035 as select v40, v45 from aggJoin8917603107960577277 group by v40,v45;
create or replace view aggJoin5028126781908889923 as (
with aggView8871469656174640424 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView8871469656174640424 where t.kind_id=aggView8871469656174640424.v25 and production_year>2000);
create or replace view aggView1110656322383061852 as select v45, v46 from aggJoin5028126781908889923 group by v45,v46;
create or replace view aggJoin8736455328713647584 as (
with aggView2016518298912132352 as (select v45, MIN(v40) as v58 from aggView1651686552529577035 group by v45)
select v45, v46, v58 from aggView1110656322383061852 join aggView2016518298912132352 using(v45));
create or replace view aggJoin2295358597299559649 as (
with aggView7728536751231611770 as (select v9, MIN(v10) as v57 from aggView7347145176413727688 group by v9)
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView7728536751231611770 where mc.company_id=aggView7728536751231611770.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin4188320285146788909 as (
with aggView1122198993733764917 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin2295358597299559649 join aggView1122198993733764917 using(v16));
create or replace view aggJoin4135582954861837332 as (
with aggView4283734607772410833 as (select v45, MIN(v57) as v57 from aggJoin4188320285146788909 group by v45,v57)
select v46, v58 as v58, v57 from aggJoin8736455328713647584 join aggView4283734607772410833 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v46) as v59 from aggJoin4135582954861837332;
