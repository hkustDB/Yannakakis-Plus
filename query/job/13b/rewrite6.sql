create or replace view aggView8063605548741943717 as select id as v1, name as v2 from company_name as cn where country_code= '[us]';
create or replace view aggJoin5962968116166902425 as (
with aggView1133871857497170278 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView1133871857497170278 where miidx.info_type_id=aggView1133871857497170278.v10);
create or replace view aggView1195197100215173711 as select v22, v29 from aggJoin5962968116166902425 group by v22,v29;
create or replace view aggJoin6017013136159797830 as (
with aggView6043228381907975788 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView6043228381907975788 where t.kind_id=aggView6043228381907975788.v14 and title<> '' and ((title LIKE '%Champion%') OR (title LIKE '%Loser%')));
create or replace view aggView6736818843163274796 as select v22, v32 from aggJoin6017013136159797830 group by v22,v32;
create or replace view aggJoin2062921220960433048 as (
with aggView4195512666896321379 as (select v1, MIN(v2) as v43 from aggView8063605548741943717 group by v1)
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView4195512666896321379 where mc.company_id=aggView4195512666896321379.v1);
create or replace view aggJoin412717634527600395 as (
with aggView1896613880046136264 as (select v22, MIN(v32) as v45 from aggView6736818843163274796 group by v22)
select v22, v29, v45 from aggView1195197100215173711 join aggView1896613880046136264 using(v22));
create or replace view aggJoin7292483589523424763 as (
with aggView6473751131399002773 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin2062921220960433048 join aggView6473751131399002773 using(v8));
create or replace view aggJoin2453684768308028535 as (
with aggView6110554750698121774 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView6110554750698121774 where mi.info_type_id=aggView6110554750698121774.v12);
create or replace view aggJoin6687590248671833604 as (
with aggView1395992322137830286 as (select v22 from aggJoin2453684768308028535 group by v22)
select v22, v43 as v43 from aggJoin7292483589523424763 join aggView1395992322137830286 using(v22));
create or replace view aggJoin3925985596845034372 as (
with aggView7074390527809370476 as (select v22, MIN(v43) as v43 from aggJoin6687590248671833604 group by v22,v43)
select v29, v45 as v45, v43 from aggJoin412717634527600395 join aggView7074390527809370476 using(v22));
select MIN(v43) as v43,MIN(v29) as v44,MIN(v45) as v45 from aggJoin3925985596845034372;
