create or replace view aggView6746891338301078910 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin3866614052916733584 as select id as v12, title as v13 from title as t, aggView6746891338301078910 where t.id=aggView6746891338301078910.v12 and production_year>2010;
create or replace view aggView3266889108705494905 as select v12, MIN(v13) as v24 from aggJoin3866614052916733584 group by v12;
create or replace view aggJoin1933504245913204685 as select keyword_id as v1, v24 from movie_keyword as mk, aggView3266889108705494905 where mk.movie_id=aggView3266889108705494905.v12;
create or replace view aggView3989215884965355315 as select v1, MIN(v24) as v24 from aggJoin1933504245913204685 group by v1;
create or replace view aggJoin6854022542068400756 as select v24 from keyword as k, aggView3989215884965355315 where k.id=aggView3989215884965355315.v1 and keyword LIKE '%sequel%';
create or replace view res as select MIN(v24) as v24 from aggJoin6854022542068400756;
select sum(v24) from res;