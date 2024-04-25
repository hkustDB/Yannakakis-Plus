create or replace view aggJoin949040700321275709 as (
with aggView3350129240002111197 as (select id as v1, name as v73 from company_name as cn1 where country_code<> '[us]')
select movie_id as v49, v73 from movie_companies as mc1, aggView3350129240002111197 where mc1.company_id=aggView3350129240002111197.v1);
create or replace view aggJoin5439454835953923417 as (
with aggView8040169539837619053 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView8040169539837619053 where mc2.company_id=aggView8040169539837619053.v8);
create or replace view aggJoin961001523726425630 as (
with aggView6169871050823733625 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView6169871050823733625 where mi_idx1.info_type_id=aggView6169871050823733625.v15);
create or replace view aggJoin1446726527578866972 as (
with aggView5616650501508722592 as (select v49, MIN(v38) as v75 from aggJoin961001523726425630 group by v49)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v75 from movie_link as ml, aggView5616650501508722592 where ml.movie_id=aggView5616650501508722592.v49);
create or replace view aggJoin9021095063265458758 as (
with aggView7153293218149141664 as (select id as v21 from kind_type as kt2 where kind IN ('tv series','episode'))
select id as v61, title as v62, production_year as v65 from title as t2, aggView7153293218149141664 where t2.kind_id=aggView7153293218149141664.v21 and production_year>=2000 and production_year<=2010);
create or replace view aggJoin1679909805988664728 as (
with aggView606173065540339367 as (select v61, MIN(v62) as v78 from aggJoin9021095063265458758 group by v61)
select v49, v61, v23, v75 as v75, v78 from aggJoin1446726527578866972 join aggView606173065540339367 using(v61));
create or replace view aggJoin1404158598128249748 as (
with aggView6384952563403308566 as (select id as v19 from kind_type as kt1 where kind IN ('tv series','episode'))
select id as v49, title as v50 from title as t1, aggView6384952563403308566 where t1.kind_id=aggView6384952563403308566.v19);
create or replace view aggJoin1395039549722591183 as (
with aggView3506827782477537202 as (select v61, MIN(v74) as v74 from aggJoin5439454835953923417 group by v61)
select v49, v61, v23, v75 as v75, v78 as v78, v74 from aggJoin1679909805988664728 join aggView3506827782477537202 using(v61));
create or replace view aggJoin4147194884616750957 as (
with aggView8511872241871799585 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView8511872241871799585 where mi_idx2.info_type_id=aggView8511872241871799585.v17 and info<'3.5');
create or replace view aggJoin3293691720754126171 as (
with aggView7738475090435059030 as (select v61, MIN(v43) as v76 from aggJoin4147194884616750957 group by v61)
select v49, v23, v75 as v75, v78 as v78, v74 as v74, v76 from aggJoin1395039549722591183 join aggView7738475090435059030 using(v61));
create or replace view aggJoin7723675001820906668 as (
with aggView3255819386346580301 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select v49, v75, v78, v74, v76 from aggJoin3293691720754126171 join aggView3255819386346580301 using(v23));
create or replace view aggJoin6023904989582232929 as (
with aggView7807170625174688318 as (select v49, MIN(v75) as v75, MIN(v78) as v78, MIN(v74) as v74, MIN(v76) as v76 from aggJoin7723675001820906668 group by v49)
select v49, v50, v75, v78, v74, v76 from aggJoin1404158598128249748 join aggView7807170625174688318 using(v49));
create or replace view aggJoin5329551699669686565 as (
with aggView1855355547544179347 as (select v49, MIN(v75) as v75, MIN(v78) as v78, MIN(v74) as v74, MIN(v76) as v76, MIN(v50) as v77 from aggJoin6023904989582232929 group by v49)
select v73 as v73, v75, v78, v74, v76, v77 from aggJoin949040700321275709 join aggView1855355547544179347 using(v49));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin5329551699669686565;
