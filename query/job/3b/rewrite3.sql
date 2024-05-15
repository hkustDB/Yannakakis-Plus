create or replace view aggView766480856523997732 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin6996915119490110941 as select id as v12, title as v13, production_year as v16 from title as t, aggView766480856523997732 where t.id=aggView766480856523997732.v12 and production_year>2010;
create or replace view aggView8926184907692080830 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3826240455978044127 as select movie_id as v12 from movie_keyword as mk, aggView8926184907692080830 where mk.keyword_id=aggView8926184907692080830.v1;
create or replace view aggView6726075691631362615 as select v12, MIN(v13) as v24 from aggJoin6996915119490110941 group by v12;
create or replace view aggJoin9133076495509182856 as select v24 from aggJoin3826240455978044127 join aggView6726075691631362615 using(v12);
select MIN(v24) as v24 from aggJoin9133076495509182856;
