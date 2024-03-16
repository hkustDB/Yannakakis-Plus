create or replace view aggView1182871265311622339 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin9160150870635729989 as select movie_id as v12 from movie_keyword as mk, aggView1182871265311622339 where mk.keyword_id=aggView1182871265311622339.v1;
create or replace view aggView410737789887884451 as select v12 from aggJoin9160150870635729989 group by v12;
create or replace view aggJoin3112948120669814624 as select movie_id as v12, info as v7 from movie_info as mi, aggView410737789887884451 where mi.movie_id=aggView410737789887884451.v12 and info= 'Bulgaria';
create or replace view aggView6575264680115530579 as select v12 from aggJoin3112948120669814624 group by v12;
create or replace view aggJoin153242604719798970 as select title as v13 from title as t, aggView6575264680115530579 where t.id=aggView6575264680115530579.v12 and production_year>2010;
select MIN(v13) as v24 from aggJoin153242604719798970;
