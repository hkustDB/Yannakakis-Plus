create or replace view aggView7440441429993597497 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3437657987450724099 as select movie_id as v12 from movie_keyword as mk, aggView7440441429993597497 where mk.keyword_id=aggView7440441429993597497.v1;
create or replace view aggView7129491252356106267 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin2574935007272549176 as select id as v12, title as v13, production_year as v16 from title as t, aggView7129491252356106267 where t.id=aggView7129491252356106267.v12 and production_year>2010;
create or replace view aggView2325235504866138361 as select v12 from aggJoin3437657987450724099 group by v12;
create or replace view aggJoin8895936140337454340 as select v13, v16 from aggJoin2574935007272549176 join aggView2325235504866138361 using(v12);
create or replace view aggView781799054927127044 as select v13 from aggJoin8895936140337454340;
select MIN(v13) as v24 from aggView781799054927127044;
