create or replace view aggView3263103661619689071 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin905129295212735325 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView3263103661619689071 where mk.movie_id=aggView3263103661619689071.v12;
create or replace view aggView4045034677408789228 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin8065025784368608821 as select v1, v24 as v24 from aggJoin905129295212735325 join aggView4045034677408789228 using(v12);
create or replace view aggView187771701404838882 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5061575710533967608 as select v24 from aggJoin8065025784368608821 join aggView187771701404838882 using(v1);
create or replace view res as select MIN(v24) as v24 from aggJoin5061575710533967608;
select sum(v24) from res;