create or replace view aggJoin9030296258542700661 as (
with aggView3328422812877418810 as (select id as v12, title as v24 from title as t where production_year>2005)
select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView3328422812877418810 where mk.movie_id=aggView3328422812877418810.v12);
create or replace view aggJoin6096787827405229117 as (
with aggView8064205510961159132 as (select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id)
select v1, v24 as v24 from aggJoin9030296258542700661 join aggView8064205510961159132 using(v12));
create or replace view aggJoin5547793822354997156 as (
with aggView7297278057457560241 as (select id as v1 from keyword as k where keyword LIKE '%sequel%')
select v24 from aggJoin6096787827405229117 join aggView7297278057457560241 using(v1));
select MIN(v24) as v24 from aggJoin5547793822354997156;
