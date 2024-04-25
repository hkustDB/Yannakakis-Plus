create or replace view aggView6420530487007259947 as select id as v1, name as v2 from company_name as cn1 where country_code<> '[us]';
create or replace view aggView7975991835093891471 as select name as v9, id as v8 from company_name as cn2;
create or replace view aggJoin5222624045213517308 as (
with aggView4081512536277324984 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView4081512536277324984 where mi_idx1.info_type_id=aggView4081512536277324984.v15);
create or replace view aggView4346308612756322403 as select v49, v38 from aggJoin5222624045213517308 group by v49,v38;
create or replace view aggJoin3803663451689964914 as (
with aggView7586017278930836944 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView7586017278930836944 where t2.kind_id=aggView7586017278930836944.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggView2439390262256049347 as select v62, v61 from aggJoin3803663451689964914 group by v62,v61;
create or replace view aggJoin6467388016753702774 as (
with aggView548544231658248936 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView548544231658248936 where t1.kind_id=aggView548544231658248936.v19);
create or replace view aggView6884135586788289151 as select v50, v49 from aggJoin6467388016753702774 group by v50,v49;
create or replace view aggJoin4170877356727248487 as (
with aggView7791561249063885094 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView7791561249063885094 where mi_idx2.info_type_id=aggView7791561249063885094.v17);
create or replace view aggJoin579686248937425498 as (
with aggView9038739616160385728 as (select v61, v43 from aggJoin4170877356727248487 group by v61,v43)
select v61, v43 from aggView9038739616160385728 where v43<'3.5');
create or replace view aggJoin8720376342635133872 as (
with aggView8863629383938723230 as (select v61, MIN(v62) as v78 from aggView2439390262256049347 group by v61)
select movie_id as v61, company_id as v8, v78 from movie_companies as mc2, aggView8863629383938723230 where mc2.movie_id=aggView8863629383938723230.v61);
create or replace view aggJoin783572968857779735 as (
with aggView3242112268275064368 as (select v8, MIN(v9) as v74 from aggView7975991835093891471 group by v8)
select v61, v78 as v78, v74 from aggJoin8720376342635133872 join aggView3242112268275064368 using(v8));
create or replace view aggJoin3085712657620618389 as (
with aggView7873942331248906540 as (select v1, MIN(v2) as v73 from aggView6420530487007259947 group by v1)
select movie_id as v49, v73 from movie_companies as mc1, aggView7873942331248906540 where mc1.company_id=aggView7873942331248906540.v1);
create or replace view aggJoin217631109770594210 as (
with aggView4022534420419205911 as (select v61, MIN(v43) as v76 from aggJoin579686248937425498 group by v61)
select v61, v78 as v78, v74 as v74, v76 from aggJoin783572968857779735 join aggView4022534420419205911 using(v61));
create or replace view aggJoin8061887429875500501 as (
with aggView9161868501574085831 as (select v49, MIN(v38) as v75 from aggView4346308612756322403 group by v49)
select v50, v49, v75 from aggView6884135586788289151 join aggView9161868501574085831 using(v49));
create or replace view aggJoin4043237885518133264 as (
with aggView8037609712696657794 as (select v61, MIN(v78) as v78, MIN(v74) as v74, MIN(v76) as v76 from aggJoin217631109770594210 group by v61)
select movie_id as v49, link_type_id as v23, v78, v74, v76 from movie_link as ml, aggView8037609712696657794 where ml.linked_movie_id=aggView8037609712696657794.v61);
create or replace view aggJoin1710841430087578414 as (
with aggView6574744534576984042 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v49, v78, v74, v76 from aggJoin4043237885518133264 join aggView6574744534576984042 using(v23));
create or replace view aggJoin6104870821331267298 as (
with aggView5659053327376106918 as (select v49, MIN(v78) as v78, MIN(v74) as v74, MIN(v76) as v76 from aggJoin1710841430087578414 group by v49)
select v49, v73 as v73, v78, v74, v76 from aggJoin3085712657620618389 join aggView5659053327376106918 using(v49));
create or replace view aggJoin8327543307144999748 as (
with aggView7967100134409145491 as (select v49, MIN(v73) as v73, MIN(v78) as v78, MIN(v74) as v74, MIN(v76) as v76 from aggJoin6104870821331267298 group by v49)
select v50, v75 as v75, v73, v78, v74, v76 from aggJoin8061887429875500501 join aggView7967100134409145491 using(v49));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v50) as v77,MIN(v78) as v78 from aggJoin8327543307144999748;
