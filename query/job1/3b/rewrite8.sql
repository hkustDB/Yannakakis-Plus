create or replace view aggView6504651440754941504 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin2072639379261144272 as select movie_id as v12, keyword_id as v1 from movie_keyword as mk, aggView6504651440754941504 where mk.movie_id=aggView6504651440754941504.v12;
create or replace view aggView1776523940509597167 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin22128586169892623 as select v12 from aggJoin2072639379261144272 join aggView1776523940509597167 using(v1);
create or replace view aggView7390592035121370508 as select v12 from aggJoin22128586169892623 group by v12;
create or replace view aggJoin7245845847294662163 as select title as v13 from title as t, aggView7390592035121370508 where t.id=aggView7390592035121370508.v12 and production_year>2010;
select MIN(v13) as v24 from aggJoin7245845847294662163;
