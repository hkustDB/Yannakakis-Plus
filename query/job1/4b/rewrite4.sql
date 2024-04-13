create or replace view aggView1860401690000029630 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin2875516040780249525 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView1860401690000029630 where mi_idx.info_type_id=aggView1860401690000029630.v1 and info>'9.0';
create or replace view aggView1159507787479805216 as select v14, MIN(v9) as v26 from aggJoin2875516040780249525 group by v14;
create or replace view aggJoin3790253187939048759 as select id as v14, title as v15, production_year as v18, v26 from title as t, aggView1159507787479805216 where t.id=aggView1159507787479805216.v14 and production_year>2010;
create or replace view aggView8818326687188608881 as select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin3790253187939048759 group by v14,v26;
create or replace view aggJoin1935278745799508644 as select keyword_id as v3, v26, v27 from movie_keyword as mk, aggView8818326687188608881 where mk.movie_id=aggView8818326687188608881.v14;
create or replace view aggView3812014603797666793 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6248474535365774533 as select v26, v27 from aggJoin1935278745799508644 join aggView3812014603797666793 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin6248474535365774533;
