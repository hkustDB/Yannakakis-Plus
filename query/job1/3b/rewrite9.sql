create or replace view aggView8730026486729789359 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin640539165065462618 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView8730026486729789359 where mi.movie_id=aggView8730026486729789359.v12 and info= 'Bulgaria';
create or replace view aggView5817859862792046515 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8711827084899904568 as select movie_id as v12 from movie_keyword as mk, aggView5817859862792046515 where mk.keyword_id=aggView5817859862792046515.v1;
create or replace view aggView6610594034850401717 as select v12 from aggJoin8711827084899904568 group by v12;
create or replace view aggJoin8290662304307541557 as select v7, v24 as v24 from aggJoin640539165065462618 join aggView6610594034850401717 using(v12);
select MIN(v24) as v24 from aggJoin8290662304307541557;
