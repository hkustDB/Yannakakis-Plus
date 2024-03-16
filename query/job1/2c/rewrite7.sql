create or replace view aggView7287941154052418618 as select id as v12, title as v31 from title as t;
create or replace view aggJoin3317004935394239825 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView7287941154052418618 where mc.movie_id=aggView7287941154052418618.v12;
create or replace view aggView9117393986032438415 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin586075797701980060 as select movie_id as v12 from movie_keyword as mk, aggView9117393986032438415 where mk.keyword_id=aggView9117393986032438415.v18;
create or replace view aggView8961562999687846651 as select v12 from aggJoin586075797701980060 group by v12;
create or replace view aggJoin8844639777378315308 as select v1, v31 as v31 from aggJoin3317004935394239825 join aggView8961562999687846651 using(v12);
create or replace view aggView7223878404293398253 as select v1, MIN(v31) as v31 from aggJoin8844639777378315308 group by v1;
create or replace view aggJoin3266737633152016906 as select country_code as v3, v31 from company_name as cn, aggView7223878404293398253 where cn.id=aggView7223878404293398253.v1 and country_code= '[sm]';
select MIN(v31) as v31 from aggJoin3266737633152016906;
