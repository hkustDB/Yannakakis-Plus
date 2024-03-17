create or replace view aggView3903767964185685362 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin7489608687842698057 as select movie_id as v12 from movie_keyword as mk, aggView3903767964185685362 where mk.keyword_id=aggView3903767964185685362.v1;
create or replace view aggView5100211451671017332 as select v12 from aggJoin7489608687842698057 group by v12;
create or replace view aggJoin5965898130772241330 as select id as v12, title as v13 from title as t, aggView5100211451671017332 where t.id=aggView5100211451671017332.v12 and production_year>2005;
create or replace view aggView6249977290576488867 as select v12, MIN(v13) as v24 from aggJoin5965898130772241330 group by v12;
create or replace view aggJoin7540038903190874245 as select v24 from movie_info as mi, aggView6249977290576488867 where mi.movie_id=aggView6249977290576488867.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view res as select MIN(v24) as v24 from aggJoin7540038903190874245;
select sum(v24) from res;