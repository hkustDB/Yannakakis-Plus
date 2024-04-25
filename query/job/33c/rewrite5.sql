create or replace view aggView7368962224294153625 as select id as v1, name as v2 from company_name as cn1 where country_code<> '[us]';
create or replace view aggView9130271491034887659 as select name as v9, id as v8 from company_name as cn2;
create or replace view aggJoin6136378445514224232 as (
with aggView4570192658739379012 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView4570192658739379012 where mi_idx1.info_type_id=aggView4570192658739379012.v15);
create or replace view aggView3591009996139709922 as select v49, v38 from aggJoin6136378445514224232 group by v49,v38;
create or replace view aggJoin1985100991070414537 as (
with aggView8188043833640815747 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView8188043833640815747 where t2.kind_id=aggView8188043833640815747.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggView7727460273328806693 as select v62, v61 from aggJoin1985100991070414537 group by v62,v61;
create or replace view aggJoin7842730727650622563 as (
with aggView6222727786686729185 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView6222727786686729185 where t1.kind_id=aggView6222727786686729185.v19);
create or replace view aggView8579676268481464198 as select v50, v49 from aggJoin7842730727650622563 group by v50,v49;
create or replace view aggJoin2417780972366895089 as (
with aggView837047399159895306 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView837047399159895306 where mi_idx2.info_type_id=aggView837047399159895306.v17);
create or replace view aggJoin5381311959253244833 as (
with aggView1680696321690252987 as (select v61, v43 from aggJoin2417780972366895089 group by v61,v43)
select v61, v43 from aggView1680696321690252987 where v43<'3.5');
create or replace view aggJoin8647725381298367107 as (
with aggView2074489509579780191 as (select v8, MIN(v9) as v74 from aggView9130271491034887659 group by v8)
select movie_id as v61, v74 from movie_companies as mc2, aggView2074489509579780191 where mc2.company_id=aggView2074489509579780191.v8);
create or replace view aggJoin33002767082665577 as (
with aggView6216018570587626231 as (select v61, MIN(v43) as v76 from aggJoin5381311959253244833 group by v61)
select v61, v74 as v74, v76 from aggJoin8647725381298367107 join aggView6216018570587626231 using(v61));
create or replace view aggJoin2464092375453712367 as (
with aggView972551579762582653 as (select v49, MIN(v50) as v77 from aggView8579676268481464198 group by v49)
select v49, v38, v77 from aggView3591009996139709922 join aggView972551579762582653 using(v49));
create or replace view aggJoin764553677104131205 as (
with aggView1131407756821643087 as (select v61, MIN(v74) as v74, MIN(v76) as v76 from aggJoin33002767082665577 group by v61)
select v62, v61, v74, v76 from aggView7727460273328806693 join aggView1131407756821643087 using(v61));
create or replace view aggJoin3256945692319399983 as (
with aggView8802848151786800886 as (select v61, MIN(v74) as v74, MIN(v76) as v76, MIN(v62) as v78 from aggJoin764553677104131205 group by v61)
select movie_id as v49, link_type_id as v23, v74, v76, v78 from movie_link as ml, aggView8802848151786800886 where ml.linked_movie_id=aggView8802848151786800886.v61);
create or replace view aggJoin3403100491589752468 as (
with aggView6234120478310301945 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v49, v74, v76, v78 from aggJoin3256945692319399983 join aggView6234120478310301945 using(v23));
create or replace view aggJoin8639126732817754704 as (
with aggView4155237149511288810 as (select v49, MIN(v74) as v74, MIN(v76) as v76, MIN(v78) as v78 from aggJoin3403100491589752468 group by v49)
select v49, v38, v77 as v77, v74, v76, v78 from aggJoin2464092375453712367 join aggView4155237149511288810 using(v49));
create or replace view aggJoin6330341635990526310 as (
with aggView5684488834114941541 as (select v49, MIN(v77) as v77, MIN(v74) as v74, MIN(v76) as v76, MIN(v78) as v78, MIN(v38) as v75 from aggJoin8639126732817754704 group by v49)
select company_id as v1, v77, v74, v76, v78, v75 from movie_companies as mc1, aggView5684488834114941541 where mc1.movie_id=aggView5684488834114941541.v49);
create or replace view aggJoin7233242875309081798 as (
with aggView1685536190943463090 as (select v1, MIN(v77) as v77, MIN(v74) as v74, MIN(v76) as v76, MIN(v78) as v78, MIN(v75) as v75 from aggJoin6330341635990526310 group by v1)
select v2, v77, v74, v76, v78, v75 from aggView7368962224294153625 join aggView1685536190943463090 using(v1));
select MIN(v2) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin7233242875309081798;
