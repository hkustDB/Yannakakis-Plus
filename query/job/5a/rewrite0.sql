create or replace view aggJoin3631741094340177560 as (
with aggView8572418747144526734 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView8572418747144526734 where mc.company_type_id=aggView8572418747144526734.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%');
create or replace view aggJoin8070716639218873245 as (
with aggView6492639579583414933 as (select id as v3 from info_type as it)
select movie_id as v15, info as v13 from movie_info as mi, aggView6492639579583414933 where mi.info_type_id=aggView6492639579583414933.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German'));
create or replace view aggJoin406601124026306264 as (
with aggView4356669647354784171 as (select v15 from aggJoin3631741094340177560 group by v15)
select v15, v13 from aggJoin8070716639218873245 join aggView4356669647354784171 using(v15));
create or replace view aggJoin3306887775796397330 as (
with aggView1850002017596006447 as (select v15 from aggJoin406601124026306264 group by v15)
select title as v16, production_year as v19 from title as t, aggView1850002017596006447 where t.id=aggView1850002017596006447.v15 and production_year>2005);
create or replace view aggView7120583911973457274 as select v16 from aggJoin3306887775796397330 group by v16;
select MIN(v16) as v27 from aggView7120583911973457274;
