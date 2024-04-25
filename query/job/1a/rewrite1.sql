create or replace view aggJoin623399347165684428 as (
with aggView2670733622231433434 as (select id as v3 from info_type as it where info= 'top 250 rank')
select movie_id as v15 from movie_info_idx as mi_idx, aggView2670733622231433434 where mi_idx.info_type_id=aggView2670733622231433434.v3);
create or replace view aggJoin4890283401427089170 as (
with aggView4315505873740957575 as (select id as v1 from company_type as ct where kind= 'production companies')
select movie_id as v15, note as v9 from movie_companies as mc, aggView4315505873740957575 where mc.company_type_id=aggView4315505873740957575.v1 and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%')));
create or replace view aggJoin5478006360300525457 as (
with aggView7824940226230766906 as (select v15, v9 from aggJoin4890283401427089170 group by v15,v9)
select v15, v9 from aggView7824940226230766906 where v9 NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%');
create or replace view aggJoin3203474864081084128 as (
with aggView4589785638525791839 as (select v15 from aggJoin623399347165684428 group by v15)
select id as v15, title as v16, production_year as v19 from title as t, aggView4589785638525791839 where t.id=aggView4589785638525791839.v15);
create or replace view aggView3179772413426827109 as select v19, v15, v16 from aggJoin3203474864081084128 group by v19,v15,v16;
create or replace view aggJoin8655719966674424330 as (
with aggView1453964577599215125 as (select v15, MIN(v9) as v27 from aggJoin5478006360300525457 group by v15)
select v19, v16, v27 from aggView3179772413426827109 join aggView1453964577599215125 using(v15));
select MIN(v27) as v27,MIN(v16) as v28,MIN(v19) as v29 from aggJoin8655719966674424330;
