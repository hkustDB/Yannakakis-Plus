create or replace view aggView6991200945489261225 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin3577767724804610324 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView6991200945489261225 where mi.movie_id=aggView6991200945489261225.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView2603861199731346570 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1551672723804618410 as select movie_id as v12 from movie_keyword as mk, aggView2603861199731346570 where mk.keyword_id=aggView2603861199731346570.v1;
create or replace view aggView5543344514823756806 as select v12 from aggJoin1551672723804618410 group by v12;
create or replace view aggJoin7573378813102135392 as select v7, v24 as v24 from aggJoin3577767724804610324 join aggView5543344514823756806 using(v12);
create or replace view res as select MIN(v24) as v24 from aggJoin7573378813102135392;
select sum(v24) from res;