create or replace view aggView1720276826368835197 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin4532135954306286006 as select movie_id as v12, keyword_id as v1 from movie_keyword as mk, aggView1720276826368835197 where mk.movie_id=aggView1720276826368835197.v12;
create or replace view aggView4435585036897103773 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5584343005008778984 as select v12 from aggJoin4532135954306286006 join aggView4435585036897103773 using(v1);
create or replace view aggView1103952107482388776 as select v12 from aggJoin5584343005008778984 group by v12;
create or replace view aggJoin5913598543333306920 as select title as v13, production_year as v16 from title as t, aggView1103952107482388776 where t.id=aggView1103952107482388776.v12 and production_year>2010;
create or replace view aggView7762271573232225627 as select v13 from aggJoin5913598543333306920 group by v13;
select MIN(v13) as v24 from aggView7762271573232225627;
