create or replace view aggView8650753642689771630 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin2921460774866531735 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView8650753642689771630 where mi.movie_id=aggView8650753642689771630.v12 and info= 'Bulgaria';
create or replace view aggView8993947076474522876 as select v12, MIN(v24) as v24 from aggJoin2921460774866531735 group by v12;
create or replace view aggJoin4218392332833574451 as select keyword_id as v1, v24 from movie_keyword as mk, aggView8993947076474522876 where mk.movie_id=aggView8993947076474522876.v12;
create or replace view aggView3924170662057832730 as select v1, MIN(v24) as v24 from aggJoin4218392332833574451 group by v1;
create or replace view aggJoin6001265675297205808 as select keyword as v2, v24 from keyword as k, aggView3924170662057832730 where k.id=aggView3924170662057832730.v1 and keyword LIKE '%sequel%';
select MIN(v24) as v24 from aggJoin6001265675297205808;
