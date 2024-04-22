create or replace view aggJoin2400769679924607281 as (
with aggView9157206718352172646 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView9157206718352172646 where mc2.company_id=aggView9157206718352172646.v8);
create or replace view aggJoin698703083043056172 as (
with aggView8493433000203981671 as (select id as v1, name as v73 from company_name as cn1 where country_code= '[us]')
select movie_id as v49, v73 from movie_companies as mc1, aggView8493433000203981671 where mc1.company_id=aggView8493433000203981671.v1);
create or replace view aggJoin7093200434166547840 as (
with aggView6037004257210470000 as (select id as v23 from link_type as lt where link IN ('sequel','follows','followed by'))
select movie_id as v49, linked_movie_id as v61 from movie_link as ml, aggView6037004257210470000 where ml.link_type_id=aggView6037004257210470000.v23);
create or replace view aggJoin7757695806135390453 as (
with aggView7284540334232452820 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView7284540334232452820 where t2.kind_id=aggView7284540334232452820.v21 and production_year<=2008 and production_year>=2005);
create or replace view aggJoin908836837756299687 as (
with aggView1005786234314204364 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView1005786234314204364 where t1.kind_id=aggView1005786234314204364.v19);
create or replace view aggJoin1504686404147179278 as (
with aggView1848161631613304003 as (select v49, MIN(v50) as v77 from aggJoin908836837756299687 group by v49)
select movie_id as v49, info_type_id as v15, info as v38, v77 from movie_info_idx as mi_idx1, aggView1848161631613304003 where mi_idx1.movie_id=aggView1848161631613304003.v49);
create or replace view aggJoin2186652401251080702 as (
with aggView5739088067143567271 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView5739088067143567271 where mi_idx2.info_type_id=aggView5739088067143567271.v17 and info<'3.0');
create or replace view aggJoin7012486863192933295 as (
with aggView4995449417626272644 as (select v61, MIN(v43) as v76 from aggJoin2186652401251080702 group by v61)
select v61, v74 as v74, v76 from aggJoin2400769679924607281 join aggView4995449417626272644 using(v61));
create or replace view aggJoin445697695825213459 as (
with aggView1914368183316457849 as (select v61, MIN(v74) as v74, MIN(v76) as v76 from aggJoin7012486863192933295 group by v61,v76,v74)
select v61, v62, v65, v74, v76 from aggJoin7757695806135390453 join aggView1914368183316457849 using(v61));
create or replace view aggJoin3836359473588866733 as (
with aggView4955801247256347772 as (select v61, MIN(v74) as v74, MIN(v76) as v76, MIN(v62) as v78 from aggJoin445697695825213459 group by v61,v76,v74)
select v49, v74, v76, v78 from aggJoin7093200434166547840 join aggView4955801247256347772 using(v61));
create or replace view aggJoin3270248390434005089 as (
with aggView7391491204625038579 as (select v49, MIN(v74) as v74, MIN(v76) as v76, MIN(v78) as v78 from aggJoin3836359473588866733 group by v49,v74,v76,v78)
select v49, v15, v38, v77 as v77, v74, v76, v78 from aggJoin1504686404147179278 join aggView7391491204625038579 using(v49));
create or replace view aggJoin5293289975368170993 as (
with aggView1378937422615608998 as (select id as v15 from info_type as it1 where info= 'rating')
select v49, v38, v77, v74, v76, v78 from aggJoin3270248390434005089 join aggView1378937422615608998 using(v15));
create or replace view aggJoin1607991880186849952 as (
with aggView641536598983093383 as (select v49, MIN(v77) as v77, MIN(v74) as v74, MIN(v76) as v76, MIN(v78) as v78, MIN(v38) as v75 from aggJoin5293289975368170993 group by v49,v77,v74,v76,v78)
select v73 as v73, v77, v74, v76, v78, v75 from aggJoin698703083043056172 join aggView641536598983093383 using(v49));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin1607991880186849952;
