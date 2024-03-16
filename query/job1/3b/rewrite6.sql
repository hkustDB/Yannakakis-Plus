create or replace view aggView7848462241195869085 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1503413780329929402 as select movie_id as v12 from movie_keyword as mk, aggView7848462241195869085 where mk.keyword_id=aggView7848462241195869085.v1;
create or replace view aggView2404253694950862174 as select v12 from aggJoin1503413780329929402 group by v12;
create or replace view aggJoin5986626776054719529 as select id as v12, title as v13 from title as t, aggView2404253694950862174 where t.id=aggView2404253694950862174.v12 and production_year>2010;
create or replace view aggView2907787641198931602 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin5044450060947157545 as select v13 from aggJoin5986626776054719529 join aggView2907787641198931602 using(v12);
select MIN(v13) as v24 from aggJoin5044450060947157545;
