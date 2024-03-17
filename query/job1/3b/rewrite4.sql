create or replace view aggView867621827807409276 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin3954541168482689336 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView867621827807409276 where mk.movie_id=aggView867621827807409276.v12;
create or replace view aggView1349991976306517786 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin1700169648575173878 as select v1, v24 as v24 from aggJoin3954541168482689336 join aggView1349991976306517786 using(v12);
create or replace view aggView2372342364905622425 as select v1, MIN(v24) as v24 from aggJoin1700169648575173878 group by v1;
create or replace view aggJoin3119980891746988218 as select keyword as v2, v24 from keyword as k, aggView2372342364905622425 where k.id=aggView2372342364905622425.v1 and keyword LIKE '%sequel%';
create or replace view res as select MIN(v24) as v24 from aggJoin3119980891746988218;
select sum(v24) from res;