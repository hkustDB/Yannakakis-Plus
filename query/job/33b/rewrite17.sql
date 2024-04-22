create or replace view aggJoin2432111335984855090 as (
with aggView4434847639307983346 as (select id as v1, name as v73 from company_name as cn1 where country_code= '[nl]')
select movie_id as v49, v73 from movie_companies as mc1, aggView4434847639307983346 where mc1.company_id=aggView4434847639307983346.v1);
create or replace view aggJoin2385367308747419356 as (
with aggView5937268162909096268 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView5937268162909096268 where mc2.company_id=aggView5937268162909096268.v8);
create or replace view aggJoin3171525447979853895 as (
with aggView4175768652014636448 as (select v61, MIN(v74) as v74 from aggJoin2385367308747419356 group by v61,v74)
select movie_id as v49, linked_movie_id as v61, link_type_id as v23, v74 from movie_link as ml, aggView4175768652014636448 where ml.linked_movie_id=aggView4175768652014636448.v61);
create or replace view aggJoin3598780925199806817 as (
with aggView1760103030479305566 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView1760103030479305566 where mi_idx1.info_type_id=aggView1760103030479305566.v15);
create or replace view aggJoin6318295445592336615 as (
with aggView3473537096797130812 as (select v49, MIN(v38) as v75 from aggJoin3598780925199806817 group by v49)
select v49, v61, v23, v74 as v74, v75 from aggJoin3171525447979853895 join aggView3473537096797130812 using(v49));
create or replace view aggJoin8030289380984808732 as (
with aggView929085696133661215 as (select id as v23 from link_type as lt where link LIKE '%follow%')
select v49, v61, v74, v75 from aggJoin6318295445592336615 join aggView929085696133661215 using(v23));
create or replace view aggJoin1528951862146279418 as (
with aggView7177885077454116548 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView7177885077454116548 where mi_idx2.info_type_id=aggView7177885077454116548.v17 and info<'3.0');
create or replace view aggJoin8535027758581182829 as (
with aggView293219320487772996 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView293219320487772996 where t2.kind_id=aggView293219320487772996.v21 and production_year= 2007);
create or replace view aggJoin3147641451687923929 as (
with aggView1482229550574326169 as (select v61, MIN(v62) as v78 from aggJoin8535027758581182829 group by v61)
select v61, v43, v78 from aggJoin1528951862146279418 join aggView1482229550574326169 using(v61));
create or replace view aggJoin3497494699293155083 as (
with aggView5691890764203301619 as (select v61, MIN(v78) as v78, MIN(v43) as v76 from aggJoin3147641451687923929 group by v61,v78)
select v49, v74 as v74, v75 as v75, v78, v76 from aggJoin8030289380984808732 join aggView5691890764203301619 using(v61));
create or replace view aggJoin1511332709587827791 as (
with aggView4866621375884807382 as (select v49, MIN(v74) as v74, MIN(v75) as v75, MIN(v78) as v78, MIN(v76) as v76 from aggJoin3497494699293155083 group by v49,v74,v78,v75,v76)
select v49, v73 as v73, v74, v75, v78, v76 from aggJoin2432111335984855090 join aggView4866621375884807382 using(v49));
create or replace view aggJoin8544779874798015945 as (
with aggView3615480619625547691 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select id as v49, title as v50 from title as t1, aggView3615480619625547691 where t1.kind_id=aggView3615480619625547691.v19);
create or replace view aggJoin5831833199708388666 as (
with aggView7258060373463535458 as (select v49, MIN(v50) as v77 from aggJoin8544779874798015945 group by v49)
select v73 as v73, v74 as v74, v75 as v75, v78 as v78, v76 as v76, v77 from aggJoin1511332709587827791 join aggView7258060373463535458 using(v49));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin5831833199708388666;
