create or replace view aggView6682837937533834650 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin2045219744158299694 as select id as v12, title as v13 from title as t, aggView6682837937533834650 where t.id=aggView6682837937533834650.v12 and production_year>2010;
create or replace view aggView7936867841800648453 as select v12, MIN(v13) as v24 from aggJoin2045219744158299694 group by v12;
create or replace view aggJoin6048503673380311360 as select keyword_id as v1, v24 from movie_keyword as mk, aggView7936867841800648453 where mk.movie_id=aggView7936867841800648453.v12;
create or replace view aggView5135054804635495459 as select v1, MIN(v24) as v24 from aggJoin6048503673380311360 group by v1;
create or replace view aggJoin2547703073426033161 as select v24 from keyword as k, aggView5135054804635495459 where k.id=aggView5135054804635495459.v1 and keyword LIKE '%sequel%';
select MIN(v24) as v24 from aggJoin2547703073426033161;
