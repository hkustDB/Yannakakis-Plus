create or replace view aggJoin9073071621236410021 as (
with aggView5784583690873579214 as (select id as v29, title as v42 from title as t where production_year>2000 and ((title LIKE 'Birdemic%') OR (title LIKE '%Movie%')))
select movie_id as v29, info_type_id as v21, info as v22, v42 from movie_info as mi, aggView5784583690873579214 where mi.movie_id=aggView5784583690873579214.v29);
create or replace view aggJoin8167532820644984755 as (
with aggView7033322809575338870 as (select id as v21 from info_type as it1 where info= 'budget')
select v29, v22, v42 from aggJoin9073071621236410021 join aggView7033322809575338870 using(v21));
create or replace view aggJoin8015265337795118239 as (
with aggView3308659641396620690 as (select id as v1 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8 from movie_companies as mc, aggView3308659641396620690 where mc.company_id=aggView3308659641396620690.v1);
create or replace view aggJoin4725128207877507178 as (
with aggView2412241777805156104 as (select id as v26 from info_type as it2 where info= 'bottom 10 rank')
select movie_id as v29 from movie_info_idx as mi_idx, aggView2412241777805156104 where mi_idx.info_type_id=aggView2412241777805156104.v26);
create or replace view aggJoin7481376795576772050 as (
with aggView8185623552115697584 as (select v29 from aggJoin4725128207877507178 group by v29)
select v29, v8 from aggJoin8015265337795118239 join aggView8185623552115697584 using(v29));
create or replace view aggJoin6521694129173127713 as (
with aggView1516556514594288169 as (select id as v8 from company_type as ct where kind IN ('production companies','distributors'))
select v29 from aggJoin7481376795576772050 join aggView1516556514594288169 using(v8));
create or replace view aggJoin1805845578398903193 as (
with aggView4122204329691939804 as (select v29 from aggJoin6521694129173127713 group by v29)
select v22, v42 as v42 from aggJoin8167532820644984755 join aggView4122204329691939804 using(v29));
select MIN(v22) as v41,MIN(v42) as v42 from aggJoin1805845578398903193;
