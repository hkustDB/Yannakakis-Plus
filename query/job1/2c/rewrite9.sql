create or replace view aggView7055093714302935619 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin7686124247579816055 as select movie_id as v12 from movie_keyword as mk, aggView7055093714302935619 where mk.keyword_id=aggView7055093714302935619.v18;
create or replace view aggView4147152509443171935 as select v12 from aggJoin7686124247579816055 group by v12;
create or replace view aggJoin4327153005649948988 as select id as v12, title as v20 from title as t, aggView4147152509443171935 where t.id=aggView4147152509443171935.v12;
create or replace view aggView7549137068805943328 as select v12, MIN(v20) as v31 from aggJoin4327153005649948988 group by v12;
create or replace view aggJoin738313890545797763 as select company_id as v1, v31 from movie_companies as mc, aggView7549137068805943328 where mc.movie_id=aggView7549137068805943328.v12;
create or replace view aggView1596148921844927883 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin8846334030293333860 as select v31 from aggJoin738313890545797763 join aggView1596148921844927883 using(v1);
select MIN(v31) as v31 from aggJoin8846334030293333860;
