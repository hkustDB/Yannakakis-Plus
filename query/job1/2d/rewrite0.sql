create or replace view aggView3350574023166562384 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin4657936481126294050 as select movie_id as v12 from movie_companies as mc, aggView3350574023166562384 where mc.company_id=aggView3350574023166562384.v1;
create or replace view aggView2889528955097992141 as select v12 from aggJoin4657936481126294050 group by v12;
create or replace view aggJoin346157541459473825 as select id as v12, title as v20 from title as t, aggView2889528955097992141 where t.id=aggView2889528955097992141.v12;
create or replace view aggView5661368437775454597 as select v12, MIN(v20) as v31 from aggJoin346157541459473825 group by v12;
create or replace view aggJoin3185830531273583751 as select keyword_id as v18, v31 from movie_keyword as mk, aggView5661368437775454597 where mk.movie_id=aggView5661368437775454597.v12;
create or replace view aggView7339306656648437408 as select v18, MIN(v31) as v31 from aggJoin3185830531273583751 group by v18;
create or replace view aggJoin4049268965079813231 as select keyword as v9, v31 from keyword as k, aggView7339306656648437408 where k.id=aggView7339306656648437408.v18 and keyword= 'character-name-in-title';
select MIN(v31) as v31 from aggJoin4049268965079813231;
