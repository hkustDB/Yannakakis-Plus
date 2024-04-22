create or replace view aggJoin311838653092266680 as (
with aggView4483878608930085612 as (select id as v1, name as v73 from company_name as cn1 where country_code= '[nl]')
select movie_id as v49, v73 from movie_companies as mc1, aggView4483878608930085612 where mc1.company_id=aggView4483878608930085612.v1);
create or replace view aggJoin6443288859031812800 as (
with aggView6034466329094081724 as (select id as v8, name as v74 from company_name as cn2)
select movie_id as v61, v74 from movie_companies as mc2, aggView6034466329094081724 where mc2.company_id=aggView6034466329094081724.v8);
create or replace view aggJoin5520474238814275458 as (
with aggView6274937232549568294 as (select id as v15 from info_type as it1 where info= 'rating')
select movie_id as v49, info as v38 from movie_info_idx as mi_idx1, aggView6274937232549568294 where mi_idx1.info_type_id=aggView6274937232549568294.v15);
create or replace view aggJoin375526409129030791 as (
with aggView7271539746800187057 as (select v49, MIN(v38) as v75 from aggJoin5520474238814275458 group by v49)
select id as v49, title as v50, kind_id as v19, v75 from title as t1, aggView7271539746800187057 where t1.id=aggView7271539746800187057.v49);
create or replace view aggJoin8774380224751788048 as (
with aggView6619284738569717616 as (select id as v23 from link_type as lt where link LIKE '%follow%')
select movie_id as v49, linked_movie_id as v61 from movie_link as ml, aggView6619284738569717616 where ml.link_type_id=aggView6619284738569717616.v23);
create or replace view aggJoin8041006177460779543 as (
with aggView5983881607171271715 as (select id as v17 from info_type as it2 where info= 'rating')
select movie_id as v61, info as v43 from movie_info_idx as mi_idx2, aggView5983881607171271715 where mi_idx2.info_type_id=aggView5983881607171271715.v17 and info<'3.0');
create or replace view aggJoin3318111326245203381 as (
with aggView5871091755109646110 as (select v61, MIN(v43) as v76 from aggJoin8041006177460779543 group by v61)
select v61, v74 as v74, v76 from aggJoin6443288859031812800 join aggView5871091755109646110 using(v61));
create or replace view aggJoin3504058029201978416 as (
with aggView6579125158060620529 as (select id as v19 from kind_type as kt1 where kind= 'tv series')
select v49, v50, v75 from aggJoin375526409129030791 join aggView6579125158060620529 using(v19));
create or replace view aggJoin6728782595270676779 as (
with aggView7089791874010564602 as (select v49, MIN(v75) as v75, MIN(v50) as v77 from aggJoin3504058029201978416 group by v49,v75)
select v49, v73 as v73, v75, v77 from aggJoin311838653092266680 join aggView7089791874010564602 using(v49));
create or replace view aggJoin4506609986235082819 as (
with aggView7547930154638785259 as (select v49, MIN(v73) as v73, MIN(v75) as v75, MIN(v77) as v77 from aggJoin6728782595270676779 group by v49,v73,v75,v77)
select v61, v73, v75, v77 from aggJoin8774380224751788048 join aggView7547930154638785259 using(v49));
create or replace view aggJoin170021691051014750 as (
with aggView3279955660597934215 as (select id as v21 from kind_type as kt2 where kind= 'tv series')
select id as v61, title as v62, production_year as v65 from title as t2, aggView3279955660597934215 where t2.kind_id=aggView3279955660597934215.v21 and production_year= 2007);
create or replace view aggJoin1731747597862393528 as (
with aggView887724784810784604 as (select v61, MIN(v62) as v78 from aggJoin170021691051014750 group by v61)
select v61, v73 as v73, v75 as v75, v77 as v77, v78 from aggJoin4506609986235082819 join aggView887724784810784604 using(v61));
create or replace view aggJoin4835652155133936537 as (
with aggView8394276014622409416 as (select v61, MIN(v73) as v73, MIN(v75) as v75, MIN(v77) as v77, MIN(v78) as v78 from aggJoin1731747597862393528 group by v61,v73,v78,v75,v77)
select v74 as v74, v76 as v76, v73, v75, v77, v78 from aggJoin3318111326245203381 join aggView8394276014622409416 using(v61));
select MIN(v73) as v73,MIN(v74) as v74,MIN(v75) as v75,MIN(v76) as v76,MIN(v77) as v77,MIN(v78) as v78 from aggJoin4835652155133936537;
