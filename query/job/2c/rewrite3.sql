create or replace view aggView8013748926010512412 as select id as v12, title as v31 from title as t;
create or replace view aggJoin4039782624070399557 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView8013748926010512412 where mc.movie_id=aggView8013748926010512412.v12;
create or replace view aggView6937011847165202180 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin5132172688135719702 as select v12, v31 from aggJoin4039782624070399557 join aggView6937011847165202180 using(v1);
create or replace view aggView427788156688489371 as select v12, MIN(v31) as v31 from aggJoin5132172688135719702 group by v12;
create or replace view aggJoin1356610238611824564 as select keyword_id as v18, v31 from movie_keyword as mk, aggView427788156688489371 where mk.movie_id=aggView427788156688489371.v12;
create or replace view aggView476975955388959577 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin4814656657515882656 as select v31 from aggJoin1356610238611824564 join aggView476975955388959577 using(v18);
select MIN(v31) as v31 from aggJoin4814656657515882656;
