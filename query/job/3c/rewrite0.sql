create or replace view aggView3680438315624948834 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3844644805507275178 as select movie_id as v12 from movie_keyword as mk, aggView3680438315624948834 where mk.keyword_id=aggView3680438315624948834.v1;
create or replace view aggView3389687211089369281 as select v12 from aggJoin3844644805507275178 group by v12;
create or replace view aggJoin8999090591291783406 as select id as v12, title as v13 from title as t, aggView3389687211089369281 where t.id=aggView3389687211089369281.v12 and production_year>1990;
create or replace view aggView243626309853812850 as select v12, MIN(v13) as v24 from aggJoin8999090591291783406 group by v12;
create or replace view aggJoin7508450435444701569 as select v24 from movie_info as mi, aggView243626309853812850 where mi.movie_id=aggView243626309853812850.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view res as select MIN(v24) as v24 from aggJoin7508450435444701569;
select sum(v24) from res;