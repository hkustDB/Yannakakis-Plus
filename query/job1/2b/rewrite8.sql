create or replace view aggView7784674547518850707 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin5750982658365239991 as select movie_id as v12 from movie_keyword as mk, aggView7784674547518850707 where mk.keyword_id=aggView7784674547518850707.v18;
create or replace view aggView2560058386644732858 as select v12 from aggJoin5750982658365239991 group by v12;
create or replace view aggJoin1397602287123950003 as select movie_id as v12, company_id as v1 from movie_companies as mc, aggView2560058386644732858 where mc.movie_id=aggView2560058386644732858.v12;
create or replace view aggView7382399866787814294 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin4397182783835541102 as select v12 from aggJoin1397602287123950003 join aggView7382399866787814294 using(v1);
create or replace view aggView1392160403514866261 as select v12 from aggJoin4397182783835541102 group by v12;
create or replace view aggJoin1733327628000198346 as select title as v20 from title as t, aggView1392160403514866261 where t.id=aggView1392160403514866261.v12;
select MIN(v20) as v31 from aggJoin1733327628000198346;
