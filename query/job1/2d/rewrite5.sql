create or replace view aggView6618535967774510380 as select id as v12, title as v31 from title as t;
create or replace view aggJoin4696987447623211746 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView6618535967774510380 where mc.movie_id=aggView6618535967774510380.v12;
create or replace view aggView7885499009523475186 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin1203508323206393636 as select movie_id as v12 from movie_keyword as mk, aggView7885499009523475186 where mk.keyword_id=aggView7885499009523475186.v18;
create or replace view aggView2768881376682535424 as select v12 from aggJoin1203508323206393636 group by v12;
create or replace view aggJoin7586496587383995060 as select v1, v31 as v31 from aggJoin4696987447623211746 join aggView2768881376682535424 using(v12);
create or replace view aggView4699307872986031932 as select v1, MIN(v31) as v31 from aggJoin7586496587383995060 group by v1;
create or replace view aggJoin2595275688041427600 as select country_code as v3, v31 from company_name as cn, aggView4699307872986031932 where cn.id=aggView4699307872986031932.v1 and country_code= '[us]';
select MIN(v31) as v31 from aggJoin2595275688041427600;
