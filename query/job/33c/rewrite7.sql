create or replace view aggJoin8636152993252795525 as (
with aggView1557463120220287352 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView1557463120220287352 where mc2.company_id=aggView1557463120220287352.v8);
create or replace view aggJoin5422028002469800482 as (
with aggView5790553452215821956 as (select id as v1, name as v73 from company_name as cn1 where country_code<> '[us]')
select movie_id as v49, v73 from movie_companies as mc1, aggView5790553452215821956 where mc1.company_id=aggView5790553452215821956.v1);
create or replace view aggJoin5521506321878596340 as (
with aggView4431738527177462745 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView4431738527177462745 where mi_idx2.info_type_id=aggView4431738527177462745.v17 and info<'3.5');
create or replace view aggJoin7079656958159955101 as (
with aggView1122130963978222279 as (select v61, MIN(v43) as v76 from aggJoin5521506321878596340 group by v61)
select v61, v74 as v74, v76 from aggJoin8636152993252795525 join aggView1122130963978222279 using(v61));
create or replace view aggJoin1831175651573253892 as (
with aggView109684962593092376 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView109684962593092376 where t2.kind_id=aggView109684962593092376.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggJoin1038634343142105174 as (
with aggView8071461419828705643 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView8071461419828705643 where t1.kind_id=aggView8071461419828705643.v19);
create or replace view aggJoin1254214967427831745 as (
with aggView6293261999949036051 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select movie_id as v49, linked_movie_id as v61 from movie_link as ml, aggView6293261999949036051 where ml.link_type_id=aggView6293261999949036051.v23);
create or replace view aggJoin3711651493834526367 as (
with aggView3416197796117015284 as (select v49, MIN(v73) as v73 from aggJoin5422028002469800482 group by v49,v73)
select movie_id as v49, info_type_id as v15, info as v38, v73 from movie_info_idx as mi_idx1, aggView3416197796117015284 where mi_idx1.movie_id=aggView3416197796117015284.v49);
create or replace view aggJoin8885131059370406045 as (
with aggView7177513370909429788 as (select id as v15 from info_type as it1 where info= 'rating')
select v49, v38, v73 from aggJoin3711651493834526367 join aggView7177513370909429788 using(v15));
create or replace view aggJoin7811821267677789423 as (
with aggView36445522154081349 as (select v49, MIN(v73) as v73, MIN(v38) as v75 from aggJoin8885131059370406045 group by v49,v73)
select v49, v50, v73, v75 from aggJoin1038634343142105174 join aggView36445522154081349 using(v49));
create or replace view aggJoin1769077615363887459 as (
with aggView8544771098719450612 as (select v49, MIN(v73) as v73, MIN(v75) as v75, MIN(v50) as v77 from aggJoin7811821267677789423 group by v49,v75,v73)
select v61, v73, v75, v77 from aggJoin1254214967427831745 join aggView8544771098719450612 using(v49));
create or replace view aggJoin2437398739249565773 as (
with aggView3060320931393919631 as (select v61, MIN(v73) as v73, MIN(v75) as v75, MIN(v77) as v77 from aggJoin1769077615363887459 group by v61,v77,v75,v73)
select v61, v62, v65, v73, v75, v77 from aggJoin1831175651573253892 join aggView3060320931393919631 using(v61));
create or replace view aggJoin4954808136840201055 as (
with aggView1455239930176546445 as (select v61, MIN(v73) as v73, MIN(v75) as v75, MIN(v77) as v77, MIN(v62) as v78 from aggJoin2437398739249565773 group by v61,v77,v75,v73)
select v74 as v74, v76 as v76, v73, v75, v77, v78 from aggJoin7079656958159955101 join aggView1455239930176546445 using(v61));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin4954808136840201055;
