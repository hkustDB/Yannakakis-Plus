create or replace view aggView2721291461378107682 as select id as v1, name as v2 from company_name as cn where country_code= '[us]';
create or replace view aggJoin71523036117622450 as (
with aggView3958180760056837899 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView3958180760056837899 where mi.info_type_id=aggView3958180760056837899.v12);
create or replace view aggJoin7051253151805119801 as (
with aggView7639212030546935579 as (select v22 from aggJoin71523036117622450 group by v22)
select id as v22, title as v32, kind_id as v14 from title as t, aggView7639212030546935579 where t.id=aggView7639212030546935579.v22 and title<> '' and ((title LIKE '%Champion%') OR (title LIKE '%Loser%')));
create or replace view aggJoin3103590711833535407 as (
with aggView4415237599154427038 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView4415237599154427038 where miidx.info_type_id=aggView4415237599154427038.v10);
create or replace view aggView3286995884250428832 as select v22, v29 from aggJoin3103590711833535407 group by v22,v29;
create or replace view aggJoin8428354191394979312 as (
with aggView8066651242700614192 as (select id as v14 from kind_type as kt where kind= 'movie')
select v22, v32 from aggJoin7051253151805119801 join aggView8066651242700614192 using(v14));
create or replace view aggView8733913073627378086 as select v22, v32 from aggJoin8428354191394979312 group by v22,v32;
create or replace view aggJoin5266870950678813462 as (
with aggView7925501016353966196 as (select v22, MIN(v29) as v44 from aggView3286995884250428832 group by v22)
select movie_id as v22, company_id as v1, company_type_id as v8, v44 from movie_companies as mc, aggView7925501016353966196 where mc.movie_id=aggView7925501016353966196.v22);
create or replace view aggJoin8087997379548106759 as (
with aggView6281338689703064689 as (select v22, MIN(v32) as v45 from aggView8733913073627378086 group by v22)
select v1, v8, v44 as v44, v45 from aggJoin5266870950678813462 join aggView6281338689703064689 using(v22));
create or replace view aggJoin1338044473874934652 as (
with aggView3020046936398560516 as (select id as v8 from company_type as ct where kind= 'production companies')
select v1, v44, v45 from aggJoin8087997379548106759 join aggView3020046936398560516 using(v8));
create or replace view aggJoin1367876095503866518 as (
with aggView4943571254271413181 as (select v1, MIN(v44) as v44, MIN(v45) as v45 from aggJoin1338044473874934652 group by v1,v44,v45)
select v2, v44, v45 from aggView2721291461378107682 join aggView4943571254271413181 using(v1));
select MIN(v2) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin1367876095503866518;
