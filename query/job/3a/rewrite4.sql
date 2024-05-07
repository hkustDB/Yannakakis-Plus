create or replace view aggView3892949732617565012 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin2562258792579422721 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView3892949732617565012 where mi.movie_id=aggView3892949732617565012.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView7953333491423770586 as select v12, MIN(v24) as v24 from aggJoin2562258792579422721 group by v12;
create or replace view aggJoin7742861293244576685 as select keyword_id as v1, v24 from movie_keyword as mk, aggView7953333491423770586 where mk.movie_id=aggView7953333491423770586.v12;
create or replace view aggView7047837453275291985 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2157637405425049216 as select v24 from aggJoin7742861293244576685 join aggView7047837453275291985 using(v1);
select MIN(v24) as v24 from aggJoin2157637405425049216;
