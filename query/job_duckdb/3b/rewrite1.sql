create or replace view aggView4823812856613294879 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4145856188504670860 as select movie_id as v12 from movie_keyword as mk, aggView4823812856613294879 where mk.keyword_id=aggView4823812856613294879.v1;
create or replace view aggView7238453929505976923 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin4670046648899819884 as select v12 from aggJoin4145856188504670860 join aggView7238453929505976923 using(v12);
create or replace view aggView6920174622502605044 as select v12 from aggJoin4670046648899819884 group by v12;
create or replace view aggJoin4414704667267045777 as select title as v13, production_year as v16 from title as t, aggView6920174622502605044 where t.id=aggView6920174622502605044.v12 and production_year>2010;
create or replace view aggView4376770238411601150 as select v13 from aggJoin4414704667267045777;
select MIN(v13) as v24 from aggView4376770238411601150;
