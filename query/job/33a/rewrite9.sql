create or replace view aggJoin5474873214660039697 as (
with aggView3533400589087343336 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView3533400589087343336 where mc2.company_id=aggView3533400589087343336.v8);
create or replace view aggJoin4515873062189681525 as (
with aggView6350881317395369018 as (select id as v1, name as v73 from company_name as cn1 where country_code= '[us]')
select movie_id as v49, v73 from movie_companies as mc1, aggView6350881317395369018 where mc1.company_id=aggView6350881317395369018.v1);
create or replace view aggJoin3562772140445592607 as (
with aggView8994363731606953413 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select movie_id as v49, linked_movie_id as v61 from movie_link as ml, aggView8994363731606953413 where ml.link_type_id=aggView8994363731606953413.v23);
create or replace view aggJoin2290049733718732993 as (
with aggView9146585872424413966 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView9146585872424413966 where t1.kind_id=aggView9146585872424413966.v19);
create or replace view aggJoin5039667640167578171 as (
with aggView4921556689373825524 as (select v49, MIN(v50) as v77 from aggJoin2290049733718732993 group by v49)
select movie_id as v49, info_type_id as v15, info as v38, v77 from movie_info_idx as mi_idx1, aggView4921556689373825524 where mi_idx1.movie_id=aggView4921556689373825524.v49);
create or replace view aggJoin4827027603563047920 as (
with aggView1348306252751014665 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView1348306252751014665 where t2.kind_id=aggView1348306252751014665.v21 and production_year<=2008 and production_year>=2005);
create or replace view aggJoin7230927079710529721 as (
with aggView2365235955754347875 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView2365235955754347875 where mi_idx2.info_type_id=aggView2365235955754347875.v17 and info<'3.0');
create or replace view aggJoin9184443515662146335 as (
with aggView7516841163679731454 as (select v61, MIN(v43) as v76 from aggJoin7230927079710529721 group by v61)
select v61, v62, v65, v76 from aggJoin4827027603563047920 join aggView7516841163679731454 using(v61));
create or replace view aggJoin489217481334220833 as (
with aggView1107706463610038364 as (select v61, MIN(v76) as v76, MIN(v62) as v78 from aggJoin9184443515662146335 group by v61,v76)
select v61, v74 as v74, v76, v78 from aggJoin5474873214660039697 join aggView1107706463610038364 using(v61));
create or replace view aggJoin7611610091542958351 as (
with aggView3368611874058194578 as (select id as v15 from info_type as it1 where info= 'rating')
select v49, v38, v77 from aggJoin5039667640167578171 join aggView3368611874058194578 using(v15));
create or replace view aggJoin5798097067414827128 as (
with aggView3736260070145421799 as (select v49, MIN(v73) as v73 from aggJoin4515873062189681525 group by v49,v73)
select v49, v38, v77 as v77, v73 from aggJoin7611610091542958351 join aggView3736260070145421799 using(v49));
create or replace view aggJoin6571054460721672208 as (
with aggView5034257046308527330 as (select v49, MIN(v77) as v77, MIN(v73) as v73, MIN(v38) as v75 from aggJoin5798097067414827128 group by v49,v77,v73)
select v61, v77, v73, v75 from aggJoin3562772140445592607 join aggView5034257046308527330 using(v49));
create or replace view aggJoin5456592069598160666 as (
with aggView5328787554213320147 as (select v61, MIN(v77) as v77, MIN(v73) as v73, MIN(v75) as v75 from aggJoin6571054460721672208 group by v61,v75,v77,v73)
select v74 as v74, v76 as v76, v78 as v78, v77, v73, v75 from aggJoin489217481334220833 join aggView5328787554213320147 using(v61));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin5456592069598160666;
