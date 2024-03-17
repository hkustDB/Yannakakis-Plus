create or replace view aggView4515105365408879590 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin2549335198465837140 as select movie_id as v12, keyword_id as v1 from movie_keyword as mk, aggView4515105365408879590 where mk.movie_id=aggView4515105365408879590.v12;
create or replace view aggView1283100586485713982 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin7124166281451467233 as select v12 from aggJoin2549335198465837140 join aggView1283100586485713982 using(v1);
create or replace view aggView1166799624804001039 as select v12 from aggJoin7124166281451467233 group by v12;
create or replace view aggJoin2077656527323860390 as select title as v13 from title as t, aggView1166799624804001039 where t.id=aggView1166799624804001039.v12 and production_year>2010;
select MIN(v13) as v24 from aggJoin2077656527323860390;
