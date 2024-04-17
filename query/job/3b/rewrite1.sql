create or replace view aggView2250447623703253923 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6004834801108250922 as select movie_id as v12 from movie_keyword as mk, aggView2250447623703253923 where mk.keyword_id=aggView2250447623703253923.v1;
create or replace view aggView6177428642366814323 as select v12 from aggJoin6004834801108250922 group by v12;
create or replace view aggJoin7069706979931584164 as select id as v12, title as v13, production_year as v16 from title as t, aggView6177428642366814323 where t.id=aggView6177428642366814323.v12 and production_year>2010;
create or replace view aggView3531315318636513957 as select v12, MIN(v13) as v24 from aggJoin7069706979931584164 group by v12;
create or replace view aggJoin5304707318628285782 as select v24 from movie_info as mi, aggView3531315318636513957 where mi.movie_id=aggView3531315318636513957.v12 and info= 'Bulgaria';
select MIN(v24) as v24 from aggJoin5304707318628285782;
